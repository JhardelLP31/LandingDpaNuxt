<script setup lang="ts">
import { ref, onMounted, watch, computed } from 'vue';
import { useRoute } from 'vue-router';
import HttpClient from "@/helpers/http-client";
import { formatImageUrl } from '@/helpers/url';



const route = useRoute();
const loading = ref(true);
const post = ref<any>({});
const categoryName = ref('BLOG');

// --- 1. LÓGICA DE CARGA (TU API) ---
const fetchArticle = async () => {
    loading.value = true;
    window.scrollTo({ top: 0, behavior: 'instant' });

    try {
        const slug = route.params.slug;
        // Petición a la ruta pública correcta
        const { data } = await HttpClient.get(`public/news/${slug}`);
        const apiData = data.post || data.data || data;

        let blocks: any = {};
        if (apiData.content_blocks) {
            blocks = typeof apiData.content_blocks === 'string'
                ? JSON.parse(apiData.content_blocks)
                : apiData.content_blocks;
        }

        post.value = {
            title: apiData.title,
            slug: apiData.slug,
            type: apiData.type,
            subtitle: apiData.excerpt,
            imageUrl: apiData.featured_image_path,
            content: blocks.html || apiData.content || '',
            date: apiData.start_date || apiData.start_date,
            formattedDate: new Date(apiData.start_date || apiData.start_date).toLocaleDateString('es-ES', { day: 'numeric', month: 'long', year: 'numeric' }),
            author: blocks.author?.name || apiData.author || 'Redacción ESAN',
            authorAvatar: blocks.author?.avatar,
            authorRole: blocks.author?.role || 'Colaborador',
            readTime: blocks.extra?.read_time || '5 min',
            tags: blocks.extra?.tags || []
        };

        if (apiData.categories?.[0]) categoryName.value = apiData.categories[0].name;
        document.title = `${post.value.title} | Noticias ESAN`;

    } catch (e) {
        console.error("Error cargando noticia:", e);
    } finally {
        loading.value = false;
    }
};

onMounted(() => fetchArticle());
watch(() => route.params.slug, (val, old) => { if (val && val !== old) fetchArticle() });

// --- 2. LINKS COMPARTIR ---
const currentUrl = computed(() => window.location.href);
const shareLinks = computed(() => {
    const url = encodeURIComponent(currentUrl.value);

    const title = encodeURIComponent('Te comparto' + (post.value.type === 'news' ? ' está interesante Noticia:' : ' este interesante Evento: ') + post.value.title);


    console.log(title);
    return {
        facebook: `https://www.facebook.com/sharer/sharer.php?u=${url}`,
        twitter: `https://twitter.com/intent/tweet?url=${url}&text=${title}`,
        linkedin: `https://www.linkedin.com/shareArticle?mini=true&url=${url}&title=${title}`,
        whatsapp: `https://api.whatsapp.com/send?text=${title}%20${url}`
    };
});

// Avatar helper
const avatarUrl = computed(() => {
    return post.value.authorAvatar
        ? formatImageUrl(post.value.authorAvatar)
        : `https://ui-avatars.com/api/?name=${encodeURIComponent(post.value.author || 'U')}&background=e31140&color=fff`;
});
</script>

<template>
    <div class="page-wrapper">

        <div v-if="loading" class="loading-screen">
            <div class="spinner-border text-danger" role="status"></div>
        </div>

        <div v-else class="main-content">

            <div class="hero-bg-container">
                <div class="hero-image"
                    :style="{ backgroundImage: post.imageUrl ? `url(${formatImageUrl(post.imageUrl)})` : 'none' }">
                </div>
                <div class="hero-gradient"></div>

                <div
                    class="container h-100 position-relative z-2 d-flex align-items-center justify-content-center pt-5">
                    <div class="text-center text-white hero-text-box">
                        <span class="badge-category mb-3">{{ post.type === 'news' ? 'Noticias' : 'Eventos' }}</span>

                        <h1 class="display-4 fw-bold mb-4">{{ post.title }}</h1>

                        <div
                            class="d-flex justify-content-center gap-4 text-white-50 small text-uppercase ls-2 fw-bold">
                            <span><i class="las la-calendar me-1"></i> {{ post.formattedDate }}</span>
                            <span><i class="las la-clock me-1"></i> {{ post.readTime }} lectura</span>
                        </div>
                    </div>
                </div>
            </div>

            <div class="container floating-container">
                <div class="paper-card">
                    <div class="row g-0 justify-content-center">

                        <div class="col-lg-1 d-none d-lg-block relative-sidebar">
                            <div class="sticky-share">
                                <a :href="shareLinks.facebook" target="_blank" class="share-icon"><i
                                        class="lab la-facebook-f"></i></a>
                                <a :href="shareLinks.twitter" target="_blank" class="share-icon"><i
                                        class="lab la-twitter"></i></a>
                                <a :href="shareLinks.linkedin" target="_blank" class="share-icon"><i
                                        class="lab la-linkedin-in"></i></a>
                                <a :href="shareLinks.whatsapp" target="_blank" class="share-icon"><i
                                        class="lab la-whatsapp"></i></a>
                            </div>
                        </div>

                        <div class="col-lg-9 col-xl-8">
                            <div class="article-padding">

                                <div class="d-flex align-items-center mb-5 pb-4 border-bottom">
                                    <img :src="avatarUrl" class="author-avatar me-3">
                                    <div>
                                        <h6 class="fw-bold m-0 text-dark">{{ post.author }}</h6>
                                        <span class="small text-muted">{{ post.authorRole }}</span>
                                    </div>
                                </div>

                                <p class="lead fw-normal text-secondary mb-5 fst-italic" v-if="post.subtitle">
                                    {{ post.subtitle }}
                                </p>

                                <div class="article-body ql-editor" v-html="post.content"></div>

                                <div class="mt-5 pt-4 border-top" v-if="post.tags && post.tags.length">
                                    <div class="d-flex flex-wrap gap-2">
                                        <span v-for="tag in post.tags" :key="tag" class="tag-badge">#{{ tag
                                        }}</span>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>

        </div>

    </div>
</template>

<style scoped lang="scss">
$esan-red: #e31140;

/* Estructura Flex para Footer Sticky Natural */
.page-wrapper {
    display: flex;
    flex-direction: column;
    min-height: 100vh;
    background-color: #f8f9fa;
    /* Fondo gris claro detrás de todo */
}

.main-content {
    flex: 1;
}

.loading-screen {
    min-height: 80vh;
    display: flex;
    align-items: center;
    justify-content: center;
}

/* HERO */
.hero-bg-container {
    position: relative;
    height: 65vh;
    /* Altura dramática */
    background: #111;
    overflow: hidden;
}

.hero-image {
    position: absolute;
    inset: 0;
    background-size: cover;
    background-position: center;
    opacity: 0.5;
    transform: scale(1.05);
}

.hero-gradient {
    position: absolute;
    inset: 0;
    background: linear-gradient(180deg, rgba(0, 0, 0, 0.6) 0%, rgba(0, 0, 0, 0.8) 100%);
}

.hero-text-box {
    max-width: 900px;
    padding-bottom: 80px;
}

/* Padding bottom para que el texto no choque con la tarjeta */

.badge-category {
    background: $esan-red;
    color: white;
    padding: 5px 12px;
    text-transform: uppercase;
    font-size: 0.7rem;
    letter-spacing: 2px;
    font-weight: 800;
}

.ls-2 {
    letter-spacing: 2px;
}

/* TARJETA FLOTANTE (EL TRUCO) */
.floating-container {
    position: relative;
    margin-top: -100px;
    /* Sube la tarjeta sobre el Hero */
    margin-bottom: 80px;
    /* Empuja el footer hacia abajo */
    z-index: 10;
}

.paper-card {
    background: #ffffff;
    border-radius: 12px;
    box-shadow: 0 20px 60px rgba(0, 0, 0, 0.08);
    /* Sombra elegante */
    overflow: hidden;
}

.article-padding {
    padding: 60px 40px;
}

/* SIDEBAR & SHARE */
.relative-sidebar {
    position: relative;
}

.sticky-share {
    position: sticky;
    top: 150px;
    left: 0;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 15px;
    padding-top: 60px;
    /* Alineación visual */
}

.share-icon {
    width: 36px;
    height: 36px;
    border-radius: 50%;
    border: 1px solid #eaeaea;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #999;
    transition: all 0.2s;
    text-decoration: none;

    &:hover {
        color: $esan-red;
        border-color: $esan-red;
        background: #fff5f6;
    }
}

/* CONTENT STYLES */
.author-avatar {
    width: 50px;
    height: 50px;
    border-radius: 50%;
    object-fit: cover;
}

.article-body {
    font-family: 'Merriweather', 'Georgia', serif;
    /* Fuente serif para lectura premium */
    font-size: 1.15rem;
    color: #2c2c2c;
    line-height: 1.9;
}

/* Estilos profundos para el HTML */
.article-body :deep(p) {
    margin-bottom: 1.8rem;
}

.article-body :deep(h2) {
    font-family: 'Inter', sans-serif;
    font-weight: 800;
    margin-top: 3rem;
    margin-bottom: 1rem;
    color: #000;
    letter-spacing: -0.5px;
}

.article-body :deep(h3) {
    font-family: 'Inter', sans-serif;
    font-weight: 700;
    margin-top: 2rem;
    margin-bottom: 1rem;
    color: #333;
}

.article-body :deep(img) {
    max-width: 100%;
    height: auto;
    border-radius: 8px;
    margin: 2rem 0;
    box-shadow: 0 4px 20px rgba(0, 0, 0, 0.05);
}

.article-body :deep(blockquote) {
    border-left: 4px solid $esan-red;
    padding-left: 20px;
    font-style: italic;
    color: #555;
    margin: 2rem 0;
    font-size: 1.25rem;
}

.article-body :deep(a) {
    color: $esan-red;
    text-decoration: underline;
    text-underline-offset: 3px;
    font-weight: 600;
}

.tag-badge {
    background: #f1f3f5;
    color: #555;
    padding: 6px 14px;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 600;
}

/* Responsive */
@media (max-width: 992px) {
    .floating-container {
        margin-top: 0;
        margin-bottom: 40px;
    }

    /* En móvil quitamos el efecto flotante */
    .paper-card {
        border-radius: 0;
        box-shadow: none;
    }

    .hero-bg-container {
        height: 50vh;
    }

    .article-padding {
        padding: 40px 20px;
    }

    .sticky-share {
        display: none;
    }
}
</style>