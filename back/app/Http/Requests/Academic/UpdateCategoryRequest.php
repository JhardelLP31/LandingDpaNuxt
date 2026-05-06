<?php
namespace App\Http\Requests\Academic;

use Illuminate\Foundation\Http\FormRequest;

class UpdateCategoryRequest extends FormRequest
{
    public function authorize()
    {
        return true; // Cambiar si tienes lógica de permisos
    }

    public function rules()
    {
        // Obtenemos el ID de la URL (asumiendo que tu ruta es api/categories/{category})
        $categoryId = $this->route('category') ?? $this->route('id');

        return [
            'name'        => 'required|string|max:255',
            'type'        => 'required|string',
            'slug'        => 'required|string|unique:categories,slug,' . $categoryId,
            'parent_id'   => 'nullable|exists:categories,id',
            'description' => 'nullable|string',
        ];
    }
}