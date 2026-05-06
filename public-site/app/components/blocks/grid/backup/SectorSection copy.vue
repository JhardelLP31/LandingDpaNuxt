<script setup lang="ts">
import { ref, onMounted } from 'vue';
import HttpClient from "@/helpers/http-client";

// 1. IMPORTAMOS EL NUEVO COMPONENTE "MAGNETIC"
// Asegúrate de que la ruta sea correcta donde guardaste el archivo anterior
import SectorsMagnetic, { type SectorItem } from '@/components/ui/SectionCard.vue'; 

const props = defineProps<{
  data?: {
    title?: string;
  }
}>();

const sectors = ref<SectorItem[]>([]); 
const loading = ref(true);

onMounted(async () => {
  try {
    const response = await HttpClient.get('categories-list'); 
    const rawData = response.data.data || response.data;
    
    // El mapeo se mantiene IDÉNTICO, la lógica de datos no cambia
    sectors.value = rawData.map((item: any) => {
        return {
            id: item.id,
            title: item.name, 
            image: item.image_path, 
            url: `/categoria/${item.slug}`,
            // Asegúrate de que tu DB tenga colores hexadecimales válidos
            // O deja el fallback '#2c2c51'
            color: item.color || '#2c2c51' 
        };
    });

  } catch (e) {
    console.error("Error cargando sectores:", e);
  } finally {
    loading.value = false;
  }
});
</script>

<template>
  <section class="sector-section-wrapper">
    
    <div class="container pt-5" v-if="!loading && sectors.length > 0">
       <small class="text-uppercase text-muted fw-bold ls-2">
         {{ props.data?.title || 'Explora nuestros sectores' }}
       </small>
    </div>

    <div v-if="loading" class="loading-screen">
      <div class="spinner-border text-light"></div>
    </div>

    <SectorsMagnetic 
      v-else-if="sectors.length > 0" 
      :items="sectors" 
    />

    <div v-else class="text-center py-5 text-muted">
       <p>No hay sectores disponibles.</p>
    </div>

  </section>
</template>

<style scoped>
/* Un wrapper oscuro base para evitar flasheos blancos al cargar */
.sector-section-wrapper {
  background-color: #0a0a0a; 
  min-height: 50vh;
}

.loading-screen {
  height: 60vh;
  display: flex;
  align-items: center;
  justify-content: center;
}

/* Utilidad para espaciado de letras */
.ls-2 { letter-spacing: 2px; }
</style>