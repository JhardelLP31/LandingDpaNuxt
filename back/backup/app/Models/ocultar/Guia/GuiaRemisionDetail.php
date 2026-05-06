<?php

namespace App\Models\Guia;

use Carbon\Carbon;
use App\Models\Product\Product;
use Illuminate\Database\Eloquent\Model;
use App\Models\Product\ProductCategorie;
use Illuminate\Database\Eloquent\SoftDeletes;

class GuiaRemisionDetail extends Model
{
    use SoftDeletes;
    protected $fillable = [
        "guia_remision_id",
        "product_id",
        "product_categorie_id",
        "unidad_medida",
        "quantity",
        "peso",
        "total",
        "description",
    ];
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

    public function guia(){
        return $this->belongsTo(GuiaRemision::class,"guia_id");
    }
    public function product(){
        return $this->belongsTo(Product::class,"product_id");
    }
    public function product_categorie(){
        return $this->belongsTo(ProductCategorie::class,"product_categorie_id");
    }
}
