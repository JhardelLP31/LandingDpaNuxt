<?php
namespace App\Models\Content;

use Illuminate\Database\Eloquent\Model;
use App\Models\Academic\AcademicUnit;

class Category extends Model
{
    const UPDATED_AT = null; // Tu SQL solo tiene created_at

    protected $fillable = [
        'academic_unit_id',
        'parent_id',
        'name',
        'slug',
        'type'
    ];

    public function unit() { return $this->belongsTo(AcademicUnit::class); }
    public function parent() { return $this->belongsTo(Category::class, 'parent_id'); }
    public function children() { return $this->hasMany(Category::class, 'parent_id'); }
}
