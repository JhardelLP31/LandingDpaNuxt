<?php

namespace App\Models\Course;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Support\Facades\Storage;
use App\Models\Category\Category;
use App\Models\User;

class Course extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'courses';

    protected $fillable = [
        'user_id',
        'category_id',
        'title',
        'slug',
        'subtitle',
        'price',
        'price_original',
        'status_course',
        'modality',
        'excerpt',
        'description',
        'content_blocks', // <--- Tu constructor de bloques
        'image_path',
        'video_url',
        'start_date',
        'end_date',
        'status',
        'seo_title',
        'seo_description'
    ];

    // Mágica conversión automática de tipos
    protected $casts = [
        'price' => 'decimal:2',
        'price_original' => 'decimal:2',
        'start_date' => 'date:Y-m-d',
        'end_date' => 'date:Y-m-d',
        'content_blocks' => 'array', // <--- ESTO ES CRUCIAL: JSON <-> Array
        'is_active' => 'boolean', // Si usas status como boolean en lógica interna
    ];

    // Virtual: URL completa de la imagen
    protected $appends = ['image_url'];

    public function getImageUrlAttribute()
    {
        return $this->image_path ? Storage::url($this->image_path) : null;
    }

    // --- RELACIONES ---

    public function category()
    {
        return $this->belongsTo(Category::class);
    }
// En app/Models/Course.php

    public function getRouteKeyName()
    {
        return 'slug'; // Le dice a Laravel: "Busca por esta columna en la URL"
    }
    public function instructor()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
    // App/Models/Course/Course.php


    public function teacher() {
        // Asegúrate que 'user_id' sea el correcto para el profesor
        return $this->belongsTo(\App\Models\User::class, 'user_id');
    }
}