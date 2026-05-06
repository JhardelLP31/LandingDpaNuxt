<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import HttpClient from "@/helpers/http-client";
import { formatImageUrl } from '@/helpers/url';

// --- INTERFACES ---
interface Post {
  id: number;
  title: string;
  slug: string;
  image: string;
  excerpt: string;
  tags: string[];
  author: string;
  authorAvatar?: string;
  date: string;
  readTime: string;
}

// Límite 7 para asegurar que haya scroll si hay noticias
const props = withDefaults(defineProps<{ title?: string; limit?: number; }>(), {
  title: "Actualidad & Tendencias", limit: 7 
});

const rawPosts = ref<any[]>([]);
const loading = ref(true);

onMounted(async () => {
  try {
    const response = await HttpClient.get(`news-public?limit=${props.limit}`);
    rawPosts.value = response.data.pages?.data || response.data.data || response.data || [];
  } catch (e) { console.error(e); } finally { loading.value = false; }
});

const mappedPosts = computed<Post[]>(() => {
  const posts = rawPosts.value || [];
  return posts.map(post => {
    let blocks: any = {};
    try {
        if (post.content_blocks) blocks = typeof post.content_blocks === 'string' ? JSON.parse(post.content_blocks) : post.content_blocks;
    } catch (e) {}
    
    const extra = blocks.extra || {};
    const authorInfo = blocks.author || {};
    let date = post.created_at ? new Date(post.created_at).toLocaleDateString('es-ES', { day: '2-digit', month: 'short' }) : '';

    return {
      id: post.id,
      title: post.title,
      slug: post.slug,
      image: post.featured_image_path,
      excerpt: post.excerpt,
      tags: (extra.tags && extra.tags.length) ? extra.tags : ['Noticias'],
      author: authorInfo.name || post.author || 'Redacción',
      authorAvatar: authorInfo.avatar,
      date: date,
      readTime: extra.read_time || '3 min'
    };
  });
});

// --- SEPARACIÓN JERÁRQUICA ---
const heroPost = computed(() => mappedPosts.value[0]); 
const sidePosts = computed(() => mappedPosts.value.slice(1)); // El resto va al scroll

const resolveAvatar = (post: Post) => post.authorAvatar ? formatImageUrl(post.authorAvatar) : `https://ui-avatars.com/api/?name=${encodeURIComponent(post.author)}&background=random&color=fff`;
</script>

<template>
  <div class="bento-section">
    <div class="container">
      
      <div class="d-flex justify-content-between align-items-end mb-4 border-bottom pb-3" style="border-color: #eee;">
        <div>
            <span class="text-uppercase fw-bold text-muted small ls-2 mb-1 d-block">Publicaciones Recientes</span>
            <h2 class="display-4 fw-bold m-0 lh-1 esan-title">{{ title }}</h2>
        </div>
        
        
      </div>

      <div v-if="loading" class="py-5 text-center"><div class="spinner-border text-danger"></div></div>

      <div v-else-if="heroPost" class="bento-grid">
        
        <router-link :to="`/noticias/view-detail/${heroPost.slug}`" class="hero-card">
          <div class="hero-bg-wrapper">
             <img :src="formatImageUrl(heroPost.image)" class="hero-img" loading="lazy">
             <div class="hero-overlay"></div>
          </div>
          
          <div class="hero-content">
             <div class="mb-3">
                 <span class="badge-tech">{{ heroPost.tags[0] }}</span>
             </div>
             <h3 class="hero-title">{{ heroPost.title }}</h3>
             <p class="hero-excerpt">{{ heroPost.excerpt }}</p>
             
             <div class="hero-meta">
                <img :src="resolveAvatar(heroPost)" class="hero-avatar">
                <div class="d-flex flex-column text-white">
                    <span class="fw-bold text-uppercase fs-xs">{{ heroPost.author }}</span>
                    <span class="text-white-50 fs-xs">{{ heroPost.date }} • {{ heroPost.readTime }}</span>
                </div>
             </div>
          </div>
        </router-link>

        <div class="side-stack-container">
            <div class="side-stack">
               <router-link v-for="post in sidePosts" :key="post.id" :to="`/noticias/${post.slug}`" class="side-card">
                  <div class="side-img-box">
                      <img :src="formatImageUrl(post.image)" class="side-img" loading="lazy">
                  </div>
                  <div class="side-content">
                      <div class="d-flex align-items-center gap-2 mb-1">
                          <span class="side-tag">{{ post.tags[0] }}</span>
                          <span class="side-date">{{ post.date }}</span>
                      </div>
                      <h4 class="side-title">{{ post.title }}</h4>
                      <span class="read-link">Leer nota <i class="las la-long-arrow-alt-right"></i></span>
                  </div>
               </router-link>
            </div>
            <div class="scroll-fade"></div>
        </div>

      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
/* --- TUS VARIABLES ESAN --- */
$esan-red: #e31140;
$esan-black: #000000;
$esan-dark-gray: #333333;
$esan-light-gray: #E6E7E8;
$esan-white: #FFFFFF;

.fs-xs { font-size: 0.75rem; letter-spacing: 0.5px; }
.ls-2 { letter-spacing: 2px; }

.bento-section {
    padding: 80px 0;
    background: $esan-white; /* Fondo Blanco Puro */
    color: $esan-black;
}

/* Título ESAN Rojo */
.esan-title {
    color: $esan-red;
    letter-spacing: -1px;
}

.link-arrow {
    text-decoration: none; color: $esan-dark-gray; font-weight: 700; font-size: 0.95rem;
    transition: 0.3s;
    &:hover { color: $esan-red; }
}

/* --- GRID LAYOUT --- */
.bento-grid {
    display: grid;
    grid-template-columns: 1.6fr 1fr; /* 60% - 40% */
    gap: 30px;
    height: 600px; /* ALTURA FIJA PARA SCROLL */
}

/* --- HERO CARD --- */
.hero-card {
    position: relative; display: block; height: 100%; border-radius: 20px;
    overflow: hidden; text-decoration: none; color: white;
    box-shadow: 0 10px 30px rgba(0,0,0,0.1);
    
    .hero-bg-wrapper { position: absolute; inset: 0; width: 100%; height: 100%; z-index: 0; }
    .hero-img { width: 100%; height: 100%; object-fit: cover; transition: transform 1.2s cubic-bezier(0.215, 0.610, 0.355, 1.000); }
    .hero-overlay { position: absolute; inset: 0; background: linear-gradient(0deg, rgba(0,0,0,0.95) 0%, rgba(0,0,0,0.4) 50%, rgba(0,0,0,0.1) 100%); z-index: 1; }
    
    .hero-content {
        position: relative; z-index: 2; height: 100%; display: flex; flex-direction: column; justify-content: flex-end; padding: 40px;
    }
    .badge-tech { background: $esan-red; color: white; padding: 6px 12px; font-weight: 800; text-transform: uppercase; font-size: 0.7rem; letter-spacing: 1px; border-radius: 4px; }
    .hero-title { font-size: 2.8rem; font-weight: 800; line-height: 1.1; margin-bottom: 15px; text-shadow: 0 4px 10px rgba(0,0,0,0.3); }
    .hero-excerpt { font-size: 1.1rem; color: rgba(255,255,255,0.9); line-height: 1.6; max-width: 90%; margin-bottom: 30px; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
    
    .hero-meta { display: flex; align-items: center; gap: 15px; border-top: 1px solid rgba(255,255,255,0.2); padding-top: 20px; .hero-avatar { width: 45px; height: 45px; border-radius: 50%; border: 2px solid white; } }
    

&:hover {
    .hero-img { 
        transform: scale(1.08); 
    }
    .hero-overlay {
        /* Hacemos el overlay un poco más oscuro al pasar el mouse */
        background: linear-gradient(0deg, rgba(0,0,0,0.95) 0%, rgba(0,0,0,0.6) 50%, rgba(0,0,0,0.2) 100%);
    }
    .hero-title { 
        /* Desplazamiento lateral sutil */
        transform: translateX(5px); 
    }
}
}

/* --- SIDE STACK SCROLLABLE --- */
.side-stack-container {
    position: relative;
    height: 100%;
    overflow: hidden; 
}

.side-stack {
    height: 100%;
    overflow-y: auto;
    padding-right: 12px;
    display: flex; flex-direction: column; gap: 20px;
    
    &::-webkit-scrollbar { width: 6px; }
    &::-webkit-scrollbar-track { background: #f1f1f1; border-radius: 4px; }
    &::-webkit-scrollbar-thumb { background: #ccc; border-radius: 4px; }
    &::-webkit-scrollbar-thumb:hover { background: $esan-red; } /* Detalle en rojo al hover */
}

/* Gradiente blanco puro para fundirse con el fondo */
.scroll-fade {
    position: absolute; bottom: 0; left: 0; right: 0; height: 80px;
    background: linear-gradient(to bottom, transparent, $esan-white);
    pointer-events: none; z-index: 5;
}

.side-card {
    flex-shrink: 0;
    min-height: 140px;
    display: flex; gap: 20px;
    background: #fcfcfc; /* Un gris casi blanco para diferenciar */
    border-radius: 16px; padding: 15px;
    text-decoration: none; transition: all 0.3s ease; border: 1px solid transparent;

    .side-img-box { width: 140px; min-width: 140px; height: 100%; border-radius: 12px; overflow: hidden; position: relative; }
    .side-img { width: 100%; height: 100%; object-fit: cover; transition: transform 0.5s; }
    .side-content { display: flex; flex-direction: column; justify-content: center; width: 100%; }
    .side-tag { font-size: 0.7rem; font-weight: 800; color: $esan-red; text-transform: uppercase; }
    .side-date { font-size: 0.75rem; color: #999; font-weight: 600; }
    .side-title { font-size: 1.05rem; font-weight: 700; color: $esan-black; margin: 5px 0 10px 0; line-height: 1.3; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
    .read-link { font-size: 0.85rem; font-weight: 700; color: $esan-dark-gray; display: flex; align-items: center; gap: 5px; transition: gap 0.3s; }

    &:hover {
        background: $esan-white; border-color: $esan-light-gray; 
        box-shadow: 0 10px 30px rgba(0,0,0,0.08); transform: translateX(-5px);
        .side-img { transform: scale(1.1); }
        .read-link { color: $esan-red; gap: 10px; }
    }
}

@media (max-width: 992px) {
    .bento-grid { grid-template-columns: 1fr; height: auto; }
    .hero-card { min-height: 450px; }
    .side-stack-container { height: auto; overflow: visible; }
    .side-stack { height: auto; overflow-y: visible; padding-right: 0; }
    .scroll-fade { display: none; }
}
</style>