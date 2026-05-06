<template>
    <TheHeader2 />
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
    <TheFooter />
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import HttpClient from "@/helpers/http-client";
import TheFooter from '@/components/layout/TheFooter.vue';
import TheHeader2 from '@/components/layout/TheHeader2.vue';

// Importamos el resolutor que creamos anteriormente
import { resolveBlock } from '@/core/BlockRegistry'; 

const route = useRoute();
const post = ref<any>({});
const blocks = ref<any[]>([]);
const loading = ref(true);

onMounted(async () => {
    try {
        const slug = route.params.slug;
        
        // CORRECCIÓN 1: Usar el endpoint de cursos, no de páginas
        const { data } = await HttpClient.get(`courses/${slug}`);
        
        // Laravel a veces devuelve { data: { ... } } o directo { ... }
        const loadedPost = data.data || data; 
        post.value = loadedPost;

        // CORRECCIÓN 2: Procesamiento robusto de bloques
        if (loadedPost.content_blocks) {
            // Si viene como string (JSON viejo), lo parseamos. Si ya es Array (JSON nuevo), lo usamos.
            const rawBlocks = typeof loadedPost.content_blocks === 'string' 
                ? JSON.parse(loadedPost.content_blocks) 
                : loadedPost.content_blocks;
            
            // Asignamos a la variable reactiva
            blocks.value = Array.isArray(rawBlocks) ? rawBlocks : [];
        }

        console.log("Bloques cargados para vista pública:", blocks.value);

    } catch (e) {
        console.error("Error cargando curso:", e);
        // Opcional: Redirigir a 404 si falla
    } finally {
        loading.value = false;
    }
});
</script>