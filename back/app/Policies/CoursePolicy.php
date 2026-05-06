<?php

namespace App\Policies;

use App\Models\Course\Course;
use App\Models\User;
use Illuminate\Auth\Access\Response;

class CoursePolicy
{
    /**
     * Determine whether the user can view any models.
     * Permiso: list_course (Para el panel administrativo)
     */
    public function viewAny(User $user): bool
    {
        return $user->can('list_course');
    }

    /**
     * Determine whether the user can view the model.
     * Permiso: list_course
     */
    public function view(User $user, Course $course): bool
    {
        return $user->can('list_course');
    }

    /**
     * Determine whether the user can create models.
     * Permiso: register_course
     */
    public function create(User $user): bool
    {
        return $user->can('register_course');
    }

    /**
     * Determine whether the user can update the model.
     * Permiso: edit_course
     */
    public function update(User $user, Course $course): bool
    {
        // Opcional: Si quieres que un Instructor solo edite SUS cursos:
        // return $user->can('edit_course') && ($user->hasRole('Super-Admin') || $user->id === $course->user_id);
        
        return $user->can('edit_course');
    }

    /**
     * Determine whether the user can delete the model.
     * Permiso: delete_course
     */
    public function delete(User $user, Course $course): bool
    {
        return $user->can('delete_course');
    }
}