<template>
  <div class="page-container">
    <!-- Cargando -->
    <div v-if="loading" class="flex justify-center items-center py-20">
      <span class="text-gray-500">Cargando contenido...</span>
    </div>

    <!-- Error -->
    <div v-else-if="error" class="text-center py-20 text-red-600">
      <h2 class="text-xl font-bold">Error</h2>
      <p>{{ error }}</p>
    </div>
  
    <!-- Contenido de la página -->
    <div v-else>
      <template v-for="(block, index) in page?.blocks" :key="block.id || index">
        <component 
          v-if="resolveBlock(block.type)" 
          :is="resolveBlock(block.type)" 
          :data="block.content" 
          class="mb-8"
        />
        
        <!-- Bloque desconocido -->
        <div v-else class="p-4 bg-yellow-100 text-yellow-800 text-center border border-yellow-300">
          ⚠️ Bloque desconocido: <strong>{{ block.type }}</strong>
        </div>
      </template>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, watch } from 'vue';
import { useRoute } from 'vue-router';
import HttpClient from "@/helpers/http-client";

// Importamos la lógica centralizada para resolver los bloques
import { resolveBlock } from '@/core/BlockRegistry'; 

const route = useRoute();
const page = ref<any>(null);
const loading = ref(true);
const error = ref('');

// Función para cargar la página
const fetchPage = async () => {
  loading.value = true;
  error.value = '';
  
  try {
    const slug = route.params.slug || 'home'; // Slug por defecto si no hay slug en la URL
    const { data } = await HttpClient.get(`/pages/${slug}?t=${Date.now()}`); // Añadimos timestamp para evitar caché
    page.value = data; // Guardamos los datos en la referencia 'page'
  } catch (e: any) {
    console.error(e);
    error.value = 'No se pudo cargar la página. Verifica tu conexión o la URL.'; // Error en caso de fallo
  } finally {
    loading.value = false; // Finalizamos la carga
  }
};

// Cargamos la página cuando el componente se monta
onMounted(() => {
  fetchPage();
});

// Watcher para detectar cambios en la URL y volver a cargar la página si el slug cambia
watch(
  () => route.params.slug, 
  (newSlug, oldSlug) => {
    if (newSlug !== oldSlug) {
      fetchPage();
    }
  }
);
</script>
