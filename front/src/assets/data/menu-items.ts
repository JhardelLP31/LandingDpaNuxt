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
    permission: "dashboard", // <-- OPCIONAL: Si quieres que dependa del permiso que creaste llamado 'dashboard'
  },

  // ----------------------------------------------------------------------
  // 1. SECCIÓN: GESTIÓN ACADÉMICA
  // ----------------------------------------------------------------------
  {
    key: "Academico",
    label: "GESTIÓN ACADÉMICA",
    isTitle: true,
    permissions: ['list_academic_unit', 'list_study_program']
  },
  {
    key: "academic_units",
    icon: "fas fa-university",
    label: "Unidades Académicas",
    route: { name: "comercial.academic_units" },
    parentKey: "academic",
    permission: 'list_academic_unit',
  },
  {
    key: "study_programs",
    icon: "fas fa-book-reader",
    label: "Programas de Estudio",
    route: { name: "comercial.study_programs" },
    parentKey: "academic",
    permission: 'list_study_program',
  },

  // ----------------------------------------------------------------------
  // 2. SECCIÓN: MARKETING Y COMERCIAL
  // ----------------------------------------------------------------------
  {
    key: "Comercial",
    label: "MARKETING Y VENTAS",
    isTitle: true,
    permissions: ['list_campaign', 'list_lead', 'list_category']
  },
  {
    key: "campaigns",
    icon: "fas fa-bullseye",
    label: "Campañas",
    route: { name: "comercial.campaigns" },
    parentKey: "comercial",
    permission: 'list_campaign',
  },
  {
    key: "leads",
    icon: "fas fa-funnel-dollar",
    label: "Leads",
    route: { name: "comercial.leads" },
    parentKey: "comercial",
    permission: 'list_lead',
  },
  {
    key: "categories",
    icon: "fas fa-tags",
    label: "Categorías",
    route: { name: "comercial.categories" },
    parentKey: "comercial",
    permission: 'list_category',
  },

  // ----------------------------------------------------------------------
  // 3. SECCIÓN: CMS (GESTIÓN DE CONTENIDO)
  // ----------------------------------------------------------------------
  {
    key: "Cms",
    label: "GESTIÓN DE CONTENIDO",
    isTitle: true,
    permissions: [
      'list_page',   // <-- CORREGIDO (Antes decía list_post)
      'list_menu',   // <-- CORREGIDO (Antes decía list_menu_item)
      'list_course',
      'list_news',
      'list_media'
    ]
  },
  {
    key: "pages",
    icon: "fas fa-file-invoice",
    label: "Páginas",
    route: { name: "comercial.pages" },
    parentKey: "cms",
    permission: 'list_page', // <-- CORREGIDO: Ahora usa el permiso real de páginas
  },
  {
    key: "news",
    icon: "fas fa-newspaper",
    label: "Noticias y Eventos",
    route: { name: "comercial.news" },
    parentKey: "cms",
    permission: 'list_news',
  },
  {
    key: "courses2",
    icon: "fas fa-chalkboard-teacher",
    label: "Cursos",
    route: { name: "comercial.courses2" },
    parentKey: "cms",
    permission: 'list_course',
  },
  {
    key: "menus",
    icon: "fas fa-compass",
    label: "Menús",
    route: { name: "comercial.menus" },
    parentKey: "cms",
    permission: 'list_menu', // <-- CORREGIDO: Para entrar a esta vista, la validación principal es sobre el menú contenedor
  },
  {
    key: "media",
    icon: "fas fa-images",
    label: "Gestor de Archivos",
    route: { name: "comercial.media_manager" },
    parentKey: "cms",
    permission: 'list_media',
  },

  // ----------------------------------------------------------------------
  // 4. SECCIÓN: ACCESOS Y CONFIGURACIÓN
  // ----------------------------------------------------------------------
  {
    key: "Accesos",
    label: "SISTEMA Y ACCESOS",
    isTitle: true,
    permissions: ['list_role', 'list_user', 'list_manual', 'list_setting'] // <-- AÑADIDO list_setting
  },
  {
    key: "roles",
    icon: "fas fa-unlock",
    label: "Roles y Permisos",
    route: { name: "access.roles" },
    parentKey: "sistema",
    permission: 'list_role',
  },
  {
    key: "usuarios",
    icon: "fas fa-users",
    label: "Usuarios",
    route: { name: "access.users" },
    parentKey: "sistema",
    permission: 'list_user',
  },
  {
    key: "manual",
    icon: "las la-folder-open",
    label: "Manuales",
    route: { name: "comercial.manual" },
    parentKey: "sistema",
    permission: 'list_manual',
  },
  {
    key: "settings",
    icon: "fas fa-cogs",
    label: "Configuraciones",
    route: { name: "access.settings" },
    parentKey: "sistema",
    permission: 'list_setting',
  },
];

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
