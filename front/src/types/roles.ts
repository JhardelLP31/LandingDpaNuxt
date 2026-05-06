export type Role = {
    id:string,
    name:string,
    created_at:string,
    permissions: Array<any>,
    permissions_pluck: Array<any>,
}
export type Roles = {
    total: number,
    paginate: number,
    roles:  Role[],
}
export type RoleResponse = {
    message:string | number,
    message_text?:string,
    role?: Role,
}

export const PERMISOS = [
    {
        name: 'Dashboard',
        permisos: [
            { name: 'Ver Dashboard', permiso: 'dashboard' },
        ]
    },
    // --- GESTIÓN ACADÉMICA (Nuevos) ---
    {
        name: 'Unidades Académicas',
        permisos: [
            { name: 'Listado', permiso: 'list_academic_unit' },
            { name: 'Registrar', permiso: 'register_academic_unit' },
            { name: 'Editar', permiso: 'edit_academic_unit' },
            { name: 'Eliminar', permiso: 'delete_academic_unit' },
        ]
    },
    {
        name: 'Programas de Estudio',
        permisos: [
            { name: 'Listado', permiso: 'list_study_program' },
            { name: 'Registrar', permiso: 'register_study_program' },
            { name: 'Editar', permiso: 'edit_study_program' },
            { name: 'Eliminar', permiso: 'delete_study_program' },
        ]
    },
    // --- MARKETING Y COMERCIAL ---
    {
        name: 'Campañas de Marketing', 
        permisos: [
            { name: 'Listado', permiso: 'list_campaign' },
            { name: 'Registrar', permiso: 'register_campaign' },
            { name: 'Editar', permiso: 'edit_campaign' },
            { name: 'Eliminar', permiso: 'delete_campaign' },
        ]
    },
    {
        name: 'Contactos (Leads)',
        permisos: [
            { name: 'Listado', permiso: 'list_lead' },
            { name: 'Registrar', permiso: 'register_lead' },
            { name: 'Editar', permiso: 'edit_lead' },
            { name: 'Eliminar', permiso: 'delete_lead' },
        ]
    },
    {
        name: 'Categorías',
        permisos: [
            { name: 'Listado', permiso: 'list_category' },
            { name: 'Registrar', permiso: 'register_category' },
            { name: 'Editar', permiso: 'edit_category' },
            { name: 'Eliminar', permiso: 'delete_category' },
        ]
    },
    // --- CMS / GESTIÓN DE CONTENIDO ---
    {
        name: 'Páginas (Landings)', // <-- CORREGIDO A "_page"
        permisos: [
            { name: 'Listado', permiso: 'list_page' },
            { name: 'Registrar', permiso: 'register_page' },
            { name: 'Editar', permiso: 'edit_page' },
            { name: 'Eliminar', permiso: 'delete_page' },
        ]
    },
    {
        name: 'Noticias y Eventos', // (Si en la BD dejaste "_post" para noticias, lo cambias a "_post", pero "_news" es más claro)
        permisos: [
            { name: 'Listado', permiso: 'list_news' },
            { name: 'Registrar', permiso: 'register_news' },
            { name: 'Editar', permiso: 'edit_news' },
            { name: 'Eliminar', permiso: 'delete_news' },
        ]
    },
    {
        name: 'Cursos',
        permisos: [
            { name: 'Listado', permiso: 'list_course' },
            { name: 'Registrar', permiso: 'register_course' },
            { name: 'Editar', permiso: 'edit_course' },
            { name: 'Eliminar', permiso: 'delete_course' },
        ]
    },
    {
        name: 'Gestión de Menús', // <-- CORREGIDO A "_menu"
        permisos: [
            { name: 'Listado', permiso: 'list_menu' },
            { name: 'Registrar', permiso: 'register_menu' },
            { name: 'Editar', permiso: 'edit_menu' },
            { name: 'Eliminar', permiso: 'delete_menu' },
        ]
    },
    {
        name: 'Multimedia (Archivos)',
        permisos: [
            { name: 'Listado', permiso: 'list_media' },
            { name: 'Subir Archivos', permiso: 'register_media' },
            { name: 'Editar Metadata', permiso: 'edit_media' },
            { name: 'Eliminar', permiso: 'delete_media' },
        ]
    },
    // --- SISTEMA Y AJUSTES ---
    {
        name: 'Usuarios',
        permisos: [
            { name: 'Listado', permiso: 'list_user' },
            { name: 'Registrar', permiso: 'register_user' },
            { name: 'Editar', permiso: 'edit_user' },
            { name: 'Eliminar', permiso: 'delete_user' },
        ]
    },
    {
        name: 'Roles y Permisos',
        permisos: [
            { name: 'Listado', permiso: 'list_role' },
            { name: 'Registrar', permiso: 'register_role' },
            { name: 'Editar', permiso: 'edit_role' },
            { name: 'Eliminar', permiso: 'delete_role' },
        ]
    },
    {
        name: 'Manuales',
        permisos: [
            { name: 'Listado', permiso: 'list_manual' },
            { name: 'Registrar', permiso: 'register_manual' },
            { name: 'Editar', permiso: 'edit_manual' },
            { name: 'Eliminar', permiso: 'delete_manual' },
        ]
    },
    {
        name: 'Configuraciones',
        permisos: [
            { name: 'Listado', permiso: 'list_setting' },
            { name: 'Registrar', permiso: 'register_setting' },
            { name: 'Editar', permiso: 'edit_setting' },
            { name: 'Eliminar', permiso: 'delete_setting' },
        ]
    },
];