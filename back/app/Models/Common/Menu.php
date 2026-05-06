<?php

namespace App\Models\Common;

use Illuminate\Database\Eloquent\Model;

class Menu extends Model
{
    protected $table = 'menus';
    public $timestamps = false;
    protected $fillable = ['academic_unit_id', 'name', 'location'];

    public function items()
    {
        return $this->hasMany(MenuItem::class, 'menu_id');
    }
}
