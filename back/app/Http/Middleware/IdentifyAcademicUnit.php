<?php
namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use App\Models\Academic\AcademicUnit;
use Symfony\Component\HttpFoundation\Response;

class IdentifyAcademicUnit
{
    public function handle(Request $request, Closure $next): Response
    {
        // 1. Buscamos el ID en el Header primero. Si no está, lo buscamos en el FormData/Body.
        $unitId = $request->header('X-Academic-Unit') ?? $request->input('academic_unit_id');

        if (!$unitId) {
            return response()->json([
                'message' => 'Falta identificar el contexto de la Unidad Académica (enviar header X-Academic-Unit o campo academic_unit_id).'
            ], 400);
        }

        // 2. Buscamos la unidad (Cambiamos el nombre de $slug a $unitId para mayor claridad)
        $unit = AcademicUnit::where('id', $unitId)->where('is_active', true)->first();

        if (!$unit) {
            return response()->json([
                'message' => 'Unidad académica no encontrada o inactiva.'
            ], 404);
        }

        // 3. Registramos la unidad en el contenedor de Laravel para que los Global Scopes la usen
        app()->instance(AcademicUnit::class, $unit);

        return $next($request);
    }
}