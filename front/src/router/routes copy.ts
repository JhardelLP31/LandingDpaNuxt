const setTitle = (title: string) => {
  return title
    ? `${title} | ESAN`
    : "ESAN";
};

const authRoutes = [
  {
    path: "/auth/sign-in",
    name: "auth.sign-in",
    meta: {
      title: setTitle("Sign In"),
      authLogin:true,
    },
    component: () => import("@/views/auth/login.vue"),
  },
  
  // {
    //   path: "/auth/register",
    //   name: "auth.register",
    //   meta: {
    //     title: setTitle("Register"),
    //   },
    //   component: () => import("@/views/auth/register.vue"),
    // },
    // {
    //   path: "/auth/reset-pass",
    //   name: "auth.reset-pass",
    //   meta: {
    //     title: setTitle("Reset Password"),
    //   },
    //   component: () => import("@/views/auth/reset-pass.vue"),
    // },
    // {
    //   path: "/auth/lock-screen",
    //   name: "auth.lock-screen",
    //   meta: {
    //     title: setTitle("Lock Screen"),
    //   },
    //   component: () => import("@/views/auth/lock-screen.vue"),
    // },
    // {
    //   path: "/auth/maintenance",
    //   name: "auth.maintenance",
    //   meta: {
    //     title: setTitle("Maintenance"),
    //   },
    //   component: () => import("@/views/auth/maintenance.vue"),
  // },
];
const publicRoutes = [
 /*{
    path: '/cursos',
    name: 'public.courses.index',
    component: () => import('@/views/public/CoursesIndex.vue'),
    meta: { requiresAuth: false }
  },*/

  // 2. DETALLE DE CURSO (Usa el componente NUEVO con precio y botón)
  { 
    path: '/categoria/:slug', 
    name: 'public.category.detail',
    // Asegúrate de que la ruta apunte al archivo que creamos en el paso anterior
    component: () => import('@/views/public/CategoryDetail.vue'), 
    meta: { requiresAuth: false } 
  },
  { 
    path: '/cursos/:slug', 
    name: 'public.course.detail',
    component: () => import('@/views/public/CourseDetail.vue'), // <--- AQUÍ EL CAMBIO
    meta: { requiresAuth: false } 
  },
    { 
    path: '/cursos/:slug', 
    name: 'public.course.detail',
    component: () => import('@/views/public/CourseDetail.vue'), // <--- AQUÍ EL CAMBIO
    meta: { requiresAuth: false } 
  },
  // 3. PÁGINA GENÉRICA (Usa el componente VIEJO para "Nosotros", "Contacto")
  {
    path: '/:slug',
    name: 'public.page',
    component: () => import('@/views/public/PageView.vue'),
    meta: { requiresAuth: false } 
  }
];
const errorRoutes = [
  {
    path: "/auth/error-404",
    name: "error.404",
    meta: {
      title: setTitle("Error 404"),
    },
    component: () => import("@/views/auth/error-404.vue"),
  },
  {
    path: "/auth/error-500",
    name: "error.500",
    meta: {
      title: setTitle("Error 500"),
    },
    component: () => import("@/views/auth/error-500.vue"),
  },
  {
    path: "/:catchAll(.*)",
    redirect: "/auth/error-404",
  },
];

const dashboardRoutes = [
  // {
  //   path: "/",
  //   name: "dashboards.analytics",
  //   meta: {
  //     title: setTitle("Analytics"),
  //     authRequired: true,
  //     permission: 'all',
  //   },
  //   component: () => import("@/views/dashboards/analytics/index.vue"),
  // },
  {
    path: "/",
    name: "dashboards.analytics",
    meta: {
      title: setTitle("Analytics"),
      authRequired: true,
      permission: 'all',
    },
    component: () => import("@/views/dashboards/fe/index.vue"),
  },
  {
    path: "/dashboards/ecommerce",
    name: "dashboards.ecommerce",
    meta: {
      title: setTitle("Ecommerce"),
      authRequired: true,
      permission: 'all',
    },
    component: () => import("@/views/dashboards/ecommerce/index.vue"),
  },
];

const accessRoutes = [
  {
    path: "/roles-permisos",
    name: "access.roles",
    meta: {
      title: setTitle("Roles y Permisos"),
      authRequired: true,
      permission: 'list_role',
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
    },
    component: () => import("@/views/users/index.vue"),
  },
]

const comercialRoutes = [
  // ---------------------------------------------------------------
  // CATEGORÍAS
  // ---------------------------------------------------------------
  {
      path: "/categorias",
      name: "comercial.categories",
      meta: {
        title: setTitle("Categorias"),
        authRequired: true,
        permission: 'list_category', // Asegúrate que en BD sea 'category'
      },
      component: () => import("@/views/categories/index.vue"),
  },

  // ---------------------------------------------------------------
  // PÁGINAS (CMS) - Usa permisos '_post'
  // ---------------------------------------------------------------
  {
      path: "/pages",
      name: "comercial.pages",
      meta: {
        title: setTitle("Paginas"),
        authRequired: true,
        permission: 'list_post', // Coincide con PostPolicy
      },
      component: () => import("@/views/page/index.vue"),
  },
  {
      path: '/pages-editor/:slug',
      name: "comercial.pageseditor",
      meta: {
        title: setTitle("Editor de Paginas"),
        authRequired: true,
        permission: 'edit_post', // Permiso de edición
      },
    component: () => import('@/views/page/editor/PageEditor.vue'), 
  },

  // ---------------------------------------------------------------
  // CURSOS (Estándar) - Usa permisos '_course'
  // ---------------------------------------------------------------
  /*{
      path: "/courses",
      name: "comercial.courses",
      meta: {
        title: setTitle("Cursos"),
        authRequired: true,
        permission: 'list_course', // Coincide con CoursePolicy
      },
      component: () => import("@/views/course/index.vue"),
  },
  {
      path: '/courses-editor/:slug',
      name: "comercial.courseeditor",
      meta: {
        title: setTitle("Editor de Curso"),
        authRequired: true,
        permission: 'edit_course',
      },
    component: () => import('@/views/course/editor/PageEditor.vue'), 
  },*/

  // ---------------------------------------------------------------
  // CURSOS 2 (Solicitado explícitamente)
  // ---------------------------------------------------------------
  {
      path: "/courses2",
      name: "comercial.courses2",
      meta: {
        title: setTitle("Cursos"),
        authRequired: true,
        permission: 'list_course', // Usamos el mismo permiso que cursos normales
      },
      component: () => import("@/views/course2/index.vue"),
  },
  {
      path: '/courses-editor2/:slug',
      name: "comercial.courseeditor2",
      meta: {
        title: setTitle("Editor de Curso 2"),
        authRequired: true,
        permission: 'edit_course',
      },
    component: () => import('@/views/course2/editor/PageEditor.vue'), 
  },

  // ---------------------------------------------------------------
  // MENÚS - Usa permisos '_menu_item'
  // ---------------------------------------------------------------
      {
      path: "/menus",
      name: "comercial.menus",
      meta: {
        title: setTitle("Menus"),
        authRequired: true,
        permission: 'list_menu_item', // Coincide con MenuPolicy
      },
      component: () => import("@/views/menu/index.vue"),
  },
  {
    path: "/leads",
    name: "comercial.leads",
    meta: {
        title: setTitle("Leads"), // Usando tu helper setTitle
        authRequired: true,
        permission: 'list_lead',
    },
    // Importación dinámica (Lazy Loading) para optimizar el bundle
    component: () => import("@/views/leads/index.vue"), 
},

  // ---------------------------------------------------------------
  // CONFIGURACIONES (Siempre útil dejarlo)
  // ---------------------------------------------------------------
  {
    path: "/configuraciones",
    name: "access.configuraciones",
    meta: {
      title: setTitle("Configuraciones"),
      authRequired: true,
      permission: 'all', // O el permiso 'super-admin'
    },
    component: () => import("@/views/configurations/index.vue"),
  },
]

export const allRoute = [
  ...authRoutes,
  ...dashboardRoutes,
  ...accessRoutes,
  ...publicRoutes,
  ...comercialRoutes,
  
  ...errorRoutes,
];
