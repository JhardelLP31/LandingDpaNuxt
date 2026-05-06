<script setup lang="ts">
import { ref, onMounted, computed, watchEffect } from 'vue';
import { useRoute } from 'vue-router';
import { resolveBlock } from '@shared/core/BlockRegistry';
import { useApi } from '~/composables/useApi';

// Forzamos el layout limpio (sin menu/footer)
definePageMeta({ layout: 'landing' });

const route = useRoute();
const unitSlug = route.params.unit as string;
const pageSlug = route.params.slug as string;

// 1. FETCH EN PARALELO
const [{ data: pageResponse, pending: pagePending, error: pageError }] = await Promise.all([
  useAsyncData(`landing-${unitSlug}-${pageSlug}`, () => useApi().getPage(unitSlug, pageSlug))
]);

const pageData = computed(() => pageResponse.value?.data || pageResponse.value);

// 2. ERROR 404 SÍNCRONO
if (pageError.value || !pageData.value) {
  showError({ 
    statusCode: 404, 
    statusMessage: 'Landing no encontrada', 
    fatal: true 
  });
}

const blocks = computed(() => {
  const raw = pageData.value?.content_blocks;
  if (!raw) return [];
  try {
    const parsed = typeof raw === 'string' ? JSON.parse(raw) : raw;
    return Array.isArray(parsed) ? parsed : [];
  } catch (e) { return []; }
});

// SEO dinámico para la landing
watchEffect(() => {
  if (!pageData.value) return;
  
  let seoTitle = pageData.value.title;
  let seoDesc = 'Landing promocional.';

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
    description: seoDesc,
  });
});

// Fix de hidratación
const isMounted = ref(false);
onMounted(() => { isMounted.value = true; });
</script>

<template>
  <div class="landing-content">
    
    <div v-if="pagePending" class="loading-container text-center py-5">
      <div class="spinner-border text-danger" role="status"></div>
    </div>

    <main v-else class="landing-blocks-container">
      <div v-if="!isMounted" class="loading-container text-center py-5">
        <div class="spinner-grow text-danger mb-3" role="status"></div>
        <p class="text-muted small">Cargando...</p>
      </div>

      <div v-else class="blocks-wrapper">
        <Suspense v-for="(block, index) in blocks" :key="block.id || index">
          
          <component 
            :is="resolveBlock(block.type)" 
            v-if="resolveBlock(block.type)"
            :data="block.content || {}" 
            :id="'sec-' + block.id"
            class="scroll-anchor"
          />
          
          <template #fallback>
            <div class="py-5 text-center text-muted small">Cargando sección...</div>
          </template>
        </Suspense>
      </div>
    </main>
  </div>
</template>

<style>
/* Estilos globales para la landing */
html {
  scroll-behavior: smooth; /* Hace que el menú navegue suave */
}

/* Compensación para que el sticky no tape el contenido al hacer click en el menú */
.scroll-anchor {
  scroll-margin-top: 80px; 
}

.landing-content {
  width: 100%;
  min-height: 100vh;
  font-family: var(--global-font, inherit) !important;
}

.landing-content * {
  font-family: inherit !important;
}
</style>

<style scoped>
.loading-container {
  min-height: 70vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}
</style>