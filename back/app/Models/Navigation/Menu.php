<?php
namespace App\Models\Navigation;

use Illuminate\Database\Eloquent\Model;
use App\Models\Academic\AcademicUnit;

class Menu extends Model
{
    public $timestamps = false; // Ni created_at ni updated_at en tu SQL

    protected $fillable = [
        'academic_unit_id',
        'name',
        'location',
        'settings'
    ];

    protected $casts = [
        'settings' => 'array',
    ];

    public function unit() { return $this->belongsTo(AcademicUnit::class); }
    public function items() { return $this->hasMany(MenuItem::class)->whereNull('parent_id')->orderBy('order'); }
}