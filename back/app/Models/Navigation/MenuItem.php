<?php
namespace App\Models\Navigation;

use Illuminate\Database\Eloquent\Model;
use App\Models\Content\Content;

class MenuItem extends Model
{
    public $timestamps = false; // Sin timestamps

    protected $fillable = [
        'menu_id',
        'parent_id',
        'content_id',
        'title',
        'url',
        'order',
        'target'
    ];

    public function menu() { return $this->belongsTo(Menu::class); }
    public function parent() { return $this->belongsTo(MenuItem::class, 'parent_id'); }
    public function children() { return $this->hasMany(MenuItem::class, 'parent_id')->with('children')->orderBy('order'); }
    public function content() { return $this->belongsTo(Content::class); }
}