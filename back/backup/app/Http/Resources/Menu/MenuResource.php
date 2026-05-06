<?php

namespace App\Http\Resources\Menu;

use Illuminate\Http\Resources\Json\JsonResource;

class MenuResource extends JsonResource
{
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'title' => $this->title,
            
            'slug' => $this->slug,
            'type' => $this->type, 
            'post_id' => $this->post_id,
            'order' => $this->order,


            'link' => $this->resolveLink(),

            'children' => MenuResource::collection($this->whenLoaded('children')),
            
            'created_at' => $this->created_at->format('Y-m-d H:i'),
        ];
    }

private function resolveLink()
    {
        // 1. Enlace externo: devuelve tal cual
        if ($this->type === 'external') {
            return $this->slug; 
        }

        // 2. Cursos (Lógica específica de prefijo)
        if ($this->type === 'course') {
            return '/programas/' . $this->slug; 
        }

        // 3. GRUPOS DINÁMICOS (NUEVO)
        // Si el tipo es dinámico, devolvemos el slug como ruta base (ej: /noticias)
        // O si prefieres que NO tenga link (sea solo texto), devuelves '#'
        if ($this->type === 'dynamic_group') {
            return $this->slug === 'home' ? '/' : '/' . $this->slug;
        }

        // 4. CATEGORÍAS (NUEVO - Opcional)
        // Como en Vue ya guardamos la ruta completa (ej: blog/categoria/futbol), 
        // el return por defecto funciona bien. 
        // Pero si en el futuro guardas solo "futbol", necesitarías un if aquí.

        // Default (Páginas, Categorías con ruta completa, etc.)
        return $this->slug === 'home' ? '/' : '/' . $this->slug;
    }
}   