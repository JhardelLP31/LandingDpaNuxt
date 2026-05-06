<script setup lang="ts">
import { Swiper, SwiperSlide } from 'swiper/vue';
import { Pagination, Autoplay } from 'swiper/modules';
import 'swiper/css';
import 'swiper/css/pagination';
import { formatImageUrl } from '@/helpers/url'; // <--- IMPORTANTE

// Interfaces
interface Testimonial {
  name: string;
  role: string;
  quote: string;
  linkText?: string;
  linkUrl?: string;
}

interface TestimonialsData {
  title: string;
  subtitle: string;
  items: Testimonial[];
  // Objeto de decoraciones (opcional para que no falle si es antiguo)
  decorations?: {
      leftSmall?: string;
      leftLarge?: string;
      rightSmall?: string;
      rightLarge?: string;
      bottomSmall?: string;
  }
}

const props = defineProps<{
  data: TestimonialsData;
}>();

const modules = [Pagination, Autoplay];

// Fallbacks por si el usuario borra la imagen (Mantenemos las fotos actuales)
const defaults = {
    leftSmall: 'https://i.pravatar.cc/150?u=3',
    leftLarge: 'https://i.pravatar.cc/150?u=1',
    rightSmall: 'https://i.pravatar.cc/150?u=6',
    rightLarge: 'https://i.pravatar.cc/150?u=5',
    bottomSmall: 'https://i.pravatar.cc/150?u=4'
};
</script>

<template>
  <section class="ms-section ms-loaded-animate position-relative" id="testimonials">
    
    <div class="ms-wrapper-section container position-relative z-2">
      <article class="ms-article text-center mb-5">
        <h3 class="ms-article-title text-gradient display-5 fw-bold">
          {{ data.title || 'Qué dicen de nosotros' }}
        </h3>
        <p class="lead text-muted mx-auto" style="max-width: 700px;">
          {{ data.subtitle || 'En la era digital, la satisfacción del cliente es nuestra mayor recompensa.' }}
        </p>
      </article>

      <div class="ms-wrapper-testimonials">
        <div class="ms-wrapper mx-auto" style="max-width: 1000px;">
          <div class="ms-testimonials-list">
            <swiper
              :modules="modules"
              :slides-per-view="1"
              :space-between="30"
              :centered-slides="true"
              :loop="true"
              :autoplay="{ delay: 4000 }"
              :pagination="{ clickable: true }"
              :breakpoints="{
                '768': { slidesPerView: 2, spaceBetween: 20 },
                '1024': { slidesPerView: 3, spaceBetween: 30 }
              }"
              class="ms-slider pb-5"
            >
              <swiper-slide v-for="(item, index) in data.items" :key="index">
                <div class="ms-card bg-white p-4 rounded-4 shadow-sm border h-100 text-center">
                  <div class="ms-card-body d-flex flex-column h-100">
                    <h3 class="ms-card-title h5 fw-bold mb-1">{{ item.name }}</h3>
                    <div class="ms-card-st text-primary small text-uppercase fw-bold mb-3">{{ item.role }}</div>
                    <p class="mb-4 text-muted flex-grow-1">{{ item.quote }}</p>
                    <div class="ms-wrapper-btn mt-auto" v-if="item.linkUrl">
                      <a :href="item.linkUrl" class="ms-link btn btn-outline-primary btn-sm rounded-pill px-4">
                        {{ item.linkText || 'Ver proyecto' }}
                      </a>
                    </div>
                  </div>
                </div>
              </swiper-slide>
            </swiper>
          </div>
        </div>
      </div>
    </div>

    <div class="ms-avatar-testimonial -left d-none d-lg-block">
        <div class="ms-line -testimonial-a">
             <svg width="200" height="100" viewBox="0 0 200 100" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M10 10 Q 100 90 190 10" stroke="#e9ecef" stroke-width="2" stroke-dasharray="5 5"/>
             </svg>
        </div>
        <div class="ms-bubble -small" style="top: 0; left: 140px;">
            <img :src="formatImageUrl(data.decorations?.leftSmall || defaults.leftSmall)" class="rounded-circle shadow border border-white" width="60">
        </div>
        <div class="ms-bubble -large" style="top: 80px; left: 0;">
            <img :src="formatImageUrl(data.decorations?.leftLarge || defaults.leftLarge)" class="rounded-circle shadow border border-white" width="100">
        </div>
    </div>

    <div class="ms-avatar-testimonial -right d-none d-lg-block">
        <div class="ms-line">
            <svg width="200" height="100" viewBox="0 0 200 100" fill="none">
                <path d="M10 90 Q 100 10 190 90" stroke="#e9ecef" stroke-width="2" stroke-dasharray="5 5"/>
            </svg>
        </div>
        <div class="ms-bubble -small" style="top: 10px; right: 170px;">
            <img :src="formatImageUrl(data.decorations?.rightSmall || defaults.rightSmall)" class="rounded-circle shadow border border-white" width="70">
        </div>
        <div class="ms-bubble -large" style="top: 90px; right: 10px;">
            <img :src="formatImageUrl(data.decorations?.rightLarge || defaults.rightLarge)" class="rounded-circle shadow border border-white" width="110">
        </div>
    </div>

    <div class="ms-avatar-testimonial -bottom d-none d-md-block">
        <div class="ms-bubble -small" style="top: -70px; right: 140px;">
            <img :src="formatImageUrl(data.decorations?.bottomSmall || defaults.bottomSmall)" class="rounded-circle shadow border border-white" width="80">
        </div>
    </div>

  </section>
</template>

<style scoped>
/* (TUS MISMOS ESTILOS - NO CAMBIAN) */
.ms-section {
    padding: 80px 0;
    overflow: hidden;
    /*background-color: #fcfcfc;*/
}
.text-gradient {
    background: linear-gradient(90deg, #e31140 0%, #e31140 100%);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
}
.ms-avatar-testimonial {
    position: absolute;
    pointer-events: none;
    z-index: 1;
}
.-left { top: 15%; left: 2%; }
.-right { top: 20%; right: 2%; }
.-bottom { bottom: 5%; left: 50%; transform: translateX(-50%); }
.ms-bubble { position: absolute; }
.ms-line { position: absolute; z-index: -1; opacity: 0.5; }
:deep(.swiper-pagination-bullet-active) {
    background-color: #0d6efd;
}
</style>