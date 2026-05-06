<?php

namespace App\Http\Resources\Manual;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class ManualResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        // Usamos el helper asset() de Laravel que ya toma la URL del .env
        $baseUrl = rtrim(config('app.url'), '/');

        return [
            "id" => $this->id,
            "title" => $this->title,
            "slug" => $this->slug,
            "description" => $this->description,
            
            "status" => $this->status,
            "created_at" => $this->created_at ? $this->created_at->format("d/m/Y h:i A") : null,
            "updated_at" => $this->updated_at ? $this->updated_at->format("d/m/Y h:i A") : null,
            
            "image_path" => $this->image_path,
            "image_url" => $this->imagen_url, 

            "download_links" => $this->download_links ?? [],

            "category" => $this->category ? [
                "id" => $this->category->id,
                "name" => $this->category->name,
                "slug" => $this->category->slug,
            ] : null,

            "category_id" => $this->category_id,

            // SEO
            "seo_title" => $this->seo_title,
            "seo_description" => $this->seo_description,
        ];
    }
};