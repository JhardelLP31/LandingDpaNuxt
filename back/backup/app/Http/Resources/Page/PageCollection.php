<?php

namespace App\Http\Resources\Page;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\ResourceCollection;

class PageCollection extends ResourceCollection
{
    /**
     * Transform the resource collection into an array.
     *
     * @return array<int|string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            // Usamos el PageResource para formatear cada item de la lista
            "data" => PageResource::collection($this->collection),
        ];
    }
}