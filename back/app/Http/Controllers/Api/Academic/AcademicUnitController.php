<?php

namespace App\Http\Controllers\Api\Academic;

use App\Http\Controllers\Controller;
use App\Models\Academic\AcademicUnit;
use App\Services\Academic\AcademicUnitService;
use Illuminate\Http\Request;

class AcademicUnitController extends Controller
{
    protected $academicUnitService;

    public function __construct(AcademicUnitService $academicUnitService)
    {
        $this->academicUnitService = $academicUnitService;
    }

    public function index()
    {
        return response()->json(AcademicUnit::all());
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name'      => 'required|string|max:255',
            'code'      => 'required|string|max:50|unique:academic_units,code',
            'slug'      => 'nullable|string|unique:academic_units,slug',
            'domain'    => 'nullable|string|max:255|unique:academic_units,domain',
            'is_active' => 'boolean'
        ]);

        $unit = $this->academicUnitService->createUnit($validated);

        return response()->json([
            'message' => 'Unidad Académica creada con éxito.',
            'data'    => $unit
        ], 201);
    }

    public function update(Request $request, AcademicUnit $academicUnit)
    {
        $validated = $request->validate([
            'name'      => 'string|max:255',
            'code'      => 'string|max:50|unique:academic_units,code,' . $academicUnit->id,
            'slug'      => 'string|unique:academic_units,slug,' . $academicUnit->id,
            'domain'    => 'nullable|string|max:255|unique:academic_units,domain,' . $academicUnit->id, 
            'is_active' => 'boolean'
        ]);

        $unit = $this->academicUnitService->updateUnit($academicUnit, $validated);

        return response()->json([
            'message' => 'Unidad Académica actualizada.',
            'data'    => $unit
        ]);
    }
}
