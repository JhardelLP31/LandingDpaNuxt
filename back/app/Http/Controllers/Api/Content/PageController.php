<?php
// app/Http/Controllers/Api/Content/PageController.php

namespace App\Http\Controllers\Api\Content;

use App\Http\Controllers\Controller;
use App\Http\Requests\Content\StoreContentRequest;
use App\Http\Requests\Content\UpdateContentRequest;
use App\Http\Resources\Content\PageResource;
use App\Models\Academic\AcademicUnit;
use App\Models\Content\Content;
use App\Services\Content\ContentService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Gate;

class PageController extends Controller
{
    protected $contentService;

    public function __construct(ContentService $contentService)
    {
        $this->contentService = $contentService;
    }

    public function index(Request $request)
    {
        // Gate::authorize('viewAny', Content::class); 
        $pages = $this->contentService->getPaginatedPages($request->all());
        return PageResource::collection($pages);
    }

    public function show(Request $request, $identifier)
    {
        $query = Content::query();

        // Validamos si es un ID numérico o un slug de texto
        if (is_numeric($identifier)) {
            $query->where('id', $identifier);
        } else {
            $query->where('slug', $identifier);
            // Si por alguna razón pasamos un slug, filtramos por unidad
            if ($request->has('academic_unit_id')) {
                $query->where('academic_unit_id', $request->academic_unit_id);
            }
        }

        // Buscamos la página
        $page = $query->firstOrFail();

        // Gate::authorize('view', $page);            

        $page->load(['author', 'unit']);

        return new PageResource($page);
    }

    public function store(StoreContentRequest $request)
    {
        $unit = AcademicUnit::findOrFail($request->academic_unit_id);
        $page = $this->contentService->createPage($request->validated(), $unit);

        return response()->json([
            'message' => 'Página creada correctamente',
            'data' => new PageResource($page)
        ], 201);
    }

    public function showBySlug(Request $request, $slug)
    {
        $unitId = $request->academic_unit_id;

        $page = Content::where('slug', $slug)
            ->where('academic_unit_id', $unitId) 
            ->firstOrFail();

        return new PageResource($page);
    }

    public function showByUnitAndPageSlug($unitSlug, $pageSlug)
    {
        $page = Content::where('slug', $pageSlug)
            ->whereHas('unit', function ($query) use ($unitSlug) {
                $query->where('slug', $unitSlug);
            })
            ->first(); 

        if (!$page) {
            return response()->json([
                'success' => false,
                'message' => 'Página no encontrada para esta unidad académica'
            ], 404);
        }

        return new PageResource($page);
    }

    public function update(UpdateContentRequest $request, $identifier)
    {
        // 1. Buscamos la página igual que en el show
        $query = Content::query();

        if (is_numeric($identifier)) {
            $query->where('id', $identifier);
        } else {
            $query->where('slug', $identifier);
            if ($request->has('academic_unit_id')) {
                $query->where('academic_unit_id', $request->academic_unit_id);
            }
        }

        $page = $query->firstOrFail();

        // Gate::authorize('update', $page); // Descomenta si usas policies

        // 2. Actualizamos con los datos validados del FormRequest que me mostraste
        $page->update($request->validated());

        return response()->json([
            'message' => 'Contenido actualizado correctamente',
            'data' => new PageResource($page)
        ]);
    }

    public function selection(Request $request)
    {
        // Filtramos por unidad académica si viene en la petición
        $query = Content::select('id', 'title');
        
        if ($request->has('academic_unit_id')) {
            $query->where('academic_unit_id', $request->academic_unit_id);
        }

        return response()->json($query->get());
    }

    public function destroy(Content $page)
    {
        // OJO: Igual que en 'show', si pasas el slug aquí, podría borrar la página equivocada.
        // Siempre pasa el ID cuando vayas a eliminar.
        // Gate::authorize('delete', $page);          

        $this->contentService->deletePage($page);

        return response()->json(['message' => 'Página eliminada correctamente']);
    }
}