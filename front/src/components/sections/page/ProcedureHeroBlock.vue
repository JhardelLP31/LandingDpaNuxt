<script setup lang="ts">
import { computed } from 'vue';
// 1. IMPORTAMOS EL HELPER
import { formatImageUrl } from '@/helpers/url';

const props = defineProps<{
  data: {
    title?: string;
    bgImage?: string;
    overlayOpacity?: number;
    height?: string;
  },
  isEditor?: boolean
}>();

const blockData = computed(() => ({
  title: props.data.title || 'PROCEDIMIENTOS',
  bgImage: props.data.bgImage || 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?q=80&w=1920&auto=format&fit=crop',
  overlayOpacity: props.data.overlayOpacity ?? 0.6,
  height: props.data.height || '300px'
}));

const sectionStyle = computed(() => ({
  // 2. USAMOS EL HELPER AQUÍ
  // Esto asegura que si la imagen viene de tu storage, tenga el dominio completo
  backgroundImage: `url(${formatImageUrl(blockData.value.bgImage)})`,
  minHeight: blockData.value.height
}));

const overlayStyle = computed(() => ({
  backgroundColor: `rgba(0, 0, 0, ${blockData.value.overlayOpacity})`
}));
</script>

<template>
  <section 
    class="procedure-hero position-relative d-flex align-items-center" 
    :class="isEditor ? 'w-100' : 'break-out'"
    :style="sectionStyle"
  >
    
    <div class="row-overlay" :style="overlayStyle"></div>

    <div :class="isEditor ? 'w-100 px-4' : 'container'" class="position-relative z-2">
      <div class="row">
        <div class="col-md-12">
          
          <div class="section-title-wrapper text-start">
            <h1 class="title-heading text-white fw-bold text-uppercase mb-0">
              {{ blockData.title }}
            </h1>
            <div class="title-accent mt-3"></div>
          </div>

        </div>
      </div>
    </div>

  </section>
</template>

<style scoped>
.procedure-hero {
  background-size: cover;
  background-position: center center;
  background-repeat: no-repeat;
  overflow: hidden; 
}

/* === TÉCNICA FULL WIDTH === */
.break-out {
  width: 100vw;
  position: relative;
  left: 50%;
  right: 50%;
  margin-left: -50vw;
  margin-right: -50vw;
}

.row-overlay {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 1;
}

.title-heading {
  font-size: 2.8rem;
  letter-spacing: 2px;
  text-shadow: 0 4px 8px rgba(0,0,0,0.5);
  line-height: 1.2;
}

.title-accent {
  width: 70px;
  height: 5px;
  background-color: #dc3545; /* Rojo */
}

/* Ajustes Responsive */
@media (max-width: 768px) {
  .title-heading { font-size: 2rem; }
  .procedure-hero { min-height: 200px !important; }
}
</style>