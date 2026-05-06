<?php

namespace App\Http\Requests\Content;

use Illuminate\Foundation\Http\FormRequest;
use Illuminate\Validation\Rule;
use App\Models\Content\Post; 

class UpdatePostRequest extends FormRequest
{
    public function authorize()
    {
        return true;
    }

    public function rules()
    {
        // En Laravel, cuando pasas el parámetro por la URL (ej: /api/news/{identifier}), 
        // puedes obtener ese ID desde el request para ignorarlo en la validación.
        // Ojo: Si en tu ruta lo llamaste 'news', usa $this->route('news'). Si es 'post', usa 'post'.
        // Asumiendo que tu parámetro se llama 'identifier' como en el controlador:
        
        // Aquí sacamos el post actual de la ruta o de la DB para saber qué ID ignorar
        $identifier = $this->route('identifier') ?? $this->route('news') ?? $this->route('post');
        
        // Si el identifier es un slug, buscamos el ID real en la DB. Si es un ID, lo usamos directo.
        $postId = is_numeric($identifier) ? $identifier : Post::where('slug', $identifier)->value('id');

        return [
            'academic_unit_id'    => 'required|integer|exists:academic_units,id',
            'title'               => 'required|string|max:255',
            
            'slug'                => [
                'required',
                'string',
                'max:255',
                Rule::unique('posts')->where(function ($query) {
                    return $query->where('academic_unit_id', $this->academic_unit_id);
                })->ignore($postId) 
            ],
            
            'type'                => 'required|in:news,event',
            'category_id'         => 'nullable|integer|exists:categories,id',
            'status'              => 'required|in:draft,published,archived',
            'excerpt'             => 'nullable|string|max:500',
            'body'                => 'nullable|string',
            'featured_image_path' => 'nullable|string',
            'start_date'          => 'nullable|date',
            'end_date'            => 'nullable|date|after_or_equal:start_date',
        ];
    }

    public function messages()
    {
        return [
            'slug.unique' => 'Ya existe otra noticia o evento con esta URL en esta unidad académica.',
            'end_date.after_or_equal' => 'La fecha de fin no puede ser anterior a la fecha de inicio.',
        ];
    }
}