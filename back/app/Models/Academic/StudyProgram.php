<?php
namespace App\Models\Academic;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;

class StudyProgram extends Model
{
    protected $fillable = [
        'academic_unit_id', 'category_id', 'name', 'slug', 'branding_color','curriculum_json',
        'description', 'modality', 'duration', 'is_active'
    ];

    protected static function booted()
    {
        static::addGlobalScope('unit_filter', function (Builder $builder) {
            if (app()->has(AcademicUnit::class)) {
                $builder->where('academic_unit_id', app(AcademicUnit::class)->id);
            }
        });
    }

    // Relaciones
    public function category() { return $this->belongsTo(Category::class); }
}