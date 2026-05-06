<?php
namespace App\Services\Media;

use App\Models\Media\Media;
use App\Models\Media\MediaFolder;
use Illuminate\Support\Facades\Storage;
use Illuminate\Support\Str;
use Intervention\Image\Laravel\Facades\Image;

class MediaService
{
public function uploadFile($file, $data, $unit)
{
    $extension = $file->getClientOriginalExtension();
    // En el request de upload, el id de la carpeta viene como 'folder_id'
    $folderId = $data['folder_id'] ?? null; 
    
    $baseName = $this->generateName($data, $file);
    $subPath = "media/{$unit->slug}/" . date('Y/m');

    if (strtolower($extension) === 'pdf') {
        $filename = $baseName . '.pdf';
        $path = $subPath . '/' . $filename;
        Storage::disk('public')->putFileAs($subPath, $file, $filename);
        $mimeType = 'application/pdf';
        $size = $file->getSize();
    } else {
        $filename = $baseName . '.webp';
        $path = $subPath . '/' . $filename;
        
        $image = Image::read($file->getRealPath());
        $image->scaleDown(width: 2000);
        $encoded = $image->toWebp(quality: 80);
        
        Storage::disk('public')->put($path, (string) $encoded);
        $mimeType = 'image/webp';
        $size = strlen((string) $encoded);
    }

    return Media::create([
        'academic_unit_id' => $unit->id,
        'folder_id'        => $folderId, // <--- Vinculación con la carpeta virtual
        'filename'         => $filename,
        'url'              => Storage::disk('public')->url($path),
        'path'             => 'public/' . $path,
        'mime_type'        => $mimeType,
        'size'             => $size,
    ]);
}

    private function generateName($data, $file)
    {
        if (!empty($data['custom_title']) && !empty($data['custom_category'])) {
            return Str::slug($data['custom_category'] . '-' . ($data['custom_subtitle'] ?? '') . '-en-' . $data['custom_title']) . '-' . time();
        }
        return time() . '_' . Str::slug(pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME));
    }
}