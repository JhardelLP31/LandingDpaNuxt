<?php

namespace App\Http\Resources\Content;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PostResource extends JsonResource
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
            
            // CAMPOS DE CONTENIDO DINÁMICO
            'excerpt' => $this->excerpt,
            'body' => $this->body,
            'featured_image_path' => $this->featured_image_path,

            // FECHAS (Mantenemos tu estándar ISO 8601)
            'start_date' => $this->start_date ? $this->start_date->toIso8601String() : null,
            'end_date' => $this->end_date ? $this->end_date->toIso8601String() : null,
            'created_at' => $this->created_at ? $this->created_at->toIso8601String() : null,
            'updated_at' => $this->updated_at ? $this->updated_at->toIso8601String() : null,

            // RELACIONES
            'category' => $this->whenLoaded('category', function () {
                return [
                    'id' => $this->category->id,
                    'name' => $this->category->name,
                    // 'color' => $this->category->color ?? null, // Si tus categorías tienen color, lo pasas aquí
                ];
            }),

            'unit' => $this->whenLoaded('academicUnit', function () {
                return [
                    'id' => $this->academicUnit->id,
                    'name' => $this->academicUnit->name,
                    'slug' => $this->academicUnit->slug,
                ];
            }),

            // Descomenta esto si en tu migración final le pusiste 'user_id' a los posts
            /*
            'author' => $this->whenLoaded('author', function () {
                return [
                    'id' => $this->author->id,
                    'name' => $this->author->name,
                ];
            }),
            */
        ];
    }
}