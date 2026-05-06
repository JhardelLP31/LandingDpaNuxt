<?php
namespace App\Services\Academic;

use App\Models\Academic\AcademicUnit;
use Illuminate\Support\Str;

class AcademicUnitService
{
    /**
     * Crea una nueva Unidad Académica.
     */
    public function createUnit(array $data): AcademicUnit
    {
        if (empty($data['slug']) && isset($data['name'])) {
            $data['slug'] = Str::slug($data['name']);
        }


        return AcademicUnit::create($data);
    }

    /**
     * Actualiza una Unidad Académica existente.
     */
    public function updateUnit(AcademicUnit $unit, array $data): AcademicUnit
    {
        if (isset($data['name']) && empty($data['slug'])) {
            $data['slug'] = Str::slug($data['name']);
        }

        $unit->update($data);

        return $unit;
    }
}