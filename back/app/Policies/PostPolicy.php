<?php

namespace App\Policies;

use App\Models\Content\Post;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class PostPolicy
{
    use HandlesAuthorization;

    public function viewAny(User $user): bool
    {
        return $user->can('list_post');
    }

    public function view(User $user, Post $post): bool
    {
        return $user->can('list_post') && 
               $user->academic_unit_id === $post->academic_unit_id;
    }

    public function create(User $user): bool
    {
        return $user->can('register_post');
    }

    public function update(User $user, Post $post): bool
    {
        return $user->can('edit_post') && 
               $user->academic_unit_id === $post->academic_unit_id;
    }

    public function delete(User $user, Post $post): bool
    {
        return $user->can('delete_post') && 
               $user->academic_unit_id === $post->academic_unit_id;
    }
}