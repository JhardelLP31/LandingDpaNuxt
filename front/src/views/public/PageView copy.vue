<template>
  <PageLayout>
  <div v-if="loading" class="d-flex justify-content-center align-items-center py-5" style="min-height: 50vh;">
    <div class="spinner-border text-primary" role="status">
      <span class="visually-hidden">Cargando...</span>
    </div>
  </div>

  <div v-else class="page-content min-vh-100 ">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-12">
          <section v-for="(block, index) in blocks" :key="index" class="block-section">
            <component :is="resolveBlock(block.type)" :data="block.content" />
          </section>
        </div>
      </div>
    </div>
  </div>
</PageLayout>

</template>

<script setup lang="ts">
import { ref, onMounted, watch, nextTick, onBeforeUnmount } from 'vue';
import { useRoute } from 'vue-router';
import HttpClient from "@/helpers/http-client";

// Layout & Registry
import PageLayout from '@/components/layout/PageLayout.vue';
import { resolveBlock } from '@shared/core/BlockRegistry'; 

const props = defineProps<{
    slug?: string
}>();

const route = useRoute();

// --- ESTADO ---
const post = ref<any>({});
const blocks = ref<any[]>([]);
const loading = ref(true);
const error = ref(false);

/**
 * SCROLL MANAGEMENT
 */
const handleHashScroll = () => {
    if (route.hash) {
        const id = route.hash.replace('#', '');
        const element = document.getElementById(id);
        if (element) {
            const yOffset = -100; 
            const y = element.getBoundingClientRect().top + window.pageYOffset + yOffset;
            window.scrollTo({ top: y, behavior: 'smooth' });
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
    error.value = false;
    blocks.value = []; 

    try {
        const { data } = await HttpClient.get(`public/pages/${currentSlug}?t=${Date.now()}`);         
        post.value = data.post || data.data || data;

        if (post.value && post.value.content_blocks) {
            blocks.value = typeof post.value.content_blocks === 'string' 
                ? JSON.parse(post.value.content_blocks) 
                : post.value.content_blocks;
            
            nextTick(() => {
                setTimeout(handleHashScroll, 600);
            });
        }
    } catch (e) {
        console.error("❌ Error cargando página:", e);
        error.value = true; 
        document.title = "Página no encontrada";
    } finally {
        loading.value = false;
    }
};

// --- CICLO DE VIDA ---
onMounted(() => {
    loadContent();
});

// Limpiar título al salir de la página
onBeforeUnmount(() => {
    document.title = "ESAN"; 
});

/**
 * WATCHERS
 */
// 1. Detectar cambios de URL
watch(
    () => [route.params.slug, props.slug], 
    ([newSlug, newProp], [oldSlug, oldProp]) => {
        if (newSlug !== oldSlug || newProp !== oldProp) {
            loadContent();
        } else {
            handleHashScroll();
        }
    }
);

// 2. Detectar cambios de Hash
watch(() => route.hash, () => {
    if (!loading.value) handleHashScroll();
});

// 3. ACTUALIZAR TÍTULO Y META (SEO)
watch(post, (newPost) => {
  if (newPost && Object.keys(newPost).length > 0) {
    // Tomamos el título de la base de datos
    const rawTitle = newPost.seo_title || newPost.title;
    
    if (rawTitle) {
      const finalTitle = `${rawTitle} | ESAN`;
      
      document.title = finalTitle;
      
      route.meta.title = finalTitle;
    }

    // Lógica de descripción (se mantiene igual)
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
.page-content {
  margin: 0 auto; /* Centramos el contenido */
  overflow-x: hidden; /* Ocultar cualquier desbordamiento horizontal */
}

.bg-dark {
  padding: 5rem 0; /* Añadimos un padding controlado */
}

/* En el contenedor, aseguramos que las columnas no se expandan más allá de un tamaño razonable */
.container {
  width: 100%; /* Limitar el ancho máximo del contenedor */
  margin: 0 auto; /* Centramos el contenido */
}

/* Aseguramos que la sección con overlay no desborde */
.position-relative {
  position: relative;
  z-index: 1;
}

/* La imagen de fondo y el overlay en la sección del curso */
.bg-primary {
  position: absolute;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background: rgba(0, 123, 255, 0.1);
  z-index: 0;
}

/* Ajustes en el card flotante para evitar desbordamientos */
.floating-card {
  transform: translateY(0);
  transition: transform 0.3s ease;
}

.floating-card:hover {
  transform: translateY(-5px);
}

.hover-scale {
  transition: transform 0.2s;
}

.hover-scale:hover {
  transform: scale(1.02);
}

</style>