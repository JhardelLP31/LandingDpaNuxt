<script setup lang="ts">
import { computed } from 'vue';
import { formatImageUrl } from '@/helpers/url';

// --- PROPS (Tal cual las tenías) ---
const props = defineProps<{
  post: {
    title: string;
    subtitle?: string;
    content: string;
    imageUrl: string;
    date: string;
    author: string;
    authorAvatar?: string;
    authorRole?: string; // Agregué esto por si acaso, opcional
    readTime?: string;
    tags?: string[];
  };
  categoryName?: string;
}>();

// --- COMPUTED PARA AVATAR (Para limpiar el template) ---
const avatarUrl = computed(() => {
    return props.post.authorAvatar 
        ? formatImageUrl(props.post.authorAvatar) 
        : `https://ui-avatars.com/api/?name=${encodeURIComponent(props.post.author || 'U')}&background=e31140&color=fff`;
});
</script>

<template>
  <div class="article-preview-wrapper bg-light">
    
    <div class="hero-bg-container">
        <div class="hero-image" 
             :style="{ backgroundImage: post.imageUrl ? `url(${formatImageUrl(post.imageUrl)})` : 'none' }">
        </div>
        <div class="hero-gradient"></div>
        
        <div class="container h-100 position-relative z-2 d-flex align-items-center justify-content-center pt-5">
            <div class="text-center text-white hero-text-box">
                <span class="badge-category mb-3">{{ categoryName || 'BLOG' }}</span>
                
                <h1 class="display-4 fw-bold mb-4 text-white">
                    {{ post.title || 'Escribe un título...' }}
                </h1>
                
                <div class="d-flex justify-content-center gap-4 text-white-50 small text-uppercase ls-2 fw-bold">
                    <span>{{ post.date || 'Fecha' }}</span>
                    <span>{{ post.readTime || 'Lectura' }}</span>
                </div>
            </div>
        </div>
    </div>

    <div class="container floating-container">
        <div class="paper-card mx-auto" style="max-width: 900px;"> <div class="article-padding">
                
                <div class="d-flex align-items-center mb-5 pb-4 border-bottom">
                    <img :src="avatarUrl" class="author-avatar me-3">
                    <div>
                        <h6 class="fw-bold m-0 text-dark">{{ post.author || 'Nombre Autor' }}</h6>
                        <span class="small text-muted">{{ post.authorRole || 'Colaborador' }}</span>
                    </div>
                </div>

                <p class="lead fw-normal text-secondary mb-5 fst-italic" v-if="post.subtitle">
                    {{ post.subtitle }}
                </p>

                <div class="article-body ql-editor" 
                     v-html="post.content || '<p class=\'text-muted text-center py-5\'>El contenido del artículo aparecerá aquí...</p>'">
                </div>

                <div class="mt-5 pt-4 border-top" v-if="post.tags && post.tags.length">
                    <div class="d-flex flex-wrap gap-2">
                        <span v-for="tag in post.tags" :key="tag" class="tag-badge">#{{ tag }}</span>
                    </div>
                </div>

            </div>
        </div>
    </div>

  </div>
</template>

<style scoped lang="scss">
$esan-red: #e31140;

/* --- LAYOUT GENERAL --- */
.article-preview-wrapper {
    width: 100%;
    min-height: 100vh;
    padding-bottom: 80px; /* Espacio al final */
}

/* --- HERO SECTION --- */
.hero-bg-container {
    position: relative;
    height: 500px; /* Altura fija para el preview */
    background: #111;
    overflow: hidden;
}

.hero-image {
    position: absolute; inset: 0; 
    background-size: cover; background-position: center;
    opacity: 0.6; 
    transition: background-image 0.3s ease;
}

.hero-gradient {
    position: absolute; inset: 0;
    background: linear-gradient(180deg, rgba(0,0,0,0.5) 0%, rgba(0,0,0,0.8) 100%);
}

.hero-text-box { 
    max-width: 800px; 
    padding-bottom: 60px; /* Para subir el texto y dejar espacio a la tarjeta */
}

.badge-category {
    background: $esan-red; color: white; padding: 5px 12px; 
    text-transform: uppercase; font-size: 0.7rem; letter-spacing: 2px; font-weight: 800;
    border-radius: 4px;
}
.ls-2 { letter-spacing: 2px; }

/* --- TARJETA FLOTANTE --- */
.floating-container {
    position: relative;
    margin-top: -80px; /* EL TRUCO: Margen negativo para montar sobre el hero */
    z-index: 10;
}

.paper-card {
    background: #ffffff;
    border-radius: 16px;
    box-shadow: 0 20px 60px rgba(0,0,0,0.1);
    overflow: hidden;
}

.article-padding {
    padding: 60px;
}

/* --- ESTILOS DE CONTENIDO --- */
.author-avatar { width: 50px; height: 50px; border-radius: 50%; object-fit: cover; border: 2px solid #eee; }

/* Tipografía Editorial */
.article-body {
    font-family: 'Georgia', 'Times New Roman', serif; /* Fuente Serif elegante */
    font-size: 1.15rem; 
    color: #2c2c2c; 
    line-height: 1.8;
}

/* Estilos profundos para el HTML inyectado */
.article-body :deep(p) { margin-bottom: 1.8rem; }
.article-body :deep(h2) { 
    font-family: sans-serif; 
    font-weight: 800; margin-top: 3rem; margin-bottom: 1rem; 
    color: #000; letter-spacing: -0.5px; 
}
.article-body :deep(h3) { 
    font-family: sans-serif; 
    font-weight: 700; margin-top: 2rem; margin-bottom: 1rem; 
    color: #333; 
}
.article-body :deep(img) { 
    max-width: 100%; height: auto; border-radius: 8px; 
    margin: 2rem 0; box-shadow: 0 4px 20px rgba(0,0,0,0.05); display: block;
}
.article-body :deep(blockquote) { 
    border-left: 4px solid $esan-red; padding-left: 20px; 
    font-style: italic; color: #555; margin: 2rem 0; font-size: 1.2rem; 
}

.tag-badge {
    background: #f1f3f5; color: #555; padding: 6px 14px; border-radius: 20px; 
    font-size: 0.8rem; font-weight: 600;
}

/* Responsive */
@media (max-width: 768px) {
    .hero-bg-container { height: 400px; }
    .floating-container { margin-top: -40px; }
    .paper-card { border-radius: 0; }
    .article-padding { padding: 30px 20px; }
}
</style>