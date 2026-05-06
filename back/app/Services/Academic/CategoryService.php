<?php
namespace App\Services\Academic;

use App\Models\Academic\Category;
use Illuminate\Support\Str;

class CategoryService
{
    public function createCategory(array $data, int $academicUnitId): Category
    {
        $data['academic_unit_id'] = $academicUnitId;
        
        if (empty($data['slug'])) {
            $data['slug'] = Str::slug($data['name']);
        }

        // Aquí podrías validar que si viene un parent_id, 
        // ese padre pertenezca a la misma unidad académica.
        
        return Category::create($data);
    }

   public function updateCategory($id, array $data)
    {
        $category = Category::findOrFail($id);

        // Regla de negocio: no ser padre de sí misma
        if (isset($data['parent_id']) && $data['parent_id'] == $category->id) {
            throw new \Exception('Una categoría no puede ser subcategoría de sí misma.');
        }

        $category->update($data);

        return $category;
    }

    public function deleteCategory($id)
    {
        $category = Category::findOrFail($id);

        // Regla de negocio: no borrar si tiene hijos
        // (Asegúrate de tener la relación children() en el modelo Category)
        if ($category->where('parent_id', $id)->count() > 0) {
            throw new \Exception('No puedes eliminar esta categoría porque contiene subcategorías.');
        }

        return $category->delete();
    }
}