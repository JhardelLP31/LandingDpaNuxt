<?php

namespace App\Models;

use App\Models\Academic\AcademicUnit;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Traits\HasRoles;
use Illuminate\Notifications\Notifiable;
use Illuminate\Database\Eloquent\SoftDeletes;
use PHPOpenSourceSaver\JWTAuth\Contracts\JWTSubject;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;

class User extends Authenticatable implements JWTSubject
{
    use HasFactory, Notifiable;
    use HasRoles;
    use SoftDeletes;

    public $guard_name = 'api';

    protected $fillable = [
        'name',
        'email',
        'password',
        "surname",
        "avatar",
        "role_id",
        "academic_unit_id",
        "phone",
        "type_document",
        "n_document",
        "gender",
        "state",
    ];

    protected $hidden = [
        'password',
        'remember_token',
    ];

    protected function casts(): array
    {
        return [
            'email_verified_at' => 'datetime',
            'password' => 'hashed',
            'academic_unit_id' => 'integer', // <--- 2. Casteo para asegurar que sea un número
        ];
    }

    public function getJWTIdentifier()
    {
        return $this->getKey();
    }
 
    public function getJWTCustomClaims()
    {
        // 3. OPCIONAL: Puedes meter el academic_unit_id en el Token si quieres
        return [
            'academic_unit_id' => $this->academic_unit_id
        ];
    }

    public function role()
    {
        return $this->belongsTo(Role::class, "role_id");
    }

    // 4. RELACIÓN: Para acceder a los datos de la unidad desde el usuario
    public function academicUnit()
    {
        return $this->belongsTo(AcademicUnit::class, "academic_unit_id");
    }
}