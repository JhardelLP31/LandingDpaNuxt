<script setup lang="ts">
import { computed } from 'vue';
import { formatImageUrl } from '@/helpers/url';

const props = defineProps<{
  data: {
    title?: string;
    content?: string;
    image?: string;
    inverted?: boolean;
  }
}>();

const blockData = computed(() => ({
  title: props.data.title || '',
  content: props.data.content || '',
  // Si no viene imagen, lo dejamos vacío para activar el modo "ancho completo"
  image: props.data.image || '', 
  inverted: props.data.inverted || false 
}));

// Determina si existe una imagen válida para mostrar
const hasImage = computed(() => !!blockData.value.image);
</script>

<template>
  <section class="sppb-section">
    <div class="container">
      <div class="row align-items-start">
        
        <div 
          :class="[
            hasImage ? 'col-md-6' : 'col-md-12',
            { 
              'order-md-last ps-md-5': hasImage && blockData.inverted, 
              'pe-md-5': hasImage && !blockData.inverted 
            }
          ]" 
          class="mb-4 mb-md-0"
        >
          <div class="content-wrapper">
            <h3 class="sppb-addon-title">{{ blockData.title }}</h3>
            <div class="sppb-addon-content">
              <div class="rich-text-content" v-html="blockData.content"></div>
            </div>
          </div>
        </div>

        <div 
          v-if="hasImage"
          class="col-md-6" 
          :class="{ 'order-md-first': blockData.inverted }"
        >
          <div class="image-container text-center">
            <img 
              class="img-fluid w-100" 
              :src="formatImageUrl(blockData.image)" 
              alt="Soporte" 
              loading="lazy"
            >
          </div>
        </div>

      </div>
    </div>
  </section>
</template>

<style scoped>
.sppb-section {
  background-color: #fff;
  font-family: "Arial", sans-serif;
  padding: 40px 0; /* Un poco de padding vertical para la sección */
}
.container{
  max-width: 1150px;
}

/* 1. EL TÍTULO FINO */
.sppb-addon-title {
  font-size: 24px;      
  line-height: 1.3;
  font-weight: 300;     
  color: #444444;      
  margin-top: 0;
  margin-bottom: 15px;
  letter-spacing: 0.1px;
  position: relative;
  z-index: 1;
}

/* Ajuste de la imagen */
.image-container {
  position: relative;
  margin-top: 0;
}

.img-fluid {
  display: block;
  width: 100%;
  height: auto;
  border-radius: 0;
}

/* 2. EL TEXTO DEL CUERPO */
.sppb-addon-content {
  color: #666666;
  font-size: 16px;
  line-height: 24px; /* Aumentado ligeramente para mejor legibilidad */
  font-weight: 400;
}

/* 3. JUSTIFICADO OBLIGATORIO */
:deep(.rich-text-content),
:deep(.rich-text-content p) {
  text-align: justify !important;
  margin-bottom: 15px;
}

/* Alineación superior forzada */
.row.align-items-start {
  align-items: flex-start !important;
}
</style>