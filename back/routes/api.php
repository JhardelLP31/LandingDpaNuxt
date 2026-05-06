<?php

use App\Http\Controllers\Api\Academic\AcademicUnitController;
use App\Http\Controllers\Api\Academic\BrandingController;
use App\Http\Controllers\Api\Academic\CategoryController;
use App\Http\Controllers\Api\Academic\StudyProgramController;
use App\Http\Controllers\Api\Common\ConfigController;
use App\Http\Controllers\Api\Content\MenuController;
use App\Http\Controllers\Api\Content\MenuItemController;
use App\Http\Controllers\Api\Content\PageController;
use App\Http\Controllers\Api\Content\PostController;
use App\Http\Controllers\Api\Marketing\LeadController;
use App\Http\Controllers\Api\Marketing\MarketingCampaignController;
use App\Http\Controllers\Api\Media\MediaController;
use App\Http\Controllers\Auth\LoginController;
use App\Http\Controllers\Role\RoleController;
use App\Http\Controllers\User\UserController;
use App\Http\Middleware\IdentifyAcademicUnit;
use App\Http\Middleware\ValidateExternalToken;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| RUTAS GLOBALES (Sin Tenancy)
|--------------------------------------------------------------------------
*/

Route::post('login-system', [LoginController::class, 'login']);

/*
|--------------------------------------------------------------------------
| 1. RUTAS PÚBLICAS TENANT (Requieren X-Academic-Unit)
|--------------------------------------------------------------------------
| El Frontend las consume para pintar la Landing Page.
*/
Route::get('public/pages/{unitSlug}/{pageSlug}', [PageController::class, 'showByUnitAndPageSlug']);
Route::get('public/unit-branding/{slug}', [BrandingController::class, 'getPublicBrandingBySlug']);
Route::get('public/news/{unitSlug}/{newsSlug}', [PostController::class, 'showByUnitAndPostSlug']);

Route::middleware([IdentifyAcademicUnit::class])->group(function () {

    // Configuración inicial (Branding, Logos, Colores, Menús)
    Route::get('public/config', [ConfigController::class, 'getPublicConfig']);

    // Contenido de Páginas/Landings
    Route::get('public/pages/{slug}', [PageController::class, 'showBySlug']);

    Route::get('public/posts', [PostController::class, 'index']); 
    Route::get('public/posts/{slug}', [PostController::class, 'show']); 

    // Captura de Leads (Formulario de la Landing)
    Route::post('leads', [LeadController::class, 'store']);
});
    
/*
|--------------------------------------------------------------------------
| 2. RUTAS PRIVADAS (Requieren Token + X-Academic-Unit)
|--------------------------------------------------------------------------
| Gestión desde el Panel Administrativo (CMS).
*/
Route::middleware([
    ValidateExternalToken::class,
    IdentifyAcademicUnit::class
])->group(function () {

    // --- MI PERFIL ---
    Route::get('/auth/me', function (Request $request) {
        return response()->json($request->user());
    });

    // --- ACADEMIC & CONTENT ---
    Route::apiResource('academic-units', AcademicUnitController::class);
    Route::apiResource('categories', CategoryController::class);
    Route::apiResource('study-programs', StudyProgramController::class);
    
    // RUTAS NUEVAS PARA EL GESTOR DE MENÚS
    Route::get('pages/selection', [PageController::class, 'selection']); // <- Soluciona el 404 de las páginas
    
    Route::apiResource('pages', PageController::class);

    Route::apiResource('posts', PostController::class);

    // Branding & Menus
    // Agregamos el GET para cargar la configuración actual de la unidad
    Route::get('unit-branding/unit/{id}', [BrandingController::class, 'show']); 
    
    // Cambiamos 'branding' por 'unit-branding' para guardar/actualizar
    Route::post('unit-branding', [BrandingController::class, 'update']); 

    Route::apiResource('menus', MenuController::class);
    Route::apiResource('menu-items', MenuItemController::class)->except(['index', 'show']);
    Route::post('menu-items/reorder', [MenuItemController::class, 'updateOrder']);

    // --- MEDIA (Archivos y Carpetas Virtuales) ---
    Route::prefix('media')->group(function () {
        Route::post('upload', [MediaController::class, 'storeFile']);
        Route::delete('{id}', [MediaController::class, 'destroyFile']); // <-- Faltaba apuntar a destroyFile
    });

    Route::prefix('marketing')->group(function () {
        Route::get('campaigns', [MarketingCampaignController::class, 'index']);
        Route::post('campaigns', [MarketingCampaignController::class, 'store']);
        Route::delete('campaigns/{id}', [MarketingCampaignController::class, 'destroy']);
        Route::put('campaigns/{id}', [MarketingCampaignController::class, 'update']);
    });

    Route::get('media-manager/{academic_unit_id}', [MediaController::class, 'index']);
    
    // Rutas para las carpetas
    Route::post('media-folders', [MediaController::class, 'storeFolder']);
    Route::put('media-folders/{id}', [MediaController::class, 'updateFolder']); 
    Route::delete('media-folders/{id}', [MediaController::class, 'destroyFolder']);
   
    // --- MARKETING (Gestión de Leads) ---
    Route::prefix('leads')->group(function () {
        Route::get('/', [LeadController::class, 'index']);
        Route::get('excel', [LeadController::class, 'download_excel']);
    });

    // --- ADMIN (Roles & Usuarios) ---
    Route::apiResource("users", UserController::class);             
    Route::apiResource("role", RoleController::class);
});