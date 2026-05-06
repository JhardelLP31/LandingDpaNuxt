<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use App\Models\User;
use Illuminate\Support\Facades\Auth;

class ValidateExternalToken
{
    public function handle(Request $request, Closure $next)
    {
        // 1. Obtener el token del header
        $token = $request->bearerToken();

        if (!$token) {
            return response()->json(['message' => 'Token no proporcionado'], 401);
        }

        // 2. Validar contra la Auth API
        try {
            $response = Http::withToken($token)->get(env('AUTH_API_URL') . '/api/auth/me'); 
            
            if ($response->failed()) {
                return response()->json(['message' => 'Token inválido o expirado'], 401);
            }

            $authData = $response->json();
            
            $email = $authData['email'] ?? $authData['user']['email'] ?? null;

            if (!$email) {
                return response()->json(['message' => 'Token válido pero sin identidad de email'], 401);
            }

        } catch (\Exception $e) {
            return response()->json(['message' => 'Error validando token externo'], 500);
        }

        // 3. BUSCAR EL USUARIO EN LA BD LOCAL DEL CMS
        $localUser = User::where('email', $email)->first();

        if (!$localUser) {
            return response()->json(['message' => 'Acceso denegado: Usuario no registrado en CMS'], 403);
        }

        if ($localUser->state === 0) {
            return response()->json(['message' => 'Usuario desactivado'], 403);
        }

        // =================================================================
        // 4. CORRECCIÓN PARA ROLES SPATIE (GUARD API)
        // =================================================================
        
        if (Auth::guard('api')->getProvider()) {
            Auth::guard('api')->setUser($localUser);
        }

        Auth::shouldUse('api');

        // C. Vinculación extra al Request (Seguridad adicional para controladores)
        $request->merge(['user' => $localUser]);
        $request->setUserResolver(function () use ($localUser) {
            return $localUser;
        });

        return $next($request);
    }
}