<?php
namespace App\Models\Media;

use Illuminate\Database\Eloquent\Model;

class Media extends Model
{
    // Agregamos academic_unit_id
    const UPDATED_AT = null; 

    protected $fillable = ['folder_id', 'academic_unit_id', 'filename', 'url', 'path', 'mime_type', 'size'];

    public function folder() { return $this->belongsTo(MediaFolder::class); }
}