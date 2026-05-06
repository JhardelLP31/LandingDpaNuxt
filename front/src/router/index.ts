import { createRouter, createWebHistory } from "vue-router";
import { allRoute } from "@/router/routes";
import { useAuthStore } from "@/stores/auth";

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: allRoute,
  scrollBehavior(to, from, savedPosition) {
    return { top: 0 };
  },
});

router.beforeEach((to, from, next) => {
  const title = to.meta.title;
  if (title) {
    document.title = title.toString();
  }

  const useAuth = useAuthStore();

  const isAuthPage = to.matched.some((route) => route.meta.authLogin);
  if (isAuthPage && useAuth.isAuthenticated()) {
    return next({ name: "dashboards.analytics" });
  }

  const authRequired = to.matched.some((route) => route.meta.authRequired);

  if (!authRequired) {
    return next();
  }

  // 5. SI REQUIERE AUTH
  if (useAuth.isAuthenticated()) {
    const requiredPermission = to.meta.permission;
    
    if (!requiredPermission || useAuth.isPermitedRoute(String(requiredPermission))) {
      return next();
    } else {
      return next({ name: "error.500" }); 
    }
  }

  return next({ 
    name: "auth.sign-in", 
    query: { redirectedFrom: to.fullPath } 
  });
});

export default router;