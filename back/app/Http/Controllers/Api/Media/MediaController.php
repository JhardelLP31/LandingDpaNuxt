<?php

namespace App\Http\Controllers\Api\Media;

use App\Http\Controllers\Controller;
use App\Models\Academic\AcademicUnit;
use App\Models\Media\Media;
use App\Models\Media\MediaFolder;
use App\Services\Media\MediaService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Facades\Gate; // <-- AÑADIDO PARA LA SEGURIDAD

class MediaController extends Controller
{
    protected $service;

    public function __construct(MediaService $service)
    {
        $this->service = $service;
    }

    public function index(Request $request)
    {
        if (!$request->user()->can('list_media_folder') && !$request->user()->can('list_media')) {
            abort(403, 'No tienes permiso para acceder al gestor de archivos.');
        }

        $unit = app(AcademicUnit::class);
        $folderId = $request->query('folder_id');

        return response()->json([
            'folders' => MediaFolder::where('academic_unit_id', $unit->id)
                ->where('parent_id', $folderId)->get(),
            'files'   => Media::where('academic_unit_id', $unit->id)
                ->where('folder_id', $folderId)->get()
        ]);
    }
    
    public function storeFile(Request $request)
    {
        Gate::authorize('create', Media::class);

        if (!$request->user()->hasRole('Super-Admin') && $request->user()->academic_unit_id != $request->academic_unit_id) {
            abort(403, 'No tienes permiso para subir archivos en esta unidad.');
        }

        try {
            if (!$request->hasFile('files')) {
                return response()->json(['message' => 'No se detectó ningún archivo'], 400);
            }

            $unit = AcademicUnit::find($request->academic_unit_id);
            if (!$unit) {
                return response()->json(['message' => 'Unidad Académica no encontrada'], 404);
            }

            $uploadedFiles = [];

            foreach ($request->file('files') as $file) {
                $media = $this->service->uploadFile($file, $request->all(), $unit);
                $uploadedFiles[] = $media;
            }

            return response()->json([
                'success' => true,
                'message' => 'Archivo subido con éxito',
                'data'    => $uploadedFiles
            ], 201);

        } catch (\Exception $e) {
            Log::error('Error al subir: ' . $e->getMessage());
            
            return response()->json([
                'success' => false,
                'message' => 'Error interno: ' . $e->getMessage()
            ], 500);
        }
    }
    
    public function storeFolder(Request $request)
    {
        Gate::authorize('create', MediaFolder::class);

        if (!$request->user()->hasRole('Super-Admin') && $request->user()->academic_unit_id != $request->academic_unit_id) {
            abort(403, 'No tienes permiso para crear carpetas en esta unidad.');
        }

        try {
            $folder = MediaFolder::create([
                'academic_unit_id' => $request->academic_unit_id,
                'parent_id'        => $request->parent_id,
                'name'             => $request->name
            ]);

            return response()->json([
                'success' => true,
                'folder' => $folder
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => $e->getMessage()
            ], 500);
        }
    }

    /**
     * Renombrar una carpeta existente
     */
    public function updateFolder(Request $request, $id)
    {
        try {
            $request->validate([
                'name' => 'required|string|max:255'
            ]);

            $folder = MediaFolder::findOrFail($id);
            
            Gate::authorize('update', $folder);

            $folder->update([
                'name' => $request->name
            ]);

            return response()->json([
                'success' => true,
                'message' => 'Carpeta renombrada con éxito',
                'folder'  => $folder
            ], 200);

        } catch (\Exception $e) {
            return response()->json([
                'success' => false,
                'message' => 'Error al renombrar la carpeta: ' . $e->getMessage()
            ], 500);
        }
    }

    /**
     * Eliminar una carpeta
     */
    public function destroyFolder($id)
    {
        try {
            $folder = MediaFolder::findOrFail($id);
            
            Gate::authorize('delete', $folder);
            
            $folder->delete();

            return response()->json([
                'success' => true,
                'message' => 'Carpeta eliminada con éxito'
            ], 200);

        } catch (\Exception $e) {
            Log::error('Error al eliminar carpeta: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'No se pudo eliminar la carpeta. Asegúrate de que esté vacía.'
            ], 500);
        }
    }

    /**
     * Eliminar un archivo individual
     */
    public function destroyFile($id)
    {
        try {
            $media = Media::findOrFail($id);

            Gate::authorize('delete', $media);

            if ($media->path && Storage::disk('public')->exists($media->path)) {
                Storage::disk('public')->delete($media->path);
            }

            $media->delete();

            return response()->json([
                'success' => true,
                'message' => 'Archivo eliminado correctamente'
            ], 200);

        } catch (\Exception $e) {
            Log::error('Error al eliminar archivo: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'message' => 'Error al eliminar el archivo: ' . $e->getMessage()
            ], 500);
        }
    }
}