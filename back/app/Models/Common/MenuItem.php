<?php
namespace App\Models\Common;

use App\Models\Content\Content; 
use Illuminate\Database\Eloquent\Model;

class MenuItem extends Model
{
    protected $table = 'menu_items';

    protected $fillable = [
        'menu_id', 'parent_id', 'content_id', 'title', 'url', 'order', 'target'
    ];

    public function children()
    {
        return $this->hasMany(MenuItem::class, 'parent_id')->orderBy('order');
    }

    // ESTA ES LA BUENA 🏆
    public function content()
    {
        return $this->belongsTo(Content::class, 'content_id');
    }
}