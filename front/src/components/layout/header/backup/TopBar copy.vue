<template>
  <div class="top-bar py-1">
    <div class="container d-flex flex-column flex-md-row justify-content-between align-items-center gap-3">
      
      <div class="logo-wrapper">
        <img src="@/assets/images/LogoSolitario.png" alt="ESAN" class="img-fluid main-logo" />
      </div>

      <div class="d-flex flex-column flex-md-row align-items-center gap-3 w-100 justify-content-center px-md-5">
        <div class="social-icons d-flex gap-3 text-muted fs-5">
          <a href="#" class="social-link"><i class="fab fa-facebook-f"></i></a>
          <a href="#" class="social-link"><i class="fab fa-twitter"></i></a>
          <a href="#" class="social-link"><i class="fab fa-linkedin-in"></i></a>
          <a href="#" class="social-link"><i class="fab fa-instagram"></i></a>
        </div>

        <div class="search-wrapper w-100 position-relative" style="max-width: 500px;" ref="searchContainer">
          <div class="input-group bg-white rounded-pill overflow-hidden px-3 py-1 align-items-center">
            <span class="input-group-text bg-white border-0 p-0 pe-2">
              <i v-if="!loading" class="las la-search fs-4 text-dark fw-bold"></i>
              <div v-else class="spinner-border spinner-border-sm text-primary" role="status"></div>
            </span>
            <input 
              type="text" 
              class="form-control border-0 shadow-none p-0" 
              v-model="search" 
              placeholder="Buscar un curso..."
              @keyup.esc="clearSearch"
            >
            <button v-if="search.length > 0" @click="clearSearch" class="btn border-0 p-0 ms-2">
              <i class="las la-times-circle text-muted fs-5"></i>
            </button>
          </div>

          <ul v-if="search.length >= 3 && (results.length > 0 || !loading)" class="search-results-dropdown list-unstyled shadow">
            <li v-for="item in results" :key="item.id">
              <a :href="item.url" class="d-flex align-items-center p-2 text-decoration-none text-dark border-bottom">
                <img :src="item.image" class="result-img me-2" v-if="item.image">
                <div class="d-flex flex-column">
                    <span class="fw-bold">{{ item.title }}</span>
                    <small class="text-muted" v-if="item.subtitle">{{ item.subtitle }}</small>
                </div>
              </a>
            </li>
            
            <li v-if="results.length === 0 && !loading" class="p-3 text-center text-muted">
              <small>No se encontraron resultados para "{{ search }}"</small>
            </li>
          </ul>
        </div>
      </div>

      <div class="logo-wrapper text-end d-none d-md-block">
        <img src="@/assets/images/LogoHorizontal.png" alt="FRI" class="img-fluid secondary-logo" />
      </div>

    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, watch, onMounted, onUnmounted } from 'vue';
import HttpClient from "@/helpers/http-client";

const search = ref('');
const results = ref<any[]>([]);
const loading = ref(false);
const searchContainer = ref<HTMLElement | null>(null); // Referencia al contenedor
let timeout: ReturnType<typeof setTimeout>;

// Limpiar buscador
const clearSearch = () => {
  search.value = '';
  results.value = [];
};

// Cerrar al hacer clic fuera del buscador
const handleClickOutside = (event: MouseEvent) => {
  if (searchContainer.value && !searchContainer.value.contains(event.target as Node)) {
    results.value = [];
  }
};

onMounted(() => document.addEventListener('click', handleClickOutside));
onUnmounted(() => document.removeEventListener('click', handleClickOutside));

watch(search, (val) => {
  clearTimeout(timeout);

  if (val.length < 3) {
    results.value = [];
    loading.value = false;
    return;
  }

  timeout = setTimeout(async () => {
    loading.value = true;
    try {
      const response = await HttpClient.get('courses/search', { params: { search: val } });
      results.value = response.data.data; 
    } catch (error) {
      console.error("Error buscando cursos", error);
      results.value = [];
    } finally {
      loading.value = false;
    }
  }, 700); // 700ms es un buen equilibrio entre API y velocidad
});
</script>

<style scoped lang="scss">
.top-bar { background-color: #1a1a1a; color: white; }
.main-logo { height: 80px; object-fit: contain; }
.secondary-logo { height: 70px; object-fit: contain; }

.search-results-dropdown {
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background: white;
  z-index: 1050;
  max-height: 400px; // Un poco más alto para ver más resultados
  overflow-y: auto;
  border-radius: 8px;
  margin-top: 5px;

  li:hover { background-color: #f8f9fa; }
  .result-img { width: 45px; height: 45px; object-fit: cover; border-radius: 4px; }
  
  // Estilo para el scrollbar
  &::-webkit-scrollbar { width: 6px; }
  &::-webkit-scrollbar-thumb { background: #ccc; border-radius: 10px; }
}

.social-link {
  color: #6c757d;
  &:hover { color: white; }
}
</style>