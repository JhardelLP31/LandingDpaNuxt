<?php
namespace App\Http\Controllers\Api\Academic;

use App\Http\Controllers\Controller;
use App\Http\Requests\Academic\StoreCategoryRequest;
use App\Http\Requests\Academic\UpdateCategoryRequest; 
use App\Models\Academic\AcademicUnit;
use App\Models\Academic\Category;
use App\Services\Academic\CategoryService;
use Illuminate\Support\Facades\Gate; // <-- AÑADIDO PARA LA SEGURIDAD

class CategoryController extends Controller
{
    protected $service;

    public function __construct(CategoryService $service)
    {
        $this->service = $service;
    }

    public function index()
    {
        Gate::authorize('viewAny', Category::class);

        return Category::all();
    }

    public function store(StoreCategoryRequest $request)
    {
        Gate::authorize('create', Category::class);

        $unitId = app(AcademicUnit::class)->id;
        $category = $this->service->createCategory($request->validated(), $unitId);

        return response()->json([
            'message' => 'Categoría creada con éxito',
            'data'    => $category
        ], 201);
    }

    public function update(UpdateCategoryRequest $request, $id)
    {
        $categoryForAuth = Category::findOrFail($id);
        
        Gate::authorize('update', $categoryForAuth);

        $category = $this->service->updateCategory($id, $request->validated());

        return response()->json([
            'success' => true,
            'message' => 'Categoría actualizada con éxito',
            'data'    => $category
        ]);
    }

    public function destroy($id)
    {
        $categoryForAuth = Category::findOrFail($id);
        
        Gate::authorize('delete', $categoryForAuth);

        $this->service->deleteCategory($id);

        return response()->json([
            'success' => true,
            'message' => 'Categoría eliminada con éxito'
        ]);
    }
}