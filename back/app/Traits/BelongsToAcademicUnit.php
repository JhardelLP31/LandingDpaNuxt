<?php
namespace App\Traits;

use App\Models\Academic\AcademicUnit;
use Illuminate\Database\Eloquent\Builder;

trait BelongsToAcademicUnit
{
    protected static function bootBelongsToAcademicUnit()
    {
        static::addGlobalScope('academic_unit', function (Builder $builder) {
            if (app()->has(AcademicUnit::class)) {
                $unit = app(AcademicUnit::class);
                $builder->where($builder->getModel()->getTable() . '.academic_unit_id', $unit->id);
            }
        });

        static::creating(function ($model) {
            if (app()->has(AcademicUnit::class) && empty($model->academic_unit_id)) {
                $model->academic_unit_id = app(AcademicUnit::class)->id;
            }
        });
    }

    public function unit()
    {
        return $this->belongsTo(AcademicUnit::class, 'academic_unit_id');
    }
}