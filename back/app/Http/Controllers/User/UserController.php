<?php

namespace App\Http\Controllers\User;

use App\Models\User;
use App\Models\Academic\AcademicUnit; // <-- Importar el modelo
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Models\Role;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Storage;
use App\Http\Resources\User\UserResource;
use App\Http\Resources\User\UserCollection;

class UserController extends Controller
{
    public function index(Request $request)
    {
        Gate::authorize("viewAny", User::class);
        $search = $request->get("search");

        $users = User::where(DB::raw("CONCAT(users.name,' ',IFNULL(users.surname, ''),' ',users.email,' ',IFNULL(users.phone, ''))"), "like", "%" . $search . "%")
            ->orderBy("id", "desc")
            ->paginate(10);
            
        $roles = Role::select("id", "name")->orderBy("id", "desc")->get();
        
        // Enviamos también las unidades académicas para los filtros o el modal de edición
        $academic_units = AcademicUnit::select("id", "name")->get();

        return response()->json([
            "total" => $users->total(),
            "paginate" => 10,
            "users" => UserCollection::make($users),
            "roles" => $roles,
            "academic_units" => $academic_units // <-- Disponible para el front
        ]);
    }

    public function config()
    {
        $roles = Role::all();
        $academic_units = AcademicUnit::select("id", "name")->get();

        return response()->json([
            "roles" => $roles->map(function($rol) {
                return ["id" => $rol->id, "name" => $rol->name];
            }),
            "academic_units" => $academic_units // <-- Para cargar el select en el modal "Nuevo Usuario"
        ]);
    }

    public function store(Request $request)
    {
        Gate::authorize("create", User::class);
        
        $is_user_exists = User::where("email", $request->email)->first();
        if($is_user_exists){
            return response()->json(["message" => 403, "message_text" => "EL USUARIO YA EXISTE"]);
        }

        if($request->hasFile("imagen")){
            $path = Storage::putFile("users", $request->file("imagen"));
            $request->request->add(["avatar" => $path]);
        }
        
        if($request->password){
            $request->request->add(["password" => bcrypt($request->password)]);
        }

        // El academic_unit_id viene en el request desde el front
        $user = User::create($request->all());
        
        $role = Role::findOrFail($request->role_id);
        $user->assignRole($role);

        return response()->json([
            "message" => 200,
            "user" => UserResource::make($user),
        ]);
    }

    public function update(Request $request, string $id)
    {
        Gate::authorize("update", User::class);
        
        $is_user_exists = User::where("email", $request->email)->where("id", "<>", $id)->first();
        if($is_user_exists){
            return response()->json(["message" => 403, "message_text" => "EL USUARIO YA EXISTE"]);
        }
        
        $user = User::findOrFail($id);

        if($request->hasFile("imagen")){
            if($user->avatar){ Storage::delete($user->avatar); }
            $path = Storage::putFile("users", $request->file("imagen"));
            $request->request->add(["avatar" => $path]);
        }
        
        if($request->password){
            $request->request->add(["password" => bcrypt($request->password)]);
        }

        // Se actualiza incluyendo el academic_unit_id
        $user->update($request->all());

        if($request->role_id != $user->role_id){
            $role_old = Role::findOrFail($user->role_id);
            $user->removeRole($role_old);
            $role_new = Role::findOrFail($request->role_id);
            $user->assignRole($role_new);
        }

        return response()->json([
            "message" => 200,
            "user" => UserResource::make($user),
        ]);
    }

    public function destroy(string $id)
    {
        Gate::authorize("delete", User::class);
        $user = User::findOrFail($id);
        $user->delete();
        return response()->json(["message" => 200]);
    }
}