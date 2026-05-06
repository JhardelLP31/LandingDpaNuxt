<?php

namespace App\Models\Note;

use Carbon\Carbon;
use App\Models\User;
use App\Models\Sale\Sale;
use App\Models\Client\Client;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class ElectronicNote extends Model
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
        "n_comprobante",
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
        "doc_nota",
        "type_nota",
        "description_motivo",
        // "created_at",
        // "updated_at",
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


    public function electronic_note_details() {
        return $this->hasMany(ElectronicNoteDetail::class,"electronic_note_id");
    }

    public function details() {
        return $this->hasMany(ElectronicNoteDetail::class,"electronic_note_id");
    }

    public function ce_relation() {
        return $this->belongsTo(Sale::class,"n_comprobante","n_operacion");
    }

    public function ce_anticipo() {
        return $this->belongsTo(Sale::class,"n_comprobante_anticipo","n_operacion");
    }
}
