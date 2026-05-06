<template>
  <div class="search-page bg-white min-vh-100 py-5">
    <div class="container container-narrow">
      
      <header class="mb-4 border-bottom pb-3">
        <h1 class="h4 text-muted fw-normal">
          Resultados para <span class="text-dark fw-bold">"{{ route.query.q }}"</span>
        </h1>
        <p class="small text-muted mb-0" v-if="!loading">
          Se han encontrado {{ filteredResults.length }} coincidencias en el portal.
        </p>
      </header>

      <nav class="d-flex gap-4 mb-5 border-bottom overflow-auto no-scrollbar">
        <button 
          v-for="filter in ['todos', 'course', 'manual', 'page', 'news']" 
          :key="filter"
          @click="activeFilter = filter"
          class="filter-tab pb-2 text-capitalize"
          :class="{ active: activeFilter === filter }"
        >
          {{ filter === 'page' ? 'Páginas' : (filter === 'news' ? 'Noticias' : filter) }}
        </button>
      </nav>

      <div v-if="loading" class="loading-state">
        <div v-for="i in 4" :key="i" class="mb-5 placeholder-glow">
          <div class="placeholder col-3 mb-2 bg-light"></div>
          <div class="placeholder col-8 d-block mb-2 bg-light" style="height: 25px;"></div>
          <div class="placeholder col-10 bg-light"></div>
        </div>
      </div>

      <div v-else-if="filteredResults.length > 0" class="results-container">
        <article 
          v-for="item in filteredResults" 
          :key="`${item.type}-${item.id}`" 
          class="result-item mb-5"
        >
          <!--<div class="result-breadcrumb text-truncate">
            {{ siteOrigin }}{{ item.url }}
          </div>-->

          <router-link :to="item.url" class="result-link">
            <h2 class="result-title h4 mb-1" v-html="highlight(item.title)"></h2>
          </router-link>

          <div class="result-content">
            <span class="badge-type me-2" :class="item.type">{{ item.type }}</span>
            <span class="result-snippet" v-html="highlight(item.excerpt || 'Explora el contenido detallado de esta sección para obtener más información.')"></span>
          </div>

          <div v-if="item.url.includes('#')" class="result-sublink mt-2">
            <i class="las la-share text-muted la-rotate-90"></i>
            <span class="ms-1">Salto directo a la sección donde se encontró la coincidencia.</span>
          </div>
        </article>
      </div>

      <div v-else class="text-start py-5">
        <h3 class="h5 text-dark">Tu búsqueda - <span class="fw-bold">{{ route.query.q }}</span> - no produjo ningún documento.</h3>
        <p class="mt-4 mb-2">Sugerencias:</p>
        <ul class="text-muted">
          <li>Asegúrate de que todas las palabras estén escritas correctamente.</li>
          <li>Intenta usar términos más generales.</li>
          <li>Prueba a buscar términos específicos de ESAN (ej. "ISO", "SQL", "Admisión").</li>
        </ul>
      </div>

    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, watch } from 'vue';
import { useRoute } from 'vue-router';
import { useGlobalSearch } from '@/composables/useGlobalSearch';

const route = useRoute();
const activeFilter = ref('todos');
const siteOrigin = window.location.origin;

// Importamos la lógica del composable
const { results, loading, performSearch } = useGlobalSearch();

/**
 * Lógica de resaltado (Highlighting)
 * Envuelve la coincidencia en una etiqueta <mark> para el subrayado amarillo
 */
const highlight = (text: string) => {
  const query = route.query.q as string;
  if (!query || !text) return text;

  // Escapar caracteres especiales para el RegExp
const cleanQuery = query.replace(/[-[\]{}()*+?.,\\^$|#\s]/g, '\\$&');

  const regex = new RegExp(`(${cleanQuery})`, 'gi');
  
  return text.replace(regex, '<mark class="highlight-search">$1</mark>');
};

/**
 * Filtrado dinámico por pestañas
 */
const filteredResults = computed(() => {
  if (activeFilter.value === 'todos') return results.value;
  return results.value.filter(item => item.type === activeFilter.value);
});

/**
 * Ejecutar búsqueda basándose en el query param 'q' de la URL
 */
const executeSearchFromUrl = () => {
  const q = route.query.q as string;
  if (q && q.length >= 3) {
    performSearch(q);
  }
};

// Observar cambios en la URL (cuando el usuario busca desde el buscador del TopBar)
watch(() => route.query.q, executeSearchFromUrl);

onMounted(executeSearchFromUrl);
</script>

<style scoped lang="scss">
// Configuración de ancho estilo buscador
.container-narrow {
  max-width: 750px;
  margin-left: auto;
  margin-right: auto;
  @media (min-width: 1200px) {
    margin-left: 10%; // Alineación ligeramente a la izquierda como Google
  }
}

.result-breadcrumb {
  font-size: 0.8rem;
  color: #202124;
  margin-bottom: 2px;
}

.result-link {
  text-decoration: none;
  .result-title {
    color: #1a0dab; // Azul clásico de enlaces de búsqueda
    font-weight: 500;
    &:hover {
      text-decoration: underline;
    }
  }
}

.result-snippet {
  font-size: 0.95rem;
  line-height: 1.58;
  color: #4d5156;
}

.result-sublink {
  font-size: 0.85rem;
  color: #70757a;
  padding-left: 10px;
}

// Estilo de las pestañas de filtro
.filter-tab {
  background: none;
  border: none;
  color: #5f6368;
  font-size: 0.9rem;
  padding: 8px 4px;
  border-bottom: 3px solid transparent;
  white-space: nowrap;
  transition: all 0.2s;
  
  &:hover { color: #1a0dab; }
  &.active {
    color: #1a0dab;
    border-bottom-color: #1a0dab;
    font-weight: 600;
  }
}

// Estilos del Badge (Etiqueta de tipo)
.badge-type {
  font-size: 0.7rem;
  font-weight: 700;
  text-transform: uppercase;
  padding: 2px 8px;
  border-radius: 4px;
  background-color: #f1f3f4;
  color: #3c4043;
  
  &.curso { background: #e8f0fe; color: #1967d2; }
  &.manual { background: #e6f4ea; color: #137333; }
  &.noticia { background: #fef7e0; color: #b06000; }
}

// --- SUBRAYADO AMARILLO ---
:deep(.highlight-search) {
  background-color: #fff2ac; // Amarillo suave
  color: #000;
  padding: 0 1px;
  border-radius: 2px;
}

// Ocultar scrollbar en los filtros (móvil)
.no-scrollbar::-webkit-scrollbar {
  display: none;
}
.no-scrollbar {
  -ms-overflow-style: none;
  scrollbar-width: none;
}
</style>