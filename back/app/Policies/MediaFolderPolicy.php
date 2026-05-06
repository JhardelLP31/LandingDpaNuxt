<?php

namespace App\Policies;

use App\Models\Media\MediaFolder;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class MediaFolderPolicy
{
    use HandlesAuthorization;

    public function viewAny(User $user): bool
    {
        return $user->can('list_media_folder');
    }

    public function view(User $user, MediaFolder $mediaFolder): bool
    {
        return $user->can('list_media_folder') && 
               $user->academic_unit_id === $mediaFolder->academic_unit_id;
    }

    public function create(User $user): bool
    {
        return $user->can('register_media_folder');
    }

    public function update(User $user, MediaFolder $mediaFolder): bool
    {
        return $user->can('edit_media_folder') && 
               $user->academic_unit_id === $mediaFolder->academic_unit_id;
    }

    public function delete(User $user, MediaFolder $mediaFolder): bool
    {
        return $user->can('delete_media_folder') && 
               $user->academic_unit_id === $mediaFolder->academic_unit_id;
    }
}