import { type RouteRecordRaw } from 'vue-router';

// Helper simple para títulos
const setTitle = (title: string) => {
  return title ? `${title} | ESAN` : "ESAN";
};

// =============================================================================
// 1. RUTAS DE AUTENTICACIÓN (Layout: 'auth')
// =============================================================================
const authRoutes: RouteRecordRaw[] = [
  {
    path: "/auth/sign-in",
    name: "auth.sign-in",
    meta: {
      title: setTitle("Sign In"),
      authLogin: true,
      layout: 'auth' 
    },
    component: () => import("@/views/auth/login.vue"),
  },
];

// =============================================================================
// 2. RUTAS PÚBLICAS (Layout: 'public' -> Header + Footer)
// =============================================================================
const publicRoutes: RouteRecordRaw[] = [
  // A. HOME (Raíz)
  {
    path: '/',
    name: 'public.home',
    component: () => import('@/views/public/PageView.vue'),
    props: { slug: 'inicio' },
    meta: { 
      requiresAuth: false, 
      title: setTitle("Inicio"),
      layout: 'public' // <--- Layout Web
    }
  },

  {
    path: '/simulacion',
    name: 'public.simulator',
    component: () => import('@/views/simulator/simulador.vue'),
    props: { slug: 'simulador' },
    meta: { 
      requiresAuth: false, 
      title: setTitle("Simulador de Secciones"),
      layout: 'public'
    }
  },
  {
    path: '/search',
    name: 'public.search',
    component: () => import('@/views/search/index.vue'),
    props: route => ({ query: route.query.q }),
    meta: { 
      requiresAuth: false, 
      title: setTitle("Resultados de búsqueda"),
      layout: 'public' 
    }
  },
  {
    path: '/course/:slug',
    name: 'public.category.detail',
    component: () => import('@/views/public/CategoryDetail.vue'),
    meta: { requiresAuth: false, layout: 'public' }
  },
  {
    path: '/course2/:slug',
    name: 'public.course2.detail',
    component: () => import('@/views/public/CourseDetail.vue'),
    meta: { requiresAuth: false, layout: 'public' }
  },
  {
    path: '/noticias/view-detail/:slug',
    name: 'public.noticias.detail',
    component: () => import('@/views/public/ArticleDetailView.vue'),
    meta: { requiresAuth: false, layout: 'public' }
  },
  {
    path: '/noticias/:slug',
    name: 'public.news.detail',
    component: () => import('@/views/public/NewsDetail.vue'),
    meta: { requiresAuth: false, layout: 'public' }
  },

  // C. CMS DINÁMICO (CATCH-ALL DE PÁGINAS)
  // Esta ruta atrapa cosas como "/nosotros", "/contacto", etc.
  {
    path: '/:slug',
    name: 'public.page',
    component: () => import('@/views/public/PageView.vue'),
    meta: { requiresAuth: false, layout: 'public' }
  },
];

// =============================================================================
// 3. RUTAS DE ADMIN / DASHBOARD (Layout: 'admin')
// =============================================================================
const dashboardRoutes: RouteRecordRaw[] = [
  {
    path: "/admin",
    name: "dashboards.analytics",
    meta: {
      title: setTitle("Analytics"),
      authRequired: true,
      permission: 'all',
      layout: 'admin' // <--- Layout Sistema
    },
    component: () => import("@/views/dashboards/fe/index.vue"),
  },
  {
    path: "/admin/ecommerce",
    name: "dashboards.ecommerce",
    meta: {
      title: setTitle("Ecommerce"),
      authRequired: true,
      permission: 'all',
      layout: 'admin'
    },
    component: () => import("@/views/dashboards/ecommerce/index.vue"),
  },
];

const accessRoutes: RouteRecordRaw[] = [
  {
    path: "/roles-permisos",
    name: "access.roles",
    meta: {
      title: setTitle("Roles y Permisos"),
      authRequired: true,
      permission: 'list_role',
      layout: 'admin'
    },
    component: () => import("@/views/roles/index.vue"),
  },
  {
    path: "/usuarios",
    name: "access.users",
    meta: {
      title: setTitle("Usuarios"),
      authRequired: true,
      permission: 'list_user',
      layout: 'admin'
    },
    component: () => import("@/views/users/index.vue"),
  },
];

const comercialRoutes: RouteRecordRaw[] = [
  // ==========================================
  // 1. ACADEMIC & INSTITUTIONAL
  // ==========================================
  {
    path: "/academic-units",
    name: "comercial.academic_units",
    meta: {
      title: setTitle("Unidades Académicas"),
      authRequired: true,
      permission: 'list_academic_unit', // Valida tu permiso exacto
      layout: 'admin'
    },
    component: () => import("@/views/AcademicUnits/index.vue"),
  },
  {
    path: "/study-programs",
    name: "comercial.study_programs",
    meta: {
      title: setTitle("Programas de Estudio"),
      authRequired: true,
      permission: 'list_study_program',
      layout: 'admin'
    },
    component: () => import("@/views/StudyPrograms/index.vue"),
  },

  // ==========================================
  // 2. MARKETING & SALES
  // ==========================================
  {
    path: "/categories",
    name: "comercial.categories",
    meta: {
      title: setTitle("Categorías"),
      authRequired: true,
      permission: 'list_category',
      layout: 'admin'
    },
    // ¡Ojo aquí! Corregí la ruta para que no apunte a campañas
    component: () => import("@/views/categories/index.vue"), 
  },
  {
    path: "/marketing-campaigns",
    name: "comercial.campaigns",
    meta: {
      title: setTitle("Campañas de Marketing"),
      authRequired: true,
      permission: 'list_campaign',
      layout: 'admin'
    },
    component: () => import("@/views/MarketingCampaigns/index.vue"),
  },
  {
    path: "/leads",
    name: "comercial.leads",
    meta: {
      title: setTitle("Leads"),
      authRequired: true,
      permission: 'list_lead',
      layout: 'admin'
    },
    component: () => import("@/views/leads/index.vue"),
  },

  // ==========================================
  // 3. CMS / CONTENT MANAGEMENT
  // ==========================================
  {
    path: "/pages",
    name: "comercial.pages",
    meta: {
      title: setTitle("Páginas"),
      authRequired: true,
      permission: 'list_post',
      layout: 'admin'
    },
    component: () => import("@/views/page/index.vue"),
  },
{
    path: '/pages-editor/:id', 
    name: "comercial.pageseditor",
    meta: {
      title: setTitle("Editor de Páginas"),
      authRequired: true,
      permission: 'edit_post',
      layout: 'editor'
    },
    component: () => import('@/views/page/editor/PageEditor.vue'),
  },
  {
    path: "/news",
    name: "comercial.news",
    meta: {
      title: setTitle("Noticias y Eventos"),
      authRequired: true,
      permission: 'list_post',
      layout: 'admin'
    },
    component: () => import("@/views/news/index.vue"),
  },
{
  path: '/news-editor/:id', // <-- ¡Cambiado aquí!
  name: "comercial.newseditor",
  meta: {
    title: setTitle("Editor de Noticias y Eventos"),
    authRequired: true,
    permission: 'edit_post',
    layout: 'editor'
  },
  component: () => import('@/views/news/editor/NewsEditor.vue'),
},
  {
    path: "/courses", // Le quité el "2" al path para que sea más limpio (courses2 -> courses)
    name: "comercial.courses2",
    meta: {
      title: setTitle("Cursos"),
      authRequired: true,
      permission: 'list_course',
      layout: 'admin'
    },
    component: () => import("@/views/course2/index.vue"),
  },
  {
    path: '/courses-editor/:slug',
    name: "comercial.courseeditor2",
    meta: {
      title: setTitle("Editor de Curso"),
      authRequired: true,
      permission: 'edit_course',
      layout: 'editor'
    },
    component: () => import('@/views/course2/editor/PageEditor.vue'),
  },
  {
    path: "/menus",
    name: "comercial.menus",
    meta: {
      title: setTitle("Menús"),
      authRequired: true,
      permission: 'list_menu_item',
      layout: 'admin'
    },
    component: () => import("@/views/menu/index.vue"),
  },
  {
    path: "/media-manager",
    name: "comercial.media_manager",
    meta: {
      title: setTitle("Gestor de Archivos"),
      authRequired: true,
      permission: 'list_media',
      layout: 'admin'
    },
    component: () => import("@/views/MediaManager/index.vue"),
  },

  // ==========================================
  // 4. SETTINGS & OTHERS
  // ==========================================
  {
    path: "/manuals", // manual -> manuals
    name: "comercial.manual",
    meta: {
      title: setTitle("Manuales"),
      authRequired: true,
      permission: 'list_manual',
      layout: 'admin'
    },
    component: () => import("@/views/manual/index.vue"),
  },
  {
    path: "/settings", // configuraciones -> settings
    name: "access.settings", 
    meta: {
      title: setTitle("Configuraciones"),
      authRequired: true,
      permission: 'all',
      layout: 'editor'
    },
    component: () => import("@/views/UnitBranding/index.vue"),
  },
];

// =============================================================================
// 4. RUTAS DE ERROR (Layout: 'auth' o 'empty')
// =============================================================================
const errorRoutes: RouteRecordRaw[] = [
  {
    path: "/auth/error-404",
    name: "error.404",
    meta: {
      title: setTitle("Error 404"),
      layout: 'auth'
    },
    component: () => import("@/views/auth/error-404.vue"),
  },
  {
    path: "/auth/error-500",
    name: "error.500",
    meta: {
      title: setTitle("Error 500"),
      layout: 'auth'
    },
    component: () => import("@/views/auth/error-500.vue"),
  },
  // Catch All (Debe ser SIEMPRE la última de todas)
  {
    path: "/:catchAll(.*)",
    redirect: "/auth/error-404",
  },
];

// =============================================================================
// EXPORTACIÓN FINAL
// El orden aquí es CRÍTICO para que Vue Router sepa qué matchear primero.
// =============================================================================
export const allRoute = [
  ...authRoutes,
  ...dashboardRoutes, // Admin primero (rutas fijas)
  ...accessRoutes,    // Admin primero
  ...comercialRoutes, // Admin primero

  ...publicRoutes,    // Públicas al final (porque contiene /:slug genérico)
  ...errorRoutes,     // Errores al final absoluto (catch all)
];