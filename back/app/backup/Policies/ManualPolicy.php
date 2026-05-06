<?php

namespace App\Policies;

use App\Models\Manual\Manual;
use App\Models\User;
use Illuminate\Auth\Access\Response;

class ManualPolicy
{
    /**
     * Determine whether the user can view any models.
     * Permiso: list_manual (Para el panel administrativo)
     */
    public function viewAny(User $user): bool
    {
        return $user->can('list_manual');
    }

    /**
     * Determine whether the user can view the model.
     * Permiso: list_manual
     */
    public function view(User $user, Manual $manual): bool
    {
        return $user->can('list_manual');
    }

    /**
     * Determine whether the user can create models.
     * Permiso: register_manual
     */
    public function create(User $user): bool
    {
        return $user->can('register_manual');
    }

    /**
     * Determine whether the user can update the model.
     * Permiso: edit_manual
     */
    public function update(User $user, Manual $manual): bool
    {
        // Opcional: Si quieres que un Instructor solo edite SUS cursos:
        // return $user->can('edit_manual') && ($user->hasRole('Super-Admin') || $user->id === $manual->user_id);
        
        return $user->can('edit_manual');
    }

    /**
     * Determine whether the user can delete the model.
     * Permiso: delete_manual
     */
    public function delete(User $user, Manual $manual): bool
    {
        return $user->can('delete_manual');
    }
}