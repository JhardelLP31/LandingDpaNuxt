<?php
namespace App\Models\Academic;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class AcademicUnit extends Model
{
    use SoftDeletes; // Usa created_at, updated_at, deleted_at

    protected $fillable = [
        'name',
        'slug',
        'code',
        'domain',
        'is_active'
    ];

    protected $casts = [
        'is_active' => 'boolean',
    ];

    public function branding() { return $this->hasOne(UnitBranding::class); }
}