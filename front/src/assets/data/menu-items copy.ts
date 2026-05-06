import type { MenuItemType } from "@/types/menu";

export const MENU_ITEMS: MenuItemType[] = [
  {
    key: "main",
    label: "Main Menu",
    isTitle: true,
  },
  // {
  //   key: "dashboards",
  //   icon: "iconoir-home-simple",
  //   label: "Dashboards",
  //   children: [
  //     {
  //       key: "dashboard-analytics",
  //       label: "Analytics",
  //       route: { name: "dashboards.analytics" },
  //       parentKey: "dashboards",
  //     },
  //     {
  //       key: "dashboard-ecommerce",
  //       label: "Ecommerce",
  //       route: { name: "dashboards.ecommerce" },
  //       parentKey: "dashboards",
  //     },
  //   ],
  // },
  {
    key: "dashboards",
    icon: "iconoir-home-simple",
    label: "Dashboards",
    route: { name: "dashboards.analytics" },
    parentKey: "dashboards",
    permission: "all",
  },
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
  {
    key: "Comercial",
    label: "COMERCIAL",
    isTitle: true,
    permissions: ['list_categorie','list_product','register_product','list_client','register_sale','list_sale',
      'register_guia_remision','list_guia_remision'
    ]
  },
  {
    key: "categories",
    icon: "fas fa-life-ring",
    label: "Categorias",
    route: { name: "comercial.categories" },
    parentKey: "categories",
    permission: 'list_categorie',
  },
  {
    key: "pages",
    icon: "fas fa-file-alt",
    label: "Paginas",
    route: { name: "comercial.pages" },
    parentKey: "pages",
    permission: 'list_categorie',
  },
    {
    key: "menus",
    icon: "fas fa-life-ring",
    label: "Menus",
    route: { name: "comercial.menus" },
    parentKey: "menus",
    permission: 'list_categorie',
  },
  /*{
    key: "courses",
    icon: "fas fa-life-ring",
    label: "Cursos",
    route: { name: "comercial.courses" },
    parentKey: "courses",
    permission: 'list_categorie',
  },*/
    {
    key: "courses2",
    icon: "fas fa-file-alt",
    label: "Cursos",
    route: { name: "comercial.courses2" },
    parentKey: "courses2",
    permission: 'list_categorie',
  },/*
  {
    key: "products",
    label: "Productos",
    isTitle: false,
    icon: "fas fa-qrcode",
    children: [
      {
        key: "register_product",
        label: "Registrar",
        route: { name: "product.register" },
        parentKey: "products",
        permission: 'register_product',
      },
      {
        key: "list_products",
        label: "Listar",
        route: { name: "product.index" },
        parentKey: "products",
        permission: 'list_product',
      },
    ],
  },
  {
    key: "clients",
    icon: "fas fa-user-plus",
    label: "Clientes",
    route: { name: "comercial.clients" },
    parentKey: "clients",
    permission: 'list_client',
  },
  {
    key: "sales",
    label: "Ventas",
    isTitle: false,
    icon: "fas fa-money-check-alt",
    children: [
      {
        key: "register_sale",
        label: "Registrar",
        route: { name: "comercial.sales.register" },
        parentKey: "sales",
        permission: 'register_sale',
      },
      {
        key: "list_sales",
        label: "Listar",
        route: { name: "comercial.sales" },
        parentKey: "sales",
        permission: 'list_sale',
      },
    ],
  },
  {
    key: "guias",
    label: "Guia de Remisión",
    isTitle: false,
    icon: "fas fa-file-alt",
    children: [
      {
        key: "register_guia",
        label: "Registrar",
        route: { name: "comercial.guias.register" },
        parentKey: "guias",
        permission: 'register_guia_remision',
      },
      {
        key: "list_guia",
        label: "Listar",
        route: { name: "comercial.guias" },
        parentKey: "guias",
        permission: 'list_guia_remision',
      },
    ],
  },
  {
    key: "configurat",
    icon: "fas fa-wrench",
    label: "Configuraciones",
    route: { name: "access.configuraciones" },
    parentKey: "configurat",
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
