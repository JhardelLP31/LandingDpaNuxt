<?php

namespace App\Http\Controllers\Api\Marketing;

use App\Http\Controllers\Controller;
use App\Models\Marketing\MarketingCampaign;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;
use Illuminate\Support\Facades\Gate; 

class MarketingCampaignController extends Controller
{
    // Obtener todas las campañas
    public function index(Request $request)
    {
        Gate::authorize('viewAny', MarketingCampaign::class);

        $campaigns = MarketingCampaign::orderBy('created_at', 'desc')
            ->when($request->academic_unit_id, function($query, $id) {
                return $query->where('academic_unit_id', $id);
            })
            ->get();

        return response()->json($campaigns);    
    }

    // Crear una nueva campaña
    public function store(Request $request)
    {
        Gate::authorize('create', MarketingCampaign::class);

        if (!$request->user()->hasRole('Super-Admin') && $request->user()->academic_unit_id != $request->input('academic_unit_id')) {
            abort(403, 'No tienes permiso para crear campañas en una sede ajena.');
        }

        $validated = $request->validate([
            'name'             => 'required|string|max:255',
            'slug'             => 'required|string|unique:marketing_campaigns,slug',
            'academic_unit_id' => 'required|integer',
            'academic_period'  => 'required|string',
            'start_date'       => 'required|date',
            'end_date'         => 'required|date',
            'form_config'      => 'nullable|array',
            'is_active'        => 'boolean',
            //'study_program_id' => 'nullable|integer',
            //'content_id'       => 'nullable|integer',
        ]);

        $campaign = MarketingCampaign::create($validated);

        return response()->json([
            'message' => 'Campaña creada con éxito',
            'campaign' => $campaign
        ], 201);
    }

    // Actualizar campaña existente
    public function update(Request $request, $id)
    {
        $campaign = MarketingCampaign::findOrFail($id);

        Gate::authorize('update', $campaign);

        if ($request->has('academic_unit_id') && !$request->user()->hasRole('Super-Admin') && $request->user()->academic_unit_id != $request->input('academic_unit_id')) {
            abort(403, 'No puedes trasladar esta campaña a una sede ajena.');
        }

        $validated = $request->validate([
            'name'             => 'required|string|max:255',
            'slug'             => [
                'required', 
                'string', 
                Rule::unique('marketing_campaigns')->ignore($campaign->id)
            ],
            'academic_unit_id' => 'required|integer',
            'academic_period'  => 'required|string',
            'start_date'       => 'required|date',
            'end_date'         => 'required|date',
            'form_config'      => 'nullable|array',
            'is_active'        => 'boolean',
            //'study_program_id' => 'nullable|integer',
            //'content_id'       => 'nullable|integer',
        ]);

        $campaign->update($validated);

        return response()->json([
            'message'  => 'Campaña actualizada con éxito',
            'campaign' => $campaign
        ]);
    }

    // Eliminar campaña
    public function destroy($id)
    {
        try {
            $campaign = MarketingCampaign::findOrFail($id);

            Gate::authorize('delete', $campaign);

            $campaign->delete();

            return response()->json([
                'success' => true,
                'message' => 'Campaña eliminada con éxito'
            ]);
            
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al eliminar: ' . $e->getMessage()
            ], 500);
        }
    }
}