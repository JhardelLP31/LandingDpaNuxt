<?php

namespace App\Policies;

use App\Models\Common\MenuItem;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class MenuItemPolicy
{
    use HandlesAuthorization;

    public function viewAny(User $user): bool
    {
        return $user->can('list_menu_item');
    }

    public function view(User $user, MenuItem $menuItem): bool
    {
        // Validamos la Sede a través de la relación del Menú padre
        return $user->can('list_menu_item') && 
               $user->academic_unit_id === $menuItem->menu->academic_unit_id;
    }

    public function create(User $user): bool
    {
        return $user->can('register_menu_item');
    }

    public function update(User $user, MenuItem $menuItem): bool
    {
        return $user->can('edit_menu_item') && 
               $user->academic_unit_id === $menuItem->menu->academic_unit_id;
    }

    public function delete(User $user, MenuItem $menuItem): bool
    {
        return $user->can('delete_menu_item') && 
               $user->academic_unit_id === $menuItem->menu->academic_unit_id;
    }

    public function restore(User $user, MenuItem $menuItem): bool
    {
        return $user->can('delete_menu_item') && 
               $user->academic_unit_id === $menuItem->menu->academic_unit_id;
    }

    public function forceDelete(User $user, MenuItem $menuItem): bool
    {
        return $user->can('delete_menu_item') && 
               $user->academic_unit_id === $menuItem->menu->academic_unit_id;
    }
}