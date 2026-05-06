<?php

namespace App\Models\Content;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use App\Models\Academic\AcademicUnit;
use App\Traits\BelongsToAcademicUnit; 
class Content extends Model
{
    use BelongsToAcademicUnit; 
    use SoftDeletes;

    protected $fillable = [
        'academic_unit_id',
        'user_id',
        'title',
        'slug',
        'type',
        'content_blocks',
        'status',
        'seo_config',
        'published_at',
        'primary_color',
        'font_family'
    ];

    protected $casts = [
        'content_blocks' => 'collection', 
        'seo_config' => 'object',
        'published_at' => 'datetime',
    ];
    public function getRouteKeyName()
    {
        return 'slug';
    }


    public function unit()
    {
        return $this->belongsTo(AcademicUnit::class, 'academic_unit_id');
    }
    public function author()
    {
        return $this->belongsTo(\App\Models\User::class, 'user_id');
    }
}
