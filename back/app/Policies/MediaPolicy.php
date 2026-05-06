<?php

namespace App\Policies;

use App\Models\Media\Media;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class MediaPolicy
{
    use HandlesAuthorization;

    public function viewAny(User $user): bool
    {
        return $user->can('list_media');
    }

    public function view(User $user, Media $media): bool
    {
        // Nota: Asumo que Media tiene el campo academic_unit_id, si está vinculado
        // por medio del folder_id, podrías validar la relación.
        return $user->can('list_media'); 
    }

    public function create(User $user): bool
    {
        return $user->can('register_media');
    }

    public function update(User $user, Media $media): bool
    {
        return $user->can('edit_media');
    }

    public function delete(User $user, Media $media): bool
    {
        return $user->can('delete_media');
    }
}