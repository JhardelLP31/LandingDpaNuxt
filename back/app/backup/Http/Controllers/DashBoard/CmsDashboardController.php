<?php

namespace App\Http\Controllers\DashBoard;

use App\Http\Controllers\Controller;
use App\Models\Lead\Lead;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Gate;
use Carbon\Carbon;

class CmsDashboardController extends Controller
{
    public function index()
    {
        // 1. VALIDACIÓN DE PERMISOS
        if (!Gate::allows('viewDashBoard', Lead::class)) {
            return response()->json([
                'success' => false,
                'message' => 'No tienes permisos para ver el Dashboard.',
                'code' => 403
            ]);
        }

        try {
            // --- A. KPIS GENERALES ---
            $kpis = [
                'total_leads'      => (int)Lead::count(),
                'leads_this_month' => (int)Lead::whereMonth('created_at', now()->month)->count(),
                'pending'          => (int)Lead::where('status', 'new')->count(),
                'spam_count'       => (int)Lead::where('status', 'spam')->count(),
            ];

            // --- B. DISTRIBUCIÓN POR TIPO DE FORMACIÓN (Donut Chart) ---
            // Extraemos "formation_type" del JSON metadata
            $formationStats = Lead::query()
                ->selectRaw("JSON_UNQUOTE(JSON_EXTRACT(metadata, '$.formation_type')) as label, count(*) as total")
                ->whereNotNull('metadata->formation_type') // Filtramos los que tienen este dato
                ->groupBy('label')
                ->orderByDesc('total')
                ->get()
                ->map(function($item) {
                    return [
                        'name'  => $item->label ?: 'Sin Especificar', // Si viene vacío
                        'value' => (int)$item->total
                    ];
                });

            // --- C. TOP 5 CURSOS MÁS SOLICITADOS (Bar Chart) ---
            // Extraemos "course_interest" del JSON metadata
            $courseStats = Lead::query()
                ->selectRaw("JSON_UNQUOTE(JSON_EXTRACT(metadata, '$.course_interest')) as label, count(*) as total")
                ->whereNotNull('metadata->course_interest')
                ->groupBy('label')
                ->orderByDesc('total')
                ->limit(5) // Solo el Top 5 para no saturar
                ->get()
                ->map(function($item) {
                    return [
                        'name'  => $item->label ?: 'Otros',
                        'value' => (int)$item->total
                    ];
                });

            // --- D. TREEMAP (ORIGEN URL) ---
            $urlData = Lead::select('origin_url', DB::raw('count(*) as total'))
                ->whereNotNull('origin_url')
                ->groupBy('origin_url')
                ->orderByDesc('total')
                ->limit(10)
                ->get()
                ->map(function($item) {
                    return [
                        'x' => $item->origin_url ? mb_convert_encoding($item->origin_url, 'UTF-8', 'UTF-8') : 'Directo',
                        'y' => (int)$item->total
                    ];
                });

            // --- E. HEATMAP (HORARIOS) ---
            $heatmapRaw = Lead::selectRaw("
                    DAYOFWEEK(DATE_SUB(created_at, INTERVAL 5 HOUR)) as day_num, 
                    HOUR(DATE_SUB(created_at, INTERVAL 5 HOUR)) as hour, 
                    count(*) as total
                ")
                ->groupBy('day_num', 'hour')
                ->get();

            $days = [1 => 'Dom', 2 => 'Lun', 3 => 'Mar', 4 => 'Mie', 5 => 'Jue', 6 => 'Vie', 7 => 'Sab'];
            $heatmapSeries = [];

            foreach ($days as $num => $name) {
                $dayData = [];
                for ($h = 0; $h < 24; $h++) {
                    $found = $heatmapRaw->where('day_num', $num)->where('hour', $h)->first();
                    $dayData[] = [
                        'x' => sprintf('%02d:00', $h),
                        'y' => $found ? (int)$found->total : 0
                    ];
                }
                $heatmapSeries[] = [
                    'name' => $name,
                    'data' => $dayData
                ];
            }

            // --- RETORNO FINAL ---
            return response()->json([
                'success' => true,
                'kpis' => $kpis,
                'charts' => [
                    'by_formation' => $formationStats, // Para gráfico de Torta/Dona
                    'by_course'    => $courseStats,    // Para gráfico de Barras
                    'by_url'       => [['data' => $urlData]], // Treemap
                    'by_time'      => array_reverse($heatmapSeries) // Heatmap
                ]
            ], 200, [], JSON_INVALID_UTF8_SUBSTITUTE);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error interno: ' . $e->getMessage()
            ], 500);
        }
    }
}