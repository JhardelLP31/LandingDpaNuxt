<?php
namespace App\Models\Academic;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;
use App\Models\Academic\AcademicUnit;

class Category extends Model
{
    protected $fillable = [
        'academic_unit_id',
        'parent_id',
        'name',
        'slug',
        'type',
        'description'
    ];

    // --- EL TOQUE SECRETO: GLOBAL SCOPE ---
    protected static function booted()
    {
        static::addGlobalScope('unit_filter', function (Builder $builder) {
            // Si el Middleware ya identificó la unidad académica...
            if (app()->has(AcademicUnit::class)) {
                $unit = app(AcademicUnit::class);
                // Filtramos automáticamente por el ID de esa unidad
                $builder->where('academic_unit_id', $unit->id);
            }
        });
    }

    // --- RELACIONES ---

    // Una categoría pertenece a una Unidad Académica
    public function academicUnit()
    {
        return $this->belongsTo(AcademicUnit::class);
    }

    // Una categoría puede tener una categoría padre
    public function parent()
    {
        return $this->belongsTo(Category::class, 'parent_id');
    }

    // Una categoría puede tener muchas sub-categorías (hijos)
    public function children()
    {
        return $this->hasMany(Category::class, 'parent_id');
    }
}