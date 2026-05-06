<?php
namespace App\Models\Marketing;

use Illuminate\Database\Eloquent\Model;
use App\Models\Academic\AcademicUnit;
use App\Models\Content\Content;
use App\Models\Content\StudyProgram;

class MarketingCampaign extends Model
{
    const UPDATED_AT = null; // Tu SQL solo tiene created_at

    protected $fillable = [
        'academic_unit_id',
        //'study_program_id',
        //'content_id',
        'name',
        'slug',
        'academic_period',
        'form_config',
        //'utm_source_default',
        'is_active',
        'start_date',
        'end_date'
    ];

    protected $casts = [
        'form_config' => 'array',
        'is_active' => 'boolean',
        'start_date' => 'date',
        'end_date' => 'date',
    ];

    public function unit() { return $this->belongsTo(AcademicUnit::class); }
    //public function program() { return $this->belongsTo(StudyProgram::class, 'study_program_id'); }
    //public function landing() { return $this->belongsTo(Content::class, 'content_id'); }
    public function leads() { return $this->hasMany(Lead::class, 'campaign_id'); }
}