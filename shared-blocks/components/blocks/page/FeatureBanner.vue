<script setup lang="ts">
import { computed } from 'vue';
import { formatImageUrl } from '@/helpers/url';

interface FeatureBannerData {
  title: string;
  buttonText: string;
  buttonLink: string;
  backgroundImage: string;
}

const props = defineProps<{
  data: FeatureBannerData;
}>();

const bannerStyle = computed(() => {
  const imgUrl = props.data.backgroundImage 
    ? formatImageUrl(props.data.backgroundImage) 
    : '';
  
  return imgUrl 
    ? { backgroundImage: `url('${imgUrl}')` } 
    : { backgroundColor: '#2c3e50' };
});
</script>

<template>
  <div v-if="data" class="feature-banner-wrapper" :style="bannerStyle">
    
    <div class="overlay">
      <div class="container">
        <div class="row justify-content-center">
          <div class="col-lg-10 text-center">
            
            <h2 class="banner-title text-uppercase fw-bold text-white mb-1">
              {{ data.title || 'Título Destacado' }}
            </h2>

            <div v-if="data.buttonText" class="mt-4">
              <a :href="data.buttonLink || '#'" class="btn-custom">
                {{ data.buttonText }}
              </a>
            </div>

          </div>
        </div>
      </div>
    </div>

  </div>
</template>

<style scoped>
.feature-banner-wrapper {
  /* --- TRUCO PARA OCUPAR TODO EL ANCHO --- */
  width: 100vw; /* 100% del ancho de la ventana del navegador */
  position: relative;
  left: 50%;
  right: 50%;
  margin-left: -50vw;
  margin-right: -50vw;
  /* --------------------------------------- */

  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  min-height: 350px; /* Un poco más alto para verse imponente */
}

.overlay {
  background: rgba(0, 0, 0, 0.65);
  width: 100%;
  height: 100%; /* Asegura que la sombra cubra todo */
  min-height: 350px; /* Misma altura que el wrapper */
  display: flex;
  align-items: center;
  justify-content: center;
}

/* --- TÍTULO --- */
.banner-title {
  font-size: 2.5rem;
  letter-spacing: 1px;
  position: relative;
  display: inline-block;
  text-shadow: 0 2px 4px rgba(0,0,0,0.5); /* Sombra suave para leer mejor */
}

.banner-title::after {
    content: '';
    display: block;
    width: 60px;
    height: 4px;
    background-color: #e31140;
    margin: 15px auto 0 auto;
    border-radius: 2px;
}

/* --- BOTÓN --- */
.btn-custom {
  display: inline-block;
  background-color: #e31140;
  color: #fff;
  padding: 14px 40px; /* Un poco más grande */
  font-weight: 700;
  text-transform: uppercase;
  border-radius: 4px;
  text-decoration: none;
  transition: all 0.3s ease;
  border: 2px solid #e31140;
  letter-spacing: 1px;
}

.btn-custom:hover {
  background-color: transparent;
  border-color: #fff;
  color: #fff;
}

/* Responsive */
@media (max-width: 768px) {
  .feature-banner-wrapper, .overlay {
    min-height: 300px;
  }
  .banner-title {
    font-size: 1.8rem;
  }
}
</style>