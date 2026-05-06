<script setup lang="ts">
import { ref, onMounted } from 'vue';
import HttpClient from "@/helpers/http-client";

// IMPORTAMOS EL NUEVO COMPONENTE (Asegúrate de la ruta)
import SectorsTakeover, { type SectorItem } from '@/components/ui/SectorsTakeover.vue'; 

// Props opcionales (por si las usas)
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
    
    // Mapeo de datos (DB -> Visual)
    sectors.value = rawData.map((item: any) => {
        return {
            id: item.id,
            title: item.name, 
            image: item.image_path, 
            // URL limpia
            url: `/categoria/${item.slug}`,
            // Color o default
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
  <section class="section-clean-bg">
    <div class="container">
      
      <div class="d-flex justify-content-between align-items-center mb-4  pb-2">
         <h2 style="color: #e31140;" class="text-uppercase fw-bold mb-0 ps-3 border-start border-4 border-danger display-6">
           {{ props.data?.title || 'Sectores' }}
         </h2>
      </div>

      <div class="row justify-content-center">
        <div class="col-12">
            
            <div v-if="loading" class="text-center py-5">
                <div class="spinner-border text-secondary" role="status">
                    <span class="visually-hidden">Cargando...</span>
                </div>
            </div>

            <SectorsTakeover v-else-if="sectors.length > 0" :items="sectors" />

            <div v-else class="text-center text-muted py-5">
                No hay sectores disponibles.
            </div>

        </div>
      </div>

    </div>
  </section>
</template>

<style scoped>
/* ESTILOS DEL PADRE PARA FONDO BLANCO */
.section-clean-bg {
  background-color: #ffffff; /* BLANCO */
  padding: 5rem 0;
  
  /* Textura de puntos sutil para fondo profesional */
  background-image: radial-gradient(#e5e5e5 1px, transparent 1px);
  background-size: 20px 20px;
}

.section-heading {
  font-weight: 800;
  text-transform: uppercase;
  letter-spacing: 1px;
  color: #222; /* TEXTO OSCURO */
  margin-top: 10px;
}

.heading-line {
  width: 60px;
  height: 3px;
  background-color: #222; /* LINEA OSCURA */
  margin-top: 15px;
}
</style>