<?php

namespace App\Policies;

use App\Models\Academic\UnitBranding;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class BrandingPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can view any models.
     */
    public function viewAny(User $user): bool
    {
        return $user->can('list_branding');
    }

    /**
     * Determine whether the user can view the model.
     */
    public function view(User $user, UnitBranding $unitBranding): bool
    {
        return $user->can('list_branding') && 
               $user->academic_unit_id === $unitBranding->academic_unit_id;
    }

    /**
     * Determine whether the user can create models.
     */
    public function create(User $user): bool
    {
        return $user->can('register_branding');
    }

    /**
     * Determine whether the user can update the model.
     */
    public function update(User $user, UnitBranding $unitBranding): bool
    {
        return $user->can('edit_branding') && 
               $user->academic_unit_id === $unitBranding->academic_unit_id;
    }

    /**
     * Determine whether the user can delete the model.
     */
    public function delete(User $user, UnitBranding $unitBranding): bool
    {
        return $user->can('delete_branding') && 
               $user->academic_unit_id === $unitBranding->academic_unit_id;
    }
}