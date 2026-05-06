<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// --- IMPORTACIONES DE CONTROLADORES ---
use App\Http\Controllers\Auth\LoginController;
use App\Http\Controllers\Api\Academic\AcademicUnitController;
use App\Http\Controllers\AuthController;

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
use App\Http\Controllers\Role\RoleController;
use App\Http\Controllers\User\UserController;

// Middlewares
use App\Http\Middleware\IdentifyAcademicUnit;

/*
|--------------------------------------------------------------------------
| 1. RUTAS PÚBLICAS (ACCESO LIBRE)
|--------------------------------------------------------------------------
*/
Route::get('public/pages/{unitSlug}/{pageSlug}', [PageController::class, 'showByUnitAndPageSlug']);
Route::get('public/unit-branding/{slug}', [BrandingController::class, 'getPublicBrandingBySlug']);
Route::get('public/news/{unitSlug}/{newsSlug}', [PostController::class, 'showByUnitAndPostSlug']);

Route::middleware([IdentifyAcademicUnit::class])->group(function () {
    Route::get('public/config', [ConfigController::class, 'getPublicConfig']);
    Route::get('public/pages/{slug}', [PageController::class, 'showBySlug']);
    Route::get('public/posts', [PostController::class, 'index']); 
    Route::get('public/posts/{slug}', [PostController::class, 'show']); 
    Route::post('leads', [LeadController::class, 'store']);
});

/*
|--------------------------------------------------------------------------
| 2. RUTAS DE AUTENTICACIÓN (LOGIN Y ME)
|--------------------------------------------------------------------------
*/
Route::group(['prefix' => 'auth'], function () {
    Route::post('/login', [AuthController::class, 'login']); 
    
    // Usamos el middleware nativo de Laravel para proteger estas rutas
    Route::group(['middleware' => ['auth:api']], function() {
        Route::post('/logout', [AuthController::class, 'logout']);
        Route::get('/me', function (Request $request) {
            return response()->json($request->user());
        });
    });
});

/*
|--------------------------------------------------------------------------
| 3. RUTAS PRIVADAS (ADMIN CMS)
|--------------------------------------------------------------------------
*/
// Quitamos ValidateExternalToken y dejamos solo el auth y la identificación de unidad
Route::middleware([
    'auth:api', 
    IdentifyAcademicUnit::class
])->group(function () {

    // --- ACADEMIC & CONTENT ---
    Route::apiResource('academic-units', AcademicUnitController::class);
    Route::apiResource('categories', CategoryController::class);
    Route::apiResource('study-programs', StudyProgramController::class);
    
    Route::get('pages/selection', [PageController::class, 'selection']); 
    Route::apiResource('pages', PageController::class);
    Route::apiResource('posts', PostController::class);

    // Branding & Menus
    Route::get('unit-branding/unit/{id}', [BrandingController::class, 'show']); 
    Route::post('unit-branding', [BrandingController::class, 'update']); 

    Route::apiResource('menus', MenuController::class);
    Route::apiResource('menu-items', MenuItemController::class)->except(['index', 'show']);
    Route::post('menu-items/reorder', [MenuItemController::class, 'updateOrder']);

    // --- MEDIA ---
    Route::prefix('media')->group(function () {
        Route::post('upload', [MediaController::class, 'storeFile']);
        Route::delete('{id}', [MediaController::class, 'destroyFile']);
    });
    Route::get('media-manager/{academic_unit_id}', [MediaController::class, 'index']);
    Route::post('media-folders', [MediaController::class, 'storeFolder']);
    Route::put('media-folders/{id}', [MediaController::class, 'updateFolder']); 
    Route::delete('media-folders/{id}', [MediaController::class, 'destroyFolder']);

    // --- MARKETING ---
    Route::apiResource('marketing/campaigns', MarketingCampaignController::class);

    // --- LEADS ---
    Route::prefix('leads')->group(function () {
        Route::get('/', [LeadController::class, 'index']);
        Route::get('excel', [LeadController::class, 'download_excel']);
    });

    // --- ADMIN ---
    Route::apiResource("users", UserController::class);             
    Route::apiResource("role", RoleController::class);
});