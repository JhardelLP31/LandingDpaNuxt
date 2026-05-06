<script setup lang="ts">
import { computed } from 'vue';
import { formatImageUrl } from '@/helpers/url';
interface Article {
  category: string;
  title: string;
  excerpt?: string;
  imageUrl: string;
  date: string;
  readTime: string;
  author: string;
  link: string;
}

const props = withDefaults(defineProps<{
  data: {
    sectionTitle?: string;
    articles: Article[];
  },
  isEditor?: boolean
}>(), {
  isEditor: false
});

// Tomamos las primeras 3 noticias para el Mega Grid
const featured = computed(() => props.data.articles?.[0]);
const secondaries = computed(() => props.data.articles?.slice(1, 3) || []);
</script>

<template>
  <section class="news-mega-engine" :class="{ 'editor-mode': isEditor }">
    <div :class="isEditor ? 'px-2' : 'container'">
      
      <div v-if="props.data.sectionTitle" class="d-flex align-items-center mb-4 gap-3">
        <h2 class="section-title-line m-0">{{ props.data.sectionTitle }}</h2>
        <div class="flex-grow-1 border-bottom opacity-25"></div>
      </div>

      <div class="news-grid" v-if="props.data.articles?.length > 0">
        
        <div class="grid-main" v-if="featured">
          <a :href="featured.link" class="news-card main-card">
            <div class="card-bg" :style="{ backgroundImage: `url(${formatImageUrl(featured.imageUrl)})` }"></div>
            <div class="card-overlay"></div>
            <div class="card-content">
              <span class="badge-category">{{ featured.category }}</span>
              <h1 class="main-title" v-html="featured.title"></h1>
              <p class="excerpt d-none d-md-block">{{ featured.excerpt }}</p>
              <div class="meta-info">
                <span><i class="las la-user"></i> {{ featured.author }}</span>
                <span><i class="las la-calendar"></i> {{ featured.date }}</span>
                <span><i class="las la-clock"></i> {{ featured.readTime }}</span>
              </div>
            </div>
          </a>
        </div>

        <div class="grid-side">
          <div v-for="(article, idx) in secondaries" :key="idx" class="side-item">
            <a :href="article.link" class="news-card side-card">
              <div class="card-bg" :style="{ backgroundImage: `url(${formatImageUrl(article.imageUrl)})` }"></div>
              <div class="card-overlay"></div>
              <div class="card-content">
                <span class="badge-category small">{{ article.category }}</span>
                <h3 class="side-title" v-html="article.title"></h3>
                <div class="meta-info small">
                  <span>{{ article.date }}</span>
                </div>
              </div>
            </a>
          </div>
        </div>

      </div>
    </div>
  </section>
</template>

<style scoped lang="scss">
.news-mega-engine {
  padding: 40px 0;
  background-color: #fcfcfc;

  &.editor-mode {
    padding: 10px 0;
    .main-title { font-size: 1.2rem !important; }
    .side-title { font-size: 0.9rem !important; }
    .excerpt, .meta-info { display: none !important; }
    .news-grid { height: auto !important; gap: 10px; }
  }
}

.news-grid {
  display: grid;
  grid-template-columns: 1.8fr 1fr;
  gap: 20px;
  height: 550px;

  @media (max-width: 992px) {
    grid-template-columns: 1fr;
    height: auto;
  }
}

.grid-side {
  display: flex;
  flex-direction: column;
  gap: 20px;
}

.news-card {
  position: relative;
  display: block;
  width: 100%;
  height: 100%;
  border-radius: 12px;
  overflow: hidden;
  text-decoration: none;
  color: white;

  .card-bg {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-size: cover;
    background-position: center;
    transition: transform 0.6s cubic-bezier(0.165, 0.84, 0.44, 1);
  }

  &:hover .card-bg {
    transform: scale(1.05);
  }

  .card-overlay {
    position: absolute;
    inset: 0;
    background: linear-gradient(to top, rgba(0,0,0,0.9) 0%, rgba(0,0,0,0.4) 50%, transparent 100%);
    z-index: 1;
  }

  .card-content {
    position: absolute;
    bottom: 0;
    padding: 25px;
    z-index: 2;
    width: 100%;
  }
}

.main-card {
  height: 100%;
  min-height: 400px;
}

.side-item {
  flex: 1;
  min-height: 250px;
}

// Tipografía y Badges
.section-title-line {
  font-weight: 800;
  text-transform: uppercase;
  letter-spacing: -1px;
  color: #1a1a1a;
}

.badge-category {
  background: #e63946; // Color de acento (News Red)
  color: white;
  padding: 4px 12px;
  font-size: 0.7rem;
  font-weight: 700;
  text-transform: uppercase;
  border-radius: 4px;
  margin-bottom: 12px;
  display: inline-block;
}

.main-title {
  font-size: 2.5rem;
  font-weight: 800;
  line-height: 1.1;
  margin-bottom: 15px;
}

.side-title {
  font-size: 1.25rem;
  font-weight: 700;
  line-height: 1.2;
}

.excerpt {
  font-size: 1rem;
  color: rgba(255,255,255,0.8);
  margin-bottom: 20px;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
}

.meta-info {
  display: flex;
  gap: 15px;
  font-size: 0.8rem;
  opacity: 0.8;
  span { display: flex; align-items: center; gap: 5px; }
}
</style>