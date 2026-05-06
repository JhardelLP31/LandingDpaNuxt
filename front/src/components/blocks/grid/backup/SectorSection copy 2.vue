<script setup lang="ts">
import { ref, onMounted } from 'vue';
import HttpClient from "@/helpers/http-client";
// Importamos el componente hijo y su interfaz
import SectorCard, { type SectorItem } from '@/components/ui/SectionCard.vue'; 

// Props para configurar el título desde fuera si es necesario
const props = defineProps<{
  data?: {
    title?: string;
  }
}>();

const sectors = ref<SectorItem[]>([]); 
const loading = ref(true);

onMounted(async () => {
  try {
    // 1. Llamada a la API (Ajusta 'categories' según tu ruta real en Laravel/Node)
    const response = await HttpClient.get('categories-list'); 
    
    // Normalizamos la respuesta (por si viene envuelta en { data: ... })
    const rawData = response.data.data || response.data;
    
    // 2. Mapeo: Base de Datos -> Componente Visual
    sectors.value = rawData.map((item: any) => {
        return {
            id: item.id,
            
            // Mapeo: columna 'name' de la DB a 'title' del componente
            title: item.name, 
            
            // Mapeo: columna 'image_path' a 'image'
            // Nota: SectorCard ya usa formatImageUrl internamente, pasamos el string tal cual
            image: item.image_path, 
            
            // Mapeo: Construimos la URL amigable con el 'slug'
            url: `/categoria/${item.slug}`,
            
            // Mapeo: columna 'color' (tu tabla tiene default #6c757d)
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
  <section class="sector-section py-5 bg-white">
    <div class="container">
      
      <div class="d-flex justify-content-between align-items-center mb-4  pb-2">
         <h2 style="color: #e31140;" class="text-uppercase fw-bold mb-0 ps-3 border-start border-4 border-danger display-6">
           {{ props.data?.title || 'Sectores' }}
         </h2>
      </div>

      <div v-if="loading" class="text-center py-5">
        <div class="spinner-border text-primary"></div>
      </div>

      <div v-else class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-4 g-4">
        <div 
          class="col" 
          v-for="sector in sectors" 
          :key="sector.id"
        >
          <SectorCard :item="sector" />
        </div>
        
        <div v-if="sectors.length === 0" class="col-12 text-center text-muted py-5">
            <i class="las la-layer-group fs-1 mb-2"></i>
            <p>No hay sectores registrados.</p>
        </div>
      </div>

    </div>
  </section>
</template>