<script setup lang="ts">
import { computed } from 'vue';

const props = defineProps<{
    data: {
        videos?: Array<{ url: string; title?: string }>; // Array simple
    }
}>();

const gallery = computed(() => {
    const videos = props.data.videos || [];
    // Si está vacío, mostramos unos de ejemplo para que no se vea feo al arrastrar
    if (videos.length === 0) {
        return [
            { url: 'https://www.youtube.com/embed/sqNJsrDAQck', title: 'Video Demo' },
            { url: 'https://www.youtube.com/embed/hQmclCZyy8s', title: 'Video Demo 2' }
        ];
    }
    return videos;
});
</script>

<template>
    <section class="video-gallery-section py-5">
        <div class="container">

            <div class="row g-4 justify-content-center">

                <div v-for="(video, index) in gallery" :key="index" class="col-12 col-md-6 col-lg-5">
                    <div class="card h-100 shadow-sm border-0 video-card">

                        <div class="ratio ratio-16x9 card-img-top bg-dark">
                            <iframe :src="video.url" title="YouTube video" allowfullscreen loading="lazy"
                                class="rounded-top"></iframe>
                        </div>

                    </div>
                </div>

            </div>

        </div>
    </section>
</template>

<style scoped>
.video-gallery-section {
    background-color: #f8f9fa00;
}

/* Efecto visual al pasar el mouse */
.video-card {
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.video-card:hover {
    transform: translateY(-5px);
    /* Se eleva un poco */
    box-shadow: 0 10px 20px rgba(0, 0, 0, 0.15) !important;
    /* Sombra más fuerte */
}
</style>