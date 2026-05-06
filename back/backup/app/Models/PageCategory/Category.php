<?php

namespace App\Models\PageCategory;

use Carbon\Carbon;
use App\Models\Page\Page;
use Illuminate\Support\Facades\DB;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Category extends Model
{
    use HasFactory;

    protected $table = 'categories';

    protected $fillable = [
        "name",
        "slug",
        "parent_id", 
        "description",
        "image_path",
        "is_active", 
        "type",      
    ];

    // -----------------------------------------------------------
    // MUTADORES DE FECHA (Timezone Lima)
    // -----------------------------------------------------------
    public function setCreatedAtAttribute($value)
    {
        date_default_timezone_set('America/Lima');
        $this->attributes["created_at"]= Carbon::now();
    }

    public function setUpdatedAtAttribute($value)
    {
        date_default_timezone_set("America/Lima");
        $this->attributes["updated_at"]= Carbon::now();
    }

    // -----------------------------------------------------------
    // RELACIONES
    // -----------------------------------------------------------
    
    // Relación con Páginas/Cursos (Muchos a Muchos)
    public function pages() {
        return $this->belongsToMany(Page::class, 'category_post', 'category_id', 'post_id');
    }

    // Relación recursiva (Padre)
    public function parent() {
        return $this->belongsTo(Category::class, 'parent_id');
    }

    // Relación recursiva (Hijos)
    public function children() {
        return $this->hasMany(Category::class, 'parent_id');
    }

    // -----------------------------------------------------------
    // ACCESSORS (Imagen URL)
    // -----------------------------------------------------------
    public function getImagenAttribute()
    {
        $link = null;
        if($this->image_path){
            if(str_contains($this->image_path,"https://") || str_contains($this->image_path,"http://")){
                $link = $this->image_path;
            }else{
                $link = env('APP_URL').'storage/'.$this->image_path;
            }
        }
        return $link;
    }

    // -----------------------------------------------------------
    // SCOPES (Filtros)
    // -----------------------------------------------------------
    public function scopeFilterAdvance($query, $search, $state)
    {
        if($search){
            $query->where("name","like","%".$search."%");
        }
        if($state){ // 1 o 0
            $query->where("is_active", $state);
        }
        return $query;
    }
}