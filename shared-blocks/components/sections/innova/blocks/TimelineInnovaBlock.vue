<script setup lang="ts">
import { ref, computed } from 'vue';
import InnovaContentRenderer from '../components/InnovaContentRenderer.vue';
import InnovaImageRenderer from '../components/InnovaImageRenderer.vue';

interface Props {
  data: {
    title?: string;
    contentType?: 'timeline' | 'html' | 'list' | 'accordion';
    imageType?: 'single' | 'triple';
    items?: any[];
    content?: string;
    features?: string[];
    image?: string;
    images?: string[];
    imageSide?: 'left' | 'right';
    bgColor?: string;
    accentColor?: string;
    titleColor?: string;
    overlayColor1?: string;
    overlayColor2?: string;
  }
}

const props = withDefaults(defineProps<Props>(), {
  data: () => ({})
});

const activeIndex = ref(0);

const safeData = computed(() => {
  const d = props.data || {};
  return {
    title: d.title || 'TIME LINE',
    contentType: d.contentType || 'timeline',
    imageType: d.imageType || 'single',
    items: d.items || [],
    content: d.content || '',
    features: d.features || [],
    image: d.image || '',
    images: d.images || [],
    imageSide: d.imageSide || 'right',
    bgColor: d.bgColor || '#ffffff',
    accentColor: d.accentColor || '#2176ff',
    titleColor: d.titleColor || '#000000',
    overlay1: d.overlayColor1 || 'rgba(33, 118, 255, 0.70)',
    overlay2: d.overlayColor2 || 'rgba(255, 129, 33, 0.70)',
  };
});

const dynamicStyles = computed(() => ({
  '--section-bg': safeData.value.bgColor,
  '--title-color': safeData.value.titleColor,
  '--accent-color': safeData.value.accentColor,
  '--overlay-grad': `linear-gradient(101deg, ${safeData.value.overlay1} 2.36%, ${safeData.value.overlay2} 94.39%)`
}));
</script>

<template>
  <section :class="['alterno-section', `side-${safeData.imageSide}`, `layout-${safeData.imageType}`]" :style="dynamicStyles">
    <div class="container-fluid p-0">
      <div class="espacio-grid">

        <article class="content-side">
          <div class="content-wrapper">
            <InnovaContentRenderer 
              :type="safeData.contentType"
              :title="safeData.title"
              :items="safeData.items"
              :free-html="safeData.content"
              :features="safeData.features"
              :accent-color="safeData.accentColor"
              :title-color="safeData.titleColor"
              :active-index="activeIndex"
              @update:active-index="activeIndex = $event"
            />
          </div>
        </article>

        <article class="image-side">
          <InnovaImageRenderer 
            :type="safeData.imageType"
            :image="safeData.image"
            :images="safeData.images"
            :title="safeData.title"
            :image-side="safeData.imageSide"
            :overlay-grad="dynamicStyles['--overlay-grad']"
          />
        </article>

      </div>
    </div>
  </section>
</template>

<style scoped lang="scss">
.alterno-section {
  background-color: var(--section-bg);
  position: relative;
  overflow: hidden;
  transition: background-color 0.3s ease;

  .espacio-grid {
    display: flex; 
    align-items: stretch;
    min-height: 600px;
  }

  /* --- ZONA DEL TEXTO --- */
  .content-side { 
    width: 50%;
    display: flex; 
    flex-direction: column;
    justify-content: center; 
    z-index: 5; 
  }

  .content-wrapper {
    max-width: 600px; 
    width: 100%;
    margin: 0 auto; 
  }

  /* --- ZONA DE LA IMAGEN --- */
  .image-side { 
    width: 50%;
    position: relative; 
    display: flex; 
    align-items: center; 
    z-index: 1; 
  }

  /* =========================================
     LÓGICA DE DERECHA / IZQUIERDA (Para el Texto)
     ========================================= */
  &.side-right {
    .espacio-grid { flex-direction: row; }
    .content-side { padding: 60px 40px 60px max(20px, calc((100vw - 1200px) / 2)); }
  }

  &.side-left {
    .espacio-grid { flex-direction: row-reverse; }
    .content-side { padding: 60px max(20px, calc((100vw - 1200px) / 2)) 60px 40px; }
  }


  /* =========================================
     LÓGICA DE IMAGEN: AL EXTREMO VS CENTRADA
     ========================================= */
  /* Si es Imagen Única: Se queda en padding 0 para pegar al borde */
  &.layout-single {
    .image-side { padding: 0; }
  }

  /* Si son Multiimágenes: Le damos padding para que se centre igual que el texto */
  &.layout-triple {
    &.side-right {
      .image-side { padding: 60px max(20px, calc((100vw - 1200px) / 2)) 60px 40px; }
    }
    &.side-left {
      .image-side { padding: 60px 40px 60px max(20px, calc((100vw - 1200px) / 2)); }
    }
  }

  /* --- RESPONSIVE --- */
  @media (max-width: 991px) {
    .espacio-grid { flex-direction: column !important; }
    .content-side, .image-side { width: 100%; padding: 40px 20px !important; }
    .image-side { order: -1; min-height: 350px; margin-bottom: 20px; }
  }
}
</style>