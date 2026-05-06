<?php
namespace App\Models\Marketing;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Builder;
use App\Models\Academic\AcademicUnit;

class Lead extends Model
{
    const UPDATED_AT = null;
    protected $fillable = [
        'campaign_id', 'first_name', 'last_name', 'email', 'phone',
        'payload', 'marketing_metadata', 'status', 'external_sync_status'
    ];

    protected $casts = [
        'payload' => 'array',
        'marketing_metadata' => 'array',
    ];

    // Relación
    public function campaign()
    {
        return $this->belongsTo(MarketingCampaign::class);
    }

    // Global Scope para filtrar leads por Unidad Académica a través de la Campaña
    protected static function booted()
    {
        static::addGlobalScope('academic_unit', function (Builder $builder) {
            if (app()->has(AcademicUnit::class)) {
                $unit = app(AcademicUnit::class);
                $builder->whereHas('campaign', function ($query) use ($unit) {
                    $query->where('academic_unit_id', $unit->id);
                });
            }
        });
    }
}