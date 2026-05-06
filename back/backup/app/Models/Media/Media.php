<?php

namespace App\Models\Media;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Media extends Model
{
    use HasFactory;

    protected $table = 'media';

    protected $fillable = [
        'filename',
        'url',
        'type', 
        'path',
        'mime_type',
        'size',
        'collection', 
        'is_public',   
    ];

    /**
     * Scope para traer solo imágenes (útil para la galería del CMS)
     */
    public function scopeImages($query)
    {
        return $query->where('collection', 'images');
    }

    /**
     * Scope para traer solo documentos
     */
    public function scopeDocuments($query)
    {
        return $query->where('collection', 'documents');
    }
}