<?php

namespace App\Policies;

use App\Models\Academic\StudyProgram;
use App\Models\User;
use Illuminate\Auth\Access\Response;

class StudyProgramPolicy
{
    /**
     * Determine whether the user can view any models.
     * Permiso: list_study_program (Para ver el listado general en el CMS)
     */
    public function viewAny(User $user): bool
    {
        return $user->can('list_study_program');
    }

    /**
     * Determine whether the user can view the model.
     * Permiso: list_study_program + Misma Unidad Académica
     */
    public function view(User $user, StudyProgram $studyProgram): bool
    {
        return $user->can('list_study_program') && 
               $user->academic_unit_id === $studyProgram->academic_unit_id;
    }

    /**
     * Determine whether the user can create models.
     * Permiso: register_study_program
     */
    public function create(User $user): bool
    {
        return $user->can('register_study_program');
    }

    /**
     * Determine whether the user can update the model.
     * Permiso: edit_study_program + Misma Unidad Académica
     */
    public function update(User $user, StudyProgram $studyProgram): bool
    {
        return $user->can('edit_study_program') && 
               $user->academic_unit_id === $studyProgram->academic_unit_id;
    }

    /**
     * Determine whether the user can delete the model.
     * Permiso: delete_study_program + Misma Unidad Académica
     */
    public function delete(User $user, StudyProgram $studyProgram): bool
    {
        return $user->can('delete_study_program') && 
               $user->academic_unit_id === $studyProgram->academic_unit_id;
    }

    /**
     * Determine whether the user can restore the model.
     * (Asociado al permiso de eliminar, para recuperar Soft Deletes)
     */
    public function restore(User $user, StudyProgram $studyProgram): bool
    {
        return $user->can('delete_study_program') && 
               $user->academic_unit_id === $studyProgram->academic_unit_id;
    }

    /**
     * Determine whether the user can permanently delete the model.
     * (Asociado al permiso de eliminar de forma definitiva)
     */
    public function forceDelete(User $user, StudyProgram $studyProgram): bool
    {
        // Puedes hacerlo más estricto si lo deseas (ej. solo el Super-Admin)
        // pero por defecto lo atamos al permiso de delete normal.
        return $user->can('delete_study_program') && 
               $user->academic_unit_id === $studyProgram->academic_unit_id;
    }
}