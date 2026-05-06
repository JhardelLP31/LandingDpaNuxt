<?php

namespace App\Http\Resources\Lead;

use Illuminate\Http\Resources\Json\JsonResource;

class LeadResource extends JsonResource
{
    public function toArray($request)
    {
        return [
            'id' => $this->id,
            'origin_url' => $this->origin_url,
            'first_name' => $this->first_name,
            'last_name' => $this->last_name,
            'full_name' => $this->first_name . ' ' . $this->last_name, // Helper útil para tablas
            'email' => $this->email,
            'phone' => $this->phone,
            'message' => $this->message,
            'status' => $this->status,
            // Aseguramos que metadata sea un objeto/array, no null
            'metadata' => $this->metadata ?? [], 
            // Formatos de fecha legibles
            'created_at' => $this->created_at ? $this->created_at->format('Y-m-d H:i:s') : null,
            'updated_at' => $this->updated_at ? $this->updated_at->format('Y-m-d H:i:s') : null,
        ];
    }
}