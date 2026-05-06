<script setup lang="ts">
import { computed } from 'vue';
import { formatImageUrl } from '@/helpers/url';

interface Props {
  data: {
    category: string;
    title: string;
    subtitle: string;
    imageUrl: string;
    content: string;
    author: string;
    authorRole: string;
    authorImage?: string;
    date: string;
    readTime: string;
    accentColor?: string;
  };
  isEditor?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  isEditor: false
});

const themeColor = computed(() => props.data.accentColor || '#e63946');
</script>

<template>
  <div class="article-landing" :class="{ 'editor-mode': isEditor }">
    
    <header class="article-hero position-relative overflow-hidden">
      <div 
        class="hero-bg" 
        :style="{ backgroundImage: `url(${formatImageUrl(data.imageUrl) || 'https://images.unsplash.com/photo-1504711434969-e33886168f5c?auto=format&fit=crop&q=80&w=1920'})` }"
      ></div>
      <div class="hero-overlay"></div>
      
      <div class="container h-100 position-relative z-2 d-flex flex-column justify-content-end pb-5">
        <div class="col-lg-10 col-xl-8 animate-slide-up">
          <span class="category-pill" :style="{ backgroundColor: themeColor }">
            {{ data.category }}
          </span>
          <h1 class="display-3 fw-bold text-white mt-3 mb-4 text-balance" v-html="data.title"></h1>
          <p class="subtitle-lead" v-if="data.subtitle">{{ data.subtitle }}</p>
          
          <div class="meta-container d-flex align-items-center gap-4 mt-5 pt-4 border-top border-white border-opacity-25">
            <div class="d-flex align-items-center gap-3">
              <img :src="data.authorImage || `https://ui-avatars.com/api/?name=${data.author}&background=random`" class="author-avatar">
              <div class="text-white">
                <div class="fw-bold">{{ data.author }}</div>
                <div class="small opacity-75">{{ data.authorRole }}</div>
              </div>
            </div>
            <div class="text-white d-none d-sm-block">
              <div class="small opacity-50 text-uppercase ls-wide">Publicado</div>
              <div class="fw-bold">{{ data.date }}</div>
            </div>
            <div class="text-white">
              <div class="small opacity-50 text-uppercase ls-wide">Lectura</div>
              <div class="fw-bold">{{ data.readTime }}</div>
            </div>
          </div>
        </div>
      </div>
    </header>

    <section class="article-content-wrapper py-5">
      <div class="container">
        <div class="row justify-content-center">
          
          <div class="col-lg-1 d-none d-lg-block">
            <div class="sticky-top pt-4 share-sidebar">
              <button class="btn-share"><i class="lab la-facebook-f"></i></button>
              <button class="btn-share"><i class="lab la-twitter"></i></button>
              <button class="btn-share"><i class="lab la-linkedin-in"></i></button>
              <div class="share-line"></div>
            </div>
          </div>

          <div class="col-lg-8 col-xl-7">
            <div class="rich-text-content" :style="{ '--accent': themeColor }" v-html="data.content"></div>
            
            <footer class="mt-5 pt-5 border-top">
              <div class="p-4 rounded-4 bg-light d-flex align-items-center justify-content-between flex-wrap gap-3">
                <h5 class="m-0 fw-bold">¿Te resultó útil esta información?</h5>
                <div class="d-flex gap-2">
                  <button class="btn btn-outline-dark rounded-pill px-4">Sí, gracias</button>
                  <button class="btn btn-outline-dark rounded-pill px-4">No exactamente</button>
                </div>
              </div>
            </footer>
          </div>

        </div>
      </div>
    </section>

  </div>
</template>

<style scoped lang="scss">
.article-landing {
  background: white;

  &.editor-mode {
    .article-hero { height: 400px; min-height: 400px; }
    .display-3 { font-size: 2rem !important; }
    .subtitle-lead { font-size: 1rem !important; }
    .article-content-wrapper { padding: 20px 0; }
  }
}

.article-hero {
  height: 90vh;
  min-height: 650px;
  color: white;

  .hero-bg {
    position: absolute;
    inset: 0;
    background-size: cover;
    background-position: center;
    transform: scale(1.05);
    transition: transform 10s ease-out;
  }
  
  .hero-overlay {
    position: absolute;
    inset: 0;
    background: linear-gradient(180deg, rgba(0,0,0,0.2) 0%, rgba(0,0,0,0.95) 100%);
  }
}

.category-pill {
  padding: 6px 20px;
  border-radius: 50px;
  font-weight: 800;
  font-size: 0.75rem;
  letter-spacing: 2px;
  text-transform: uppercase;
}

.subtitle-lead {
  font-size: 1.5rem;
  font-weight: 300;
  line-height: 1.5;
  color: rgba(255,255,255,0.8);
}

.author-avatar {
  width: 55px;
  height: 55px;
  border-radius: 50%;
  object-fit: cover;
  border: 3px solid rgba(255,255,255,0.1);
}

.ls-wide { letter-spacing: 1px; }

// ESTILOS DE LECTURA (Rich Text)
.rich-text-content {
  font-family: 'Georgia', serif; // Fuente serif para lectura larga
  font-size: 1.25rem;
  line-height: 1.8;
  color: #1a1a1a;

  :deep(h2) {
    font-family: 'Inter', sans-serif;
    font-weight: 800;
    font-size: 2.2rem;
    margin-top: 3.5rem;
    margin-bottom: 1.5rem;
    color: var(--accent);
  }

  :deep(p) { margin-bottom: 2rem; }

  :deep(blockquote) {
    font-size: 1.8rem;
    font-style: italic;
    color: #444;
    border-left: 8px solid var(--accent);
    padding: 2rem 3rem;
    margin: 3rem 0;
    background: #fdfdfd;
    line-height: 1.3;
  }

  :deep(img) {
    width: 100%;
    border-radius: 16px;
    margin: 3rem 0;
    box-shadow: 0 20px 40px rgba(0,0,0,0.1);
  }
}

// Sidebar Share
.share-sidebar {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 15px;

  .btn-share {
    width: 45px;
    height: 45px;
    border-radius: 50%;
    border: 1px solid #eee;
    background: white;
    color: #666;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s;
    &:hover { background: #000; color: white; border-color: #000; }
  }

  .share-line {
    width: 1px;
    height: 100px;
    background: #eee;
  }
}

// Animaciones
.animate-slide-up {
  animation: slideUp 0.8s cubic-bezier(0.165, 0.84, 0.44, 1) forwards;
}

@keyframes slideUp {
  from { opacity: 0; transform: translateY(40px); }
  to { opacity: 1; transform: translateY(0); }
}
</style>