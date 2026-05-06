<script setup lang="ts">
import { computed } from 'vue';

const props = defineProps<{
  data: any
}>();

const bgColor = computed(() => props.data?.bgColor || '#f8f9fa'); // Gris súper claro por defecto
const titleColor = computed(() => props.data?.titleColor || '#000000');
const textColor = computed(() => props.data?.textColor || '#555555');
const features = computed(() => props.data?.features || []);
</script>

<template>
  <section class="benefits-split-section" :style="{ backgroundColor: bgColor }">
    <div class="split-layout">
      
      <div class="content-column">
        <div class="content-inner">
          
          <h3 class="main-title" v-if="props.data?.title" :style="{ color: titleColor }">
            {{ props.data.title }}
          </h3>

          <div class="features-grid">
            <div 
              class="feature-item" 
              v-for="(feature, index) in features" 
              :key="index"
            >
              <div class="feature-icon-wrapper" v-if="feature.icon">
                <img :src="feature.icon" :alt="feature.title" class="feature-icon">
              </div>
              
              <h4 class="feature-title" v-if="feature.title" :style="{ color: titleColor }">
                {{ feature.title }}
              </h4>
              
              <p class="feature-text" v-if="feature.text" :style="{ color: textColor }">
                {{ feature.text }}
              </p>
            </div>
          </div>

        </div>
      </div>

      <div class="media-column p-0">
        <div class="image-wrapper-full" v-if="props.data?.imageSrc">
          <img :src="props.data.imageSrc" alt="Beneficios" class="full-bleed-img">
        </div>
        <div v-else class="media-placeholder-full bg-light d-flex align-items-center justify-content-center">
          <i class="las la-image fs-1 text-muted"></i>
        </div>
      </div>

    </div>
  </section>
</template>

<style scoped>
/* --- ESTRUCTURA PRINCIPAL --- */
.benefits-split-section {
  width: 100%;
  display: flex;
  overflow: hidden;
}

.split-layout {
  display: flex;
  width: 100%;
  flex-wrap: wrap; /* Para responsive */
}

/* Proporción 60/40 (aprox 7 y 5 columnas de Bootstrap) */
.content-column {
  flex: 0 0 58.333333%;
  max-width: 58.333333%;
  display: flex;
  align-items: center;
}

.media-column {
  flex: 0 0 41.666667%;
  max-width: 41.666667%;
  position: relative;
}

/* --- CONTENIDO IZQUIERDO --- */
.content-inner {
  width: 100%;
  padding: 80px 50px 80px 10vw; /* Padding izquierdo dinámico para simular el centrado de un contenedor */
}

.main-title {
  font-size: clamp(28px, 3vw, 36px);
  font-weight: 800;
  text-transform: uppercase;
  margin-bottom: 50px;
}

/* --- GRILLA DE BENEFICIOS --- */
.features-grid {
  display: grid;
  grid-template-columns: repeat(2, 1fr); /* 2 columnas exactas */
  column-gap: 40px;
  row-gap: 50px;
}

.feature-item {
  text-align: center;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.feature-icon-wrapper {
  height: 60px;
  margin-bottom: 20px;
  display: flex;
  align-items: flex-end; /* Alinea los iconos por su base si tienen distintas alturas */
}

.feature-icon {
  max-height: 100%;
  width: auto;
  object-fit: contain;
}

.feature-title {
  font-size: 15px;
  font-weight: 700;
  text-transform: uppercase;
  margin-bottom: 12px;
  line-height: 1.3;
}

.feature-text {
  font-size: 13px;
  line-height: 1.5;
  margin: 0;
  font-weight: 400;
}

/* --- IMAGEN DERECHA --- */
.image-wrapper-full {
  width: 100%;
  height: 100%;
}

.full-bleed-img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  display: block;
}

.media-placeholder-full {
  min-height: 100%;
  border-left: 1px solid #dee2e6;
}

/* --- RESPONSIVE --- */
@media (max-width: 992px) {
  .content-column, .media-column {
    flex: 0 0 100%;
    max-width: 100%;
  }
  
  .content-inner {
    padding: 60px 20px;
  }
  
  .full-bleed-img, .media-placeholder-full {
    height: 400px; /* Altura fija en móvil */
  }
}

@media (max-width: 576px) {
  .features-grid {
    grid-template-columns: 1fr; /* 1 sola columna en móviles pequeños */
    row-gap: 40px;
  }
}
</style>