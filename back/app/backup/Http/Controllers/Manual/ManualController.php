<?php

namespace App\Http\Controllers\Manual;

use App\Models\PageCategory\Category; // Tu tabla de categorías
use App\Models\Manual\Manual;     // Tu nuevo modelo
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Storage;
use App\Http\Resources\Manual\ManualResource;
use App\Http\Resources\Manual\ManualCollection;

class ManualController extends Controller
{
    /**
     * Lista simplificada para selectores o buscadores rápidos
     */
    public function selectionList(Request $request)
    {
        $type = $request->query('type', 'manual');

        // Traemos las categorías activas en formato árbol
        $categories = Category::where('type', $type)
            ->where('is_active', 1)
            ->whereNull('parent_id')
            ->with(['children' => function($query) {
                $query->select('id', 'name', 'parent_id', 'slug')->where('is_active', 1);
            }])
            ->select('id', 'name', 'slug')
            ->get();

        return response()->json($categories);
    }
    public function indexPublic(Request $request)
    {
        $manuals = Manual::query()
            ->where('status', 'published') // <--- Cambio solicitado
            ->orderBy('id', 'desc')
            ->get(); 

        // Usamos el Resource si lo tienes, sino response()->json basta
        return response()->json($manuals);
    }

    /**
     * Listado principal con filtros y paginación
     */
    public function index(Request $request)
    {
        if (!Gate::allows("viewAny", Manual::class)) {
            return response()->json(['error' => 'No tienes permisos.'], 403);
        }

        $search = $request->get("search");
        $categoryId = $request->get("category_id");

        $query = Manual::query();

        // Eager Loading optimizado
        $query->with([
            'user:id,name',
            'category:id,name' // Asumiendo que es belongsTo
        ]);

        // Búsqueda
        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('title', 'like', "%{$search}%")
                  ->orWhere('slug', 'like', "%{$search}%");
            });
        }

        // Filtro por categoría (usando tu category_id)
        if ($categoryId) {
            $query->where('category_id', $categoryId);
        }

        $manual = $query->orderBy("id", "desc")->paginate(10);

        // Traemos solo categorías que sean de tipo 'software' (ajusta el nombre del tipo)
        $categories = Category::where('type', 'software')
            ->select("id", "name")
            ->get();

        return response()->json([
            "total" => $manual->total(),
            "manual" => ManualCollection::make($manual),
            "categories" => $categories
        ]);
    }

    /**
     * Guardar nuevo software
     */
    public function store(Request $request)
    {
        if (Gate::denies("create", Manual::class)) {
            return response()->json(['error' => 'No autorizado'], 403);
        }

        try {
            // 2. Validación
            $request->validate([
                'title' => 'required|string|max:255',
                'category_id' => 'required', 
                'slug' => 'nullable|string'
            ]);

            // 3. Generar Slug
            $slug = $request->slug ? Str::slug($request->slug) : Str::slug($request->title);

            if (Manual::where('slug', $slug)->exists()) {
                return response()->json(['error' => "EL SLUG YA EXISTE: $slug"], 422);
            }

            $data = $request->all();
            $data['slug'] = $slug;
            $data['user_id'] = auth()->id() ?? 1;

            if ($request->has('download_links')) {
                $links = $request->download_links;
                $data['download_links'] = is_string($links) ? json_decode($links, true) : $links;
            }

            $manual = Manual::create($data);

            return response()->json([
                "manual" => $manual, 
                "message" => "Manual creado correctamente"
            ]);

        } catch (\Illuminate\Validation\ValidationException $e) {
            return response()->json(['errors' => $e->errors()], 422);
        } catch (\Exception $e) {
            // ESTO TE DIRÁ EL ERROR REAL EN LA PESTAÑA 'NETWORK'
            return response()->json([
                'error' => 'Error interno del servidor',
                'details' => $e->getMessage(),
                'file' => $e->getFile(),
                'line' => $e->getLine()
            ], 500);
        }
    }

    /**
     * Mostrar un software específico por ID o Slug
     */
    public function show($id_or_slug)
    {
        $manual = Manual::where('id', $id_or_slug)
            ->orWhere('slug', $id_or_slug)
            ->firstOrFail();

        return response()->json([
            'software' => ManualResource::make($manual)
        ]);
    }

    /**
     * Actualizar software
     */
    public function update(Request $request, $id)
    {
        $manual = Manual::findOrFail($id);

        if (!Gate::allows("update", $manual)) {
            return response()->json(['error' => 'No autorizado'], 403);
        }

        $data = $request->all();

        // Lógica de Slug
        if ($request->has('slug') && $request->slug != $manual->slug) {
            $data['slug'] = Str::slug($request->slug);
        }

        // Actualizar imagen
        if ($request->hasFile("image")) {
            if ($manual->image_path) {
                Storage::disk('public')->delete($manual->image_path);
            }
            $data["image_path"] = $request->file("image")->store("manual/covers", "public");
        }

        // Actualizar JSON de descargas
        if ($request->has('download_links')) {
            $data['download_links'] = is_string($request->download_links) 
                ? json_decode($request->download_links, true) 
                : $request->download_links;
        }

        $manual->update($data);

        return response()->json([
            "software" => ManualResource::make($manual),
            "message" => "Actualizado con éxito"
        ]);
    }

    /**
     * Eliminar software
     */
    public function destroy($id)
    {
        $manual = Manual::findOrFail($id);

        if (!Gate::allows("delete", $manual)) {
            return response()->json(['error' => 'No autorizado'], 403);
        }

        if ($manual->image_path) {
            Storage::disk('public')->delete($manual->image_path);
        }

        $manual->delete();

        return response()->json(['message' => 'Eliminado correctamente']);
    }
}