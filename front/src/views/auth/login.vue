<template>
  <AuthLayout>
    <b-col lg="4" class="mx-auto">
      <b-card no-body class="shadow-lg border-0">
        <b-card-body class="p-0 bg-black auth-header-box rounded-top">
          <div class="text-center p-3">
            <router-link to="/" class="logo logo-admin">
              <img :src="logoSm" height="50" alt="logo" class="auth-logo" />
            </router-link>
            <h4 class="mt-3 mb-1 fw-semibold text-white fs-18">
              Portal Administrativo
            </h4>
            <p class="text-muted fw-medium mb-0">
              Inicie sesión para gestionar el contenido de ESAN.
            </p>
          </div>
        </b-card-body>
        <b-card-body class="pt-0">
          <b-form class="my-4" @submit.prevent="handleLogin">
            <b-form-group class="mb-3" label="Usuario o Correo" label-for="username">
              <b-form-input
                type="text"
                placeholder="Ingrese su usuario o correo"
                id="username"
                v-model="credentials.username"
                class="py-2"
              />
              <div v-if="v.username.$error" class="text-danger small mt-1">
                <span v-for="(err, idx) in v.username.$errors" :key="idx">
                  El usuario es obligatorio (min. 3 caracteres)
                </span>
              </div>
            </b-form-group>

            <b-form-group
              class="mb-3"
              label="Contraseña"
              label-for="userpassword"
            >
              <b-form-input
                type="password"
                placeholder="Ingrese su contraseña"
                id="userpassword"
                v-model="credentials.password"
                class="py-2"
              />
              <div v-if="v.password.$error" class="text-danger small mt-1">
                <span v-for="(err, idx) in v.password.$errors" :key="idx">
                  La contraseña es obligatoria (min. 6 caracteres)
                </span>
              </div>
            </b-form-group>

            <div class="form-group row mt-3">
              <b-col sm="6">
                <div class="form-check form-switch-success">
                  <b-form-checkbox switch v-model="rememberMe">Recordarme</b-form-checkbox>
                </div>
              </b-col>
              <b-col sm="6" class="text-end">
                <router-link to="/auth/reset-pass" class="text-muted font-13">
                  <i class="las la-lock"></i> ¿Olvidó su contraseña?
                </router-link>
              </b-col>
            </div>

            <b-form-group class="mb-0 row">
              <b-col cols="12">
                <div class="d-grid mt-3">
                  <b-button variant="primary" type="submit" :disabled="isLoading" class="btn-lg">
                    <span v-if="!isLoading">
                      Ingresar <i class="fas fa-sign-in-alt ms-1"></i>
                    </span>
                    <span v-else class="spinner-border spinner-border-sm"></span>
                  </b-button>
                </div>
              </b-col>
            </b-form-group>
          </b-form>
          
          <div class="text-center mb-2">
            <p class="text-muted small">
              Si tiene problemas para acceder, contacte al soporte técnico de TI ESAN.
            </p>
          </div>
        </b-card-body>
      </b-card>
    </b-col>
  </AuthLayout>
</template>

<script setup lang="ts">
import { ref, reactive, computed } from "vue";
import logoSm from "@/assets/images/logo-sm.png"; // Asegúrate de que este sea el logo de ESAN
import { required, minLength } from "@vuelidate/validators";
import { useVuelidate } from "@vuelidate/core";
import AuthLayout from "@/layouts/AuthLayout.vue";
import HttpClient from "@/helpers/http-client";
import { useAuthStore } from "@/stores/auth";
import { useRoute } from "vue-router";
import type { AxiosResponse } from "axios";
import type { ResponseAuthLogin } from "@/types/auth";
import router from "@/router";
import Swal from 'sweetalert2';

const alerta = (title: string, text: string, icon: 'success' | 'error' | 'warning' | 'info' | 'question') => {
  return Swal.fire({ title, text, icon, confirmButtonColor: '#0f6eb6' });
};

const credentials = reactive({
  username: "",
  password: "",
});

const rememberMe = ref(false);
const isLoading = ref(false); 
const route = useRoute();
const useAuth = useAuthStore();
const query = route.query;

const vuelidateRules = computed(() => ({
  username: { required, minLength: minLength(3) },
  password: { required, minLength: minLength(6) },
}));

const v = useVuelidate(vuelidateRules, credentials);

const handleLogin = async () => {
  const result = await v.value.$validate();
  if (result) {
    isLoading.value = true;
    try {
      const payload = {
        email: credentials.username, 
        password: credentials.password
      };

      const res: AxiosResponse<ResponseAuthLogin> = await HttpClient.post(
        "auth/login",
        payload 
      );
      
      if (res.data.access_token) {
        useAuth.saveSession({
          ...res.data.user,
          token: res.data.access_token,
        });
        
        // Notificación de éxito antes de recargar
        /*Swal.fire({
          icon: 'success',
          title: 'Acceso Correcto',
          text: 'Bienvenido al sistema',
          showConfirmButton: false,
          timer: 1500
        });
        setTimeout(() => {
          window.location.reload();
        }, 1500);
        */
       
        setTimeout(() => {
             // Opción A: SPA (Rápido, sin recarga) - RECOMENDADO
             router.replace('/admin'); 
             
             // Opción B: Recarga forzada (Si tienes problemas de caché raros)
             // window.location.href = '/'; 
        }, 500);

      }
    } catch (e: any) {
       if (e.response?.data?.error) {
        alerta('Error de Autenticación', 'Credenciales incorrectas. Por favor, verifique sus datos.', 'error'); 
      } else {
        alerta('Error de Conexión', 'No se pudo conectar con el servidor. Intente más tarde.', 'error'); 
      }
    } finally {
      isLoading.value = false;
    }
  }
};
</script>
<!---<style lang="scss" scoped>
// --- 1. DEFINICIÓN DE VARIABLES ESAN ---
$esan-red: #e31140;
$esan-black: #000000;
$esan-dark-gray: #333333;
$esan-light-gray: #E6E7E8;
$esan-white: #FFFFFF;

// --- 2. HEADER DE LA TARJETA ---
.auth-header-box {
  // Usamos el Rojo ESAN para el impacto visual de la marca
  background-color: $esan-red !important; 
  // O usa $esan-black si prefieres sobriedad, pero el rojo destaca más la marca
  color: $esan-white;
}

// --- 3. BOTÓN PRINCIPAL (Log In) ---
// Sobrescribimos el 'btn-primary' de Bootstrap para usar el Rojo o Negro ESAN
:deep(.btn-primary) {
  background-color: $esan-black; // Negro para el botón (contraste elegante)
  border-color: $esan-black;
  transition: all 0.3s ease;

  &:hover, &:focus, &:active {
    background-color: $esan-red !important; // Al pasar el mouse, se vuelve Rojo ESAN
    border-color: $esan-red !important;
    box-shadow: 0 0 0 0.25rem rgba($esan-red, 0.25); // El brillo del foco en rojo tenue
  }

  &:disabled {
    background-color: $esan-light-gray;
    border-color: $esan-light-gray;
    color: $esan-dark-gray;
  }
}

// --- 4. INPUTS Y FORMULARIOS ---
:deep(.form-control) {
  border: 1px solid $esan-light-gray;
  color: $esan-dark-gray;

  &:focus {
    // Cuando el usuario escribe, el borde se pone Rojo ESAN en vez del azul de Bootstrap
    border-color: $esan-red;
    box-shadow: 0 0 0 0.2rem rgba($esan-red, 0.15);
  }
}

// --- 5. LINKS (Forgot password / Register) ---
.text-primary, :deep(a.text-primary) {
  color: $esan-red !important; // Links en rojo corporativo
  
  &:hover {
    color: darken($esan-red, 15%) !important;
    text-decoration: underline;
  }
}

// Texto muted un poco más oscuro para legibilidad
.text-muted {
  color: $esan-dark-gray !important; 
  opacity: 0.7;
}

// Checkbox switch (si lo usas)
:deep(.form-check-input:checked) {
  background-color: $esan-red;
  border-color: $esan-red;
}
</style>-->