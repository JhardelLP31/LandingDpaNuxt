<?php

namespace App\Http\Controllers\Lead;

use App\Models\Lead\Lead;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Arr;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Http; // <-- Importante para llamar a Google
use App\Http\Resources\Lead\LeadResource;
use App\Exports\Lead\LeadExport;
use Maatwebsite\Excel\Facades\Excel;

class LeadController extends Controller
{
    /**
     * Lista todos los leads (Solo Admin)
     */
    public function index(Request $request)
    {
        if (!Gate::allows('viewAny', Lead::class)) {
            return response()->json([
                'success' => false,
                'message' => 'No tienes permisos para ver el listado de leads.',
            ], 403);
        }

        $search = $request->get("search");

        $leads = Lead::when($search, function ($q) use ($search) {
            $q->where("first_name", "like", "%{$search}%")
                ->orWhere("last_name", "like", "%{$search}%")
                ->orWhere("email", "like", "%{$search}%");
        })
            ->orderBy("id", "desc")
            ->paginate(10);

        return LeadResource::collection($leads);
    }

    /**
     * Guarda un nuevo lead. (Público + Admin)
     */
    public function store(Request $request)
    {
        // 🚨 OMITIMOS LA VALIDACIÓN DE RECAPTCHA EN LARAVEL
        // El token no lo validamos aquí para que no se "queme". 
        // Se lo pasaremos intacto al sistema Legacy para que él lo valide.

        // 1. VALIDACIÓN BÁSICA DE DATOS
        $validated = $request->validate([
            'email'      => 'required|email|max:255',
            'first_name' => 'required|string|max:255',
            'origin_url' => 'nullable|url',
        ]);

        // 2. DEFINICIÓN Y LIMPIEZA DE DATOS LOCALES
        $fixedColumns = ['origin_url', 'first_name', 'last_name', 'email', 'phone', 'message', 'status'];

        $blackList = [
            'password', 'password_confirmation', 'token', '_token', 'api_token',
            'auth_user', 'id', 'user', 'user_id', 'permissions', 'roles',
            'recaptcha_token' // Seguimos sin guardarlo en nuestra BD local
        ];

        $cleanData = $request->except($blackList);

        // 3. SEPARACIÓN DE ATRIBUTOS (Fijos vs Dinámicos)
        $mainAttributes = Arr::only($cleanData, $fixedColumns);
        $metaAttributes = Arr::except($cleanData, $fixedColumns);

        // 4. CREACIÓN DEL LEAD (En nuestra base de datos moderna)
        $lead = Lead::create(array_merge(
            $mainAttributes,
            [
                'metadata' => $metaAttributes,
                'status'   => 'new'
            ]
        ));

        // 5. TRADUCCIÓN EXACTA PARA EL SISTEMA LEGACY (PHP)
        $datosParaPHP = [
            'nombres'          => $request->input('first_name'),
            'apellido-paterno' => $request->input('last_name'), 
            'apellido-materno' => '', 
            'email'            => $request->input('email'),
            'celular'          => $request->input('phone'),
            'dni'              => $request->input('payload.numero_documento'),
            'consulta'         => $request->input('payload.consulta'),
            'datos-personales' => $request->input('payload.acepta_condiciones') ? 1 : 0,
            'comunicaciones'   => $request->input('payload.acepta_publicidad') ? 1 : 0,
            'cursando'         => $request->input('payload.estudios_superiores'),
            'carrera'          => $request->input('payload.programa_origen'),
            'carrerainteres'   => $request->input('payload.curso_interes'),
            'title'            => $request->input('payload.url_slug', ''), // Agregado según el código PHP
            
            // 🔥 LE PASAMOS EL TOKEN INTACTO PARA QUE EL PHP LO USE
            'recaptcha_response' => $request->input('recaptcha_token')
        ];

        // 6. PUENTE AL SISTEMA LEGACY
        try {
            Http::timeout(5)
                ->asForm()
                ->post('https://qaspre.ue.edu.pe/pregrado/correo/', $datosParaPHP);
        } catch (\Exception $e) {
            Log::error('Fallo al enviar lead al sistema Legacy: ' . $e->getMessage());
        }

        // 7. RESPUESTA AL FRONTEND
        return response()->json([
            'success' => true,
            'message' => 'Lead guardado y procesado.',
            'data'    => new LeadResource($lead)
        ], 201);
    }

    /**
     * Verifica el token de Google reCAPTCHA v3 o el bypass de Admin.
     */
    private function verifyRecaptcha(?string $token): bool
    {
        // Si no hay token en absoluto, bloqueamos.
        if (!$token) return false;

        // Si es el bypass del Page Builder (Admin Vue SPA)...
        if ($token === 'admin_bypass') {
            // Validamos que el JWT sea válido y el usuario exista
            return auth('api')->check(); // Esto es equivalente a validar que auth('api')->id() exista
        }

        // ... (resto de la petición HTTP a Google para la web pública en Nuxt) ...
        $response = Http::asForm()->post('https://www.google.com/recaptcha/api/siteverify', [
            'secret'   => config('services.recaptcha.secret'),
            'response' => $token,
        ]);

        if ($response->successful()) {
            $result = $response->json();

            // v3 devuelve un score de 0.0 (bot) a 1.0 (humano). 
            // 0.5 es un excelente estándar de corte.
            return isset($result['success'])
                && $result['success'] === true
                && isset($result['score'])
                && $result['score'] >= 0.5;
        }

        return false;
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
            'email' => 'required|email|max:255|unique:leads,email,' . $id,
            'first_name' => 'required|string',
        ]);

        $fixedColumns = ['origin_url', 'first_name', 'last_name', 'email', 'phone', 'message', 'status'];

        $allData = $request->all();
        $mainAttributes = Arr::only($allData, $fixedColumns);

        if (isset($allData['metadata']) && is_array($allData['metadata'])) {
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
