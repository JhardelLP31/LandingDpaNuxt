<?php

// 🚨 IMPORTANTE: Revisa que este namespace coincida con la carpeta donde está tu archivo
// Si tu controlador dice "use App\Models\Marketing\Lead;", el namespace debe ser este:
namespace App\Models\Lead; 

use Illuminate\Database\Eloquent\Model;

class Lead extends Model
{
    // 1. Permitimos asignación masiva para los NUEVOS campos
    protected $fillable = [
        'first_name', 
        'last_name', 
        'email', 
        'phone', 
        'status', 
        'payload',              // ¡Nuevo!
        'marketing_metadata',   // ¡Nuevo!
        'external_sync_status'  // Lo tenías en el controlador
    ];

    // 2. MAGIA: Laravel convierte automáticamente a JSON al guardar y a Array al leer
    protected $casts = [
        'payload' => 'array',
        'marketing_metadata' => 'array',
    ];
}