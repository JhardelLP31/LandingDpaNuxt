<?php
// app/Services/Content/PostService.php

namespace App\Services\Content;

use App\Models\Content\Post; 
use App\Models\Academic\AcademicUnit;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;

class PostService
{
    public function getPaginatedPosts(array $filters, int $unitId)
    {
        $query = Post::where('academic_unit_id', $unitId)
            ->with(['category:id,name']); 

        if (!empty($filters['search'])) {
            $query->where(function ($q) use ($filters) {
                $q->where('title', 'like', "%{$filters['search']}%")
                  ->orWhere('slug', 'like', "%{$filters['search']}%");
            });
        }

        if (!empty($filters['type'])) {
            $query->where('type', $filters['type']);
        }

        if (!empty($filters['status'])) {
            $query->where('status', $filters['status']);
        }

        if (!empty($filters['category_id'])) {
            $query->where('category_id', $filters['category_id']);
        }

        return $query->orderByDesc('start_date')
                     ->orderByDesc('created_at')
                     ->paginate($filters['per_page'] ?? 10);
    }

    public function createPost(array $data, AcademicUnit $unit)
    {
        return DB::transaction(function () use ($data, $unit) {
            
            // Generar slug
            $slugBase = !empty($data['slug']) ? Str::slug($data['slug']) : Str::slug($data['title']);
            $data['slug'] = $this->generateUniqueSlug($slugBase, $unit->id);
            
            $data['academic_unit_id'] = $unit->id;
            
            // Si en tu migración final agregaste user_id, descomenta esto:
            // $data['user_id'] = auth('api')->id() ?? 1;

            return Post::create($data);
        });
    }

    public function updatePost(Post $post, array $data)
    {
        return DB::transaction(function () use ($post, $data) {
            
            // Validar si el slug cambió para regenerarlo y verificar unicidad
            if (isset($data['slug']) && $data['slug'] !== $post->slug) {
                $data['slug'] = $this->generateUniqueSlug(Str::slug($data['slug']), $post->academic_unit_id, $post->id);
            }

            $post->update($data);
            return $post;
        });
    }

    public function deletePost(Post $post)
    {
        // Si usas SoftDeletes en el modelo, esto solo ocultará el registro.
        // Si no, lo borrará de la DB.
        $post->delete();
    }

    /**
     * Verifica que el slug no exista dentro de la MISMA unidad académica.
     */
    private function generateUniqueSlug(string $slug, int $unitId, int $ignoreId = null)
    {
        $query = Post::where('slug', $slug)->where('academic_unit_id', $unitId);
        
        if ($ignoreId) {
            $query->where('id', '!=', $ignoreId);
        }

        if ($query->exists()) {
             // Puedes lanzar excepción o automatizar agregando -1, -2, etc.
             throw new \Exception("El Slug de esta noticia o evento ya existe en esta unidad académica."); 
        }

        return $slug;
    }
}