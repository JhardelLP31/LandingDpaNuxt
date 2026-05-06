<?php

namespace App\Models\Menu;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Page\Page; 

class MenuItem extends Model
{
    use HasFactory;

    protected $table = 'menu_items';

    protected $fillable = [
        'title',
        'slug',
        'type',      
        'post_id',   
        'parent_id', 
        'order',
        'is_active'
    ];


    protected static function booted()
    {
        static::deleting(function ($menuItem) {
            // Antes de morir, el padre se lleva a sus hijos a la tumba
            // Esto ejecuta: DELETE FROM menu_items WHERE parent_id = {id_del_padre}
            $menuItem->children()->delete();
        });
    }

    /**
     * Relación: Un menú puede apuntar a una Página/Curso
     */
    public function page()
    {
        return $this->belongsTo(Page::class, 'post_id');
    }

    /**
     * Relación: Submenús (Hijos)
     */
    public function children()
    {
        return $this->hasMany(MenuItem::class, 'parent_id')->orderBy('order');
    }

    /**
     * Relación: Padre (Inversa, útil tenerla)
     */
    public function parent()
    {
        return $this->belongsTo(MenuItem::class, 'parent_id');
    }
}