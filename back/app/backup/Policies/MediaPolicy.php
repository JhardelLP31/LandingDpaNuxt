<?php

namespace App\Policies;

use App\Models\Media\Media;
use App\Models\User;
use Illuminate\Auth\Access\Response;

class MediaPolicy
{
    /**
     * Determine whether the user can view any models.
     * Permiso: list_media
     */
    public function viewAny(User $user): bool
    {
        return $user->can('list_media');
    }

    /**
     * Determine whether the user can create models (Upload).
     * Permiso: register_media
     */
    public function create(User $user): bool
    {
        return $user->can('register_media');
    }

    /**
     * Determine whether the user can delete the model.
     * Permiso: delete_media
     */
    public function delete(User $user, Media $media): bool
    {
        return $user->can('delete_media');
    }
}