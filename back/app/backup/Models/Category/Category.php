<?php

namespace App\Models\Category;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Relations\HasMany;
use Illuminate\Database\Eloquent\Relations\BelongsTo;
use Illuminate\Support\Facades\Storage;

class Category extends Model
{
    use HasFactory, SoftDeletes;

    // Si tu tabla se llama 'categories', Laravel la detecta solo. 
    // Si la carpeta confunde a Laravel, forzamos el nombre:
    protected $table = 'categories';

    protected $fillable = [
        'parent_id',
        'name',
        'slug',
        'type', 
        'description',
        'image_path',
        'color',
        'is_active'
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    // --- ACCESORS (Atributos virtuales) ---
    
    // Esto crea un campo 'image_url' automático en el JSON
    protected $appends = ['image_url'];

    public function getImageUrlAttribute()
    {
        return $this->image_path 
            ? Storage::url($this->image_path) 
            : null;
    }

    // --- RELACIONES ---

    public function parent(): BelongsTo
    {
        return $this->belongsTo(Category::class, 'parent_id');
    }

// Relación simple de un nivel
    public function children()
    {
        return $this->hasMany(Category::class, 'parent_id');
    }

    // Relación recursiva (la que usa el Resource y el Controlador)
    public function childrenRecursive()
    {
        return $this->children()->with('childrenRecursive');
    }

    // --- SCOPES ---
    
    public function scopeRoots($query)
    {
        return $query->whereNull('parent_id');
    }
}