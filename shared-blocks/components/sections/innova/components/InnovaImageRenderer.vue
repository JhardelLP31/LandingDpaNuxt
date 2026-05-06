<script setup lang="ts">
import { formatImageUrl } from '../../../../helpers/url';

interface Props {
  type: 'single' | 'triple';
  image?: string;         // Para modo single
  images?: string[];      // Para modo triple (mosaico)
  title: string;
  imageSide: 'left' | 'right';
  overlayGrad: string;
}

defineProps<Props>();
</script>

<template>
  <div :class="['image-container-modular', `is-${type}`]">
    
    <div v-if="type === 'single'" class="image-capsule">
      <div class="custom-overlay" :style="{ background: overlayGrad }"></div>
      <img v-if="image" :src="formatImageUrl(image)" :key="image" :alt="title">
      <div v-else class="img-placeholder"><i class="las la-image"></i></div>
    </div>

    <div v-else-if="type === 'triple'" class="image-mosaic">
      <div class="mosaic-grid">
        <div class="mosaic-col">
          <div class="mosaic-item top">
            <img v-if="images?.[0]" :src="formatImageUrl(images[0])" alt="foto 1">
          </div>
          <div class="mosaic-item bottom">
            <img v-if="images?.[1]" :src="formatImageUrl(images[1])" alt="foto 2">
          </div>
        </div>
        <div class="mosaic-col">
          <div class="mosaic-item tall">
            <img v-if="images?.[2]" :src="formatImageUrl(images[2])" alt="foto 3">
          </div>
        </div>
      </div>
    </div>

  </div>
</template>

<style scoped lang="scss">
.image-container-modular {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
}

/* --- ESTILOS CÁPSULA SINGLE --- */
.image-capsule {
  width: 100%;
  max-width: 650px;
  height: 520px;
  position: relative;
  overflow: hidden;
  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
  background-color: #ffffff;
  isolation: isolate;
  
  img { width: 100%; height: 100%; object-fit: cover; display: block; position: relative; z-index: 1; }
  .custom-overlay { position: absolute; inset: 0; z-index: 2; mix-blend-mode: soft-light; opacity: 0.9; pointer-events: none; }
}

/* --- ESTILOS MOSAICO TRIPLE --- */
.image-mosaic {
  width: 100%;
  max-width: 700px;
  
  .mosaic-grid {
    display: grid;
    grid-template-columns: 1.2fr 0.8fr; // Proporción de las columnas
    gap: 15px;
    height: 520px;
  }

  .mosaic-col {
    display: flex;
    flex-direction: column;
    gap: 15px;
  }

  .mosaic-item {
    border-radius: 20px;
    overflow: hidden;
    background: #f0f0f0;
    img { width: 100%; height: 100%; object-fit: cover; }
    
    &.top { height: 65%; }
    &.bottom { height: 35%; }
    &.tall { height: 100%; }
  }
}

/* Lógica de Bordes de Cápsula (Single) */
.side-right .image-capsule { border-radius: 40px 0 0 160px; margin-left: auto; }
.side-left .image-capsule { border-radius: 0 40px 160px 0; margin-right: auto; }

.img-placeholder { height: 100%; background: #f8f9fa; display: flex; align-items: center; justify-content: center; font-size: 5rem; color: #ddd; }

@media (max-width: 991px) {
  .image-capsule, .mosaic-grid { height: 350px !important; }
  .image-capsule { border-radius: 30px !important; }
}
</style>