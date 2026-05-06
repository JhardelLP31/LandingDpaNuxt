<?php
// app/Services/Content/ContentService.php
namespace App\Services\Content;

use App\Models\Content\Content;
use App\Models\Academic\AcademicUnit;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\DB;
use App\Services\Media\MediaService; // Si implementas un servicio de Media

class ContentService
{
    public function getPaginatedPages(array $filters)
    {
        $query = Content::query()
            ->with(['author:id,name,email', 'unit:id,name']); 

        if (!empty($filters['search'])) {
            $query->where(function ($q) use ($filters) {
                $q->where('title', 'like', "%{$filters['search']}%")
                  ->orWhere('slug', 'like', "%{$filters['search']}%");
            });
        }

        if (!empty($filters['type'])) {
            $query->where('type', $filters['type']);
        }

        return $query->orderByDesc('id')->paginate(10);
    }

    public function createPage(array $data, AcademicUnit $unit)
    {
        return DB::transaction(function () use ($data, $unit) {
            
            // Generar un slug único dentro de ESA unidad académica
            $slugBase = $data['slug'] ? Str::slug($data['slug']) : Str::slug($data['title']);
            $data['slug'] = $this->generateUniqueSlug($slugBase, $unit->id);
            
            $data['academic_unit_id'] = $unit->id;
            $data['user_id'] = auth('api')->id() ?? 1;

            return Content::create($data);
        });
    }

    public function updatePage(Content $page, array $data)
    {
        return DB::transaction(function () use ($page, $data) {
            
            if (isset($data['slug']) && $data['slug'] !== $page->slug) {
                $data['slug'] = $this->generateUniqueSlug(Str::slug($data['slug']), $page->academic_unit_id, $page->id);
            }

            $page->update($data);
            return $page;
        });
    }

    public function deletePage(Content $page)
    {
        // Aquí podrías agregar lógica para borrar imágenes asociadas de la tabla Media
        $page->delete();
    }

    private function generateUniqueSlug(string $slug, int $unitId, int $ignoreId = null)
    {
        $query = Content::where('slug', $slug)->where('academic_unit_id', $unitId);
        if ($ignoreId) {
            $query->where('id', '!=', $ignoreId);
        }

        if ($query->exists()) {
             // Lanza una excepción personalizada o agrega un sufijo numérico
             throw new \Exception("El Slug ya existe para esta unidad académica."); 
        }

        return $slug;
    }
}