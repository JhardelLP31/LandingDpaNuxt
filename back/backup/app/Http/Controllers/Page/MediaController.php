<?php

namespace App\Http\Controllers\Page;

use App\Http\Controllers\Controller;
use App\Models\Media\Media;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Gate; // <--- IMPORTANTE
use Illuminate\Support\Str;
use Intervention\Image\Laravel\Facades\Image;
use Exception;

class MediaController extends Controller
{
    public function index(Request $request)
    {

        Gate::authorize('viewAny', Media::class);
        // Si pasas ?collection=avatars, filtra. Si no, trae todo.
        $query = Media::query();

        if ($request->has('collection')) {
            $query->where('collection', $request->collection);
        }

        // Filtramos para que NO traiga PDFs en la vista general de imágenes
        $media = $query->where('mime_type', '!=', 'application/pdf')
            ->orderBy('created_at', 'desc')
            ->get();

        $media->transform(function ($item) {
            if (!str_starts_with($item->url, 'http')) {
                $relativePath = str_replace('public/', '', $item->path);
                $item->url = Storage::disk('public')->url($relativePath);
            }
            return $item;
        });

        return response()->json($media);
    }

    public function download($id)
    {
        $media = Media::findOrFail($id);

        // Quitamos 'public/' del path para buscarlo en el storage
        $relativePath = str_replace('public/', '', $media->path);
        $fullPath = storage_path('app/public/' . $relativePath);

        if (!file_exists($fullPath)) {
            abort(404, 'Archivo no encontrado físicamente');
        }

        // El nombre que pusimos profesionalmente: 'categoria-en-titulo.pdf'
        $downloadName = $media->filename;

        return response()->download($fullPath, $downloadName, [
            'Content-Type' => 'application/pdf',
            'Access-Control-Expose-Headers' => 'Content-Disposition'
        ]);
    }
    public function uploadNew(Request $request)
    {
        Gate::authorize('create', Media::class);

        try {
            $fileField = $request->hasFile('file') ? 'file' : ($request->hasFile('image') ? 'image' : null);
            if (!$fileField) return response()->json(['error' => 'No file found'], 422);

            $file = $request->file($fileField);
            $extension = $file->getClientOriginalExtension();

            // --- NUEVA LÓGICA DE COLECCIÓN ---
            // Si el request trae 'collection', la usamos (ej. 'courses', 'posts').
            // Si no, la deducimos por el tipo de archivo.
            $collection = $request->input('collection', (strtolower($extension) === 'pdf' ? 'documents' : 'general'));

            // --- Lógica de nombres (se mantiene tu slug profesional) ---
            $baseName = $this->generateProfessionalName($request, $file);

            if (strtolower($extension) === 'pdf') {
                $filename = $baseName . '.pdf';
                $path = 'media/documents/' . $filename;
                Storage::disk('public')->putFileAs('media/documents', $file, $filename);
                $mimeType = 'application/pdf';
                $finalSize = $file->getSize();
                $isPublic = 0; // <--- Los PDFs por defecto podrías quererlos privados/protegidos
            } else {
                $filename = $baseName . '.webp';
                $path = 'media/' . $filename;
                $image = Image::read($file->getRealPath());
                $image->scaleDown(width: 2000);
                $encoded = $image->toWebp(quality: 80);
                Storage::disk('public')->put($path, (string) $encoded);
                $mimeType = 'image/webp';
                $finalSize = strlen((string) $encoded);
                $isPublic = 1; // <--- Las imágenes suelen ser públicas
            }

            $url = Storage::disk('public')->url($path);

            // --- CREACIÓN CON LOS NUEVOS CAMPOS ---
            $media = Media::create([
                'filename'   => $filename,
                'url'        => $url,
                'path'       => 'public/' . $path,
                'mime_type'  => $mimeType,
                'size'       => $finalSize,
                'collection' => $collection, 
                'is_public'  => $isPublic,   
            ]);

            return response()->json(['url' => $url, 'media_item' => $media], 200);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }
    private function generateProfessionalName(Request $request, $file)
    {
        $cTitle = $request->input('custom_title');
        $SubTitle = $request->input('custom_subtitle');
        $cCat = $request->input('custom_category');

        if ($cTitle && $cCat && $SubTitle) {
            return Str::slug($cCat . '-' . $SubTitle . '-en-especializacion-de-' . $cTitle) . '-' . time();
        }

        return time() . '_' . Str::slug(pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME));
    }

    // Opcional: Si en el futuro agregas borrar imagen
    /*
    public function destroy($id) {
        $media = Media::findOrFail($id);
        Gate::authorize('delete', $media);
        // ... lógica de borrado
    }
    */
}
