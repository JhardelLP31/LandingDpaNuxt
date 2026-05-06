<script setup lang="ts">
import { ref, onMounted } from 'vue';
import HttpClient from "@/helpers/http-client";
// Importamos el componente hijo y su interfaz
import SectorsTakeover, { type SectorItem } from '@/components/ui/SectorsTakeover.vue'; 

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
  <div class="w-100 bg-black"> 
     
    <div class="text-center pt-5 pb-3">
       <h3 class="text-white text-uppercase ls-2">Explora por Sector</h3>
    </div>

    <SectorsTakeover :items="sectors" />

  </div>
</template>