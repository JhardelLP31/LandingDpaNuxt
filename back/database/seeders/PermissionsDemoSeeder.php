<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\PermissionRegistrar;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\DB; 

class PermissionsDemoSeeder extends Seeder
{
    public function run(): void
    {
        // 1. Apagar las restricciones de Claves Foráneas temporalmente
        DB::statement('SET FOREIGN_KEY_CHECKS=0;');

        // 2. Limpiar las tablas de permisos (TRUNCATE)
        DB::table('model_has_permissions')->truncate();
        DB::table('model_has_roles')->truncate();
        DB::table('role_has_permissions')->truncate();
        DB::table('permissions')->truncate();
        DB::table('roles')->truncate();

        // 3. Volver a encender la seguridad
        DB::statement('SET FOREIGN_KEY_CHECKS=1;');

        // 4. Resetear la caché de Spatie
        app()[PermissionRegistrar::class]->forgetCachedPermissions();

        // --------------------------------------------------------------
        // AHORA SÍ, CREAMOS TODO DE NUEVO (LIMPIO)
        // --------------------------------------------------------------

        // Permiso suelto general
        Permission::create(['guard_name' => 'api', 'name' => 'dashboard']);

        // Tu lista de módulos COMPLETOS (Sincronizados con Vue)
       // Tu lista de módulos COMPLETOS (Sincronizados con Vue y tus Rutas)
        $modules = [
            // --- GESTIÓN ACADÉMICA ---
            'academic_unit',  // Unidades Académicas
            'study_program',  // Programas de Estudio
            'branding',       // Para BrandingController (Logos, colores de la unidad)
            
            // --- MARKETING Y VENTAS ---
            'campaign',       // Campañas de Marketing
            'category',       // Categorías
            'lead',           // Leads
            'company',        // Para la tabla companies 
            
            // --- CMS (CONTENIDO) ---
            'page',           // Para PageController (Páginas estáticas/Landing)
            'post',           // Entradas de blog
            'news',           // Noticias y Eventos
            'course',         // Cursos
            'manual',         // Manuales
            'menu',           // Para MenuController (El contenedor principal)
            'menu_item',      // Menús (Los enlaces dentro del menú)
            'media',          // Gestor de Archivos (Subir archivos)
            'media_folder',   // Para crear/editar carpetas virtuales
            
            // --- SISTEMA Y ACCESOS ---
            'user',           // Usuarios
            'role',           // Roles y Permisos
            'setting',        // Configuraciones globales
        ];

        // Generar los 4 permisos (CRUD) por cada módulo automáticamente
        foreach ($modules as $module) {
            Permission::create(['guard_name' => 'api', 'name' => 'register_' . $module]);
            Permission::create(['guard_name' => 'api', 'name' => 'list_' . $module]);
            Permission::create(['guard_name' => 'api', 'name' => 'edit_' . $module]);
            Permission::create(['guard_name' => 'api', 'name' => 'delete_' . $module]);
        }

        // Crear Rol Super-Admin
        $roleSuperAdmin = Role::create(['guard_name' => 'api', 'name' => 'Super-Admin']);

        // Crear o buscar tu Usuario
        $user = User::firstOrCreate(
            ['email' => 'jpumahuillca'], 
            [
                'name' => 'Jhardel LP',
                // Asegúrate de ponerle su unidad_id para que el Admin funcione bien
                'academic_unit_id' => 1, // <--- RECOMENDADO: Asígnele una unidad por defecto
                'password' => Hash::make('12345678'),
                'created_at' => now(),
            ]
        );

        // Asignar el rol al usuario
        $user->assignRole($roleSuperAdmin);
    }
}