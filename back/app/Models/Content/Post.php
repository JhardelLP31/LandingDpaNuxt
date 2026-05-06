<?php

namespace App\Models\Content;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Models\Academic\AcademicUnit;
use App\Models\Academic\Category; 

class Post extends Model
{
    use HasFactory, SoftDeletes;

    protected $table = 'posts';

    protected $fillable = [
        'academic_unit_id',
        'category_id',
        'title',
        'slug',
        'type',
        'excerpt',
        'body',
        'featured_image_path',
        'status',
        'start_date',
        'end_date',
    ];

    // Para que las fechas se traten como objetos Carbon automáticamente
    protected $casts = [
        'start_date' => 'datetime',
        'end_date' => 'datetime',
    ];

    /**
     * Relación: Una noticia/evento pertenece a una Categoría
     */
    public function category()
    {
        // Cambia la ruta del modelo Category si lo tienes en otra carpeta
        return $this->belongsTo(Category::class, 'category_id');
    }

    /**
     * Relación: Una noticia/evento pertenece a una Unidad Académica
     */
    public function academicUnit()
    {
        return $this->belongsTo(AcademicUnit::class, 'academic_unit_id');
    }
}