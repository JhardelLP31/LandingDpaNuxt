<?php

namespace App\Policies;

use App\Models\Academic\Category;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class CategoryPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can view any models.
     */
    public function viewAny(User $user): bool
    {
        return $user->can('list_category');
    }

    /**
     * Determine whether the user can view the model.
     */
    public function view(User $user, Category $category): bool
    {
        return $user->can('list_category') && 
               $user->academic_unit_id === $category->academic_unit_id;
    }

    /**
     * Determine whether the user can create models.
     */
    public function create(User $user): bool
    {
        return $user->can('register_category');
    }

    /**
     * Determine whether the user can update the model.
     */
    public function update(User $user, Category $category): bool
    {
        return $user->can('edit_category') && 
               $user->academic_unit_id === $category->academic_unit_id;
    }

    /**
     * Determine whether the user can delete the model.
     */
    public function delete(User $user, Category $category): bool
    {
        return $user->can('delete_category') && 
               $user->academic_unit_id === $category->academic_unit_id;
    }

    /**
     * Determine whether the user can restore the model.
     */
    public function restore(User $user, Category $category): bool
    {
        return $user->can('delete_category') && 
               $user->academic_unit_id === $category->academic_unit_id;
    }

    /**
     * Determine whether the user can permanently delete the model.
     */
    public function forceDelete(User $user, Category $category): bool
    {
        return $user->can('delete_category') && 
               $user->academic_unit_id === $category->academic_unit_id;
    }
}