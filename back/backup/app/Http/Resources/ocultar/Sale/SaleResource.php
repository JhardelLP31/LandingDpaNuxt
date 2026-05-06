<?php

namespace App\Http\Resources\Sale;

use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class SaleResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $discount_global_general = 0;
        if($this->resource->discount_global){
            $discount_global_general += $this->resource->discount_global;
        }
        if($this->resource->amount_anticipo){
            $discount_global_general += $this->resource->amount_anticipo;
        }

        $percepcion_igv_total = 0;
        if ($this->resource->retencion_igv == 3) {
            $percepcion_igv_total = round(($this->resource->total * 0.04),2);  
        }
        $retencion_igv_total = 0;
        switch ($this->resource->retencion_igv) {
            case 1://Retención
                $retencion_igv_total = round(($this->resource->total * 0.03),2);
                break;
            case 2://Detracción
                $retencion_igv_total = round(($this->resource->total * 0.04),2);
                break;
            // case 3://Percepción
            //     $retencion_igv_total = round(($this->resource->total * 0.04),2);  
            //     break;    
            default:
                break;
        }
        $icbper_total = $this->resource->sale_details->sum('icbper');
        $isc_total = $this->resource->sale_details->sum('isc');
        return [
            "id" => $this->resource->id,
            "user_id"  => $this->resource->user_id,
            "user" => [
                "full_name" => $this->resource->user->name.' '.$this->resource->user->surname,
            ],
            "client_id"  => $this->resource->client_id,
            "client" => [
                "id" => $this->resource->client->id,
                "full_name" => $this->resource->client->full_name,
                "n_document" => $this->resource->client->n_document,
                "type_client" => $this->resource->client->type_client,
            ],
            "correlativo_sale" => str_pad($this->resource->id, 8, "0", STR_PAD_LEFT),
            // 
            "serie" => $this->resource->serie,
            "retencion_igv" => (float) $this->resource->retencion_igv,
            "discount_global" => (float) $this->resource->discount_global,
            "n_comprobante_anticipo" => $this->resource->n_comprobante_anticipo,
            "amount_anticipo" => $this->resource->amount_anticipo,
            "ce_anticipo" => $this->resource->ce_anticipo ? [
               "id" => $this->resource->ce_anticipo->id,
                "n_operacion" => $this->resource->ce_anticipo->n_operacion,
                "subtotal" => (float) $this->resource->ce_anticipo->subtotal,
                "total" => (float) $this->resource->ce_anticipo->total,
                "igv" => (float) $this->resource->ce_anticipo->igv,
            ]: NULL,
            "sales_anticipos" => $this->resource->sales_anticipos ? json_decode($this->resource->sales_anticipos,true) : null,
            "cdr" => env("APP_URL_2").$this->resource->cdr,
            "xml" => env("APP_URL_2").$this->resource->xml,
            "igv_discount_general" => $this->resource->igv_discount_general,
            // 
            "correlativo" => $this->resource->correlativo,
            "n_operacion" => $this->resource->n_operacion,
            "type_client"  => $this->resource->type_client,
            "subtotal"  => (float) $this->resource->subtotal,
            "discount"  => (float) $this->resource->discount,
            // 
            "total_general"  => round(($this->resource->total + $icbper_total + $isc_total + $percepcion_igv_total) - ($discount_global_general + ($this->resource->igv_discount_general ?? 0) + $retencion_igv_total),2) ,
            "igv_general"  => (float) ($this->resource->igv - ($this->resource->igv_discount_general ?? 0)),
            // 
            "total"  => (float) $this->resource->total,
            "igv"  => (float) $this->resource->igv,
            "is_exportacion"  => (float) $this->resource->is_exportacion,
            "currency"  => $this->resource->currency,

            "state_sale"  => (float) $this->resource->state_sale,
            "state_payment"  => (float) $this->resource->state_payment,
            "state_entrega" => (float) $this->resource->state_entrega,
            "type_payment" => $this->resource->type_payment,
            "debt"  => (float) $this->resource->debt,
            "paid_out"  => (float) $this->resource->paid_out,
            "date_validation"  => $this->resource->date_validation,
            "date_pay_complete"  => $this->resource->date_pay_complete,
            "description"  => $this->resource->description,
            "created_at" => $this->resource->created_at->format("Y-m-d h:i A"),
            "created_at_format" => $this->resource->created_at->format("Y-m-d"),
            "sale_details" => $this->resource->sale_details->map(function($sale_detail) {
                return SaleDetailResource::make($sale_detail);
            }),
            "payments" => $this->resource->payments->map(function($sale_payment) {
                return [
                    "id" => $sale_payment->id,
                    "method_payment"  => $sale_payment->method_payment,
                    "amount"  => $sale_payment->amount,
                    "date_payment"  => $sale_payment->date_payment ? Carbon::parse($sale_payment->date_payment)->format("Y-m-d") : NULL,
                ];
            }),
            "notas" => $this->resource->notas->map(function($nota) {
                return [
                    "id" => $nota->id,
                    "n_operacion" =>  $nota->n_operacion,
                    "doc_nota" => $nota->doc_nota,
                    "url" => env("APP_URL")."api/electronic-note-pdf/".$nota->n_operacion,
                    "created_at" => $nota->created_at->format("Y-m-d h:i A")
                ];
            }),
        ];
    }
}
