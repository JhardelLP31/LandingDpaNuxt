<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue';
import { formatImageUrl } from '@/helpers/url';

const props = withDefaults(defineProps<{
  data: {
    autoPlayInterval?: number;
    slides: any[];
  },
  isEditor?: boolean
}>(), {
  isEditor: false
});

// --- DATOS POR DEFECTO (Para pruebas, borrar luego si se desea) ---
const defaultSlides = [
    {
        imageUrl: 'https://images.unsplash.com/photo-1522202176988-66273c2fd55f?q=80&w=1920&auto=format&fit=crop',
        preTitle: 'BIENVENIDOS A',
        title: 'INNOVACIÓN <br> DIGITAL',
        btnText: 'DESCUBRIR MÁS',
        btnLink: '#',
        layout: 'standard'
    },
    {
        imageUrl: 'https://images.unsplash.com/photo-1557804506-669a67965ba0?q=80&w=1920&auto=format&fit=crop',
        statsNumber: '15+',
        statsLabel: 'AÑOS DE EXPERIENCIA',
        title: 'LÍDERES EN <br> EL MERCADO',
        btnText: 'CONTÁCTANOS',
        btnLink: '#',
        layout: 'stats-mode'
    }
];

// Computed para usar slides reales o los de defecto
const slidesToDisplay = computed(() => {
    if (props.data.slides && props.data.slides.length > 0) {
        return props.data.slides;
    }
    return defaultSlides;
});

const currentIndex = ref(0);
const timer = ref<any>(null);

// Slide actual basado en la lista computada
const currentSlide = computed(() => slidesToDisplay.value[currentIndex.value] || {});

// Lógica de navegación (Original)
const nextSlide = () => {
  if (slidesToDisplay.value.length) {
    currentIndex.value = (currentIndex.value + 1) % slidesToDisplay.value.length;
  }
};

const goToSlide = (index: number) => {
  currentIndex.value = index;
  resetTimer();
};

const startTimer = () => {
  if (slidesToDisplay.value.length > 1) {
    timer.value = setInterval(nextSlide, props.data.autoPlayInterval || 5000);
  }
};

const resetTimer = () => {
  if (timer.value) clearInterval(timer.value);
  startTimer();
};

onMounted(() => startTimer());
onUnmounted(() => { if (timer.value) clearInterval(timer.value); });
</script>

<template>
  <section 
    class="banner-hero-engine position-relative d-flex align-items-center justify-content-center"
    :class="isEditor ? 'editor-mode' : 'break-out'"
    v-if="slidesToDisplay.length > 0"
  >
    
    <div class="slider-backgrounds position-absolute top-0 start-0 w-100 h-100 overflow-hidden">
      <transition name="fade" mode="out-in">
        <div 
          :key="currentIndex"
          class="slide-img-wrapper position-absolute top-0 start-0 w-100 h-100"
        >
            <div 
                class="slide-img-bg w-100 h-100"
                :class="{ 'ken-burns': !isEditor }"
                :style="{ backgroundImage: `url(${formatImageUrl(currentSlide.imageUrl) || 'https://placehold.co/1920x800'})` }"
            ></div>
        </div>
      </transition>
      
      <div class="banner-overlay position-absolute top-0 start-0 w-100 h-100"></div>
    </div>

    <div :class="isEditor ? 'w-100 px-3' : 'container'" class="position-relative z-content">
      <transition name="slide-up" mode="out-in">
        <div :key="currentIndex" class="content-grid d-flex align-items-center justify-content-center h-100">
          
          <div v-if="currentSlide.layout === 'stats-mode'" class="d-flex align-items-center stats-row">
            <div class="stats-col me-4">
              <div class="stats-box backdrop-blur">
                <span class="stats-number">{{ currentSlide.statsNumber }}</span>
                <span class="stats-label">{{ currentSlide.statsLabel }}</span>
              </div>
            </div>
            <div class="main-text-col text-start">
                <h1 class="main-title text-white fw-bold" v-html="currentSlide.title"></h1>
                <a v-if="currentSlide.btnText" :href="currentSlide.btnLink" class="theme-button mt-4">
                  {{ currentSlide.btnText }}
                </a>
            </div>
          </div>

          <div v-else class="text-center w-100">
             <div v-if="currentSlide.preTitle" class="pretitle-col w-100 text-white text-center mb-3">
                <div class="pre-title glass-badge" v-html="currentSlide.preTitle"></div>
             </div>

             <div class="main-text-col">
                <h1 class="main-title text-white fw-bold" v-html="currentSlide.title"></h1>
                <a v-if="currentSlide.btnText" :href="currentSlide.btnLink" class="theme-button mt-4">
                  {{ currentSlide.btnText }}
                </a>
             </div>
          </div>

        </div>
      </transition>
    </div>

    <div class="wave-bottom position-absolute bottom-0 start-0 w-100">
        <svg viewBox="0 0 1440 320" preserveAspectRatio="none" xmlns="http://www.w3.org/2000/svg">
            <path fill="#ffffff" fill-opacity="1" d="M0,224L48,213.3C96,203,192,181,288,181.3C384,181,480,203,576,224C672,245,768,267,864,261.3C960,256,1056,224,1152,197.3C1248,171,1344,149,1392,138.7L1440,128L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z"></path>
        </svg>
    </div>

    <div class="banner-pagination d-flex justify-content-center position-absolute w-100 z-pagination">
      <button 
        v-for="(_, index) in slidesToDisplay" 
        :key="index"
        :class="{ active: index === currentIndex }"
        @click="goToSlide(index)"
      ></button>
    </div>

  </section>
</template>

<style scoped lang="scss">
// --- CAPAS (Z-INDEX) ---
.z-content { z-index: 10; }
.wave-bottom { z-index: 15; pointer-events: none; }
.z-pagination { z-index: 20; bottom: 130px; } /* Ajustado para la ola */

// --- LÓGICA DE CONTENEDOR (Tu código original) ---
.banner-hero-engine {
  background-color: #222;
  overflow: hidden;
  transition: all 0.3s ease;
  position: relative;
}

// WEB
.break-out {
  width: 100vw;
  position: relative;
  left: 50%;
  right: 50%;
  margin-left: -50vw;
  margin-right: -50vw;
  height: 75vh; // Un poco más alto para lucir la imagen
  min-height: 500px;
}

// EDITOR
.editor-mode {
  width: 100% !important;
  left: 0 !important;
  margin: 0 !important;
  height: 350px; /* Altura ajustada para que quepa la ola en el editor */
  border-radius: 8px;
  box-shadow: inset 0 0 0 1px rgba(255,255,255,0.1);
  border: 1px solid #eee;

  // Escalado de fuentes editor
  .main-title { font-size: 1.5rem !important; margin-bottom: 0.5rem; }
  .pre-title { font-size: 0.6rem !important; padding: 4px 10px !important; }
  .stats-box { padding: 0.5rem !important; min-width: 90px !important; }
  .stats-number { font-size: 1.8rem !important; }
  .stats-label { font-size: 0.5rem !important; }
  .theme-button { padding: 6px 15px !important; font-size: 0.65rem !important; margin-top: 5px !important; }
  
  // Ajuste de ola en editor
  .wave-bottom svg { height: 60px; }
  .z-pagination { bottom: 10px; }
}

// --- IMAGEN DE FONDO Y ANIMACIÓN KEN BURNS ---
.slide-img-bg {
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  width: 100%;
  height: 100%;
}

.ken-burns {
    animation: kenBurns 20s ease-out infinite alternate;
}

@keyframes kenBurns {
    0% { transform: scale(1); }
    100% { transform: scale(1.15); }
}

.banner-overlay {
  // Degradado un poco más intenso abajo para resaltar la ola blanca
  background: linear-gradient(to bottom, rgba(0,0,0,0.4) 0%, rgba(0,0,0,0.6) 100%);
  z-index: 1;
}

// --- OLA (WAVE) ---
.wave-bottom {
    line-height: 0;
    width: 100%;
    svg {
        display: block;
        width: 100%;
        height: 220px; // Altura en web
    }
}

// --- TEXTOS Y CONTENIDO ---
.main-title {
  font-size: clamp(2rem, 4.5vw, 4rem);
  line-height: 1.1;
  text-shadow: 0 4px 15px rgba(0,0,0,0.6);
}

// Badges y Pre-títulos
.glass-badge {
    background: rgba(255, 255, 255, 0.2);
    backdrop-filter: blur(4px);
    padding: 8px 20px;
    border-radius: 50px;
    display: inline-block;
    border: 1px solid rgba(255, 255, 255, 0.3);
    font-size: 0.8rem;
    letter-spacing: 2px;
    font-weight: 600;
}

// Stats Box (Mejorada visualmente)
.stats-box {
  border: 1px solid rgba(255,255,255,0.5);
  background: rgba(0,0,0,0.3); // Semi transparente
  backdrop-filter: blur(5px);
  padding: 1.5rem;
  text-align: center;
  min-width: 140px;
  border-radius: 8px;
  
  .stats-number { display: block; color: white; font-size: 3.5rem; font-weight: 800; line-height: 1; }
  .stats-label { font-size: 0.8rem; color: rgba(255,255,255,0.9); letter-spacing: 1px; text-transform: uppercase; margin-top: 5px; display: block; }
}

// Botón
.theme-button {
  display: inline-block;
  padding: 14px 40px;
  background-color: white; // Botón blanco para contraste alto
  color: black;
  text-decoration: none;
  font-weight: 800;
  text-transform: uppercase;
  transition: all 0.3s;
  border-radius: 50px; // Redondeado moderno
  box-shadow: 0 10px 20px rgba(0,0,0,0.2);
  
  &:hover { 
      background: #e31140; // Color de acento al hover
      color: white; 
      transform: translateY(-3px);
  }
}

// --- PAGINACIÓN ---
.banner-pagination button {
  width: 12px; height: 12px; border-radius: 50%; border: none;
  margin: 0 6px; background: rgba(255,255,255,0.4);
  transition: all 0.3s;
  &.active { background: white; transform: scale(1.4); }
}

// --- TRANSICIONES (Vue) ---
.fade-enter-active, .fade-leave-active { transition: opacity 1s; }
.fade-enter-from, .fade-leave-to { opacity: 0; }

.slide-up-enter-active { transition: all 0.8s cubic-bezier(0.16, 1, 0.3, 1); }
.slide-up-enter-from { transform: translateY(40px); opacity: 0; }
</style>