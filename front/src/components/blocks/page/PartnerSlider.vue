<script setup lang="ts">
import { formatImageUrl } from '@/helpers/url';
import { Swiper, SwiperSlide } from 'swiper/vue';
import { Autoplay, Navigation, EffectCoverflow } from 'swiper/modules';

// Estilos Core y Efectos
import 'swiper/css';
import 'swiper/css/navigation';
import 'swiper/css/effect-coverflow';

interface Partner {
  image: string;
  alt?: string;
}

interface BlockData {
  title: string;
  partners: Partner[];
  bgColor?: string;
}

// CAMBIO 1: Hacemos 'data' opcional y le damos un valor por defecto robusto
const props = withDefaults(defineProps<{
  data?: BlockData, // El ? lo hace opcional
  isEditor?: boolean
}>(), {
  isEditor: false,
  // Valor por defecto para evitar "undefined"
  data: () => ({
    title: '',
    partners: [], // Inicializamos el array vacío para que .length no falle
    bgColor: ''
  })
});

const modules = [Autoplay, Navigation, EffectCoverflow];
</script>

<template>
  <section :class="['partner-section', isEditor ? 'editor-mode' : 'break-out']">
    <div class="container py-5">

      <div class="theme-title-one text-center mb-5">
        <h2 style="color: #e31140;" class="section-title text-uppercase fw-bold display-6">
          {{ data?.title || 'Título de la sección' }}
        </h2>
      </div>

      <div class="carousel-wrapper">
        <swiper
          v-if="data?.partners && data.partners.length > 0"
          :modules="modules"
          effect="coverflow"
          :grab-cursor="true"
          :centered-slides="true"
          :loop="data.partners.length > 3"
          :slides-per-view="1"
          :initial-slide="Math.floor((data.partners.length || 0) / 2)"
          :coverflow-effect="{
            rotate: 0,
            stretch: 0,
            depth: 100,
            modifier: 2.5,
            slideShadows: false,
          }"
          :autoplay="{
            delay: 3500,
            disableOnInteraction: false,
            pauseOnMouseEnter: true
          }"
          :navigation="{
            prevEl: '.btn-prev',
            nextEl: '.btn-next',
          }"
          :breakpoints="{
            640: { slidesPerView: 2 },
            1024: { slidesPerView: 3 }
          }"
          class="main-swiper"
        >
          <swiper-slide v-for="(item, index) in data.partners" :key="index" class="partner-slide">
            <div class="partner-card">
              <div class="card-inner">
                <img :src="formatImageUrl(item.image)" :alt="item.alt || 'Partner'">
              </div>
            </div>
          </swiper-slide>
        </swiper>

        <template v-if="data?.partners && data.partners.length > 0">
          <button class="nav-control btn-prev"><i class="bi bi-arrow-left-short"></i></button>
          <button class="nav-control btn-next"><i class="bi bi-arrow-right-short"></i></button>
        </template>
      </div>

      <div v-if="!data?.partners || data.partners.length === 0" class="empty-msg">
        Agrega logos desde el panel de edición.
      </div>
    </div>
  </section>
</template>

<style scoped lang="scss">
/* --- TÍTULO --- */
.section-title::after {
  content: '';
  display: block;
  width: 40px;
  height: 4px;
  background-color: #e31140;
  margin: 10px auto 0 auto;
  border-radius: 2px;
}

.carousel-wrapper {
  position: relative;
  max-width: 1000px;
  margin: 0 auto;
  padding: 40px 0;
  min-height: 200px; /* Altura mínima para que no colapse */
}

/* --- EFECTO DE CARTA --- */
.partner-slide {
  transition: all 0.5s ease;
  opacity: 0.8;
  transform: scale(0.8);
  filter: blur(2px);
  display: flex;
  justify-content: center;
}

/* Solo la carta activa se ve nítida y grande */
.swiper-slide-active {
  opacity: 1;
  transform: scale(1.1);
  filter: blur(0);
  z-index: 2;
}

.partner-card {
  width: 240px;
  height: 140px;
  background: white;
  border-radius: 24px;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 30px;
  box-shadow: 0 20px 40px rgba(0,0,0,0.06);
  border: 1px solid rgba(0,0,0,0.03);
  transition: all 0.4s ease;

  img {
    max-width: 100%;
    max-height: 100%;
    object-fit: contain;
    transition: transform 0.4s ease;
  }
}

/* Hover en la carta activa */
.swiper-slide-active .partner-card:hover {
  box-shadow: 0 25px 50px rgba(227, 17, 64, 0.15);
  border-color: rgba(227, 17, 64, 0.2);
  
  img {
    transform: scale(1.1);
  }
}

/* --- BOTONES DE NAVEGACIÓN --- */
.nav-control {
  position: absolute;
  top: 50%;
  transform: translateY(-50%);
  width: 50px;
  height: 50px;
  border-radius: 50%;
  border: none;
  background: white;
  color: #1a1a1a;
  box-shadow: 0 10px 25px rgba(0,0,0,0.1);
  z-index: 10;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.3s ease;
  font-size: 1.8rem;

  &:hover {
    background: #e31140;
    color: white;
    transform: translateY(-50%) scale(1.1);
  }

  &.btn-prev { left: -20px; }
  &.btn-next { right: -20px; }
}

.empty-msg {
  text-align: center;
  padding: 40px;
  border: 2px dashed #eee;
  border-radius: 20px;
  color: #999;
}

@media (max-width: 768px) {
  .nav-control { display: none; }
  .partner-card { width: 180px; height: 110px; }
}
</style>