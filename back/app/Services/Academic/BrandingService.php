<?php
namespace App\Services\Academic;

use App\Models\Academic\UnitBranding;

class BrandingService
{
    public function updateBranding(int $unitId, array $data)
    {
        return UnitBranding::updateOrCreate(
            ['academic_unit_id' => $unitId],
            $data
        );
    }
}