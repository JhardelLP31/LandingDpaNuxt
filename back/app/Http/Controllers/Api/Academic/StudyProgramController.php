<?php

namespace App\Http\Controllers\Api\Academic;

use App\Http\Controllers\Controller;
use App\Models\Academic\StudyProgram;
use App\Models\Academic\AcademicUnit;
use App\Services\Academic\StudyProgramService;
use App\Http\Requests\Academic\StoreStudyProgramRequest;
use App\Http\Requests\Academic\UpdateStudyProgramRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate; // <-- Importado para la validación de Policies

class StudyProgramController extends Controller
{
    protected $service;

    public function __construct(StudyProgramService $service)
    {
        $this->service = $service;
    }

    public function index()
    {
        // 1. Validar Policy: ¿Tiene permiso list_study_program?
        Gate::authorize('viewAny', StudyProgram::class);

        // El Global Scope filtrará automáticamente por la unidad del Header
        return response()->json(StudyProgram::with('category')->get());
    }

    public function store(StoreStudyProgramRequest $request)
    {
        // 1. Validar Policy: ¿Tiene permiso register_study_program?
        Gate::authorize('create', StudyProgram::class);

        // Recuperamos la unidad que identificó el Middleware
        $unit = app(AcademicUnit::class);

        $program = $this->service->createProgram($request->validated(), $unit->id);

        return response()->json([
            'message' => 'Programa de estudio creado con éxito',
            'data' => $program
        ], 201);
    }

    public function show(StudyProgram $studyProgram)
    {
        // 1. Validar Policy: ¿Tiene permiso list_study_program y es de su misma unidad?
        Gate::authorize('view', $studyProgram);

        return response()->json($studyProgram->load('category'));
    }

    /**
     * Actualizar un programa de estudio existente.
     */
    public function update(UpdateStudyProgramRequest $request, $id)
    {
        try {
            // Buscamos el programa
            $program = StudyProgram::findOrFail($id);

            // 1. Validar Policy: ¿Tiene permiso edit_study_program y es de su misma unidad?
            Gate::authorize('update', $program);

            $program->update($request->validated());

            return response()->json([
                'success' => true,
                'message' => 'Programa de estudio actualizado correctamente.',
                'data'    => $program
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al actualizar: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Eliminar un programa de estudio.
     */
    public function destroy($id)
    {
        try {
            $program = StudyProgram::findOrFail($id);
            
            Gate::authorize('delete', $program);

            $program->delete();

            return response()->json([
                'success' => true,
                'message' => 'Programa eliminado con éxito'
            ]);
            
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al eliminar: ' . $e->getMessage()
            ], 500);
        }
    }
}