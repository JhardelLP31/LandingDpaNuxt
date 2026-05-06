import { defineStore } from "pinia";
import router from "@/router";
import type { User, ResponseAuthLogin } from "@/types/auth";
import { ref, computed } from "vue";
import axios from "axios";

export const useAuthStore = defineStore("auth_store", () => {
  
  // --- ESTADO ---
  // Recuperamos el usuario del localStorage al iniciar
  const user = ref<User | null>(
    localStorage.getItem("user") ? JSON.parse(localStorage.getItem("user") || "") : null
  );

  // --- GETTERS ---
  
  /**
   * Obtiene el ID de la unidad académica actual.
   * Prioridad: 1. Usuario logueado, 2. LocalStorage, 3. Default (1)
   */
  const academicUnitId = computed(() => {
    // 1. Intentar desde el objeto usuario
    if (user.value?.academic_unit_id) {
      return Number(user.value.academic_unit_id);
    }

    // 2. Intentar desde LocalStorage directo
    const storedId = localStorage.getItem("academic_unit_id");
    if (storedId && storedId !== "undefined" && storedId !== "null") {
      return parseInt(storedId);
    }

    // 3. Fallback por defecto
    return 1;
  });

  const isAuthenticated = () => user.value != null;

  // --- ACCIONES ---

  /**
   * Guarda la sesión completa en el cliente
   */
  const saveSession = (newUser: User) => {
    // Guardar Token y Usuario
    localStorage.setItem("token", newUser.token || "");
    localStorage.setItem("user", JSON.stringify(newUser));
    
    // Guardar unidad académica por separado para acceso rápido si es necesario
    if (newUser.academic_unit_id) {
      localStorage.setItem("academic_unit_id", String(newUser.academic_unit_id));
    }

    user.value = newUser;

    // Configurar el header de axios inmediatamente
    axios.defaults.headers.common["Authorization"] = `Bearer ${newUser.token}`;
  };

  /**
   * Limpia la sesión y redirige al login
   */
  const removeSession = () => {
    user.value = null;
    localStorage.removeItem("token");
    localStorage.removeItem("user");
    localStorage.removeItem("academic_unit_id"); // Limpiamos también la unidad
    
    delete axios.defaults.headers.common["Authorization"];

    setTimeout(() => {
      router.push("/auth/sign-in");
    }, 25);
  };

  /**
   * Validación de permisos
   */
  const isPermitedRoute = (permission: string) => {
    const USER = user.value;
    if (USER && USER.role?.name !== "Super-Admin") {
      const permissions = USER.permissions;
      if (permissions?.includes(permission) || permission === "all") {
        return true;
      } else {
        return false;
      }
    }
    return true; // Super-Admin tiene acceso total
  };

  /**
   * Login mediante LDAP / API Laravel
   */
  const loginWithLDAP = async (credentials: { email: string; password: string }) => {
    try {
      const { data } = await axios.post<ResponseAuthLogin>("/api/auth/login", credentials);

      if (data.user && data.access_token) {
        // Unificamos el token dentro del objeto usuario para mantener tu estructura
        const userToSave: User = {
          ...data.user,
          token: data.access_token,
        };

        saveSession(userToSave);
        return true;
      }
      return false;
    } catch (error) {
      console.error("Error intentando conectar con LDAP/API:", error);
      throw error;
    }
  };

  return {
    // Estado y Getters
    user,
    academicUnitId,
    
    saveSession,
    removeSession,
    isAuthenticated,
    isPermitedRoute,
    loginWithLDAP,
  };
});