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

    public function byCategory($category_slug)
    {
        $category = Category::where('slug', $category_slug)->first();

        if (!$category) {
            return response()->json(["message" => "Categoría no encontrada"], 404);
        }
        $now = now();

        $courses = Course::where('category_id', $category->id)
            ->where('status', 'published')
            ->where('end_date', '>=', $now)

            ->with(['instructor'])
            ->orderBy('created_at', 'desc')
            ->paginate(12);

        return response()->json([
            "category" => $category,
            "courses" => CourseResource::collection($courses)
        ]);
    }
    public function search(Request $request)
    {
        // Limpiamos espacios en blanco
        $term = trim($request->query('search'));

        // Si no hay texto, devolvemos colección vacía de inmediato
        if (empty($term)) {
            return SearchCourseResource::collection(collect([]));
        }

        $courses = Course::where('status', 'published')
            // Filtro de fecha: Solo cursos que NO han terminado
            ->where('end_date', '>=', now()) 
            ->where(function($q) use ($term) {
                // Buscamos coincidencia en título O en subtítulo
                $q->where('title', 'LIKE', "%{$term}%")
                ->orWhere('subtitle', 'LIKE', "%{$term}%");
            })
            ->orderBy('created_at', 'desc')
            ->limit(10)
            ->get();

        // Retorna 200 OK con [] si no hay resultados, evitando errores de consola
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
            "data" => new CourseResource($course)
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
            ->paginate(10);

        return AdmCourseResource::collection($courses);
    }

    /**
     * Guardar nuevo curso
     */
    public function store(Request $request)
    {
        if (!Gate::allows('create', Course::class)) {
            return $this->respondError('No tienes permisos para crear cursos.', 403);
        }
        // 1. Validaciones básicas
        $request->validate([
            'title' => 'required|string|max:255',
            'user_id' => 'required|exists:users,id', // Instructor obligatorio
            'category_id' => 'nullable|exists:categories,id',
            'price' => 'required|numeric|min:0',
            'content_blocks' => 'nullable|array', // Validar que sea estructura array/json
            'image' => 'nullable|image|max:2048', // Max 2MB
        ]);

        $data = $request->all();

        // 2. Generar Slug único
        if (empty($data['slug'])) {
            $data['slug'] = Str::slug($data['title']);
            // Nota: En producción idealmente verificas que el slug no exista ya
        }

        // 3. Subir Imagen
        if ($request->hasFile('image')) {
            $data['image_path'] = $request->file('image')->store('courses', 'public');
        }

        // 4. Crear
        $course = Course::create($data);

        return $this->respondSuccess(new CourseResource($course), 'Curso creado correctamente');
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
        return new CourseResource($course);
    }

    /**
     * Actualizar curso
     */
    public function update(Request $request, $id)
    {
        $course = Course::findOrFail($id);

        // 4. Permiso: edit_course
        if (!Gate::allows('update', $course)) {
            return $this->respondError('No tienes permisos para editar este curso.', 403);
        }
        $request->validate([
            'title' => 'required|string|max:255',
            'price' => 'numeric|min:0',
        ]);

        $data = $request->except(['image']);

        // Slug
        if ($request->filled('slug') && $request->slug !== $course->slug) {
            $data['slug'] = Str::slug($request->slug);
        }

        // Imagen
        if ($request->hasFile('image')) {
            if ($course->image_path) {
                Storage::disk('public')->delete($course->image_path);
            }
            $data['image_path'] = $request->file('image')->store('courses', 'public');
        }

        $course->update($data);

        return $this->respondSuccess(new CourseResource($course), 'Curso actualizado correctamente');
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
