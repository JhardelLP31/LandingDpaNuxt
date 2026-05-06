<?php

namespace App\Models\Page;

use Carbon\Carbon;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use App\Models\PageCategory\Category;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Page extends Model
{
    use SoftDeletes, HasFactory;

    // IMPORTANTE: Definimos la tabla porque el modelo es 'Page' pero la tabla es 'posts'
    protected $table = 'posts';

    protected $fillable = [
        'user_id',
        'category_id',
        'title',
        'slug',
        'type',
        'status',
        'content_blocks',
        'excerpt',
        'featured_image_path',
        'seo_title',
        'seo_description',
        'status_course',
        'start_date',
        'end_date',
    ];

    // Opcional: Para que el precio siempre sea número en el JSON
    protected $casts = [
        'content_blocks' => 'array' // Esto ayuda mucho con el JSON
    ];
    public function category() {
    return $this->belongsTo(Category::class);
    }

    // -----------------------------------------------------------
    // MUTADORES DE FECHA (Timezone Lima - Copiado de tu estilo)
    // -----------------------------------------------------------
    public function setCreatedAtAttribute($value)
    {
        date_default_timezone_set('America/Lima');
        $this->attributes["created_at"] = Carbon::now();
    }

    public function setUpdatedAtAttribute($value)
    {
        date_default_timezone_set("America/Lima");
        $this->attributes["updated_at"] = Carbon::now();
    }

    // -----------------------------------------------------------
    // RELACIONES
    // -----------------------------------------------------------

    // El autor de la página
    public function user()
    {
        return $this->belongsTo(User::class);
    }

    // Relación Muchos a Muchos con Categorías (Vital para tus filtros)
    public function categories()
    {
        return $this->belongsToMany(Category::class, 'category_post', 'post_id', 'category_id');
    }

    // -----------------------------------------------------------
    // ACCESSORS (Manejo de Imagen URL)
    // -----------------------------------------------------------

    // Esto crea un atributo virtual $page->imagen
    public function getImagenAttribute()
    {
        $link = null;
        if ($this->featured_image_path) {
            if (str_contains($this->featured_image_path, "https://") || str_contains($this->featured_image_path, "http://")) {
                $link = $this->featured_image_path;
            } else {
                $link = env('APP_URL') . 'storage/' . $this->featured_image_path;
            }
        }
        return $link;
    }

    // -----------------------------------------------------------
    // SCOPES (Filtros Avanzados para el Controlador)
    // -----------------------------------------------------------
    public function scopeFilterAdvance($query, $search, $state)
    {
        // Filtro por Título o Slug
        if ($search) {
            $query->where(DB::raw("CONCAT(posts.title,' ',posts.slug)"), "like", "%" . $search . "%");
        }

        // Filtro por Estado (published/draft)
        if ($state) {
            $query->where("status", $state);
        }

        return $query;
    }
}
