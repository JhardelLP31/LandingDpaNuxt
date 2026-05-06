<template>
  <TheHeader />

  <div v-if="loading" class="d-flex justify-content-center align-items-center py-5" style="min-height: 50vh;">
    <div class="spinner-border text-danger" role="status">
      <span class="visually-hidden">Cargando...</span>
    </div>
  </div>

  <div v-else class="page-content min-vh-100">
    
    <section v-for="(block, index) in blocks" :key="index" class="block-section">
      
      <component 
        :is="resolveBlock(block.type)" 
        :data="block.content" 
      />

    </section>

    <div v-if="blocks.length === 0" class="text-center py-5 text-muted">
        <div class="container">
            <h3>Página Vacía</h3>
            <p>No se encontraron bloques de contenido.</p>
        </div>
    </div>

  </div>

  <TheFooter />
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import HttpClient from "@/helpers/http-client";
import TheFooter from '@/components/layout/TheFooter.vue';
import TheHeader from '@/components/layout/TheHeader.vue';
import { resolveBlock } from '@/core/BlockRegistry'; 

const route = useRoute();
const blocks = ref<any[]>([]);
const loading = ref(true);

onMounted(async () => {
  try {
    const slug = route.params.slug; 
    const { data } = await HttpClient.get(`pages/${slug}`);
    
    // Obtenemos el objeto post limpio
    const post = data.post || data.data;

    if (post && post.content_blocks) {
        // CORRECCIÓN AQUÍ: Quitamos el ".value" que causaba el error
        blocks.value = typeof post.content_blocks === 'string' 
            ? JSON.parse(post.content_blocks) 
            : post.content_blocks; 
    }
  } catch (e) {
    console.error("Error cargando página pública", e);
  } finally {
    loading.value = false;
  }
});
</script>