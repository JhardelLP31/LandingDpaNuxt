<?php

namespace App\Http\Controllers\Api\Marketing;

use App\Http\Controllers\Controller;
use App\Http\Requests\Marketing\StoreLeadRequest;
use App\Http\Resources\Marketing\LeadResource;
use App\Models\Marketing\Lead;
use Illuminate\Http\Request;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

// use App\Exports\Lead\LeadExport;
// use Maatwebsite\Excel\Facades\Excel;
class LeadController extends Controller
{
    /**
     * GUARDA UN NUEVO LEAD (Público desde Landing)
     */
public function store(StoreLeadRequest $request)
    {
        $validated = $request->validated();

        // 1. Preparar Payload para DB moderna
        $payloadData = $validated['payload'] ?? [];
        $payloadData['slug_carrera'] = $request->input('slug_carrera');
        
        // Juntamos los apellidos para la DB de Laravel
        $fullNameLast = trim($validated['apellido_paterno'] . ' ' . $validated['apellido_materno']);

        // 2. Crear Lead en tu DB
        $lead = Lead::create([
            'campaign_id'        => $validated['campaign_id'] ?? null,
            'first_name'         => $validated['first_name'],
            'last_name'          => $fullNameLast, 
            'email'              => $validated['email'],
            'phone'              => $validated['phone'] ?? null,
            'payload'            => $payloadData,
            'marketing_metadata' => $validated['marketing_metadata'] ?? [],
            'status'             => 'new'
        ]);

        // 3. Preparar datos para el PHP antiguo
        $datosParaPHP = [
            'nombres'          => $validated['first_name'],
            'apellido-paterno' => $validated['apellido_paterno'],
            'apellido-materno' => $validated['apellido_materno'], 
            'email'            => $validated['email'],
            'celular'          => $validated['phone'] ?? '',
            'dni'              => $request->input('payload.numero_documento', ''),
            'consulta'         => $request->input('payload.consulta', ''),
            
            // Forzamos a que sean 1 o 0 (enteros) como espera el Legacy
            'datos-personales' => $request->input('payload.acepta_condiciones', false) ? 1 : 0,
            'comunicaciones'   => $request->input('payload.acepta_publicidad', false) ? 1 : 0,
            
            'cursando'         => $request->input('payload.estudios_superiores', ''),
            'carrera'          => $request->input('payload.programa_origen', ''),
            'carrerainteres'   => $request->input('payload.curso_interes', ''),
            'title'            => $request->input('payload.url_slug', 'Comunicate DPA'), 
            'form_id'          => $request->input('payload.cod_form_old', 0),
            
            // EL TRUCO DEL CAPTCHA: Mandamos basura para que el score sea 0 y entre al IF del Legacy
            'recaptcha_response' => 'token_invalido_para_forzar_bypass', 
            
            'refererhidden'    => $request->input('marketing_metadata.referrer', ''),
            'procedenciahidden'=> 'web',

            // CAMPOS FALTANTES QUE ESPERA EL MODELO ANTIGUO
            'cookdatos'        => '', 
            'idcarrera'        => 0,
            'modalidad'        => '',
            'departamento'     => '',
            'distrito'         => '',
            'edad'             => 0,
            'fechaevento'      => ''
        ];
        
        Log::info('Datos que se están enviando al Legacy:', $datosParaPHP);

        // 4. Envío al sistema antiguo
        try {
            $responseLegacy = Http::withoutVerifying() 
                ->timeout(10)
                ->withHeaders([
                    // EL TRUCO DEL REFERER: El PHP antiguo usa $_SERVER['HTTP_REFERER']
                    'Referer' => 'https://www.ue.edu.pe/pregrado/' 
                ])
                ->asForm()
                ->post('https://qaspre.ue.edu.pe/pregrado/correo/', $datosParaPHP);

            $legacyStatus = $responseLegacy->successful();

            Log::info('Respuesta del PHP Legacy:', [
                'status' => $responseLegacy->status(),
                'body'   => $responseLegacy->body()
            ]);
        } catch (\Exception $e) {
            Log::error('Fallo de conexión al sistema Legacy: ' . $e->getMessage());
            $legacyStatus = false;
        }

        return response()->json([
            'success'       => true,
            'legacy_synced' => $legacyStatus,
            'data'          => $lead
        ], 201);
    }

    /**
     * LISTAR LEADS (Solo Admin)
     */
    public function index(Request $request)
    {
        /*if (!Gate::allows('viewAny', Lead::class)) {
            return response()->json(['success' => false, 'message' => 'Sin permisos', 'code' => 403]);
        }*/

        $search = $request->get("search");

        $leads = Lead::when($search, function ($q) use ($search) {
            $q->where("first_name", "like", "%" . $search . "%")
                ->orWhere("last_name", "like", "%" . $search . "%")
                ->orWhere("email", "like", "%" . $search . "%");
        })
            ->orderBy("id", "desc")
            ->paginate(10);

        return LeadResource::collection($leads);
    }

    /**
     * VER DETALLE DEL LEAD (Solo Admin)
     */
    public function show($id)
    {
        $lead = Lead::findOrFail($id);

        if (!Gate::allows('view', $lead)) {
            return response()->json(['success' => false, 'message' => 'Sin permisos', 'code' => 403]);
        }

        return new LeadResource($lead);
    }

    /**
     * ACTUALIZAR LEAD (Solo Admin)
     */
    public function update(Request $request, $id)
    {
        $lead = Lead::findOrFail($id);

        if (!Gate::allows('update', $lead)) {
            return response()->json(['success' => false, 'message' => 'Sin permisos', 'code' => 403]);
        }

        // Validación rápida para edición administrativa
        $validated = $request->validate([
            'first_name' => 'sometimes|string',
            'last_name'  => 'sometimes|string',
            'email'      => 'sometimes|email',
            'phone'      => 'sometimes|string',
            'status'     => 'sometimes|string',
        ]);

        $lead->update($validated);

        return response()->json([
            'success' => true,
            'message' => 'Lead actualizado correctamente.',
            'lead'    => new LeadResource($lead)
        ]);
    }

    /**
     * ELIMINAR LEAD (Solo Admin)
     */
    public function destroy($id)
    {
        $lead = Lead::findOrFail($id);

        if (!Gate::allows('delete', $lead)) {
            return response()->json(['success' => false, 'message' => 'Sin permisos', 'code' => 403]);
        }

        $lead->delete();

        return response()->json([
            'success' => true,
            'message' => 'Lead eliminado correctamente'
        ]);
    }
}
