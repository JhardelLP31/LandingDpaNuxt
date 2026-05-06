<?php
namespace App\Http\Requests\Marketing;

use Illuminate\Foundation\Http\FormRequest;

class StoreLeadRequest extends FormRequest
{
    public function authorize()
    {
        return true; 
    }

    public function rules()
    {
        return [
            'campaign_id'      => 'nullable|exists:marketing_campaigns,id', 
            'first_name'       => 'required|string|max:150',
            'apellido_paterno' => 'required|string|max:150',
            'apellido_materno' => 'required|string|max:150',
            
            'email'            => 'required|email|max:255',
            'phone'            => 'nullable|string|max:20', 
            'slug_carrera'     => 'nullable|string|max:255',
            
            // Para recibir el token del captcha (o nuestro bypass)
            'recaptcha_token'  => 'nullable|string',
            
            // --- Payload (Respuestas dinámicas estrictas) ---
            'payload'                     => 'required|array', 
            'payload.tipo_documento'      => 'required|string|in:DNI,CE,PAS',
            'payload.numero_documento'    => 'required|string|max:15',
            
            
            'payload.estudios_superiores' => 'nullable|string',
            'payload.consulta'            => 'nullable|string|max:500',
            'payload.programa_origen'     => 'nullable|string|max:255',
            'payload.curso_interes'       => 'nullable|string|max:255', 
            'payload.url_slug'            => 'nullable|string|max:255', 
            
            // Checks de términos y condiciones
            'payload.acepta_condiciones'  => 'nullable|boolean', 
            'payload.acepta_publicidad'   => 'nullable|boolean',
            
            // El ID del formulario antiguo
            'payload.cod_form_old'        => 'nullable|integer', 
            
            // --- Tracking de UTMs ---
            'marketing_metadata'                => 'nullable|array', 
            'marketing_metadata.utm_source'     => 'nullable|string',
            'marketing_metadata.utm_medium'     => 'nullable|string',
            'marketing_metadata.utm_campaign'   => 'nullable|string',
            
            // Faltaba para el refererhidden
            'marketing_metadata.referrer'       => 'nullable|string', 
        ];
    }

    public function messages()
    {
        return [
            'campaign_id.exists'          => 'La campaña enlazada no es válida o ha sido eliminada.',
            'payload.tipo_documento.in'   => 'El tipo de documento debe ser DNI, CE o PAS.',
            'apellido_paterno.required'   => 'El apellido paterno es obligatorio.',
            'apellido_materno.required'   => 'El apellido materno es obligatorio.',
        ];
    }
}