<?php

namespace App\Http\Controllers\Page;

use App\Models\PageCategory\Category;
use App\Models\Page\Page;
use Illuminate\Support\Str;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Gate;
use Illuminate\Support\Facades\Storage;
use App\Http\Resources\Page\PageResource;
use App\Http\Resources\Page\PageCollection;

class PageController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function selectionList()
    {
        // OptimizaciÃ³n: Solo traemos los campos necesarios
        $pages = Page::select('id', 'title', 'slug', 'type')
            ->where('status', 'published')
            ->orderBy('title', 'asc')
            ->get();

        return response()->json($pages);
    }

    public function showBySlug($slug)
    {
        // SIN CACHE: Consulta directa a la base de datos
        $page = Page::where('slug', $slug)->firstOrFail();

        return response()->json([
            "post" => $page
        ]);
    }

    public function index(Request $request)
    {
        // 1. MODIFICACIÃ“N: Gate::allows (Soft 200)
        if (!Gate::allows("viewAny", Page::class)) {
            return $this->respondError('No tienes permisos para ver el listado de pÃ¡ginas.', 403);
        }

        $search = $request->get("search");
        $requestedType = $request->get("type");

        // 1. Iniciamos la query
        $query = Page::query();
        $query->whereIn('type', ['page', 'landing']);

        // 2. Solo traemos los campos necesarios
        $query->select(
            'id',
            'title',
            'slug',
            'type',
            'status',
            'featured_image_path',
            'created_at',
            'updated_at',
            'user_id'
        );

        // 3. Eager Loading
        $query->with([
            'user:id,name,email',
            'categories:id,name'
        ]);

        // 4. BÃšSQUEDA
        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('title', 'like', "%{$search}%")
                    ->orWhere('slug', 'like', "%{$search}%");
            });
        }

        // 5. Filtro por tipo
        if ($requestedType === 'course') {
            $query->where('type', 'course');
        } else {
            $query->where('type', '!=', 'course');
        }

        // 6. PaginaciÃ³n
        $pages = $query->orderBy("id", "desc")->paginate(10);

        // 7. SIN CACHE: CategorÃ­as activas
        $categories = Category::select("id", "name")->orderBy("id", "desc")->get();

        // MANTENEMOS TU ESTRUCTURA JSON ORIGINAL PARA NO ROMPER LA TABLA
        return response()->json([
            "total" => $pages->total(),
            "paginate" => 10,
            "pages" => PageCollection::make($pages),
            "categories" => $categories->map(function ($cat) {
                return [
                    "id" => $cat->id,
                    "name" => $cat->name
                ];
            })
        ]);
    }

    public function config()
    {
        // SIN CACHE
        $categories = Category::where('is_active', 1)->get();

        return response()->json([
            "categories" => $categories->map(function ($cat) {
                return [
                    "id" => $cat->id,
                    "name" => $cat->name,
                ];
            }),
        ]);
    }

    public function store(Request $request)
    {
        // 1. MODIFICACIÃ“N: Gate::allows (Soft 200)
        if (!Gate::allows("create", Page::class)) {
            return $this->respondError('No tienes permisos para crear pÃ¡ginas.', 403);
        }

        // ValidaciÃ³n del slug
        $slug = $request->slug ? Str::slug($request->slug) : Str::slug($request->title);

        // 2. MODIFICACIÃ“N: Respuesta de error controlada
        if (Page::where('slug', $slug)->exists()) {
            return $this->respondError("YA EXISTE UNA PÃGINA CON ESTE SLUG/URL", 403);
        }

        // Preparamos los datos base
        $data = $request->all();
        $data['slug'] = $slug;
        $data['user_id'] = auth()->id() ?? 1;

        // Manejo de imagen destacada
        if ($request->hasFile("featured_image")) {
            $path = $request->file("featured_image")->store("pages", "public");
            $data["featured_image_path"] = $path;
        }

        // Crear la pÃ¡gina
        $page = Page::create($data);

        // Sincronizar categorÃ­as
        if ($request->has('category_ids')) {
            $page->categories()->sync($request->category_ids);
        }

        // 3. MODIFICACIÃ“N: Respuesta de Ã©xito estandarizada
        return $this->respondSuccess([
            "page" => PageResource::make($page)
        ], 'PÃ¡gina creada correctamente');
    }

    public function show($id_or_slug)
    {
        // BÃºsqueda eficiente por ID o Slug
        $page = Page::where('id', $id_or_slug)
            ->orWhere('slug', $id_or_slug)
            ->firstOrFail();

        return response()->json([
            'post' => PageResource::make($page)
        ]);
    }

    public function update(Request $request, $id_or_slug)
    {
        // 1. Buscar la pÃ¡gina
        $page = Page::where('id', $id_or_slug)
            ->orWhere('slug', $id_or_slug)
            ->firstOrFail();

        // 1. MODIFICACIÃ“N: Gate::allows (Soft 200)
        if (!Gate::allows("update", $page)) {
            return $this->respondError('No tienes permisos para editar esta pÃ¡gina.', 403);
        }

        $data = $request->all();

        // 2. ValidaciÃ³n Slug
        if ($request->has('slug') && $request->slug != $page->slug) {
            $newSlug = Str::slug($request->slug);
            if (Page::where("slug", $newSlug)->where("id", "<>", $page->id)->exists()) {
                // MODIFICACIÃ“N: Error controlado
                return $this->respondError("El Slug/URL ya existe en otra pÃ¡gina.", 422);
            }
            $data['slug'] = $newSlug;
        }

        // 3. CORRECCIÃ“N IMAGEN
        if ($request->hasFile("featured_image")) {
            if ($page->featured_image_path) {
                Storage::disk('public')->delete($page->featured_image_path);
            }
            $path = $request->file("featured_image")->store("pages", "public");
            $data["featured_image_path"] = $path;
        }


        if (empty($data['start_date'])) $data['start_date'] = null;
        if (empty($data['end_date'])) $data['end_date'] = null;

        // 5. Page Builder JSON
        if ($request->has('content_blocks')) {
            $blocks = $request->input('content_blocks');
            if (is_string($blocks)) {
                $decoded = json_decode($blocks, true);
                $data['content_blocks'] = (json_last_error() === JSON_ERROR_NONE) ? $decoded : [];
            } else {
                $data['content_blocks'] = $blocks;
            }
        }

        // 6. Guardar cambios
        $page->update($data);

        // Sincronizar categorÃ­as
        if ($request->has('category_ids')) {
            $page->categories()->sync($request->category_ids);
        }

        // 3. MODIFICACIÃ“N: Respuesta de Ã©xito estandarizada
        return $this->respondSuccess([
            "post" => $page
        ], 'Guardado correctamente');
    }

    public function destroy(string $id)
    {
        $page = Page::findOrFail($id);

        // 1. MODIFICACIÃ“N: Gate::allows (Soft 200)
        if (!Gate::allows("delete", $page)) {
            return $this->respondError('No tienes permisos para eliminar esta pÃ¡gina.', 403);
        }

        if ($page->featured_image_path) {
            Storage::delete($page->featured_image_path);
        }

        $page->delete();

        // 2. MODIFICACIÃ“N: Respuesta de Ã©xito estandarizada
        return $this->respondSuccess([], 'PÃ¡gina eliminada correctamente');
    }

    public function uploadImage(Request $request)
    {
        // 1. MODIFICACIÃ“N: Gate::allows (Soft 200)
        if (!Gate::allows("create", Page::class)) {
            return $this->respondError('No tienes permiso para subir imÃ¡genes.', 403);
        }

        $request->validate([
            'image' => 'required|image|mimes:jpeg,png,jpg,gif,webp|max:2048',
        ]);

        if ($request->hasFile('image')) {
            $path = Storage::putFile('blocks', $request->file('image'));

            // 2. MODIFICACIÃ“N: Respuesta de Ã©xito
            return $this->respondSuccess([
                'url' => asset('storage/' . $path)
            ], 'Imagen subida');
        }

        return $this->respondError('No se subiÃ³ ningÃºn archivo', 400);
    }
}
