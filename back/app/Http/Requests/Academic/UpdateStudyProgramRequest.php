<?php

namespace App\Http\Requests\Academic;

use Illuminate\Foundation\Http\FormRequest;

class UpdateStudyProgramRequest extends FormRequest
{
    public function authorize()
    {
        return true; 
    }

    public function rules()
    {
        // Capturamos el ID de la ruta para excluirlo de la regla unique
        $programId = $this->route('study_program') ?? $this->route('id');

        return [
            'academic_unit_id' => 'sometimes|required|exists:academic_units,id',
            'category_id'      => 'sometimes|required|exists:categories,id',
            'name'             => 'sometimes|required|string|max:255',
            'slug'             => 'sometimes|required|string|max:255|unique:study_programs,slug,' . $programId,
            'modality'         => 'sometimes|required|string|max:100',
            'duration'         => 'nullable|string|max:100',
            'description'      => 'nullable|string',
            'branding_color'   => 'nullable|string|max:50',
            'is_active'        => 'sometimes|required|boolean',
        ];
    }
}