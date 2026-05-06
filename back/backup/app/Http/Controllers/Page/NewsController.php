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

class NewsController extends Controller
{
    /**
     * Lista de selección para relacionar noticias.
     */
    public function selectionList()
    {
        $articles = Page::select('id', 'title', 'slug', 'type', 'start_date')
            ->where('status', 'published')
            ->orderBy('title', 'asc')
            ->get();

        return response()->json($articles);
    }

    /**
     * Obtener noticia por slug para el lector.
     */
    public function showBySlug($slug)
    {
        $article = Page::where('id', $slug)
            ->orWhere('slug', $slug)
            ->firstOrFail();

        return response()->json([
            'post' => PageResource::make($article)
        ]);
    }

    /**
     * Listado administrativo de la redacción.
     */
    public function index(Request $request)
    {
        if (!Gate::allows("viewAny", Page::class)) {
            return $this->respondError('No tienes permisos para ver el archivo de noticias.', 403);
        }

        $search = $request->get("search");

        $query = Page::query();

        $query->whereIn('type', ['news', 'events']);

        $query->select(
            'id',
            'title',
            'category_id',
            'slug',
            'type',
            'status',
            'featured_image_path',
            'created_at',
            'updated_at',
            'user_id',
            'start_date',
            'end_date',
        );

        $query->with([
            'user:id,name,email',
            'categories:id,name'
        ]);

        if ($search) {
            $query->where(function ($q) use ($search) {
                $q->where('title', 'like', "%{$search}%")
                    ->orWhere('slug', 'like', "%{$search}%");
            });
        }

        // Paginación de noticias
        $articles = $query->orderBy("id", "desc")->paginate(10);

        $categories = Category::select("id", "name")->orderBy("id", "desc")->get();

        return response()->json([
            "total" => $articles->total(),
            "paginate" => 10,
            "pages" => PageCollection::make($articles),
            "categories" => $categories->map(fn($cat) => [
                "id" => $cat->id,
                "name" => $cat->name
            ])
        ]);
    }
    /**
     * Listado PÚBLICO para el Home/Blog (Frontend).
     * No requiere autenticación.
     */
    public function publicList(Request $request)
    {
        // 1. Preparamos la consulta
        $query = Page::query()
            ->whereIn('type', ['news', 'events'])
            ->where('status', 'published')
            ->select(
                'id',
                'title',
                'slug',
                'excerpt',
                'featured_image_path',
                'content_blocks',
                'created_at',
                'start_date',
                'end_date',
                //'author'
            )
            ->orderBy('created_at', 'desc');

        // 2. Si el frontend pide un límite, lo aplicamos
        /*if ($request->has('limit')) {
            $query->take($request->input('limit'));
        }*/

        // 3. Obtenemos la colección directa (Array limpio)
        $articles = $query->get();

        return response()->json($articles);
    }

    public function config()
    {
        $sections = Category::where('is_active', 1)->get();

        return response()->json([
            "categories" => $sections->map(fn($cat) => [
                "id" => $cat->id,
                "name" => $cat->name,
            ]),
        ]);
    }

    /**
     * Publicar nuevo artículo.
     */
public function store(Request $request)
{
    if (!Gate::allows("create", [Page::class, 'news'])) { 
        return $this->respondError('No tienes permisos.', 403);
    }

    $data = $request->all();

    $data['type'] = $request->input('type', 'news');

    $data['slug'] = $request->slug ? Str::slug($request->slug) : Str::slug($request->title);
    $data['user_id'] = auth()->id() ?? 1;

    if ($request->hasFile("featured_image")) {
        $path = $request->file("featured_image")->store("media", "public");
        $data["featured_image_path"] = $path;
    } 
    elseif ($request->filled('image_path')) {
        $data["featured_image_path"] = $request->image_path;
    }

    $article = Page::create($data);

    if ($request->has('category_ids')) {
        $article->categories()->sync($request->category_ids);
    }

    return $this->respondSuccess([
        "page" => PageResource::make($article)
    ], 'Noticia creada');
}

    /**
     * Actualizar contenido de la noticia.
     */

    public function update(Request $request, $id_or_slug)
    {
        $article = Page::where('id', $id_or_slug)
            ->orWhere('slug', $id_or_slug)
            ->firstOrFail();

        if (!Gate::allows("update", $article)) {
            return $this->respondError('No tienes permisos.', 403);
        }

        // 1. AQUI AGREGAMOS 'type' PARA QUE SE PUEDA CAMBIAR AL EDITAR
        $data = $request->only([
            'title',
            'type',  // <--- AGREGAR ESTO
            'content_blocks',
            'excerpt',
            'category_id',
            'start_date',
            'status',
            'end_date',
            'is_active',
            'featured_image_path' // Esto recibe la ruta que manda el MediaSelector
        ]);

        // 2. Gestión de Slug (Si cambió)
        if ($request->has('slug') && $request->slug != $article->slug) {
            $newSlug = Str::slug($request->slug);
            
            // Verificamos que el slug no exista en OTRO post diferente a este
            if (Page::where("slug", $newSlug)->where("id", "<>", $article->id)->exists()) {
                return $this->respondError("La URL ya existe en otra noticia.", 422);
            }
            $data['slug'] = $newSlug;
        }

        // 3. Update masivo
        // Como ya tienes 'featured_image_path' dentro del only([]), 
        // y el frontend manda la ruta final, no necesitas un if extra para la imagen.
        
        $article->update($data);

        return $this->respondSuccess([
            "post" => PageResource::make($article)
        ], 'Contenido actualizado correctamente');
    }

    /**
     * Ver noticia por ID o Slug.
     */
    public function show($id_or_slug)
    {
        $article = Page::where('id', $id_or_slug)
            ->orWhere('slug', $id_or_slug)
            ->firstOrFail();

        return response()->json([
            'post' => PageResource::make($article)
        ]);
    }


    /**
     * Eliminar noticia.
     */
    public function destroy(string $id)
    {
        $article = Page::findOrFail($id);

        if (!Gate::allows("delete", $article)) {
            return $this->respondError('No tienes permisos para eliminar esta noticia.', 403);
        }

        if ($article->featured_image_path) {
            Storage::delete($article->featured_image_path);
        }

        $article->delete();

        return $this->respondSuccess([], 'Noticia eliminada correctamente');
    }

    /**
     * Subir multimedia para el cuerpo de la noticia.
     */
    public function uploadImage(Request $request)
    {
        if (!Gate::allows("create", Page::class)) {
            return $this->respondError('No tienes permiso para subir imágenes.', 403);
        }

        $request->validate([
            'image' => 'required|image|mimes:jpeg,png,jpg,gif,webp|max:2048',
        ]);

        if ($request->hasFile('image')) {
            $path = Storage::putFile('news_assets', $request->file('image'));

            return $this->respondSuccess([
                'url' => asset('storage/' . $path)
            ], 'Imagen subida');
        }

        return $this->respondError('No se subió ningún archivo', 400);
    }
}
