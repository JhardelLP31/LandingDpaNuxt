<?php

namespace App\Http\Requests\Content;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;

class StorePostRequest extends FormRequest
{
    /**
     * Determina si el usuario está autorizado para hacer esta petición.
     */
    public function authorize()
    {
        // Aquí podrías validar permisos si usas Spatie Permission o Gates.
        // Por ahora lo dejamos en true asumiendo que el middleware ya protege la ruta.
        return true; 
    }

    /**
     * Reglas de validación.
     */
    public function rules()
    {
        return [
            'academic_unit_id'    => 'required|integer|exists:academic_units,id',
            'title'               => 'required|string|max:255',
            
            // El slug debe ser único en la tabla posts, PERO solo para esta unidad académica
            'slug'                => [
                'required',
                'string',
                'max:255',
                Rule::unique('posts')->where(function ($query) {
                    return $query->where('academic_unit_id', $this->academic_unit_id);
                })
            ],
            
            'type'                => 'required|in:news,event',
            'category_id'         => 'nullable|integer|exists:categories,id', // O required si siempre exiges categoría
            'status'              => 'required|in:draft,published,archived',
            'excerpt'             => 'nullable|string|max:500',
            'body'                => 'nullable|string',
            'featured_image_path' => 'nullable|string',
            'start_date'          => 'nullable|date',
            
            // Si hay end_date, debe ser una fecha igual o posterior al start_date
            'end_date'            => 'nullable|date|after_or_equal:start_date',
        ];
    }

    /**
     * Mensajes personalizados (Opcional, pero muy útil para el frontend)
     */
    public function messages()
    {
        return [
            'slug.unique' => 'Ya existe una noticia o evento con esta URL en esta unidad académica.',
            'end_date.after_or_equal' => 'La fecha de fin no puede ser anterior a la fecha de inicio.',
        ];
    }
}