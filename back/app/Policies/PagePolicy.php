<?php

namespace App\Policies;

use App\Models\Page\Page;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class PagePolicy
{
    use HandlesAuthorization;

    public function viewAny(User $user): bool
    {
        return $user->can('list_page');
    }

    public function view(User $user, Page $page): bool
    {
        return $user->can('list_page') && 
               $user->academic_unit_id === $page->academic_unit_id;
    }

    public function create(User $user): bool
    {
        return $user->can('register_page');
    }

    public function update(User $user, Page $page): bool
    {
        return $user->can('edit_page') && 
               $user->academic_unit_id === $page->academic_unit_id;
    }

    public function delete(User $user, Page $page): bool
    {
        return $user->can('delete_page') && 
               $user->academic_unit_id === $page->academic_unit_id;
    }

    public function restore(User $user, Page $page): bool
    {
        return $user->can('delete_page') && 
               $user->academic_unit_id === $page->academic_unit_id;
    }

    public function forceDelete(User $user, Page $page): bool
    {
        return $user->can('delete_page') && 
               $user->academic_unit_id === $page->academic_unit_id;
    }
}