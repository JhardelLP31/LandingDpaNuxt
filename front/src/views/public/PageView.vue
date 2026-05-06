<template>
    <div v-if="loading" class="loading-screen">
      <div class="spinner-border text-primary" role="status">
        <span class="visually-hidden">Cargando...</span>
      </div>
    </div>

    <div v-else class="page-content min-vh-100">
  
      <div 
        v-for="(block, index) in blocks" 
        :key="block.id || index" 
        :id="block.id" 
        class="block-wrapper"
      >
        <component 
          :is="resolveBlock(block.type)" 
          :data="block.content"
        />
      </div>

      <div v-if="blocks.length === 0" class="text-center py-5 text-muted">
        <p>Esta página aún no tiene contenido.</p>
      </div>

    </div>
</template>

<script setup lang="ts">
import { ref, onMounted, watch, nextTick, onBeforeUnmount } from 'vue';
import { useRoute } from 'vue-router';
import HttpClient from "@/helpers/http-client";

// Layout & Registry
import PageLayout from '@/components/layout/PageLayout.vue';
import { resolveBlock } from '@shared/core/BlockRegistry'; 

const props = defineProps<{ slug?: string }>();
const route = useRoute();

// --- STATE ---
const post = ref<any>({});
const blocks = ref<any[]>([]);
const loading = ref(true);

/**
 * SCROLL MANAGEMENT
 */
const handleHashScroll = () => {
  if (route.hash) {
    const id = route.hash.replace('#', '');
    const element = document.getElementById(id);
    if (element) {
      // Ajuste para header fijo (si tienes uno)
      const headerOffset = 80; 
      const elementPosition = element.getBoundingClientRect().top;
      const offsetPosition = elementPosition + window.pageYOffset - headerOffset;
  
      window.scrollTo({
        top: offsetPosition,
        behavior: "smooth"
      });
    }
  }
};

/**
 * CARGA DE DATOS
 */
const loadContent = async () => {
  const currentSlug = props.slug || (route.params.slug as string) || 'inicio';

  if (!route.hash) {
    window.scrollTo({ top: 0, behavior: 'instant' });
  }

  loading.value = true;
  blocks.value = []; 

  try { 
    const { data } = await HttpClient.get(`public/pages/${currentSlug}?t=${Date.now()}`);        
    post.value = data.post || data.data || data;

    if (post.value && post.value.content_blocks) {
      blocks.value = typeof post.value.content_blocks === 'string' 
        ? JSON.parse(post.value.content_blocks) 
        : post.value.content_blocks;
      
      nextTick(() => {
        setTimeout(handleHashScroll, 300);
      });
    }
  } catch (e) {
    console.error("❌ Error cargando página:", e);
  } finally {
    loading.value = false;
  }
};

// --- LIFECYCLE ---
onMounted(() => {
  loadContent();
});

onBeforeUnmount(() => {
  document.title = "ESAN"; 
});

// --- WATCHERS ---
watch(() => [route.params.slug, props.slug], ([newSlug], [oldSlug]) => {
  if (newSlug !== oldSlug) loadContent();
});

watch(() => route.hash, () => {
  if (!loading.value) handleHashScroll();
});

// SEO UPDATE
watch(post, (newPost) => {
  if (newPost && Object.keys(newPost).length > 0) {
    const rawTitle = newPost.seo_title || newPost.title;
    if (rawTitle) {
      const finalTitle = `${rawTitle} | ESAN`;
      document.title = finalTitle;
    }
    // Meta Description
    const metaDescription = newPost.seo_description || newPost.excerpt;
    if (metaDescription) {
      let metaTag = document.querySelector('meta[name="description"]');
      if (!metaTag) {
        metaTag = document.createElement('meta');
        metaTag.setAttribute('name', 'description');
        document.head.appendChild(metaTag);
      }
      metaTag.setAttribute('content', metaDescription);
    }
  }
}, { deep: true });
</script>

<style scoped>
/* Estilos limpios.
  Ya no forzamos anchos aquí. Cada bloque es responsable de su propio layout.
*/
.page-content {
  width: 100%;
  overflow-x: hidden;
  display: flex;
  flex-direction: column;
}

.loading-screen {
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 60vh;
}

/* Eliminé los estilos de .floating-card y .bg-primary 
  porque esos deben ir DENTRO de sus respectivos componentes (Bloques),
  no en el renderizador general de la página.
*/
</style>