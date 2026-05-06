<?php

namespace App\Http\Resources\Course;

use Illuminate\Http\Resources\Json\JsonResource;
use App\Http\Resources\Category\CategorySimpleResource;
use App\Http\Resources\Category\CategoryResource; // Asumiendo que ya creamos este antes

class AdmCourseResource extends JsonResource
{
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'title' => $this->title,
            'slug' => $this->slug,
            'subtitle' => $this->subtitle,
            
            // Precios
            'price' => $this->price,
            'price_original' => $this->price_original,
            'status_course' => $this->status_course,
            'modality' => $this->modality,
            
            // Contenidos
            'excerpt' => $this->excerpt,
            'description' => $this->description,
            
            // Multimedia
            'image_path' => $this->image_path,
            'image_url' => $this->image_url,

            // Metadatos
            'start_date' => $this->start_date ? $this->start_date->format('Y-m-d') : null,
            'end_date' => $this->end_date ? $this->end_date->format('Y-m-d') : null,
            'status' => $this->status,
            
            // SEO
            'seo_title' => $this->seo_title,
            'seo_description' => $this->seo_description,
            'category_id' => $this->category_id,
            'category' => new CategorySimpleResource($this->whenLoaded('category')),
            'instructor' => $this->whenLoaded('instructor', function() {
                return [
                    'id' => $this->instructor->id,
                    'name' => $this->instructor->name,
                    'email' => $this->instructor->email,
                    // Agrega avatar si tienes
                ];
            }),

            'created_at' => $this->created_at->format('Y-m-d H:i:s'),
        ];
    }
}