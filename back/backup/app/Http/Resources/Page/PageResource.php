<?php

namespace App\Http\Resources\Page;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class PageResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        // Obtener la URL base del .env para asegurar consistencia
        $baseUrl = rtrim(env('APP_URL', $request->getSchemeAndHttpHost()), '/');

        return [
            "id" => $this->id,
            "title" => $this->title,
            "slug" => $this->slug,
            
            "type" => $this->type,
            "start_date" => $this->start_date,
            "status" => $this->status,
            "end_date" => $this->end_date,
            
            // Procesamiento de Imagen y Bloques
            "featured_image_path" => $this->formatImageUrl($this->featured_image_path, $baseUrl),
            "content_blocks" => $this->processContentBlocks($this->content_blocks, $baseUrl),

            
            "category" => $this->category ? [
                "id" => $this->category->id,
                "name" => $this->category->name,
                "slug" => $this->category->slug,
                "color" => $this->category->color, 
            ] : null,

            // 2. Solo el ID (Para que el Select del Formulario sepa cuál marcar)
            "category_id" => $this->category_id,

            // =========================================================

            "excerpt" => $this->excerpt,
            "created_at" => $this->created_at ? $this->created_at->format("Y-m-d h:i A") : null,
        ];
    }

    /**
     * Helper para limpiar URLs de imágenes
     */
    private function formatImageUrl($path, $baseUrl)
    {
        if (!$path) return null;

        // Si ya es una URL externa, la devolvemos tal cual
        if (str_starts_with($path, 'http')) return $path;

        // Limpieza robusta de dobles barras y 'storage' duplicado
        $cleanPath = str_replace('public/', '', $path);
        $cleanPath = ltrim($cleanPath, '/');

        // Si el path ya incluye 'storage/', no lo agregamos de nuevo
        if (str_starts_with($cleanPath, 'storage/')) {
            return $baseUrl . '/' . $cleanPath;
        }

        return $baseUrl . '/storage/' . $cleanPath;
    }

    /**
     * Helper para procesar URLs dentro del contenido rico (Editor de texto)
     */
    private function processContentBlocks($content, $baseUrl)
    {
        if (empty($content)) return null;
        
        // Decodificar si viene como string JSON
        $data = is_string($content) ? json_decode($content, true) : $content;
        
        if (!$data) return null;

        $jsonString = json_encode($data);
        
        $currentHost = parse_url($baseUrl, PHP_URL_HOST);
        
        // Buscamos referencias antiguas a localhost o IPs viejas
        $search = ['http://localhost:8000', 'http://127.0.0.1:8000']; 
        
        // Las reemplazamos por la URL actual
        $replace = [$baseUrl, $baseUrl];
        
        $jsonString = str_replace($search, $replace, $jsonString);

        return json_decode($jsonString, true);
    }
}