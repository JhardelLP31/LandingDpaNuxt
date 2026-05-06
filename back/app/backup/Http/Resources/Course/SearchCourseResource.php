<?php

namespace App\Http\Resources\Course;

use Illuminate\Http\Resources\Json\JsonResource;
use Illuminate\Support\Str;

class SearchCourseResource extends JsonResource
{
    public function toArray($request)
    {
        $image = $this->image_path;

        if ($image) {
            // 1. Si ya empieza con http, la dejamos tal cual
            if (Str::startsWith($image, ['http://', 'https://'])) {
                // Solo nos aseguramos de no tener dobles barras perdidas por ahí
                $image = str_replace('8000//', '8000/', $image);
            } 
            // 2. Si no es URL, le pegamos el dominio y el storage
            else {
                $image = asset('storage/' . ltrim($image, '/'));
            }
        }

        return [
            'id'    => $this->id,
            'title' => $this->title,
            'slug'  => $this->slug,
            'image' => $image,
            'url'   => "/programas/{$this->slug}",
        ];
    }
}