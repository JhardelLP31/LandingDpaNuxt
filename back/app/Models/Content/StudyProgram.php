<?php
namespace App\Models\Content;

use Illuminate\Database\Eloquent\Model;
use App\Models\Academic\AcademicUnit;

class StudyProgram extends Model
{
    protected $table = 'study_programs';
    const UPDATED_AT = null; // Solo tienes created_at

    protected $fillable = [
        'academic_unit_id',
        'category_id',
        'name',
        'slug',
        'branding_color',
        'description',
        'is_active'
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    public function unit() { return $this->belongsTo(AcademicUnit::class); }
    public function category() { return $this->belongsTo(Category::class); }
}