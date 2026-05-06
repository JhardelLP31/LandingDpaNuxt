<?php

namespace App\Http\Controllers\Api\Content;

use App\Http\Controllers\Controller;
use App\Models\Common\Menu;
use App\Models\Common\MenuItem;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;

class MenuItemController extends Controller
{
    public function store(Request $request)
    {
        Gate::authorize('create', MenuItem::class);

        $validated = $request->validate([
            'menu_id'    => 'required|exists:menus,id',
            'parent_id'  => 'nullable|exists:menu_items,id',
            'title'      => 'required|string|max:100',
            'url'        => 'nullable|string',
            'content_id' => 'nullable|exists:contents,id', 
            'order'      => 'integer',
            'target'     => 'string|in:_self,_blank',
        ]);

        $menu = Menu::findOrFail($request->menu_id);
        if (!$request->user()->hasRole('Super-Admin') && $request->user()->academic_unit_id != $menu->academic_unit_id) {
            abort(403, 'No tienes permiso para agregar enlaces a un menú de otra sede.');
        }

        $item = MenuItem::create($validated);
        return response()->json($item, 201);
    }

    public function update(Request $request, $id)
    {
        $item = MenuItem::findOrFail($id);
        
        Gate::authorize('update', $item);

        $validated = $request->validate([
            'menu_id'    => 'required|exists:menus,id',
            'parent_id'  => 'nullable|exists:menu_items,id',
            'title'      => 'required|string|max:100',
            'url'        => 'nullable|string',
            'content_id' => 'nullable|exists:contents,id', 
            'order'      => 'integer',
            'target'     => 'string|in:_self,_blank',
        ]);

        if ($request->has('menu_id') && $request->menu_id != $item->menu_id) {
            $newMenu = Menu::findOrFail($request->menu_id);
            if (!$request->user()->hasRole('Super-Admin') && $request->user()->academic_unit_id != $newMenu->academic_unit_id) {
                abort(403, 'No puedes trasladar este enlace a un menú de una sede ajena.');
            }
        }

        $item->update($validated);

        return response()->json($item, 200);
    }

    public function updateOrder(Request $request)
    {
        if (!$request->user()->can('edit_menu_item')) {
            abort(403, 'No tienes permiso para editar menús.');
        }

        foreach ($request->items as $index => $id) {
            $item = MenuItem::find($id);
            
            if ($item && ($request->user()->hasRole('Super-Admin') || $request->user()->academic_unit_id === $item->menu->academic_unit_id)) {
                $item->update(['order' => $index]);
            }
        }
        
        return response()->json(['message' => 'Orden actualizado']);
    }

    public function destroy($id)
    {
        $item = MenuItem::findOrFail($id);

        Gate::authorize('delete', $item);

        $item->delete();
        
        return response()->json(null, 204);
    }
}