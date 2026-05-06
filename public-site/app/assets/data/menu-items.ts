import type { MenuItemType } from "@/types/menu";

export const MENU_ITEMS: MenuItemType[] = [
  {
    key: "main",
    label: "Main Menu",
    isTitle: true,
  },
  {
    key: "dashboards",
    icon: "iconoir-home-simple",
    label: "Dashboards",
    route: { name: "dashboards.analytics" },
    parentKey: "dashboards",
    permission: "all",
  },
  
  // ----------------------------------------------------------------------
  // SECCIÓN ACCESOS
  // ----------------------------------------------------------------------
  {
    key: "Accesos",
    label: "ACCESS",
    isTitle: true,
    permissions: ['list_role','list_user']
  },
  {
    key: "roles",
    icon: "fas fa-unlock",
    label: "Roles y Permisos",
    route: { name: "access.roles" },
    parentKey: "roles",
    permission: 'list_role',
  },
  {
    key: "usuarios",
    icon: "fas fa-users",
    label: "Usuarios",
    route: { name: "access.users" },
    parentKey: "usuarios",
    permission: 'list_user',
  },

  // ----------------------------------------------------------------------
  // SECCIÓN CMS (Antes Comercial)
  // ----------------------------------------------------------------------
  {
    key: "Cms",
    label: "GESTIÓN DE CONTENIDO", // Le cambié el nombre para que tenga sentido
    isTitle: true,
    // Este array es vital: Si el usuario NO tiene ninguno de estos, se oculta el título
    permissions: [
        'list_category', 
        'list_post', 
        'list_menu_item', 
        'list_course',
        'list_news', 
        'list_lead'
    ]
  },
  {
    key: "categories",
    icon: "fas fa-tags", // Cambié icono para diferenciar
    label: "Categorias",
    route: { name: "comercial.categories" },
    parentKey: "categories",
    permission: 'list_category', // O 'list_categorie' si así está en tu BD
  },
{
    key: "manual", // Key única para evitar conflictos
    icon: "las la-folder-open", // Icono de carpeta, más común para organizar documentos/manuales
    label: "Manuales",
    route: { name: "comercial.manual"}, // Pasamos el query para filtrar directamente
    parentKey: "manual", // Si lo vas a agrupar bajo un menú superior de Manuales
    permission: 'list_category', 
},
  {
    key: "pages",
    icon: "fas fa-file-invoice", // Representa una página de estructura o contenido fijo
    label: "Paginas",
    route: { name: "comercial.pages" },
    parentKey: "pages",
    permission: 'list_post',
  },
  {
    key: "news",
    icon: "fas fa-newspaper", // El icono estándar universal para noticias/eventos
    label: "Noticias y Eventos",
    route: { name: "comercial.news" },
    parentKey: "news",
    permission: 'list_news', 
  },
  {
    key: "menus",
    icon: "fas fa-compass", // Cambié icono
    label: "Menus",
    route: { name: "comercial.menus" },
    parentKey: "menus",
    permission: 'list_menu_item', // <--- Corregido para coincidir con MenuPolicy
  },
  /*{
    key: "courses",
    icon: "fas fa-graduation-cap", // Icono de cursos
    label: "Cursos",
    route: { name: "comercial.courses" },
    parentKey: "courses",
    permission: 'list_course', // <--- Corregido para coincidir con CoursePolicy
  },*/
  {
    key: "courses2",
    icon: "fas fa-chalkboard-teacher",
    label: "Cursos",
    route: { name: "comercial.courses2" },
    parentKey: "courses2",
    permission: 'list_course', // Mismo permiso que cursos normales
  },
  {
    key: "leads",
    icon: "fas fa-bullhorn", // O 'fas fa-funnel-dollar' si es más de ventas
    label: "Leads",
    route: { name: "comercial.leads" },
    parentKey: "comercial", // Asumo que "categories" también pertenece a este grupo padre
    permission: 'list_lead', // Estandarizado en singular como 'list_category'
},
  // ----------------------------------------------------------------------
  // CONFIGURACIONES (Siempre útil dejarlo al final)
  // ----------------------------------------------------------------------
  /*{
    key: "configurat",
    icon: "fas fa-wrench",
    label: "Configuraciones",
    route: { name: "access.configuraciones" },
    parentKey: "configurat",
    permission: "all" // O 'super-admin'
  },*/

  // {
    //   key: "page-authentication",
    //   label: "Authentication",
    //   isTitle: false,
    //   icon: "iconoir-fingerprint-lock-circle",
    //   children: [
    //     {
    //       key: "login",
    //       label: "Log In",
    //       route: { name: "auth.sign-in" },
    //       parentKey: "page-authentication",
    //     },
    //     {
    //       key: "register",
    //       label: "Register",
    //       route: { name: "auth.register" },
    //       parentKey: "page-authentication",
    //     },
    //     {
    //       key: "reset-pass",
    //       label: "Re-Password",
    //       route: { name: "auth.reset-pass" },
    //       parentKey: "page-authentication",
    //     },
    //     {
    //       key: "lock-screen",
    //       label: "Lock Screen",
    //       route: { name: "auth.lock-screen" },
    //       parentKey: "page-authentication",
    //     },
    //     {
    //       key: "maintenance",
    //       label: "Maintenance",
    //       route: { name: "auth.maintenance" },
    //       target: "_blank",
    //       parentKey: "page-authentication",
    //     },
    //     {
    //       key: "error-404",
    //       label: "Error 404",
    //       route: { name: "error.404" },
    //       parentKey: "page-authentication",
    //     },
    //     {
    //       key: "error-500",
    //       label: "Error 500",
    //       route: { name: "error.500" },
    //       parentKey: "page-authentication",
    //     },
    //   ],
  // },
];
