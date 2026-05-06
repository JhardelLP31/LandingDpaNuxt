<?php

namespace App\Models\Lead;

use Illuminate\Database\Eloquent\Model;

class Lead extends Model
{
    // 1. Permitimos asignación masiva para estos campos
    protected $fillable = [
        'origin_url', 'first_name', 'last_name', 'email', 'phone', 'message', 
        'status', 'metadata' 
    ];

    // 2. MAGIA: Laravel convierte automáticamente el array 'metadata' a JSON al guardar
    protected $casts = [
        'metadata' => 'array', 
    ];
}