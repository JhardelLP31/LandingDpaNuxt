<?php

namespace App\Http\Controllers\Role;

use Illuminate\Http\Request;
use Spatie\Permission\Models\Role;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Gate;

class RoleController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index(Request $request)
    {
        if(!auth('api')->user()->can("list_role")){
            return abort(403);
        }
        $search = $request->get("search");
        //
        $roles = Role::where("name","like","%".$search."%")->orderBy("id","desc")->paginate(10);

        return response()->json([
            "total" => $roles->total(),
            "paginate" => 10,
            "roles" => $roles->map(function($role) {
                return [
                    "id" => $role->id,
                    "name" => $role->name,
                    "created_at" => $role->created_at->format("Y/m/d h:i:s"),
                    "permissions" => $role->permissions->map(function($permission) {
                        return [
                            "id" => $permission->id,
                            "name" => $permission->name,
                        ];
                    }),
                    "permissions_pluck" => $role->permissions->pluck("name"),
                ];
            })
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        if(!auth('api')->user()->can("register_role")){
            return abort(403);
        }
        $exist_role = Role::where("name",$request->name)->first();

        if($exist_role){
            return response()->json([
                "message" => 403,
                "message_text" => "EL NOMBRE DEL ROL YA EXISTE, INTENTE UNO NUEVO"
            ]);
        }

        $role = Role::create([
            "name" => $request->name,
            "guard_name" => "api"
        ]);
        $permissions = $request->permissions;
        // Enlazar con los permisos que tenga
        foreach ($permissions as $key => $permission) {
            $role->givePermissionTo($permission);
        }
        return response()->json([
            "message" => 200,
            "role" => [
                "id" => $role->id,
                "name" => $role->name,
                "created_at" => $role->created_at->format("Y/m/d h:i:s"),
                "permissions" => $role->permissions->map(function($permission) {
                    return [
                        "id" => $permission->id,
                        "name" => $permission->name,
                    ];
                }),
                "permissions_pluck" => $role->permissions->pluck("name"),
            ],
        ]);
    }

    /**
     * Display the specified resource.
     */
    public function show(string $id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        if(!auth('api')->user()->can("edit_role")){
            return abort(403);
        }
         $exist_role = Role::where("name",$request->name)->where("id","<>",$id)->first();

         if($exist_role){
             return response()->json([
                 "message" => 403,
                 "message_text" => "EL NOMBRE DEL ROL YA EXISTE, INTENTE UNO NUEVO"
             ]);
         }
 
         $role = Role::findOrFail($id);

         $role->update([
            "name" => $request->name
         ]);
         $permissions = $request->permissions;
         // Enlazar con los permisos que tenga
         $role->syncPermissions($permissions);
         return response()->json([
             "message" => 200,
             "role" => [
                "id" => $role->id,
                "name" => $role->name,
                "created_at" => $role->created_at->format("Y/m/d h:i:s"),
                "permissions" => $role->permissions->map(function($permission) {
                    return [
                        "id" => $permission->id,
                        "name" => $permission->name,
                    ];
                }),
                "permissions_pluck" => $role->permissions->pluck("name"),
            ],
         ]);
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        if(!auth('api')->user()->can("delete_role")){
            return abort(403);
        }
        $role = Role::findOrFail($id);
        $role->delete();
        return response()->json([
            "message" => 200,
        ]);
    }
}
