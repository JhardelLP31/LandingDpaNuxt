<?php

namespace App\Policies;

use App\Models\Common\Menu;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class MenuPolicy
{
    use HandlesAuthorization;

    public function viewAny(User $user): bool
    {
        return $user->can('list_menu');
    }

    public function view(User $user, Menu $menu): bool
    {
        return $user->can('list_menu') && 
               $user->academic_unit_id === $menu->academic_unit_id;
    }

    public function create(User $user): bool
    {
        return $user->can('register_menu');
    }

    public function update(User $user, Menu $menu): bool
    {
        return $user->can('edit_menu') && 
               $user->academic_unit_id === $menu->academic_unit_id;
    }

    public function delete(User $user, Menu $menu): bool
    {
        return $user->can('delete_menu') && 
               $user->academic_unit_id === $menu->academic_unit_id;
    }

    public function restore(User $user, Menu $menu): bool
    {
        return $user->can('delete_menu') && 
               $user->academic_unit_id === $menu->academic_unit_id;
    }

    public function forceDelete(User $user, Menu $menu): bool
    {
        return $user->can('delete_menu') && 
               $user->academic_unit_id === $menu->academic_unit_id;
    }
}