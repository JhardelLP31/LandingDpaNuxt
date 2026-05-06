<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use App\Models\User;
use Spatie\Permission\Models\Role;
use Illuminate\Support\Facades\Log;

class LoginController extends Controller
{
    public function login(Request $request)
    {
        // 1. VALIDACIÓN
        $request->validate([
            'email' => 'required',
            'password' => 'required'
        ]);

        $email = $request->email;
        if (!str_contains($email, '@')) {
            $email .= '@esan.edu.pe';
        }

        // 2. CONSULTAR AUTH API
        try {
            $response = Http::post(env('AUTH_API_URL') . '/api/auth/login', [
                'email' => $email,
                'password' => $request->password,
            ]);
        } catch (\Exception $e) {
            Log::error("Error Auth API: " . $e->getMessage());
            return response()->json(['error' => 'Error de conexión con Auth API'], 500);
        }

        if ($response->failed()) {
            return response()->json(['error' => 'Credenciales incorrectas'], 401);
        }

        $authData = $response->json(); 

        // 3. VALIDACIÓN LOCAL
        $localUser = User::where('email', $email)->first();

        if (!$localUser) {
            return response()->json(['error' => 'No tienes permisos de acceso a este sistema.'], 403);
        }

        if ($localUser->state === 0) { 
            return response()->json(['error' => 'Usuario desactivado.'], 403);
        }

        // 4. SINCRONIZACIÓN DE DATOS (Nombre/Apellido)
        if (isset($authData['user']['name'])) $localUser->name = $authData['user']['name'];
        // if (isset($authData['user']['surname'])) $localUser->surname = $authData['user']['surname'];
        $localUser->save();

        // 5. SINCRONIZACIÓN DE ROLES (Tu lógica de role_id)
        $localUser->unsetRelation('roles'); // Limpiamos caché
        $localUser->unsetRelation('permissions');

        if ($localUser->role_id) {
            $roleSpatie = Role::find($localUser->role_id);
            if ($roleSpatie) {
                $localUser->syncRoles($roleSpatie); 
            }
        }
        
        $localUser = $localUser->refresh(); 

        // ---------------------------------------------------------
        // FASE FINAL: CONSTRUIR RESPUESTA (FORMATO ANTIGUO)
        // ---------------------------------------------------------
        
        $currentRole = $localUser->roles->first();

        $permissions = $localUser->getAllPermissions()->pluck('name');

        return response()->json([
            'access_token' => $authData['access_token'], // Token del Auth API
            'token_type' => 'bearer',
            // Si el Auth API devuelve expiración, úsala. Si no, pon 3600 o lo que uses.
            'expires_in' => $authData['expires_in'] ?? 60, 
            
            "user" => [
                "full_name" => $localUser->name . ' ' . $localUser->surname, 
                "email" => $localUser->email,
                "avatar" => $localUser->avatar ? url("storage/" . $localUser->avatar) : null,
                "role" => [
                    "id" => $currentRole ? $currentRole->id : ($localUser->role_id ?? null),
                    "name" => $currentRole ? $currentRole->name : 'Sin Rol'
                ],
                "permissions" => $permissions,
            ]
        ]);
    }
}

