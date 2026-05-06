<?php
namespace App\Models\Media;

use Illuminate\Database\Eloquent\Model;

class MediaFolder extends Model
{
    protected $fillable = ['parent_id', 'academic_unit_id', 'name'];

    // ESTO ES VITAL: Si tu tabla no tiene updated_at, dile a Laravel:
    public $timestamps = true; 
    // Pero si solo tienes created_at, usa esto mejor:
    const UPDATED_AT = null; 

    public function subfolders() { return $this->hasMany(MediaFolder::class, 'parent_id'); }
    public function files() { return $this->hasMany(Media::class, 'folder_id'); }
}