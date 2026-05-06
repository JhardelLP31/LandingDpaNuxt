<?php

namespace App\Http\Resources\Category;

use Illuminate\Http\Resources\Json\JsonResource;

class CategoryResource extends JsonResource
{
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'slug' => $this->slug,
            'type' => $this->type,
            'description' => $this->description,
            'color' => $this->color,
            'is_active' => (bool) $this->is_active,
            'parent_id' => $this->parent_id,
            
            // Imagen: mandamos el path relativo y la URL absoluta
            'image_path' => $this->image_path,
            'image_url' => $this->image_url,

            // Recursividad: Si cargamos 'childrenRecursive' en el controlador, 
            // aquí se formatea automáticamente usando este mismo Resource.
            'children' => CategoryResource::collection($this->whenLoaded('childrenRecursive')),
            
            'created_at' => $this->created_at->format('Y-m-d H:i:s'),
        ];
    }
}