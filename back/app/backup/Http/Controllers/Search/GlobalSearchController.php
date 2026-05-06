<?php

namespace App\Http\Controllers\Search;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class GlobalSearchController extends Controller
{
    public function search(Request $request)
    {
        try {
            $query = $request->get('q');

            if (!$query || strlen($query) < 3) {
                return response()->json(['data' => []]);
            }

            // 1. Buscamos Cursos
            $courses = DB::table('courses')
                ->select('id', 'title', 'slug', 'category_id', 'image_path as image') // Ahora traemos también 'category_id'
                ->whereNull('deleted_at')
                ->where('title', 'LIKE', "%{$query}%")
                ->get()
                ->map(function($item) {
                    $item->type = 'course';
                    
                    // Buscamos la categoría del curso para agregarla a la URL
                    $category = DB::table('categories')->find($item->category_id);
                    $categorySlug = $category ? $category->slug : 'categoria-desconocida';
                    
                    // Actualizamos la URL para incluir la categoría
                    $item->url = "/course/{$categorySlug}"; // Aquí la URL ahora incluye la categoría
                    return $item;
                });

            // 2. Buscamos Manuales
            $manuals = DB::table('manuals')
                ->select('id', 'title', 'slug', 'image_path as image')
                ->whereNull('deleted_at')
                ->where('title', 'LIKE', "%{$query}%")
                ->get()
                ->map(function($item) {
                    $item->type = 'manual';
                    $item->url = "/manuales#{$item->slug}";
                    return $item;
                });

            $posts = DB::table('posts')
                ->select('id', 'title', 'slug', 'featured_image_path as image', 'type', 'content_blocks')
                ->where('status', 'published')
                ->whereNull('deleted_at')
                ->where(function($q) use ($query) {
                    $q->where('title', 'LIKE', "%{$query}%")
                    ->orWhere('content_blocks', 'LIKE', "%{$query}%");
                })
                ->get()
                ->map(function($item) use ($query) {
                    $blocks = is_string($item->content_blocks) ? json_decode($item->content_blocks, true) : $item->content_blocks;
                    $targetBlockId = null;

                    if (is_array($blocks)) {
                        foreach ($blocks as $block) {
                            $contentString = json_encode($block['content'] ?? '');
                            if (stripos($contentString, $query) !== false) {
                                $targetBlockId = $block['id'] ?? null;
                                break; 
                            }
                        }
                    }

                    $baseUrl = ($item->type === 'page') ? "/{$item->slug}" : "/noticias/view-detail/{$item->slug}";

                    return [
                        'id' => $item->id,
                        'title' => $item->title,
                        'slug' => $item->slug,
                        'image' => $item->image,
                        'type' => ($item->type === 'page' ? 'page' : 'news'),
                        'url' => $targetBlockId ? "{$baseUrl}#{$targetBlockId}" : $baseUrl
                    ];
                });

            $merged = $courses->concat($manuals)->concat($posts);

            return response()->json([
                'data' => $merged
            ]);

        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Error en búsqueda Collection',
                'message' => $e->getMessage()
            ], 500);
        }
    }
}
