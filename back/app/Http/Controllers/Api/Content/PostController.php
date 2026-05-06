<?php

namespace App\Http\Controllers\Api\Content;

use App\Http\Controllers\Controller;
use App\Models\Content\Post;
use App\Models\Academic\AcademicUnit;
use Illuminate\Http\Request;
use App\Http\Requests\Content\StorePostRequest;
use App\Http\Requests\Content\UpdatePostRequest;
use App\Http\Resources\Content\PostResource;
use App\Services\Content\PostService;
use Illuminate\Support\Facades\Gate; // <-- AÑADIDO PARA LA SEGURIDAD

class PostController extends Controller
{
    protected $postService;

    public function __construct(PostService $postService)
    {
        $this->postService = $postService;
    }

    /**
     * Listar noticias/eventos paginados (CMS)
     */
    public function index(Request $request)
    {
        // 1. Validar Policy: ¿Tiene permiso list_post?
        Gate::authorize('viewAny', Post::class);

        $unitId = $request->input('academic_unit_id') ?? $request->header('X-Academic-Unit');
        
        $posts = $this->postService->getPaginatedPosts($request->all(), $unitId);

        return PostResource::collection($posts);
    }

    /**
     * Mostrar una noticia específica por ID o Slug (CMS)
     */
    public function show(Request $request, $identifier)
    {
        $query = Post::with(['category', 'academicUnit']);

        // Buscamos primero el modelo para luego validarlo
        if (is_numeric($identifier)) {
            $query->where('id', $identifier);
        } else {
            $query->where('slug', $identifier);
            if ($request->has('academic_unit_id')) {
                $query->where('academic_unit_id', $request->academic_unit_id);
            }
        }

        $post = $query->firstOrFail();

        Gate::authorize('view', $post);

        return new PostResource($post);
    }

    /**
     * Almacenar una nueva noticia/evento
     */
    public function store(StorePostRequest $request)
    {
        Gate::authorize('create', Post::class);

        $unitId = $request->input('academic_unit_id') ?? $request->header('X-Academic-Unit');

        if (!$request->user()->hasRole('Super-Admin') && $request->user()->academic_unit_id != $unitId) {
            abort(403, 'No tienes permiso para crear posts en una sede ajena.');
        }

        $unit = AcademicUnit::findOrFail($unitId);
        $post = $this->postService->createPost($request->validated(), $unit);

        return response()->json([
            'message' => 'Contenido registrado correctamente',
            'data'    => new PostResource($post)
        ], 201);
    }

    /**
     * Actualizar una noticia/evento existente
     */
    public function update(UpdatePostRequest $request, $identifier)
    {
        $query = Post::query();

        if (is_numeric($identifier)) {
            $query->where('id', $identifier);
        } else {
            $query->where('slug', $identifier);
            if ($request->has('academic_unit_id')) {
                $query->where('academic_unit_id', $request->academic_unit_id);
            }
        }

        $post = $query->firstOrFail();

        Gate::authorize('update', $post);

        if ($request->has('academic_unit_id') && !$request->user()->hasRole('Super-Admin') && $request->user()->academic_unit_id != $request->input('academic_unit_id')) {
            abort(403, 'No puedes trasladar este post a una sede ajena.');
        }

        $post->update($request->validated());

        return response()->json([
            'message' => 'Contenido actualizado correctamente',
            'data'    => new PostResource($post)
        ]);
    }

    /**
     * Eliminar una noticia
     */
    public function destroy(Post $post)
    {
        Gate::authorize('delete', $post);

        $this->postService->deletePost($post);

        return response()->json([
            'message' => 'Contenido eliminado correctamente'
        ]);
    }

    /**
     * Mostrar Noticia Público (Consumido por Frontend/Nuxt)
     */
    public function showByUnitAndPostSlug($unitSlug, $postSlug)
    {
        $unit = AcademicUnit::where('slug', $unitSlug)->firstOrFail();

        $post = Post::with('category')
            ->where('academic_unit_id', $unit->id)
            ->where('slug', $postSlug)
            ->firstOrFail();

        return response()->json([
            'data' => $post
        ]);
    }
}