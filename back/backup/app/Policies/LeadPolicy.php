<?php

namespace App\Policies;

use App\Models\User;
use App\Models\Lead\Lead;
use Illuminate\Auth\Access\HandlesAuthorization;

class LeadPolicy
{
    use HandlesAuthorization;

    /**
     * Ver listado de Leads (index)
     */
    public function viewAny(User $user): bool
    {
        return $user->can('list_lead');
    }
    public function viewDashBoard(User $user): bool
    {
        return $user->can('dashboard');
    }

    /**
     * Ver un Lead específico (show)
     */
    public function view(User $user, Lead $lead): bool
    {
        return $user->can('list_lead');
    }

    /**
     * Crear un Lead (store)
     * OJO: Esto solo aplica si un ADMIN lo crea desde el panel.
     * Si es el formulario público, no se debe chequear este permiso.
     */
    public function create(User $user): bool
    {
        return $user->can('create_lead');
    }

    /**
     * Editar un Lead (update)
     */
    public function update(User $user, Lead $lead): bool
    {
        return $user->can('edit_lead');
    }

    /**
     * Eliminar un Lead (destroy)
     */
    public function delete(User $user, Lead $lead): bool
    {
        return $user->can('delete_lead');
    }

    /**
     * Exportar a Excel (download_excel) - Método personalizado
     */
    public function export(User $user): bool
    {
        // Si no tienes un permiso específico 'export_lead', puedes reusar 'view_lead'
        return $user->can('export_lead') || $user->can('list_lead');
    }
}