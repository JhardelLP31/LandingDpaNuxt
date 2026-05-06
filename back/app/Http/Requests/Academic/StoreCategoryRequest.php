<?php
namespace App\Http\Requests\Academic;

use Illuminate\Foundation\Http\FormRequest;

class StoreCategoryRequest extends FormRequest
{
    public function rules(): array
    {
        return [
            'name'      => 'required|string|max:255',
            'slug'      => 'nullable|string|max:255',
            'parent_id' => 'nullable|exists:categories,id',
            'type'      => 'nullable|string|max:50', 
        ];
    }
}