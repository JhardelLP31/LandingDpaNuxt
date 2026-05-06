<?php
namespace App\Http\Resources\Content;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PageResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
{
    return [
        'id' => $this->id,
        'title' => $this->title,
        'slug' => $this->slug,
        'type' => $this->type,
        'status' => $this->status,
        
        'primary_color' => $this->primary_color,
        'font_family' => $this->font_family ?? 'Arial, sans-serif',

        'content_blocks' => $this->content_blocks ?? [], 
        
        'seo_config' => $this->seo_config ?? [
            'title' => $this->title,
            'description' => '',
            'og_image' => ''
        ],

        'published_at' => $this->published_at ? $this->published_at->toIso8601String() : null,
        'created_at' => $this->created_at->toIso8601String(),
        'updated_at' => $this->updated_at->toIso8601String(),

        'author' => $this->whenLoaded('author', function () {
            return [
                'id' => $this->author->id,
                'name' => $this->author->name,
            ];
        }),

        'unit' => $this->whenLoaded('unit', function () {
            return [
                'id' => $this->unit->id,
                'name' => $this->unit->name,
                'slug' => $this->unit->slug,
            ];
        }),
    ];
}
}