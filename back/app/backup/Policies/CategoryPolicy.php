<?php

namespace App\Policies;

use App\Models\User;
use App\Models\Category\Category;
use Illuminate\Auth\Access\Response;

class CategoryPolicy
{
    /**
     * Determina si el usuario puede ver la lista de categorías (Panel Admin).
     */
    public function viewAny(User $user): bool
    {
        return $user->can('list_category');
    }

    /**
     * Determina si el usuario puede ver una categoría específica.
     */
    public function view(User $user, Category $category): bool
    {
        // Generalmente quien puede listar, puede ver el detalle
        return $user->can('list_category');
    }

    /**
     * Determina si el usuario puede crear categorías.
     */
    public function create(User $user): bool
    {
        return $user->can('create_category');
    }

    /**
     * Determina si el usuario puede actualizar la categoría.
     */
    public function update(User $user, Category $category): bool
    {
        return $user->can('edit_category');
    }

    /**
     * Determina si el usuario puede eliminar la categoría.
     */
    public function delete(User $user, Category $category): bool
    {
        return $user->can('delete_category');
    }
}