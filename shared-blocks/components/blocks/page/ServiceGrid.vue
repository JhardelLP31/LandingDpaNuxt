<script setup lang="ts">
import { formatImageUrl } from '@/helpers/url';

interface ServiceItem {
  title: string;
  description: string;
  image: string;
  link: string;
}

interface ServiceGridData {
  items: ServiceItem[];
}

defineProps<{
  data: ServiceGridData;
}>();
</script>

<template>
  <div v-if="data && data.items.length > 0" class="service-section section-spacing">
    <div class="container">
      <div class="row g-4 justify-content-center">
        
        <div 
          v-for="(item, index) in data.items" 
          :key="index" 
          class="col-md-6 col-lg-4"
        >
          <a :href="item.link || '#'" class="service-box" :style="{ animationDelay: `${index * 0.1}s` }">
            
            <div class="service-bg"></div>

            <div class="service-content">
              
              <div class="icon-holder mb-4">
                 <img 
                  v-if="item.image" 
                  :src="formatImageUrl(item.image)" 
                  class="img-fluid custom-image-icon" 
                  alt="Icono servicio"
                >
                <i v-else class="las la-layer-group default-font-icon"></i>
              </div>

              <h3 class="service-title fw-bold text-uppercase mb-3">{{ item.title }}</h3>
              <p class="service-desc mb-0">{{ item.description }}</p>
              
              </div>
          </a>
        </div>

      </div>
    </div>
  </div>
</template>

<style scoped>
.service-section {
  padding: 100px 0;
  /*background-color: #f4f7f6;*/
}

/* --- CAJA PRINCIPAL --- */
.service-box {
  display: block;
  position: relative;
  background: #fff;
  padding: 40px 35px; /* Un poco más de padding lateral */
  border-radius: 12px; /* Bordes un poco más redondeados */
  overflow: hidden;
  box-shadow: 0 10px 30px rgba(0,0,0,0.05);
  text-decoration: none;
  transition: all 0.4s cubic-bezier(0.165, 0.84, 0.44, 1); /* Transición más suave */
  height: 100%;
  z-index: 1;
  opacity: 0;
  animation: fadeUp 0.8s ease forwards;
}

/* --- BARRIDO ROJO --- */
.service-bg {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  /* Tu rojo corporativo con un ligero degradado para profundidad */
  background: linear-gradient(135deg, #e31140 0%, #d60e39 100%);
  z-index: -1;
  transform: scaleY(0);
  transform-origin: bottom;
  transition: transform 0.4s cubic-bezier(0.4, 0, 0.2, 1);
}

.service-box:hover .service-bg {
  transform: scaleY(1);
}

.service-box:hover {
  transform: translateY(-10px);
  box-shadow: 0 20px 40px rgba(227, 17, 64, 0.25);
}

/* --- TIPOGRAFÍA --- */
.service-title {
  font-size: 1.35rem;
  color: #1a1a1a;
  transition: color 0.3s ease;
  letter-spacing: 0.5px;
}

.service-desc {
  color: #666;
  font-size: 0.95rem;
  line-height: 1.7;
  transition: color 0.3s ease;
}

/* Hover: Textos a blanco */
.service-box:hover .service-title,
.service-box:hover .service-desc {
  color: #fff;
}

/* --- LOGICA DE ICONOS CORREGIDA --- */
.icon-holder {
  height: 70px;
  display: flex;
  align-items: center;
  justify-content: left;
  margin-bottom: 25px;
}

/* A) Si es imagen PNG */
.custom-image-icon {
  max-height: 100%;
  width: auto;
  transition: all 0.4s ease;
  /* ESTADO INICIAL: Colores originales de la imagen. No aplicamos filtros. */
}

.service-box:hover .custom-image-icon {
  transform: scale(1.1) rotate(-3deg);
  /* ESTADO HOVER: Fuerza que la imagen se vuelva blanca pura */
  filter: brightness(0) invert(1); 
}

/* B) Si es icono de fuente (las la-...) */
.default-font-icon {
  font-size: 3.5rem;
  color: #e31140; /* Rojo al inicio */
  transition: all 0.4s ease;
}

.service-box:hover .default-font-icon {
  color: #fff; /* Blanco al hover */
  transform: scale(1.1) rotate(-3deg);
}

/* --- ANIMACIÓN DE ENTRADA --- */
@keyframes fadeUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>