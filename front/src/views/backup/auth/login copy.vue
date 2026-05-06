<template>
  <AuthLayout>
    <b-col lg="4" class="mx-auto">
      <b-card no-body>
        <b-card-body class="p-0 bg-black auth-header-box rounded-top">
          <div class="text-center p-3">
            <router-link to="/" class="logo logo-admin">
              <img :src="logoSm" height="50" alt="logo" class="auth-logo" />
            </router-link>
            <h4 class="mt-3 mb-1 fw-semibold text-white fs-18">
              Let's Get Started Rizz
            </h4>
            <p class="text-muted fw-medium mb-0">
              Sign in to continue to Rizz.
            </p>
          </div>
        </b-card-body>
        <b-card-body class="pt-0">
          <b-form class="my-4" @submit.prevent="handleLogin">
            <b-form-group class="mb-2" label="Username or Email" label-for="username">
              <b-form-input
                type="text"
                placeholder="Enter username or email"
                id="username"
                v-model="credentials.username"
              />
              <div v-if="v.username.$error" class="text-danger">
                <span v-for="(err, idx) in v.username.$errors" :key="idx">
                  {{ err.$message }}
                </span>
              </div>
            </b-form-group>

            <b-form-group
              class="mb-2"
              label="Password"
              label-for="userpassword"
            >
              <b-form-input
                type="password"
                placeholder="Enter password"
                id="userpassword"
                v-model="credentials.password"
              />
              <div v-if="v.password.$errors" class="text-danger">
                <span v-for="(err, idx) in v.password.$errors" :key="idx">
                  {{ err.$message }}
                </span>
              </div>
            </b-form-group>

            <div class="form-group row mt-3">
              <b-col sm="6">
                <div class="form-switch-success">
                  <b-form-checkbox switch>Remember me</b-form-checkbox>
                </div>
              </b-col>
              <b-col sm="6" class="text-end">
                <router-link to="/auth/reset-pass" class="text-muted font-13"
                  ><i class="dripicons-lock"></i> Forgot password?</router-link
                >
              </b-col>
            </div>

            <b-form-group class="mb-0 row">
              <b-col cols="12">
                <div class="d-grid mt-3">
                  <b-button variant="primary" type="submit">
                    Log In <i class="fas fa-sign-in-alt ms-1"></i>
                  </b-button>
                </div>
              </b-col>
            </b-form-group>
          </b-form>
          <div class="text-center mb-2">
            <p class="text-muted">
              Don't have an account?
              <router-link to="/auth/register" class="text-primary ms-2">
                Free Register
              </router-link>
            </p>
            <h6 class="px-3 d-inline-block">Or Login With</h6>
          </div>
          <div class="d-flex justify-content-center">
            <!-- Social Login Icons (Facebook, Twitter, Google) -->
          </div>
        </b-card-body>
      </b-card>
    </b-col>
  </AuthLayout>
</template>


<script setup lang="ts">
import { ref, reactive, computed } from "vue";
import logoSm from "@/assets/images/logo-sm.png";
import { required, minLength } from "@vuelidate/validators";
import { useVuelidate } from "@vuelidate/core";
import AuthLayout from "@/layouts/AuthLayout.vue";
import HttpClient from "@/helpers/http-client";
import { useAuthStore } from "@/stores/auth";
import { useRoute } from "vue-router";
import type { AxiosResponse } from "axios";
import type { ResponseAuthLogin } from "@/types/auth";
import router from "@/router";


// Variables reactivas
const credentials = reactive({
  username: "jpumahuillca", // Visualmente es username, pero al backend se enviará como email
  password: "",
});

const isLoading = ref(false); // <--- NUEVO: Estado de carga
const error = ref("");
const route = useRoute();
const useAuth = useAuthStore();
const query = route.query;

// Validaciones (Se mantienen igual)
const vuelidateRules = computed(() => ({
  username: { required, minLength: minLength(3) },
  password: { required, minLength: minLength(6) },
}));

const v = useVuelidate(vuelidateRules, credentials);

const handleLogin = async () => {
  const result = await v.value.$validate();
  if (result) {
    try {
      const res: AxiosResponse<ResponseAuthLogin> = await HttpClient.post(
        "auth/login",
        credentials,
      );
      if (res.data.access_token) {
        useAuth.saveSession({
          ...res.data.user,
          token: res.data.access_token,
        });
        setTimeout(() => {
          // redirectUser();
          window.location.reload();
        }, 50);
      }
    } catch (e: any) {
      console.log(e);
      if (e.response?.data?.error) {
        if (error.value.length == 0) error.value = e.response?.data?.error;
      }
    }
  }
};
const redirectUser = () => {
  if (query.redirectedFrom) {
    return router.push(`${query.redirectedFrom}`);
  }
  return router.push("/");
};
</script>