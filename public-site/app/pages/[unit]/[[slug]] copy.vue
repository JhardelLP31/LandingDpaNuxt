<script setup lang="ts">
import { ref, onMounted, computed, watchEffect } from 'vue';
import { useRoute } from 'vue-router';
import { resolveBlock } from '@shared/core/BlockRegistry';
import { useApi } from '~/composables/useApi';

// 1. Layout fijo de la unidad
definePageMeta({ layout: 'unit' });

const route = useRoute();
const unitSlug = route.params.unit as string;
const pageSlug = (route.params.slug as string) || 'inicio';

// 2. Llamada a la API
const { data: response, pending, error } = await useAsyncData(
  `page-${unitSlug}-${pageSlug}`, 
  () => useApi().getPage(unitSlug, pageSlug)
);

const pageData = computed(() => response.value?.data || response.value);

// 3. VALIDACIÓN DE ERROR SÍNCRONA (Aquí está la magia para el 404)
if (error.value || !pageData.value) {
  throw createError({ 
    statusCode: 404, 
    statusMessage: 'Página no encontrada', 
    fatal: true 
  });
}

// 4. Procesamiento de bloques
const blocks = computed(() => {
  const raw = pageData.value?.content_blocks;
  if (!raw) return [];
  try {
    const parsed = typeof raw === 'string' ? JSON.parse(raw) : raw;
    return Array.isArray(parsed) ? parsed : [];
  } catch (e) { return []; }
});

// 5. Configuración SEO
watchEffect(() => {
  if (!pageData.value) return;
  
  let seoTitle = pageData.value.title;
  let seoDesc = 'Página oficial de la institución.';

  if (pageData.value?.seo_config) {
    try {
      const parsedSeo = typeof pageData.value.seo_config === 'string' 
        ? JSON.parse(pageData.value.seo_config) : pageData.value.seo_config;
      if (parsedSeo.title) seoTitle = parsedSeo.title;
      if (parsedSeo.description) seoDesc = parsedSeo.description;
    } catch (e) {}
  }

  useSeoMeta({
    title: seoTitle,
    ogTitle: seoTitle,
    description: seoDesc,
    ogDescription: seoDesc,
  });
});

// 6. Fix de hidratación para componentes dinámicos
const isMounted = ref(false);
onMounted(() => { isMounted.value = true; });
</script>

<template>
  <div>
    <div v-if="pending" class="loading-container text-center py-5">
      <div class="spinner-border text-danger" role="status"></div>
    </div>
    
    <main v-else class="page-blocks-container">
      <div v-if="!isMounted" class="loading-container text-center py-5">
        <div class="spinner-grow text-danger mb-3" role="status" style="width: 3rem; height: 3rem;"></div>
        <p class="text-muted small">Estructurando la página...</p>
      </div>

      <div v-else class="blocks-wrapper">
        <Suspense v-for="(block, index) in blocks" :key="block.id || index">
          <component 
            :is="resolveBlock(block.type)" 
            v-if="resolveBlock(block.type)"
            :data="block.content || {}" 
          />
          <template #fallback>
            <div class="py-5 text-center text-muted small">
              <div class="spinner-grow spinner-grow-sm me-2" role="status"></div>
              Cargando sección...
            </div>
          </template>
        </Suspense>
      </div>
    </main>
  </div>
</template>

<style scoped>
.loading-container {
  min-height: 50vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}
</style>