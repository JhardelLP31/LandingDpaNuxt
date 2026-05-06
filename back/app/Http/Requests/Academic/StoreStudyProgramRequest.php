<?php
namespace App\Http\Requests\Academic;

use Illuminate\Foundation\Http\FormRequest;

class StoreStudyProgramRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true; // Asegúrate de que esto esté en true o manejar tus permisos
    }

    public function rules(): array
    {
        return [
            'academic_unit_id' => 'required|exists:academic_units,id',
            'branding_color'   => 'nullable|string|max:50',
            'is_active'        => 'boolean',
            
            'category_id'      => 'required|exists:categories,id',
            'name'             => 'required|string|max:255',
            'slug'             => 'nullable|string|max:255',    
            'description'      => 'nullable|string',
            
            'modality'         => 'nullable|string|max:100',
            'duration'         => 'nullable|string|max:100',
        ];
    }
}