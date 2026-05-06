<?php

namespace App\Http\Resources\Course;

use Illuminate\Http\Resources\Json\JsonResource;
use App\Http\Resources\Category\CategorySimpleResource;

class AdmCourseResource extends JsonResource
{
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'title' => $this->title,
            'slug' => $this->slug,
            'subtitle' => $this->subtitle,
            'content_blocks' => $this->content_blocks ?? [], // Array garantizado
            'excerpt' => $this->excerpt,
            'description' => $this->description,
            'image_path' => $this->image_path,
            'video_url' => $this->video_url,
            'image_url' => $this->image_url,
            'status' => $this->status,
            'seo_title' => $this->seo_title,
            'seo_description' => $this->seo_description,
            'category_id' => $this->category_id,
            'category' => new CategorySimpleResource($this->whenLoaded('category')),
            'created_at' => $this->created_at->format('Y-m-d H:i:s'),
        ];
    }
}