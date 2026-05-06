<?php

namespace App\Http\Resources\Manual;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\ResourceCollection;

class ManualCollection extends ResourceCollection
{
    /**
     * Transform the resource collection into an array.
     *
     * @return array<int|string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            // Usamos el ManualResource para formatear cada item de la lista
            "data" => ManualResource::collection($this->collection),
        ];
    }
}