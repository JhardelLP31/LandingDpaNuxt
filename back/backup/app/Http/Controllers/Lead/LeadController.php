<?php

namespace App\Http\Controllers\Lead;

use App\Models\Lead\Lead;
use Illuminate\Http\Request;
use App\Exports\Lead\LeadExport;
use App\Http\Controllers\Controller;
use Maatwebsite\Excel\Facades\Excel;
use Illuminate\Support\Arr;
use App\Http\Resources\Lead\LeadResource;
use Illuminate\Support\Facades\Gate; // 1. IMPORTANTE: Importar Gate

class LeadController extends Controller
{
    /**
     * Lista todos los leads (Solo Admin)
     */
    public function index(Request $request)
    {
        // --- SEGURIDAD ---
        if (!Gate::allows('viewAny', Lead::class)) {
            return response()->json([
                'success' => false,
                'message' => 'No tienes permisos para ver el listado de leads.',
                'code' => 403
            ]);
        }
        // -----------------

        $search = $request->get("search");

        $leads = Lead::where(function($q) use ($search){
                    if($search){
                        $q->where("first_name", "like", "%".$search."%")
                          ->orWhere("last_name", "like", "%".$search."%")
                          ->orWhere("email", "like", "%".$search."%");
                    }
                })
                ->orderBy("id", "desc")
                ->paginate(10);

        return LeadResource::collection($leads);
    }

    /**
     * Guarda un nuevo lead.
     * PUBLICO + ADMIN. No ponemos Gate aquí para no romper el formulario web.
     */
    public function store(Request $request)
    {
        // 1. VALIDACIÓN BÁSICA
        // Validamos solo lo indispensable para que el registro sea válido.
        $validated = $request->validate([
            'email'      => 'required|email|max:255',
            'first_name' => 'required|string|max:255',
            'origin_url' => 'nullable|url',
        ]);

        // 2. DEFINICIÓN DE COLUMNAS FIJAS
        // Estos son los campos que tienen su propia columna en la tabla 'leads'.
        $fixedColumns = [
            'origin_url', 
            'first_name', 
            'last_name', 
            'email', 
            'phone', 
            'message', 
            'status'
        ];

        // 3. FILTRADO DE DATOS SENSIBLES (Lista Negra)
        // Aquí quitamos lo que NO queremos que se guarde NUNCA en metadata
        // aunque el formulario lo envíe por error.
        $blackList = [
            'password', 
            'password_confirmation', 
            'token', 
            '_token', 
            'api_token', 
            'auth_user', 
            'id',
            'user',      // <--- Esto está causando el JSON gigante
            'user_id',   // Por si acaso
            'permissions', 
            'roles'
        ];

        $allData = $request->except($blackList);

        // 4. SEPARACIÓN DE ATRIBUTOS
        // Tomamos los fijos para las columnas.
        $mainAttributes = Arr::only($allData, $fixedColumns);
        
        // Todo lo que SOBRA de $allData (que no esté en $fixedColumns) va a metadata.
        $metaAttributes = Arr::except($allData, $fixedColumns);

        // 5. CREACIÓN DEL LEAD
        $lead = Lead::create([
            ...$mainAttributes,
            'metadata' => $metaAttributes, // Laravel lo convertirá a JSON automáticamente si el cast está en el Modelo
            'status'   => 'new'
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Lead guardado correctamente.',
            'data'    => new LeadResource($lead)
        ], 201);
    }

    /**
     * Ver detalle (Solo Admin)
     */
    public function show($id)
    {
        $lead = Lead::findOrFail($id);

        // --- SEGURIDAD ---
        if (!Gate::allows('view', $lead)) {
            return response()->json([
                'success' => false,
                'message' => 'No tienes permisos para ver este lead.',
                'code' => 403
            ]);
        }
        // -----------------

        return new LeadResource($lead);
    }

    /**
     * Exportar Excel (Solo Admin con permiso exportar)
     */
    public function download_excel(Request $request)
    {
        // --- SEGURIDAD ---
        // Usamos el método personalizado 'export' del Policy
        if (!Gate::allows('export', Lead::class)) {
            return response()->json([ // OJO: Excel espera archivo, pero si falla retornamos JSON
                'success' => false,
                'message' => 'No tienes permisos para exportar leads.',
                'code' => 403
            ]);
        }
        // -----------------

        $startDate = $request->filled('start_date') ? $request->input('start_date') : null;
        $endDate   = $request->filled('end_date')   ? $request->input('end_date')   : null;

        return Excel::download(new LeadExport($startDate, $endDate), 'leads_reporte.xlsx');
    }
    
    /**
     * Actualizar lead (Solo Admin)
     */
    public function update(Request $request, $id)
    {
        $lead = Lead::findOrFail($id);

        // --- SEGURIDAD ---
        if (!Gate::allows('update', $lead)) {
            return response()->json([
                'success' => false,
                'message' => 'No tienes permisos para editar este lead.',
                'code' => 403
            ]);
        }
        // -----------------

        $request->validate([
            'email' => 'required|email|max:255|unique:leads,email,'.$id,
            'first_name' => 'required|string',
        ]);

        $fixedColumns = ['origin_url', 'first_name', 'last_name', 'email', 'phone', 'message', 'status'];
        
        $allData = $request->all();
        $mainAttributes = Arr::only($allData, $fixedColumns);

        if(isset($allData['metadata']) && is_array($allData['metadata'])){
            $metaAttributes = $allData['metadata'];
        } else {
            $metaAttributes = Arr::except($allData, $fixedColumns);
        }

        $lead->update([
            ...$mainAttributes,
            'metadata' => $metaAttributes
        ]);

        return response()->json([
            'success' => true,
            'message' => 'Lead actualizado correctamente.',
            'lead'    => new LeadResource($lead)
        ]);
    }

    /**
     * Eliminar lead (Solo Admin)
     */
    public function destroy($id)
    {
        $lead = Lead::findOrFail($id);

        // --- SEGURIDAD ---
        if (!Gate::allows('delete', $lead)) {
            return response()->json([
                'success' => false,
                'message' => 'No tienes permisos para eliminar este lead.',
                'code' => 403
            ]);
        }
        // -----------------

        $lead->delete();
        
        return response()->json([
            'success' => true,
            'message' => 'Lead eliminado correctamente'
        ]);
    }
}