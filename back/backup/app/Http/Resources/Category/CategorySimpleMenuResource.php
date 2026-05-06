<?php

namespace App\Http\Resources\Category;

use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Facades\Storage; // <--- Importar
use Illuminate\Support\Str;             // <--- Importar

class CategorySimpleMenuResource extends JsonResource
{
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'slug' => $this->slug,
            'color' => $this->color ?? '#e31140',
            'type' => $this->type,
        
            // --- CORRECCIÓN ---
            // 1. Usamos 'image_path' (el dato crudo de la BD) en vez de 'image_url'.
            // 2. Preguntamos: ¿Ya tiene http?
            //    SI -> Lo dejamos tal cual.
            //    NO -> Le ponemos el Storage::url (que agrega /storage/).
            // 'image' => Str::startsWith($this->image_path, 'http')
            //     ? $this->image_path
            //     : Storage::url($this->image_path),
            // 'image_path' => $this->image_path,
            // 'image_url' => $this->image_url,
        ];
    }
}
