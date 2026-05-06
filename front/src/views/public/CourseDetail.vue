<script setup lang="ts">
import { ref, onMounted, watch } from 'vue';
import { useRoute } from 'vue-router';
import HttpClient from "@/helpers/http-client";
import PageLayout from '@/components/layout/PageLayout.vue';

import { resolveBlock } from '@shared/core/BlockRegistry'; 

const route = useRoute();
const post = ref<any>({});
const blocks = ref<any[]>([]);
const loading = ref(true);

/**
 * FUNCIÓN DE CARGA: Reutilizable para carga inicial y cambios de URL
 */
const fetchCourseData = async () => {
    loading.value = true;
    
    // Subir al inicio inmediatamente al cambiar de curso
    window.scrollTo({ top: 0, behavior: 'instant' });

    try {
        const slug = route.params.slug;
        const { data } = await HttpClient.get(`courses/${slug}`);
        
        const loadedPost = data.data || data; 
        post.value = loadedPost;
        
        document.title = `${loadedPost.title || 'Curso'} | ESAN`;

        if (loadedPost.content_blocks) {
            const rawBlocks = typeof loadedPost.content_blocks === 'string' 
                ? JSON.parse(loadedPost.content_blocks) 
                : loadedPost.content_blocks;
            
            blocks.value = Array.isArray(rawBlocks) ? rawBlocks : [];
        }

        console.log("Bloques cargados para curso:", slug);

    } catch (e) {
        console.error("Error cargando curso:", e);
    } finally {
        loading.value = false;
    }
};

// 1. Carga inicial
onMounted(() => {
    fetchCourseData();
});

// 2. VIGILANCIA DEL SLUG: Esto soluciona que el contenido cambie al hacer clic
watch(
    () => route.params.slug,
    (newSlug, oldSlug) => {
        if (newSlug && newSlug !== oldSlug) {
            fetchCourseData();
        }
    }
);
</script>

<template>
    <div v-if="loading" class="d-flex justify-content-center align-items-center" style="min-height: 50vh;">
        <div class="spinner-border text-primary" role="status">
            <span class="visually-hidden">Cargando...</span>
        </div>
    </div>
    
    <div v-else class="page-content bg-white">
        <div class="container py-5">
            <div class="row justify-content-center">
                <div class="col-lg-12">
                    
                    <div v-if="blocks.length === 0" class="text-center py-5 text-muted">
                        <p>Próximamente más información sobre este curso.</p>
                    </div>

                    <section v-for="(block, index) in blocks" :key="block.id || index" class="mb-5">
                        <component 
                            :is="resolveBlock(block.type)" 
                            :data="block.content" 
                        />
                    </section>
                </div>
            </div>
        </div>
    </div>
</template>