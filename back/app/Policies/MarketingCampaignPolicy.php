<?php

namespace App\Policies;

use App\Models\Marketing\MarketingCampaign;
use App\Models\User;
use Illuminate\Auth\Access\HandlesAuthorization;

class MarketingCampaignPolicy
{
    use HandlesAuthorization;

    /**
     * Determine whether the user can view any models.
     */
    public function viewAny(User $user): bool
    {
        return $user->can('list_campaign');
    }

    /**
     * Determine whether the user can view the model.
     */
    public function view(User $user, MarketingCampaign $marketingCampaign): bool
    {
        return $user->can('list_campaign') && 
               $user->academic_unit_id === $marketingCampaign->academic_unit_id;
    }

    /**
     * Determine whether the user can create models.
     */
    public function create(User $user): bool
    {
        return $user->can('register_campaign');
    }

    /**
     * Determine whether the user can update the model.
     */
    public function update(User $user, MarketingCampaign $marketingCampaign): bool
    {
        return $user->can('edit_campaign') && 
               $user->academic_unit_id === $marketingCampaign->academic_unit_id;
    }

    /**
     * Determine whether the user can delete the model.
     */
    public function delete(User $user, MarketingCampaign $marketingCampaign): bool
    {
        return $user->can('delete_campaign') && 
               $user->academic_unit_id === $marketingCampaign->academic_unit_id;
    }

    /**
     * Determine whether the user can restore the model.
     */
    public function restore(User $user, MarketingCampaign $marketingCampaign): bool
    {
        return $user->can('delete_campaign') && 
               $user->academic_unit_id === $marketingCampaign->academic_unit_id;
    }

    /**
     * Determine whether the user can permanently delete the model.
     */
    public function forceDelete(User $user, MarketingCampaign $marketingCampaign): bool
    {
        return $user->can('delete_campaign') && 
               $user->academic_unit_id === $marketingCampaign->academic_unit_id;
    }
}