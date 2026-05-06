<?php
namespace App\Http\Controllers\Api\Common;

use App\Http\Controllers\Controller;
use App\Models\Academic\AcademicUnit;
use App\Models\Academic\UnitBranding;
use App\Models\Common\Menu;

class ConfigController extends Controller
{
    public function getPublicConfig()
    {
        $unit = app(AcademicUnit::class);

        return response()->json([
            'unit' => $unit,
            'branding' => UnitBranding::where('academic_unit_id', $unit->id)
                ->with(['logoPrimary', 'logoFooter', 'favicon'])
                ->first(),
            'navigation' => [
                'header' => Menu::where('academic_unit_id', $unit->id)
                    ->where('location', 'header')
                    ->with(['items' => function($q) {
                        $q->whereNull('parent_id')->with('children')->orderBy('order');
                    }])->first(),
                'footer' => Menu::where('academic_unit_id', $unit->id)
                    ->where('location', 'footer')
                    ->with(['items' => function($q) {
                        $q->whereNull('parent_id')->with('children')->orderBy('order');
                    }])->first(),
            ]
        ]);
    }
}