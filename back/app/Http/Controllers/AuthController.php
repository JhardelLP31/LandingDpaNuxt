<?php

namespace App\Http\Controllers;

use App\Http\Controllers\Controller;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Lcobucci\JWT\Validation\Validator;
use LdapRecord\Container;
use Spatie\Permission\Models\Role;
class AuthController extends Controller
{
    // ... (Tu método register se queda igual, aunque con LDAP suele usarse menos)
    public function register()
    {
        $validator = Validator::make(request()->all(), [
            'name' => 'required',
            'email' => 'required|unique:users',
            'password' => 'required|min:8',
        ]);

        if ($validator->fails()) {
            return response()->json($validator->errors()->toJson(), 400);
        }

        $user = new User;
        $user->name = request()->name;
        $user->email = request()->email;
        $user->password = bcrypt(request()->password);
        $user->save();

        return response()->json($user, 201);
    }

    /**
     * Login Híbrido: Verifica en LDAP, Sincroniza en MySQL y devuelve JWT.
     */
    /*public function login()
    {
        $credentials = request(['email', 'password']);

        if (!$credentials['email'] || !$credentials['password']) {
            return response()->json(['error' => 'Email y contraseña requeridos'], 400);
        }

        try {
            // 1. CONEXIÓN
            $connection = \LdapRecord\Container::getConnection('default');
            
            // --- BÚSQUEDA INTELIGENTE (SIN OR) ---
            $query = $connection->query();
            
            // Verificamos si lo que escribió el usuario parece un correo
            if (str_contains($credentials['email'], '@')) {
                // Si tiene '@', buscamos SOLO por correo
                $ldapUser = $query->where('mail', '=', $credentials['email'])->first();
            } else {
                // Si NO tiene '@', asumo que es usuario corto (ej: jpumahuillca)
                $ldapUser = $query->where('sAMAccountName', '=', $credentials['email'])->first();
            }
            // -------------------------------------

            if (!$ldapUser) {
                 return response()->json(['error' => 'Usuario no encontrado.'], 401);
                 //return response()->json(['error' => 'Usuario no encontrado en Directorio Activo'], 401);
            }

            // --- CORRECCIÓN CRÍTICA: DETECTAR SI ES ARRAY O OBJETO ---
            // Si es array, tomamos ['dn']. Si es objeto, usamos ->getDn()
            $userDn = is_array($ldapUser) ? $ldapUser['dn'] : $ldapUser->getDn();

            // 2. VERIFICACIÓN DE PASSWORD
            if ($connection->auth()->attempt($userDn, $credentials['password'])) {

                // --- HELPER PARA LEER ATRIBUTOS ---
                // Esta pequeña función lee el dato sin importar si viene como array u objeto
                $getAttribute = function ($user, $key) {
                    if (is_array($user)) {
                        // En arrays LDAP, el valor suele estar en la posición 0
                        return $user[$key][0] ?? null;
                    }
                    return $user->getFirstAttribute($key);
                };

                // Extraemos el email usando el helper
                $userEmail = $getAttribute($ldapUser, 'mail');

                // Si por alguna razón el email viene vacío, usamos el que mandó el usuario
                if (!$userEmail) $userEmail = $credentials['email'];

                // 3. SINCRONIZACIÓN (MySQL)
                $user = User::where('email', $userEmail)->first();

                if (!$user) {
                    // --- USUARIO NUEVO ---
                    $user = new User();
                    $user->email = $userEmail;
                    $user->password = \Illuminate\Support\Facades\Hash::make(\Illuminate\Support\Str::random(16));
                    $user->state = 1; 
                    $user->gender = 'O'; 
                    $user->name = $getAttribute($ldapUser, 'givenname') ?? 'Usuario';
                    $user->surname = $getAttribute($ldapUser, 'sn') ?? 'AD';
                    
                    // Asignamos el ID de rol "visual" (El ID 2 que mencionas)
                    $user->role_id = 2; 
                    $user->save();

                    // --- AQUÍ ESTÁ LA MAGIA PARA SPATIE ---
                    // Buscamos el objeto Role de Spatie usando ese ID 2
                    $roleSpatie = Role::find(2); 
                    if($roleSpatie) {
                        $user->assignRole($roleSpatie); // Escribe en model_has_roles
                    }

                } else {
                    // --- USUARIO EXISTENTE ---
                    $user->name = $getAttribute($ldapUser, 'givenname') ?? $user->name;
                    $user->surname = $getAttribute($ldapUser, 'sn') ?? $user->surname;
                    if ($user->state === 0) $user->state = 1;
                    
                    $user->save();

                    // --- CORRECCIÓN DE EMERGENCIA ---
                    // Si el usuario ya existía pero NO tenía rol en Spatie (tu caso actual),
                    // forzamos la sincronización basada en su columna role_id.
                    $roleSpatie = Role::find($user->role_id);
                    if($roleSpatie) {
                        // syncRoles borra los anteriores y pone este (evita duplicados)
                        $user->syncRoles($roleSpatie); 
                    }
                    //$user->load('roles', 'permissions');
                }

                // --- RECARGA VITAL ---
                // Le decimos a Laravel: "Vuelve a leer los roles de la BD antes de hacer el token"
                // Sin esto, el token se genera con los permisos viejos (vacíos).
                $user->load('roles', 'permissions'); 

                // 4. TOKEN
                $token = auth('api')->login($user);

                return $this->respondWithToken($token);
            }
        } catch (\Exception $e) {
            \Illuminate\Support\Facades\Log::error("LDAP Error: " . $e->getMessage());
            return response()->json([
                'error' => 'Error de conexión',
                'details' => $e->getMessage()
            ], 500);
        }

        return response()->json(['error' => 'Contraseña incorrecta'], 401);
    }*/
    public function login()
    {
        $credentials = request(['email', 'password']);
        if (!$credentials['email'] || !$credentials['password']) {
            return response()->json(['error' => 'Email y contraseña requeridos'], 400);
        }
        try {
            $connection = Container::getConnection('default');
            $query = $connection->query();

            if (str_contains($credentials['email'], '@')) {
                $ldapUser = $query->where('mail', '=', $credentials['email'])->first();
            } else {
                $ldapUser = $query->where('sAMAccountName', '=', $credentials['email'])->first();
            }
            if (!$ldapUser) {
                return response()->json(['error' => 'Usuario no encontrado en Directorio Activo.'], 401);
            }
            // Obtener DN
            $userDn = is_array($ldapUser) ? $ldapUser['dn'] : $ldapUser->getDn();
            // 2. VERIFICACIÓN DE PASSWORD EN LDAP
            if ($connection->auth()->attempt($userDn, $credentials['password'])) {
                // --- HELPER PARA LEER ATRIBUTOS ---
                $getAttribute = function ($user, $key) {
                    if (is_array($user)) {
                        return $user[$key][0] ?? null;
                    }
                    return $user->getFirstAttribute($key);
                };
                // Extraemos el email real del LDAP
                $userEmail = $getAttribute($ldapUser, 'mail');
                if (!$userEmail) $userEmail = $credentials['email'];
                // 3. VALIDACIÓN EN BASE DE DATOS LOCAL (Aquí está el cambio clave)
                $user = User::where('email', $userEmail)->first();
                // CASO A: El usuario NO existe en tu sistema
                if (!$user) {
                    return response()->json([
                        'error' => 'Credenciales correctas, pero no tienes permisos de acceso a este sistema. Contacta al administrador.'
                    ], 403);
                    // 403 Forbidden: Sabes quién soy, pero no me dejas pasar.
                }
                // CASO B: El usuario existe, pero está desactivado (Papelera/Baneado)
                if ($user->state === 2) { // Asumiendo que 0 es inactivo
                    return response()->json([
                        'error' => 'Tu usuario ha sido desactivado en este sistema.'
                    ], 403);
                }

                // CASO C: Usuario existe y está activo -> ACTUALIZAMOS DATOS
                // Mantenemos los datos frescos desde el AD (por si se casó y cambió de apellido, etc.)
                $user->name = $getAttribute($ldapUser, 'givenname') ?? $user->name;
                $user->surname = $getAttribute($ldapUser, 'sn') ?? $user->surname;
                // Guardamos la actualización
                $user->save();
                // --- REPARACIÓN DE ROLES (Seguridad extra) ---
                // Nos aseguramos que Spatie reconozca el rol que tiene en base de datos
                if ($user->role_id) {
                    $roleSpatie = Role::find($user->role_id);
                    if ($roleSpatie) {
                        // syncRoles es mejor que assignRole aquí, porque evita duplicados
                        $user->syncRoles($roleSpatie);
                    }
                }
                // Recargamos permisos para el Token
                $user->load('roles', 'permissions');
                // 4. GENERAR TOKEN
                $token = auth('api')->login($user);
                return $this->respondWithToken($token);
            }
        } catch (\Exception $e) {
            \Illuminate\Support\Facades\Log::error("LDAP Error: " . $e->getMessage());
            return response()->json([
                'error' => 'Error de conexión con el servidor de autenticación',
            ], 500);
        }
        return response()->json(['error' => 'Contraseña incorrecta'], 401);
    }
    public function me()
    {
        return response()->json(auth('api')->user());
    }

    // ... (Tu método logout se queda igual)
    public function logout()
    {
        auth('api')->logout();
        return response()->json(['message' => 'Successfully logged out']);
    }

    // ... (Tu método refresh se queda igual)
    public function refresh()
    {
        return $this->respondWithToken(auth('api')->refresh());
    }

    /**
     * Get the token array structure.
     */
    protected function respondWithToken($token)
    {
        $user = auth('api')->user();

        // 1. Forzamos la carga de la unidad para que Laravel la reconozca
        $user->load('academicUnit');

        return response()->json([
            'access_token' => $token,
            'token_type' => 'bearer',
            'expires_in' => auth('api')->factory()->getTTL() * 60,
            "user" => [
                "id" => $user->id,
                "full_name" => $user->name . ' ' . $user->surname,
                "email" => $user->email,
                "avatar" => $user->avatar ? env("APP_URL") . "storage/" . $user->avatar : null,

                // --- ESTO ES LO QUE FALTA EN TU DEBUG ---
                "academic_unit_id" => $user->academic_unit_id ? (int)$user->academic_unit_id : null,

                "role" => [
                    "id" => $user->role ? $user->role->id : null,
                    "name" => $user->role ? $user->role->name : 'Sin Rol'
                ],
                "permissions" => $user->getAllPermissions()->pluck('name'),
            ]
        ]);
    }
}
