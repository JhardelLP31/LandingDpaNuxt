<?php

namespace App\Policies;

use App\Models\Page\Page;
use App\Models\User;

class PostPolicy
{
    /**
     * Determine whether the user can view any models.
     * Permitimos si tiene permiso de lista de posts O de noticias.
     */
    public function viewAny(User $user): bool
    {
        return $user->can('list_post') || $user->can('list_news');
    }

    /**
     * Determine whether the user can view the model.
     */
    public function view(User $user, Page $page): bool
    {
        return $page->type === 'news' 
            ? $user->can('list_news') 
            : $user->can('list_post');
    }

    /**
     * Determine whether the user can create models.
     */
    public function create(User $user, string $type = 'post'): bool
    {
        return $type === 'news' 
            ? $user->can('register_news') 
            : $user->can('register_post');
    }

    /**
     * Determine whether the user can update the model.
     */
    public function update(User $user, Page $page): bool
    {
        return $page->type === 'news' 
            ? $user->can('edit_news') 
            : $user->can('edit_post');
    }

    /**
     * Determine whether the user can delete the model.
     */
    public function delete(User $user, Page $page): bool
    {
        return $page->type === 'news' 
            ? $user->can('delete_news') 
            : $user->can('delete_post');
    }

    public function restore(User $user, Page $page): bool
    {
        return $this->update($user, $page);
    }

    public function forceDelete(User $user, Page $page): bool
    {
        return $this->delete($user, $page);
    }
}