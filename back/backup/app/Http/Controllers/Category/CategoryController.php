<?php

namespace App\Http\Controllers\Category;

use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Models\Category\Category;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Storage;
use App\Http\Resources\Category\CategoryResource;
use App\Http\Resources\Category\CategorySimpleResource;
use App\Http\Resources\Category\CategorySimpleMenuResource;

class CategoryController extends Controller
{
    /**
     * Lista pública ligera (ahora filtrable por ?type=)
     */
    public function indexPublic(Request $request)
    {
        // 1. Convertimos "" (vacío) a null real para evitar problemas
        $type = $request->input('type') ?: null; 

        // Cache key segura
        $cacheKey = "categories_public_" . ($type ?? 'all');

        // Cache::remember... (puedes descomentarlo luego, probemos directo primero)
        $categories = Category::query()
            // SOLUCIÓN 1: Aceptamos NULL o 0 como raíz
            ->where(function ($query) {
                $query->whereNull('parent_id')
                    ->orWhere('parent_id', 0);
            })
            // SOLUCIÓN 2: Asegúrate que tus categorías tengan is_active = 1
            ->where('is_active', 1)

            // SOLUCIÓN 3: El filtro de tipo
            ->when($type, function ($query, $type) {
                return $query->where('type', $type);
            })
            
            ->orderBy('id', 'desc')
            ->select(['id', 'name', 'slug', 'color', 'image_path', 'type', 'parent_id', 'is_active'])
            ->get();

        return CategorySimpleResource::collection($categories);
    }
    public function indexPublicMenu(Request $request)
    {
        // 1. Convertimos "" (vacío) a null real para evitar problemas
        $type = $request->input('type') ?: null; 

        // Cache key segura
        $cacheKey = "categories_public_" . ($type ?? 'all');

        // Cache::remember... (puedes descomentarlo luego, probemos directo primero)
        $categories = Category::query()
            // SOLUCIÓN 1: Aceptamos NULL o 0 como raíz
            ->where(function ($query) {
                $query->whereNull('parent_id')
                    ->orWhere('parent_id', 0);
            })
            // SOLUCIÓN 2: Asegúrate que tus categorías tengan is_active = 1
            ->where('is_active', 1)

            // SOLUCIÓN 3: El filtro de tipo
            ->when($type, function ($query, $type) {
                return $query->where('type', $type);
            })
            
            ->orderBy('id', 'desc')
            ->select(['id', 'name', 'slug', 'color', 'type', 'parent_id', 'is_active'])
            ->get();

        return CategorySimpleMenuResource::collection($categories);
    }

    /**
     * Lista completa para el Panel Administrativo
     */
   public function index(Request $request)
    {
        if (!Gate::allows('viewAny', Category::class)) {
            return $this->respondError('No tienes permisos.', 403);
        }

        $type = $request->query('type');

        $suffix = $type ?: 'all';
        $cacheKey = "categories_admin_{$suffix}";

        $categories = Cache::remember($cacheKey, 3600, function () use ($type) {
            return Category::query()
                ->whereNull('parent_id')
                
                ->when($type, function ($query) use ($type) {
                    return $query->where('type', $type);
                })
                
                ->orderBy('id', 'desc')
                ->get();
        });

        return CategoryResource::collection($categories);
    }

    /**
     * Crear Categoría
     */
    public function store(Request $request)
    {
        if (!Gate::allows('create', Category::class)) {
            return $this->respondError('No autorizado.', 403);
        }

        $request->validate([
            'name'      => 'required|string|max:255',
            //'type'      => 'required|in:post,course', // <--- VALIDACIÓN DE TIPO
            'parent_id' => 'nullable|exists:categories,id',
            'image'     => 'nullable|image|max:2048',
            'color'     => 'nullable|string|max:7',
        ]);

        $data = $request->all();

        if (empty($data['slug'])) {
            $data['slug'] = Str::slug($data['name']);
        }

        if ($request->hasFile('image')) {
            $path = $request->file('image')->store('categories', 'public');
            $data['image_path'] = $path;
        }

        $category = Category::create($data);

        // Limpieza de caché específica para el tipo creado
        $this->clearCategoryCache($category->type);

        return $this->respondSuccess(new CategoryResource($category), 'Categoría creada correctamente');
    }

    /**
     * Actualizar Categoría
     */
    public function update(Request $request, $id)
    {
        $category = Category::findOrFail($id);

        if (!Gate::allows('update', $category)) {
            return $this->respondError('No autorizado.', 403);
        }

        $request->validate([
            'name'      => 'required|string|max:255',
            'color'     => 'nullable|string|max:7',
            // No permitimos cambiar el 'type' una vez creada para evitar inconsistencias
        ]);

        $data = $request->except(['image']);

        if ($request->filled('slug') && $request->slug !== $category->slug) {
            $data['slug'] = Str::slug($request->slug);
        }

        if ($request->hasFile('image')) {
            if ($category->image_path) {
                Storage::disk('public')->delete($category->image_path);
            }
            $path = $request->file('image')->store('categories', 'public');
            $data['image_path'] = $path;
        }

        $category->update($data);

        $this->clearCategoryCache($category->type);

        return $this->respondSuccess(new CategoryResource($category), 'Categoría actualizada');
    }


    /**
     * Función privada para limpiar el caché por tipo
     */
    private function clearCategoryCache($type)
    {
        Cache::forget("categories_public_list_{$type}");
        Cache::forget("categories_admin_{$type}");
        // También limpiamos las genéricas por si acaso
        Cache::forget('categories_home'); 
    }
    /**
     * Eliminar Categoría
     */
    public function destroy($id)
    {
        $category = Category::findOrFail($id);
        
        // 1. Validamos Permiso
        if (!Gate::allows('delete', $category)) {
            return $this->respondError('No tienes permisos para eliminar esta categoría.', 403);
        }

        
        if ($category->children()->count() > 0) {
            return $this->respondError('No puedes eliminar una categoría con subcategorías.', 422);
        }

        $category->delete();

        // 2. Limpieza de Caché
        Cache::forget('categories_home');
        Cache::forget('categories_public_list');

        // 3. Respuesta Bonita
        return $this->respondSuccess([], 'Categoría enviada a la papelera');
    }
}