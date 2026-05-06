<?php

namespace App\Http\Controllers\Page;

use App\Http\Controllers\Controller;
use App\Models\Page\Page;
use Illuminate\Http\Request;

class CourseController extends Controller
{
    /*public function index(Request $request)
    {
        // 1. Configuramos el límite (por defecto 4)
        $limit = $request->input('limit', 20);

        // 2. LA CONSULTA MAESTRA
        $courses = Page::where('type', 'course')      // Solo tipo Curso
            ->where('status', 'published')            // ¡IMPORTANTE! Solo publicados
            ->orderBy('created_at', 'desc')           // Los más nuevos primero
            //->take($limit)
            ->get();

        // 3. Mapeo de datos para el Frontend (ProductCard.vue)
        $mapped = $courses->map(function($c) {
            
            // Intentamos sacar el profesor del JSON (si existe)
            $blocks = is_string($c->content_blocks) ? json_decode($c->content_blocks, true) : $c->content_blocks;
            $teacherBlock = collect($blocks)->firstWhere('type', 'CourseDetailBlock');
            $firstTeacher = $teacherBlock['content']['teachers'][0] ?? null;

            return [
                'id' => $c->id,
                'title' => $c->title,
                'link' => '/programas/' . $c->slug, // Construimos la URL
                'image' => $c->featured_image_path, // Imagen destacada
                
                // Datos de Venta
                'status_label' => 'EN VENTA', // O lógica personalizada
                'startDate' => $c->start_date ? date('d M', strtotime($c->start_date)) : 'Por definir',
                'duration' => $teacherBlock['content']['duration'] ?? 'N/A', // Sacado del bloque o columna
                'categoryName' => $teacherBlock['content']['category'] ?? 'General',
                'categoryColor' => '#00ff73ff', // Puedes personalizar esto luego
                    
                // Profesor (Si encontramos uno en el JSON)
                'teacher' => $firstTeacher ? [
                    'name' => $firstTeacher['name'],
                    'image' => $firstTeacher['image'] ?? null
                ] : null
            ];
        });

        return response()->json($mapped);
    }
    */

    public function index(Request $request)
    {
        // 1. Límite dinámico (ej: ?limit=4 para el home)
        $limit = $request->input('limit', 20);

        // 2. CONSULTA BD
        $courses = Page::where('type', 'course')
            ->where('status', 'published')
            ->orderBy('created_at', 'desc')
           // ->take($limit)  <--- ¡AQUÍ FALTABA ESTO!
            ->get();

        // 3. MAPEO SEGURO
        $mapped = $courses->map(function($c) {
            
            // Decodificar JSON seguramente
            $blocks = is_string($c->content_blocks) ? json_decode($c->content_blocks, true) : $c->content_blocks;
            if (!is_array($blocks)) $blocks = [];

            // Buscar bloque de detalles
            $teacherBlock = collect($blocks)->firstWhere('type', 'CourseDetailBlock');

           
            $content      = $teacherBlock['content'] ?? [];
            $firstTeacher = $content['teachers'][0] ?? null;
            $savedState   = $content['course_status'] ?? 'EN VENTA';

            // Configuración de Colores
            $statusConfig = match ($savedState) {
                'AGOTADO'    => ['color' => '#6c757d'], // Gris
                'RESERVADO'  => ['color' => '#ffc107'], // Amarillo
                'DISPONIBLE' => ['color' => '#4aed29ff'], // Verde
                default      => ['color' => '#e31140'], // Rojo
            };

            return [
                'id'            => $c->id,
                'title'         => $c->title,
                'link'          => '/programas/' . $c->slug,
                // Usamos la ruta que guardamos con Storage::url() en el paso anterior
                'image'         => $c->featured_image_path ?? '/img/placeholder-course.jpg', 
                
                // Estados
                'status_key'    => $savedState,
                'status_label'  => $savedState,
                'status_color'  => $statusConfig['color'],

                // Datos con fallback (por si están vacíos)
                'start_date'     => $c->start_date ? date('d M', strtotime($c->start_date)) : 'Por definir',
                'end_date'     => $c->end_date ? date('d M', strtotime($c->end_date)) : 'Por definir',
                'duration'      => $content['duration'] ?? 'Duración N/A',
                'categoryName'  => $content['category'] ?? 'General',
                'categoryColor' => '#00ff73ff',
                    
                'teacher'       => $firstTeacher ? [
                    'name'  => $firstTeacher['name'],
                    'image' => $firstTeacher['image'] ?? null
                ] : null
            ];
        });

        return response()->json($mapped);
    }
}