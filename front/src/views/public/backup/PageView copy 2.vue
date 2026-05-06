<template>
  <TheHeader2 />

  <div v-if="loading" class="d-flex justify-content-center align-items-center py-5" style="min-height: 50vh; ">
    <div class="spinner-border text-primary" role="status"><span class="visually-hidden">Cargando...</span></div>
  </div>

  <div v-else class="page-content min-vh-100 bg-white">
    
    <section v-if="post.type === 'course'" class="bg-dark text-white py-5 position-relative overflow-hidden">
        <div class="position-absolute top-0 start-0 w-100 h-100 bg-primary opacity-10" style="z-index: 0;"></div>
        
        <div class="container position-relative" style="z-index: 1;">
            <div class="row align-items-center">
                <div class="col-lg-8 mb-4 mb-lg-0">
                    <span class="badge bg-danger mb-3 px-3 py-2 rounded-pill">INSCRIPCIONES ABIERTAS</span>
                    <h1  class="fw-bold display-5 mb-3">{{ post.title }}</h1>
                    <p class="lead opacity-75 mb-4" style="max-width: 600px;">{{ post.excerpt }}</p>
                    
                    <div class="d-flex gap-4 text-white-50 small">
                        <div v-if="post.start_date">
                            <i class="las la-calendar text-primary fs-5 me-1"></i> 
                            Inicio: <span class="text-white fw-bold">{{ formatDate(post.start_date) }}</span>
                        </div>
                        <div v-if="post.end_date">
                            <i class="las la-flag text-primary fs-5 me-1"></i> 
                            Fin: <span class="text-white fw-bold">{{ formatDate(post.end_date) }}</span>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="card border-0 shadow-lg floating-card">
                        <div class="card-body p-4 text-center text-dark">
                            <p class="text-muted text-uppercase small fw-bold mb-1">Inversión Total</p>
                            <h2 class="fw-bold text-primary display-4 mb-0">
                                S/. {{ post.price || '0' }}
                            </h2>
                            <small class="text-muted d-block mb-4">Incluye certificación</small>

                            <button class="btn btn-danger btn-lg w-100 fw-bold shadow-sm mb-3 hover-scale">
                                <i class="las la-shopping-cart me-2"></i> INSCRIBIRME AHORA
                            </button>
                            
                            <div class="small text-muted">
                                <i class="las la-lock"></i> Compra 100% Segura
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!--<section v-else class="bg-white py-5 border-bottom">
        <div class="container">
            <h1 class="fw-bold display-5 text-dark">{{ post.title }}</h1>
            <p class="text-muted lead" v-if="post.excerpt">{{ post.excerpt }}</p>
        </div>
    </section>-->

    <!--<div class="container py-5">-->
    <div class="container ">
        <div class="row justify-content-center">
            <div class="col-12">
                <section v-for="(block, index) in blocks" :key="index" class="block-section mb-5">
                    <component :is="resolveBlock(block.type)" :data="block.content" />

                </section>
            </div>
        </div>
    </div>

  </div>

  <TheFooter />
</template>

<script setup lang="ts">
import { ref, onMounted, watch, nextTick } from 'vue';
import { useRoute } from 'vue-router';
import HttpClient from "@/helpers/http-client";

// Importa tus componentes de Layout (Header/Footer)
import TheFooter from '@/components/layout/TheFooter.vue';
import TheHeader2 from '@/components/layout/TheHeader2.vue';

// Importa tu registro de bloques (Asegúrate que la ruta sea la correcta en tu proyecto)
import { resolveBlock } from '@/core/BlockRegistry'; 

const route = useRoute();

// --- ESTADO ---
const post = ref<any>({});
const blocks = ref<any[]>([]);
const loading = ref(true);
const error = ref(false);

// --- UTILIDADES ---
const formatDate = (dateString: string) => {
    if(!dateString) return '';
    // Truco para evitar problemas de timezone
    const date = new Date(dateString + 'T00:00:00'); 
    return date.toLocaleDateString('es-ES', { day: 'numeric', month: 'long', year: 'numeric' });
};

// --- LÓGICA DE CARGA (El corazón del componente) ---
const loadContent = async () => {
    // 1. Scroll arriba suavemente al cambiar de página
    window.scrollTo({ top: 0, behavior: 'smooth' });

    // 2. Determinar el slug. Si es la raíz '/', route.params.slug será undefined.
    // 🔥 IMPORTANTE: Asegúrate de tener una página en tu BD con el slug 'home' (o 'inicio')
    const currentSlug = (route.params.slug as string) || 'home';

    console.log("📡 Cargando contenido para:", currentSlug);

    loading.value = true;
    error.value = false;
    blocks.value = []; // Limpiamos para evitar "fantasmas" visuales
    post.value = {};

    try {
        // Agregamos timestamp para evitar caché agresivo del navegador
        const { data } = await HttpClient.get(`pages/${currentSlug}?t=${Date.now()}`);
        
        // Asignamos la data (soporta si viene dentro de data.data o directo)
        post.value = data.post || data.data || data;

        // 3. Parseo robusto de los bloques
        if (post.value && post.value.content_blocks) {
            // A veces el backend manda String JSON, a veces manda Objeto. Esto lo arregla.
            blocks.value = typeof post.value.content_blocks === 'string' 
                ? JSON.parse(post.value.content_blocks) 
                : post.value.content_blocks;
        } else {
            blocks.value = [];
        }

    } catch (e) {
        console.error("❌ Error cargando página:", e);
        error.value = true; 
        // Aquí podrías redirigir a una página 404 si prefieres: router.push('/404')
    } finally {
        loading.value = false;
    }
};

// --- CICLO DE VIDA ---

// 1. Carga inicial
onMounted(() => {
    loadContent();
});

// 2. Observador de cambios de Ruta
// Esto arregla el problema de "cambio de página y no carga nada"
watch(
    () => route.path, // Vigilamos la ruta completa
    (newPath, oldPath) => {
        if (newPath !== oldPath) {
            loadContent();
        }
    }
);
</script>

<style scoped>
/* Aseguramos que el contenedor principal de la página no se expanda más allá de un tamaño razonable */
.page-content {
  margin: 0 auto; /* Centramos el contenido */
  overflow-x: hidden; /* Ocultar cualquier desbordamiento horizontal */
}

/* Control de márgenes y rellenos en la sección del curso */
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