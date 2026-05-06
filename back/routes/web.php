<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
*/

// 1. La ruta del root (puedes dejarla así o que mande al admin)
Route::get('/', function () {
    return view('welcome');
});

// 2. RUTA DE EMERGENCIA PARA IMPORTAR TU SQL
// Una vez que entres a tu-url.com/importar-db y funcione, BORRA ESTO por seguridad.
Route::get('/importar-db', function () {
    // Asegúrate de que tu archivo .sql esté en la carpeta raíz del proyecto (donde está artisan)
    // Cambia 'backup.sql' por el nombre real de tu archivo.
    $path = base_path('backup.sql'); 

    if (!File::exists($path)) {
        return "⚠️ Error: No encuentro el archivo .sql en la ruta: " . $path;
    }

    try {
        // Ejecuta el contenido del SQL directamente en la base de datos conectada
        DB::unprepared(File::get($path));
        return "✅ ¡Victoria! La base de datos se importó correctamente.";
    } catch (\Exception $e) {
        return "❌ Error al importar: " . $e->getMessage();
    }
});

// 3. RUTA PARA EL SPA (VUE)
// Esta ruta debe ir al final para que no intercepte las demás.
Route::get('/admin/{any?}', function () {
    $path = public_path('admin/index.html');
    
    if (!File::exists($path)) {
        return "⚠️ El archivo index.html no existe en public/admin/. Revisa que subiste la carpeta 'dist' correctamente.";
    }
    
    return file_get_contents($path);
})->where('any', '.*');