<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Menu\MenuItem;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use App\Http\Resources\Menu\MenuResource;

class MenuController extends Controller
{
    public function index()
    {
        Gate::authorize('viewAny', MenuItem::class);

        $menus = MenuItem::whereNull('parent_id')
            ->with('children')
            ->orderBy('order', 'asc')
            ->get();

        return MenuResource::collection($menus);
    }

    public function indexPublic()
    {
        $menus = MenuItem::whereNull('parent_id')
            ->where('is_active', 1) 
            ->with(['children' => function ($query) {
                $query->where('is_active', 1)->orderBy('order', 'asc');
            }])
            ->orderBy('order', 'asc')
            ->get();

        return MenuResource::collection($menus);
    }   

    public function store(Request $request)
    {
        Gate::authorize('create', MenuItem::class);

        // Eliminamos la restricción del 'in:...' para que acepte cualquier type
        $request->validate([
            'title'     => 'required|string',
            'type'      => 'required|string', 
            'slug'      => 'nullable|string',
            'post_id'   => 'nullable', 
            'parent_id' => 'nullable',
            'order'     => 'nullable|integer'
        ]);

        return DB::transaction(function () use ($request) {
            $menuItem = MenuItem::create([
                'title'     => $request->title,
                'slug'      => $request->slug,
                'type'      => $request->type,
                'post_id'   => $request->post_id,
                'parent_id' => $request->parent_id,
                'order'     => $request->order ?? 0,
                'is_active' => 1
            ]);

            return response()->json([
                'message' => 'Menú creado correctamente',
                'menu'    => $menuItem
            ]);
        });
    }

    public function update(Request $request, $id)
    {
        $menuItem = MenuItem::findOrFail($id);

        Gate::authorize('update', $menuItem);

        // Validaciones relajadas para permitir la edición fluida
        $request->validate([
            'title' => 'required|string',
            'slug'  => 'required|string', // Quitamos el unique para evitar conflictos con el mismo registro
            'type'  => 'required|string',
            'order' => 'nullable|integer'
        ]);

        $menuItem->update([
            'title'     => $request->title,
            'slug'      => $request->slug,
            'type'      => $request->type,
            'order'     => $request->order ?? 0,
            'parent_id' => $request->parent_id,
            'post_id'   => $request->post_id,
        ]);

        return response()->json([
            'message' => 'Menú actualizado correctamente',
            'menu'    => $menuItem
        ]);
    }

    public function destroy($id)
    {
        $menu = MenuItem::findOrFail($id);

        if (!Gate::allows('delete', $menu)) {
            return response()->json(['message' => 'No tienes permiso para eliminar este menú.'], 403);
        }

        $menu->delete();

        return response()->json(['message' => 'Menú eliminado correctamente']);
    }
}