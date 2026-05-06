<?php

namespace App\Http\Controllers\Api\Content;

use App\Http\Controllers\Controller;
use App\Models\Common\Menu;
use App\Models\Academic\AcademicUnit;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate; 

class MenuController extends Controller
{
    public function index()
    {
        Gate::authorize('viewAny', Menu::class);

        $unit = app(AcademicUnit::class);
        return response()->json(Menu::where('academic_unit_id', $unit->id)->get());
    }

    public function store(Request $request)
    {
        Gate::authorize('create', Menu::class);

        $unit = app(AcademicUnit::class);
        
        $validated = $request->validate([
            'name'     => 'required|string|max:100',
            'location' => 'required|string|in:header,footer,sidebar_dpa',
            'settings' => 'nullable|array'
        ]);

        $validated['academic_unit_id'] = $unit->id;
        $menu = Menu::create($validated);

        return response()->json($menu, 201);
    }

    public function show($id)
    {
        $unit = app(AcademicUnit::class);
        
        $menu = Menu::where('academic_unit_id', $unit->id)
                    ->with(['items' => function($query) {
                        $query->whereNull('parent_id')->with('children')->orderBy('order');
                    }])
                    ->findOrFail($id);

        Gate::authorize('view', $menu);

        return response()->json($menu);
    }

    public function update(Request $request, $id)
    {
        $menu = Menu::findOrFail($id);

        Gate::authorize('update', $menu);

        $validated = $request->validate([
            'name'     => 'required|string|max:100',
            'location' => 'required|string|in:header,footer,sidebar_dpa',
            'settings' => 'nullable|array'
        ]);

        $menu->update($validated);

        return response()->json($menu, 200);
    }

    public function destroy($id)
    {
        $menu = Menu::findOrFail($id);

        Gate::authorize('delete', $menu);

        $menu->delete();

        return response()->json(null, 204);
    }
}