<?php

namespace App\Models\Manual;

use App\Models\User;
use App\Models\PageCategory\Category;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Manual extends Model
{
    use SoftDeletes;

    protected $table = 'manuals'; // Tabla específica

    protected $fillable = [
        'user_id', 'category_id', 'title', 'slug', 'description', 
        'image_path', 'download_links', 'status', 'seo_title', 'seo_description'
    ];

    protected $casts = [
        'download_links' => 'array',
        //'status' => 'string',        // Asegúrate de que no sea 'boolean' si guardas 'published'    
    ];

    public function category() {
        return $this->belongsTo(Category::class);
    }

    public function getImagenUrlAttribute() {
        return $this->image_path ? asset('storage/' . $this->image_path) : null;
    }
    // App\Models\Manual\Manual.php

    public function user() 
    {
        return $this->belongsTo(\App\Models\User::class);
    }
}