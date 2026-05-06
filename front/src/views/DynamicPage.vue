<template>
  <div v-if="loading" class="text-center p-20">Cargando página...</div>
  <div v-else-if="error" class="text-center p-20 text-red-600">{{ error }}</div>
  
  <div v-else>
    <div v-for="(block, index) in page.blocks" :key="index">
      <component 
        :is="resolveComponent(block.type)" 
        :data="block.content" 
      />
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted, watch } from 'vue';
import { useRoute } from 'vue-router';
import apiClient from '@/api/client'; // Asegúrate de tener configurado Axios

// Importamos los bloques
import HeroSection from '@/components/blocks/page/HeroSection.vue';
import ProgramGrid from '@/components/blocks/page/ProgramGrid.vue';
import AchievementsBanner from '@/components/blocks/page/AchievementsBanner.vue';
//import TeachersGrid from '@/components/blocks/TeachersGrid.vue';

const route = useRoute();
const page = ref(null);
const loading = ref(true);
const error = ref('');

// MAPA: Relaciona el texto de la BD con el archivo Vue
const COMPONENT_MAP = {
  'HeroSection': HeroSection,
  'ProgramGrid': ProgramGrid,
  'AchievementsBanner': AchievementsBanner,
  'TeachersGrid': TeachersGrid,
};

const resolveComponent = (type) => {
  return COMPONENT_MAP[type] || 'div'; // Si no existe, devuelve un div vacío
};

const fetchPage = async () => {
  loading.value = true;
  try {
    // Pide al backend la página por su SLUG (ej: /api/pages/home)
    const { data } = await apiClient.get(`/pages/${route.params.slug}`);
    page.value = data;
  } catch (e) {
    console.error(e);
    error.value = 'Página no encontrada (404)';
  } finally {
    loading.value = false;
  }
};

onMounted(fetchPage);
// Si cambia la URL (de /home a /contacto), recargamos
watch(() => route.params.slug, fetchPage);
</script>