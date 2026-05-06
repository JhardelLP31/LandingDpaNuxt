<?php

namespace App\Models\Sale;

use Carbon\Carbon;
use App\Models\Product\Product;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class SaleDetailAttention extends Model
{
    use SoftDeletes;
    protected $fillable = [
        "sale_detail_id",
        "product_id",
        "unidad_medida",
        "quantity",
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

    public function product(){
        return $this->belongsTo(Product::class,"product_id");
    }
}
