<?php

namespace App\Models\Sale;

use Carbon\Carbon;
use App\Models\User;
use App\Models\Client\Client;
use Illuminate\Support\Facades\DB;
use App\Models\Note\ElectronicNote;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Sale extends Model
{
    use SoftDeletes;
    protected $fillable = [
        "correlativo",
        "n_operacion",
        "user_id",
        "client_id",
        "type_client",
        "subtotal",
        "total",
        "igv",
        "state_sale",
        "state_payment",
        "type_payment",
        "debt",
        "paid_out",
        "date_validation",
        "date_pay_complete",
        "description",
        "state_entrega",
        "discount",
        // 
        "serie",
        "retencion_igv",
        "discount_global",
        "igv_discount_general",
        "n_comprobante_anticipo",
        "amount_anticipo",
        "cdr",
        "xml",
        "is_exportacion",
        "currency",
        // "created_at",
        // "updated_at",
        "sales_anticipos",
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

    public function user(){
        return $this->belongsTo(User::class,"user_id");
    }

    public function client(){
        return $this->belongsTo(Client::class,"client_id");
    }


    public function sale_details() {
        return $this->hasMany(SaleDetail::class,"sale_id");
    }

    public function details() {
        return $this->hasMany(SaleDetail::class,"sale_id");
    }

    public function payments() {
        return $this->hasMany(SalePayment::class,"sale_id");
    }

    public function ce_anticipo() {
        return $this->belongsTo(Sale::class,"n_comprobante_anticipo","n_operacion");
    }

    public function notas() {
        return $this->hasMany(ElectronicNote::class,"n_comprobante","n_operacion");
    }

    public function getFirstPaymentAttribute() {
        return $this->payments->first();
    }
    
    public function scopeFilterAdvance($query,$search,$product_categorie_id,$search_client,$start_date,$end_date,$state_sale,$type_payment,$search_product,$user){

            if($search){
                $query->where("id",$search);
            }
            if($product_categorie_id){
                $query->whereHas("sale_details",function($q) use($product_categorie_id){
                    $q->where("product_categorie_id",$product_categorie_id);
                });
            }
            if($search_client){
                $query->whereHas("client",function($q) use($search_client){
                    $q->where(DB::raw("CONCAT(clients.full_name,' ',clients.n_document,' ',clients.phone)"),"like","%".$search_client."%");
                });
            }
            if($start_date && $end_date){
                $query->whereBetween("created_at",[Carbon::parse($start_date)->format("Y-m-d")." 00:00:00",
                                                Carbon::parse($end_date)->format("Y-m-d")." 23:59:59"]);
            }
            if($state_sale){
                $query->where("state_sale",$state_sale);
            }
            if($type_payment){
                $query->where("type_payment",$type_payment);
            }
            if($search_product){
                $query->whereHas("sale_details",function($q) use($search_product){
                    $q->whereHas("product",function($subq) use($search_product){
                        $subq->where(DB::raw("CONCAT(products.title,' ',products.sku))"),"like","%".$search_product."%");
                    });
                });
            }
            if($user){
                if($user->role_id != 1){
                    $query->where("user_id",$user->id);
                }
            }
            return $query;
    }
}
