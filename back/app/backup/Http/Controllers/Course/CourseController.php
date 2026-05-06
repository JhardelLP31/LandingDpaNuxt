<?php

namespace App\Http\Controllers\Course;

use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Models\Course\Course;
use App\Models\Category\Category;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Storage;
use App\Http\Resources\Course\CourseResource;
use App\Http\Resources\Course\AdmCourseResource;
use Illuminate\Support\Facades\Gate; // IMPORTANTE
use App\Http\Resources\Course\SearchCourseResource;
use Illuminate\Support\Facades\Log; // Importar arriba

class CourseController extends Controller
{
    // =========================================================================
    // MÉTODOS PÚBLICOS (API / Frontend) - NO LLEVAN GATE
    // =========================================================================

    public function indexPublic(Request $request)
    {
        $limit = $request->get('limit', 4);
        // Obtenemos la fecha actual
        $now = now();

        $courses = Course::where('status', 'published')
            // Filtramos: que end_date sea mayor o igual a "ahora"
            ->where('end_date', '>=', $now)
            ->with(['category', 'instructor'])
            ->orderBy('created_at', 'desc')
            // Si quieres reactivar el límite, usa ->limit($limit)
            ->get();

        return response()->json([
            "data" => CourseResource::collection($courses)
        ]);
    }

    public function byCategory($idOrSlug)
    {
        $category = Category::where(is_numeric($idOrSlug) ? 'id' : 'slug', $idOrSlug)->first();

        if (!$category) {
            return response()->json(["message" => "Categoría no encontrada"], 404);
        }

        $courses = Course::where('category_id', $category->id)
            ->orderBy('created_at', 'desc')
            ->paginate(12);

        return response()->json([
            "category" => $category,
            "courses" => AdmCourseResource::collection($courses)
        ]);
    }
    public function search(Request $request)
    {
        $term = trim($request->query('search'));

        if (empty($term)) {
            return SearchCourseResource::collection(collect([]));
        }

        $courses = Course::where('status', 'published')
            ->where('end_date', '>=', now())
            ->where(function ($q) use ($term) {
                $q->where('title', 'LIKE', "%{$term}%")
                    ->orWhere('subtitle', 'LIKE', "%{$term}%");
            })
            ->orderBy('created_at', 'desc')
            ->limit(10)
            ->get();

        return SearchCourseResource::collection($courses);
    }
    public function showBySlug($slug)
    {
        $course = Course::where('slug', $slug)
            ->where('status', 'published')
            ->with(['category', 'instructor'])
            ->first();

        if (!$course) {
            return response()->json(["message" => "Curso no encontrado"], 404);
        }

        return response()->json([
            "data" => new AdmCourseResource($course)
        ]);
    }

    // =========================================================================
    // MÉTODOS PRIVADOS (CMS / Admin) - SÍ LLEVAN GATE
    // =========================================================================

    /**
     * Listar cursos (Panel Admin)
     */
    public function index(Request $request)
    {
        // 1. Permiso: list_course
        Gate::authorize('viewAny', Course::class);

        $search = $request->get('search');

        $courses = Course::with(['category', 'instructor'])
            ->when($search, function ($query, $search) {
                return $query->where('title', 'like', "%{$search}%");
            })
            ->orderBy('created_at', 'desc')
            ->paginate(10)
            ->withQueryString(); 

        return AdmCourseResource::collection($courses);
    }

    /**
     * Guardar nuevo curso
     */
public function store(Request $request)
    {
        if (!Gate::allows('create', Course::class)) {
            return response()->json(['message' => 'No autorizado'], 403);
        }

        $data = $request->validate([
            'title'           => 'required|string|max:255',
            'slug'            => 'nullable|string|unique:courses,slug',
            'subtitle'        => 'nullable|string|max:255', // FALTABA
            'excerpt'         => 'nullable|string',          // FALTABA
            'description'     => 'nullable|string',          // FALTABA
            'category_id'     => 'required|exists:categories,id',
            // 'user_id'      => 'required|exists:users,id', // NO LO TOMES DEL REQUEST, ES INSEGURO
            'status'          => 'required|in:draft,published,archived',
            'image_path'      => 'nullable|string',
            'video_url'       => 'nullable|string',          // FALTABA VALIDAR
            'content_blocks'  => 'nullable|array',
            'seo_title'       => 'nullable|string|max:255',  // FALTABA
            'seo_description' => 'nullable|string',          // FALTABA
        ]);

        // Generar slug si viene vacío
        if (empty($data['slug'])) {
            $data['slug'] = \Illuminate\Support\Str::slug($data['title']);
        }
        
        // Asignar el usuario autenticado (más seguro)
        $data['user_id'] = auth()->id(); 

        $course = Course::create($data);

        return new AdmCourseResource($course->load('category'));
    }
    /**
     * Ver un curso específico (Panel Admin)
     */
    public function show(string $slug)
    {
        // Buscamos primero
        $course = Course::where('slug', $slug)->firstOrFail();

        // 3. Permiso: list_course (o view)
        if (!Gate::allows('view', $course)) {
            return $this->respondError('No tienes permisos para ver este curso.', 403);
        }
        return new AdmCourseResource($course);
    }

    /**
     * Actualizar curso
     */


    public function update(Request $request, $id)
    {
        $course = Course::findOrFail($id);

        if (!Gate::allows('update', $course)) {
            return response()->json(['message' => 'No autorizado'], 403);
        }

        $data = $request->validate([
            'title'           => 'required|string|max:255',
            'slug'            => 'required|string|unique:courses,slug,' . $id,
            'subtitle'        => 'nullable|string|max:255', // FALTABA
            'excerpt'         => 'nullable|string',          // FALTABA
            'description'     => 'nullable|string',          // FALTABA
            'category_id'     => 'required|exists:categories,id',
            'status'          => 'required|in:draft,published,archived',
            'image_path'      => 'nullable|string',
            'video_url'       => 'nullable|string',          // FALTABA (Vital para lo que pediste)
            'content_blocks'  => 'nullable|array',
            'seo_title'       => 'nullable|string|max:255',  // FALTABA
            'seo_description' => 'nullable|string',          // FALTABA
        ]);

        $course->update($data);

        return new AdmCourseResource($course->load('category'));
    }

    /**
     * Enviar a papelera
     */

    public function destroy($id)
    {
        $course = Course::findOrFail($id);

        if (!Gate::allows('delete', $course)) {
            return $this->respondError('No tienes permisos para eliminar este curso.', 403);
        }
        $course->delete();

        return $this->respondSuccess([], 'Curso eliminado correctamente');
    }
}
