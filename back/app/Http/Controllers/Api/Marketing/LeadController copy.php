<?php
namespace App\Http\Controllers\Api\Marketing;

use App\Http\Controllers\Controller;
use App\Models\Marketing\Lead;
use App\Http\Requests\Marketing\StoreLeadRequest;
use Illuminate\Http\Request;
use App\Http\Resources\Marketing\LeadResource;
use Illuminate\Support\Facades\Gate;
// use App\Exports\Lead\LeadExport; // Descomenta cuando uses el Excel
// use Maatwebsite\Excel\Facades\Excel; // Descomenta cuando uses el Excel

class LeadController extends Controller
{
    /**
     * GUARDA UN NUEVO LEAD (Público desde Landing)
     */
    public function store(StoreLeadRequest $request)
    {
        // 1. Validamos los datos estrictamente con el Request
        $data = $request->validated();

        // 2. Extraemos info técnica del Request (IP, User Agent, Referer)
        $metadata = $data['marketing_metadata'] ?? [];
        $metadata['ip_address'] = $request->ip();
        $metadata['user_agent'] = $request->userAgent();
        $metadata['referrer']   = $request->headers->get('referer');
        
        $data['marketing_metadata'] = $metadata;
        
        // Asignamos status inicial por defecto
        $data['status'] = 'new';
        $data['external_sync_status'] = 'pending';

        // 3. Creamos el Lead
        $lead = Lead::create($data);

        // 4. (Opcional) Aquí puedes disparar un Evento/Job para correos
        // LeadCreated::dispatch($lead);

        return response()->json([
            'success' => true,
            'message' => '¡Gracias por tu interés! Nos pondremos en contacto pronto.',
            'lead_id' => $lead->id
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

        $leads = Lead::when($search, function($q) use ($search){
                    $q->where("first_name", "like", "%".$search."%")
                      ->orWhere("last_name", "like", "%".$search."%")
                      ->orWhere("email", "like", "%".$search."%");
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