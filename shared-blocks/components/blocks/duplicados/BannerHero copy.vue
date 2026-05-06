<script setup lang="ts">
import { ref, onMounted, onUnmounted, computed } from 'vue';
import type { BannerSlide } from '@/types/banner';

// Props: Recibimos el JSON aquí
const props = withDefaults(defineProps<{
  slides: BannerSlide[];
  autoPlayInterval?: number;
}>(), {
  autoPlayInterval: 5000
});

// State
const currentIndex = ref(0);
const timer = ref<ReturnType<typeof setInterval> | null>(null);

// Actions
const nextSlide = () => {
  currentIndex.value = (currentIndex.value + 1) % props.slides.length;
};

const goToSlide = (index: number) => {
  currentIndex.value = index;
  resetTimer();
};

const startTimer = () => {
  timer.value = setInterval(nextSlide, props.autoPlayInterval);
};

const resetTimer = () => {
  if (timer.value) clearInterval(timer.value);
  startTimer();
};

const currentSlideData = computed(() => props.slides[currentIndex.value]);

// Lifecycle
onMounted(() => startTimer());
onUnmounted(() => {
  if (timer.value) clearInterval(timer.value);
});
</script>

<template>
  <section class="banner-container">
    <div class="banner-image-wrapper">
      <Transition name="fade" mode="out-in">
        <img :key="currentSlideData.id" :src="currentSlideData.imageUrl" alt="Banner background" class="bg-image" />
      </Transition>
      <div class="overlay"></div>
    </div>

    <div class="banner-content container">
      <Transition name="slide-up" mode="out-in">
        <div :key="currentSlideData.id" class="content-grid">

          <div v-if="currentSlideData.layout === 'stats-mode' && currentSlideData.stats" class="stats-col">
            <div class="stats-box">
              <span class="stats-number">{{ currentSlideData.stats.number }}</span>
              <span class="stats-label">{{ currentSlideData.stats.label }}</span>
            </div>
          </div>

          <div v-if="currentSlideData.layout === 'standard-mode' && currentSlideData.preTitle" class="pretitle-col">
            <div class="pre-title" v-html="currentSlideData.preTitle"></div>
          </div>

          <div class="main-text-col">
            <h1 class="main-title" v-html="currentSlideData.title"></h1>

            <a :href="currentSlideData.action.url" class="theme-button">
              {{ currentSlideData.action.label }}
            </a>
          </div>

        </div>
      </Transition>
    </div>

    <div class="banner-pagination">
      <button v-for="(slide, index) in slides" :key="slide.id" :class="{ active: index === currentIndex }"
        @click="goToSlide(index)"></button>
    </div>
  </section>
</template>



<style scoped>
/* Variables para facilitar cambios de tema */
:root {
  --banner-height: 442.8px;
  --primary-color: #ff6b00;
  /* Color de ejemplo */
  --text-color: #ffffff;
}

.banner-container {
  position: relative;
  height: 442.8px;
  /* Altura fija según tu HTML original */
  width: 100%;
  overflow: hidden;
  display: flex;
  align-items: center;
  background-color: #222;
}

/* Manejo de Imágenes */
.banner-image-wrapper {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 1;
}

.bg-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  /* Reemplaza el cálculo manual de width/height del JS antiguo */
  position: absolute;
}

.overlay {
  position: absolute;
  inset: 0;
  background: rgba(0, 0, 0, 0.3);
  /* Simula el camera_overlayer */
  z-index: 2;
}

/* Contenido */
.banner-content {
  position: relative;
  z-index: 10;
  width: 100%;
  max-width: 1200px;
  margin: 0 auto;
  padding: 0 15px;
  color: var(--text-color);
}

.content-grid {
  display: flex;
  align-items: center;
  gap: 2rem;
}

/* Estilos Específicos Layout 1 */
.stats-col {
  flex: 0 0 auto;
}

.stats-box {
  border: 2px solid white;
  padding: 1rem;
  text-align: center;
}

.stats-number {
  display: block;
  font-size: 3rem;
  font-weight: bold;
  line-height: 1;
}

.stats-label {
  font-size: 0.9rem;
  letter-spacing: 2px;
}

/* Estilos Específicos Layout 2 */
.pretitle-col {
  width: 100%;
  text-align: center;
  position: absolute;
  top: -60px;
  /* Ajuste visual aproximado */
  left: 0;
}

.pre-title {
  font-size: 1.5rem;
  margin-bottom: 1rem;
}

.main-text-col {
  flex: 1;
}

.main-title {
  font-size: 2.5rem;
  font-weight: 700;
  line-height: 1.2;
  margin-bottom: 2rem;
  white-space: pre-line;
  /* Respeta los saltos de línea */
}

.theme-button {
  display: inline-block;
  padding: 12px 30px;
  background-color: transparent;
  border: 2px solid #fff;
  color: #fff;
  text-decoration: none;
  font-weight: 600;
  transition: all 0.3s ease;
}

.theme-button:hover {
  background-color: #fff;
  color: #000;
}

/* Paginación */
.banner-pagination {
  position: absolute;
  bottom: 20px;
  left: 50%;
  transform: translateX(-50%);
  z-index: 20;
  display: flex;
  gap: 10px;
}

.banner-pagination button {
  width: 12px;
  height: 12px;
  border-radius: 50%;
  border: none;
  background: rgba(255, 255, 255, 0.5);
  cursor: pointer;
}

.banner-pagination button.active {
  background: white;
  transform: scale(1.2);
}

/* Vue Transitions */
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.8s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}

.slide-up-enter-active {
  transition: all 0.8s ease-out;
}

.slide-up-leave-active {
  transition: all 0.5s ease-in;
  opacity: 0;
}

.slide-up-enter-from {
  transform: translateY(30px);
  opacity: 0;
}

.slide-up-leave-to {
  transform: translateY(-30px);
  opacity: 0;
}
</style>