<?php
// app/Http/Requests/Content/StoreContentRequest.php
namespace App\Http\Requests\Content;
use App\Models\Content\Content;

use Illuminate\Foundation\Http\FormRequest;

class StoreContentRequest extends FormRequest
{
    /*public function authorize()
    {
        return $this->user()->can('create', Content::class);
    }*/

    public function rules()
    {
        return [
            'title' => 'required|string|max:255',
            'slug' => 'nullable|string|max:255',
            'type' => 'required|in:page,post,landing,news',
            'status' => 'required|in:draft,published,archived',
            'content_blocks' => 'nullable|array', 
            'content_blocks.*.type' => 'required_with:content_blocks|string', 
            'content_blocks.*.data' => 'required_with:content_blocks|array',  
            'seo_config' => 'nullable|array',
            'seo_config.title' => 'nullable|string',
            'seo_config.description' => 'nullable|string',
            'primary_color' => 'nullable|string|max:50',
            'font_family' => 'nullable|string|max:255',
        ];
    }
}