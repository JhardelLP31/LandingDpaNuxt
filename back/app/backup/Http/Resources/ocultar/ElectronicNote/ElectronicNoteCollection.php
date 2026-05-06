<?php

namespace App\Http\Resources\ElectronicNote;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\ResourceCollection;
use App\Http\Resources\ElectronicNote\ElectronicNoteResource;

class ElectronicNoteCollection extends ResourceCollection
{
    /**
     * Transform the resource collection into an array.
     *
     * @return array<int|string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            "data" => ElectronicNoteResource::collection($this->collection),
        ];
    }
}
