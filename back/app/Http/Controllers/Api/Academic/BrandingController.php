<?php

namespace App\Http\Controllers\Api\Academic;

use App\Http\Controllers\Controller;
use App\Models\Academic\AcademicUnit;
use App\Models\Academic\UnitBranding;
use App\Models\Common\Menu; 
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Gate; // <-- AÑADIDO

class BrandingController extends Controller
{
    /**
     * Actualiza o crea la identidad visual (Desde el CMS Vue).
     */
    public function update(Request $request)
    {
        $unitId = $request->input('academic_unit_id');
        $user = $request->user();

        $existingBranding = UnitBranding::where('academic_unit_id', $unitId)->first();

        if ($existingBranding) {
            Gate::authorize('update', $existingBranding);
        } else {
            Gate::authorize('create', UnitBranding::class);
            
            if (!$user->hasRole('Super-Admin') && $user->academic_unit_id != $unitId) {
                abort(403, 'No tienes permiso para crear branding en una sede ajena.');
            }
        }
        
        $validator = Validator::make($request->all(), [
            'academic_unit_id' => 'required|exists:academic_units,id',
            'header_type'      => 'nullable|string', 
            'primary_color'    => 'nullable|string|max:7',
            'secondary_color'  => 'nullable|string|max:7',
            'accent_color'     => 'nullable|string|max:7',
            'logo_primary_id'  => 'nullable|integer|exists:media,id',
            'favicon_id'       => 'nullable|integer|exists:media,id',
            'header_config'    => 'nullable|array',
            'footer_config'    => 'nullable|array',
            'custom_css'       => 'nullable|string',
            'selected_menu_id' => 'nullable|integer' 
        ]);

        if ($validator->fails()) {
            return response()->json([
                'status' => 'error',
                'message' => 'Datos inválidos',
                'errors' => $validator->errors()
            ], 422);
        }

        // UpdateOrCreate: Guarda en BD
        $branding = UnitBranding::updateOrCreate(
            ['academic_unit_id' => $unitId],
            $validator->validated()
        );

        return response()->json([
            'message' => 'Identidad visual actualizada correctamente',
            'data' => $branding->load(['logoPrimary', 'favicon']) 
        ]);
    }

    /**
     * Obtiene el branding de una unidad (Para editar en el CMS Vue).
     */
    public function show(Request $request, $unitId) // <-- Le agregué Request $request
    {
        $branding = UnitBranding::where('academic_unit_id', $unitId)
                    ->with(['logoPrimary', 'favicon'])
                    ->first();

        // 1. VALIDACIÓN DE POLICY
        if (!$branding) {
            // Si el branding aún no existe, al menos validamos que tenga acceso al módulo
            Gate::authorize('viewAny', UnitBranding::class);

            // Validamos que solo pueda consultar la data "vacía" de SU sede
            if (!$request->user()->hasRole('Super-Admin') && $request->user()->academic_unit_id != $unitId) {
                abort(403, 'Acceso denegado. No perteneces a esta unidad académica.');
            }

            return response()->json([
                'is_new' => true,
                'data' => [
                    'academic_unit_id' => (int)$unitId,
                    'primary_color'    => '#1a1a1a',
                    'secondary_color'  => '#ffffff',
                    'accent_color'     => '#00d1b2',
                    'header_config'    => ['style' => 'sticky', 'transparent' => false],
                    'selected_menu_id' => null
                ]
            ]);
        }

        // Si SÍ existe el branding, aplicamos la policy completa (Permiso + Sede)
        Gate::authorize('view', $branding);

        return response()->json([
            'is_new' => false,
            'data' => $branding
        ]);
    }

    /**
     * Obtiene el branding público buscando por SLUG (Consumido por NUXT).
     */
    public function getPublicBrandingBySlug($slug)
    {
        $unit = AcademicUnit::where('slug', $slug)->first();

        if (!$unit) {
            return response()->json(['message' => 'Unidad no encontrada'], 404);
        }

        $branding = UnitBranding::where('academic_unit_id', $unit->id)
            ->with(['logoPrimary', 'favicon'])
            ->first();

        if (!$branding) {
            return response()->json(['message' => 'Branding no configurado'], 404);
        }

        // --- LA MAGIA DEL PAGE BUILDER ---
        $menu = null;
        
        if (!empty($branding->custom_css)) {
            $blocks = json_decode($branding->custom_css, true);
            
            if (is_array($blocks)) {
                foreach ($blocks as $block) {
                    if (isset($block['type']) && str_contains($block['type'], 'Header')) {
                        $menuId = $block['content']['menu_id'] ?? null;
                        
                        if ($menuId) {
                            $menu = Menu::with([
                                'items.content',
                                'items' => function($query) {
                                    $query->orderBy('order'); 
                                }
                            ])->find($menuId);
                        }
                        break; 
                    }
                }
            }
        }

        $branding->menu = $menu;

        return response()->json([
            'data' => $branding
        ]);
    }
}