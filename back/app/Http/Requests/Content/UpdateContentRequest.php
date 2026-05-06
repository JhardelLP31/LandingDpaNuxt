<?php
namespace App\Http\Requests\Content;

use Illuminate\Foundation\Http\FormRequest;

class UpdateContentRequest extends FormRequest
{
    public function authorize(): bool
    {
        // La autorización ya la estamos haciendo en el Controlador con Gate::authorize
        return true; 
    }

    public function rules(): array
    {
        return [
            'title' => 'sometimes|required|string|max:255',
            'slug' => 'sometimes|nullable|string|max:255',
            'type' => 'sometimes|required|in:page,post,landing,news',
            'status' => 'sometimes|required|in:draft,published,archived',
            'content_blocks' => 'nullable|array',
            'seo_config' => 'nullable|array',
            'seo_config.title' => 'nullable|string',
            'seo_config.description' => 'nullable|string',
            'primary_color' => 'sometimes|nullable|string|max:50',
            'font_family' => 'sometimes|nullable|string|max:255',
        ];
    }
}