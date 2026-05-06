<script setup lang="ts">
import { computed, watchEffect } from 'vue';
import { useRoute } from 'vue-router';
import { useApi } from '~/composables/useApi';
import { resolveArticleLayout } from '@shared/core/ArticleRegistry';
import { formatImageUrl } from '~/helpers/url';

definePageMeta({ layout: 'unit' });

const route = useRoute();
const unitSlug = route.params.unit as string;
const newsSlug = route.params.slug as string;

// Definimos la estructura esperada para calmar a TypeScript
interface ArticleBody {
  html?: string;
  layout?: string;
  author?: any;
  extra?: any;
  [key: string]: any; // Permite otras propiedades dinámicas
}

// Fetch de la noticia
const { data: response, pending, error } = await useAsyncData(
  `news-${unitSlug}-${newsSlug}`, 
  () => useApi().getNewsBySlug(unitSlug, newsSlug)
);

const noticia = computed(() => response.value?.data || response.value);

// Reconstruimos el objeto de datos de forma segura
const articleData = computed(() => {
  if (!noticia.value) return null;
  console.log(noticia.value);

  // 1. Inicializamos con el tipo correcto
  let parsedBody: ArticleBody = {};

  if (noticia.value.body) {
    try {
      const parsed = typeof noticia.value.body === 'string' 
        ? JSON.parse(noticia.value.body) 
        : noticia.value.body;
      
      // 2. Validación de seguridad (evita el error hasOwnProperty si parsed es null)
      if (parsed && typeof parsed === 'object' && !Array.isArray(parsed)) {
        parsedBody = parsed;
      }
    } catch (e) {
      console.error("Error al parsear el body de la noticia", e);
      parsedBody = { html: noticia.value.body, layout: 'classic' };
    }
  }

  return {
    title: noticia.value.title,
    excerpt: noticia.value.excerpt,
    start_date: noticia.value.start_date || noticia.value.created_at,
    featured_image_path: noticia.value.featured_image_path,
    category_name: parsedBody.category || noticia.value.category?.name || 'Noticias',
    body: parsedBody
  };
});

// SEO dinámico
watchEffect(() => {
  if (!noticia.value) return;
  
  useSeoMeta({
    title: `${noticia.value.title} | ${unitSlug.toUpperCase()}`,
    ogTitle: noticia.value.title,
    description: noticia.value.excerpt || noticia.value.title,
    ogImage: formatImageUrl(noticia.value.featured_image_path),
    twitterCard: 'summary_large_image',
  });
});

</script>

<template>
  <div>
    <div v-if="pending" class="loading-container text-center py-5">
      <div class="spinner-border text-primary" role="status"></div>
    </div>

    <div v-else-if="error || !noticia" class="alert alert-warning m-4 text-center">
      <p class="m-0 fw-bold">Noticia no encontrada.</p>
    </div>

    <main v-else class="article-layout-container">
      <ClientOnly>
        <component 
          :is="resolveArticleLayout(articleData.body?.layout || 'classic')" 
          v-if="articleData"
          :data="articleData" 
        />
      </ClientOnly>
    </main>
  </div>
</template>

<style scoped>
.loading-container {
  min-height: 50vh;
  display: flex;
  align-items: center;
  justify-content: center;
}

/* El estilo específico (títulos, imágenes, tipografía) ahora depende 100% 
   del componente de layout (ej: ClassicLayout.vue, ModernLayout.vue) */
</style>