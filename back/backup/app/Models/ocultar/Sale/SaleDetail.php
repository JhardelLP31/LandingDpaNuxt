<?php

namespace App\Models\Sale;

use Carbon\Carbon;
use App\Models\Product\Product;
use Illuminate\Database\Eloquent\Model;
use App\Models\Product\ProductCategorie;
use Illuminate\Database\Eloquent\SoftDeletes;

class SaleDetail extends Model
{
    use SoftDeletes;
    protected $fillable = [
        "sale_id",
        "product_id",
        "product_categorie_id",
        "unidad_medida",
        "quantity",
        "price_final",
        "price_base",
        "discount",
        "subtotal",
        "igv",
        "description",
        "state_attention",
        "quantity_pending",
        // "created_at",
        // "updated_at",
        "tip_afe_igv",
        "per_icbper",
        "icbper",
        "percentage_isc",
        "isc",
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

    public function sale(){
        return $this->belongsTo(Sale::class,"sale_id");
    }
    public function product(){
        return $this->belongsTo(Product::class,"product_id");
    }
    public function product_categorie(){
        return $this->belongsTo(ProductCategorie::class,"product_categorie_id");
    }
}
