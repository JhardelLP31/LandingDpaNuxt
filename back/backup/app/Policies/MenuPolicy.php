<?php

namespace App\Policies;

use App\Models\Menu\MenuItem;
use App\Models\User;
use Illuminate\Auth\Access\Response;

class MenuPolicy
{
    /**
     * Determine whether the user can view any models.
     * Permiso: list_menu_item
     */
    public function viewAny(User $user): bool
    {
        return $user->can('list_menu_item');
    }

    /**
     * Determine whether the user can view the model.
     * Permiso: list_menu_item
     */
    public function view(User $user, MenuItem $menuItem): bool
    {
        return $user->can('list_menu_item');
    }

    /**
     * Determine whether the user can create models.
     * Permiso: register_menu_item
     */
    public function create(User $user): bool
    {
        return $user->can('register_menu_item');
    }

    /**
     * Determine whether the user can update the model.
     * Permiso: edit_menu_item
     */
    public function update(User $user, MenuItem $menuItem): bool
    {
        return $user->can('edit_menu_item');
    }

    /**
     * Determine whether the user can delete the model.
     * Permiso: delete_menu_item
     */
    public function delete(User $user, MenuItem $menuItem): bool
    {
        return $user->can('delete_menu_item');
    }
}