<?php

namespace App\Http\Controllers\Course;

use Illuminate\Support\Str;
use Illuminate\Http\Request;
use App\Models\Course\Course;
use App\Models\Category\Category;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Storage;
use App\Http\Resources\Course\CourseResource;

class CourseController extends Controller
{
    /**
     * Listar cursos con paginación y búsqueda
     */
    public function index(Request $request)
    {
        $search = $request->get('search');

        $courses = Course::with(['category', 'instructor'])
            ->when($search, function ($query, $search) {
                return $query->where('title', 'like', "%{$search}%");
            })
            ->orderBy('created_at', 'desc')
            ->paginate(10);

        return CourseResource::collection($courses);
    }
    public function byCategory($category_slug)
    {
        // 1. Buscamos primero la categoría para asegurar que existe
        // Asumo que tienes un modelo Category importado
        $category = Category::where('slug', $category_slug)->first();

        if (!$category) {
            return response()->json([
                "message" => "Categoría no encontrada"
            ], 404);
        }

        $courses = Course::where('category_id', $category->id)
            ->where('status', 'published') // ¡Importante! Solo publicados
            ->with(['instructor']) // Cargamos relación necesaria para la tarjeta del curso
            ->orderBy('created_at', 'desc')
            ->paginate(12); // Paginamos por si hay 100 cursos de programación

        return response()->json([
            "category" => $category, // Opcional: devolver info de la categoría (nombre, cover)
            "courses" => CourseResource::collection($courses)
        ]);
    }
   public function indexPublic(Request $request)
    {
        $limit = $request->get('limit', 4);

        $courses = Course::where('status', 'published')
            // OPTIMIZACIÓN AQUÍ:
            // 1. Cargamos 'instructor' para evitar 1 consulta extra por curso.
            // 2. Si usas una tabla 'media' separada, agrégala aquí también: 'media'
            ->with(['category','instructor']) 
            ->orderBy('created_at', 'desc') // Ordenar por más nuevo siempre ayuda
            //->take($limit) // <--- DESCOMENTADO: ¡Vital para no cargar toda la base de datos!
            ->get();

        return response()->json([
            "data" => CourseResource::collection($courses) // Usar el Resource es mejor práctica
        ]);
    }
    // 2. DETALLE PÚBLICO (Para la vista individual)
    public function showBySlug($slug)
    {
        $course = Course::where('slug', $slug)
            ->where('status', 'published')
            // OPTIMIZACIÓN: Carga todo lo que la vista necesita de una vez
            // Ajusta los nombres según tus relaciones en el Modelo Course (sections, units, etc.)
            ->with(['category', 'instructor']) 
            ->first();

        if (!$course) {
            return response()->json([
                "message" => "Curso no encontrado o no está publicado"
            ], 404);
        }

        return response()->json([
            "data" => new CourseResource($course) // Usamos el Resource para dar formato
        ]);
    }
    /**
     * Guardar nuevo curso
     */
    public function store(Request $request)
    {
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

        return response()->json([
            'message' => 'Curso creado correctamente',
            'data' => new CourseResource($course)
        ], 201);
    }

    /**
     * Ver un curso específico
     */
    public function show(string $slug) // O show(Course $course) si usas Route Model Binding
    {
        // Opción 1: Búsqueda Manual (Más segura para debuggear ahora mismo)
        $course = Course::where('slug', $slug)->firstOrFail();


        return new CourseResource($course);
        // O si no usas Resources: return response()->json(['data' => $course]);
    }

    /**
     * Actualizar curso
     */
    public function update(Request $request, $id)
    {
        $course = Course::findOrFail($id);

        $request->validate([
            'title' => 'required|string|max:255',
            'price' => 'numeric|min:0',
            'content_blocks' => 'nullable|array',
        ]);

        $data = $request->except(['image']);

        // Actualizar slug si cambia el título (opcional, cuidado con SEO)
        if ($request->filled('slug') && $request->slug !== $course->slug) {
             $data['slug'] = Str::slug($request->slug);
        }

        // Manejo de imagen (Borrar vieja, subir nueva)
        if ($request->hasFile('image')) {
            if ($course->image_path) {
                Storage::disk('public')->delete($course->image_path);
            }
            $data['image_path'] = $request->file('image')->store('courses', 'public');
        }

        $course->update($data);

        return response()->json([
            'message' => 'Curso actualizado correctamente',
            'data' => new CourseResource($course)
        ]);
    }

    /**
     * Enviar a papelera
     */
    public function destroy($id)
    {
        $course = Course::findOrFail($id);
        $course->delete(); // Soft Delete

        return response()->json(['message' => 'Curso eliminado correctamente']);
    }
}