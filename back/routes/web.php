<?php

use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});

// Esto permite que cualquier ruta que empiece con /admin 
// cargue el archivo index.html del SPA.
Route::get('/admin/{any?}', function () {
    return file_get_contents(public_path('admin/index.html'));
})->where('any', '.*');