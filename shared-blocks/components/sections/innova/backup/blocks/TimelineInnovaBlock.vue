<script setup lang="ts">
import { ref, computed } from 'vue';
import { formatImageUrl } from '../../../../helpers/url';

// Definición de la interfaz para los hitos
interface TimelineItem {
  label: string;
  content: string;
}

// Props editables
interface Props {
  data: {
    title?: string;
    items?: TimelineItem[];
    image?: string;
    imageSide?: 'left' | 'right';
    bgColor?: string;      // Fondo de la sección
    accentColor?: string;  // Color del hito activo (Azul ESAN)
    titleColor?: string;   // Color del título principal
    overlayColor1?: string; // Inicio degradado imagen
    overlayColor2?: string; // Fin degradado imagen
  }
}

const props = withDefaults(defineProps<Props>(), {
  data: () => ({})
});

const activeIndex = ref(0);

// Data segura con valores por defecto
const safeData = computed(() => {
  const d = props.data || {};
  return {
    title: d.title || 'TIME LINE',
    items: d.items || [],
    image: d.image || '',
    imageSide: d.imageSide || 'right',
    bgColor: d.bgColor || '#ffffff',
    accentColor: d.accentColor || '#2176ff',
    titleColor: d.titleColor || '#000000',
    overlay1: d.overlayColor1 || 'rgba(33, 118, 255, 0.70)',
    overlay2: d.overlayColor2 || 'rgba(255, 129, 33, 0.70)',
  };
});

// Variables CSS dinámicas
const dynamicStyles = computed(() => ({
  '--section-bg': safeData.value.bgColor,
  '--accent-color': safeData.value.accentColor,
  '--title-color': safeData.value.titleColor,
  '--overlay-grad': `linear-gradient(101deg, ${safeData.value.overlay1} 2.36%, ${safeData.value.overlay2} 94.39%)`
}));
</script>

<template>
  <section :class="['alterno-section', `side-${safeData.imageSide}`]" :style="dynamicStyles">
    <div class="container-fluid p-0">
      <div class="espacio-grid">

          <article class="content-side">
            <div class="text-wrapper">
              <h2 class="tituloPrincipal">{{ safeData.title }}</h2>

              <div class="timeline-list">
                <div v-for="(item, index) in safeData.items" :key="index" class="node-container"
                  @click="activeIndex = index">
                  <h3 :class="['titulo__time', { 'titulo__time--activo': activeIndex === index }]">
                    <span>&nbsp;</span>
                    {{ item.label }}

                    <transition name="expand">
                      <div v-show="activeIndex === index" class="content-detail">
                        <div class="html-renderer" v-html="item.content"></div>
                      </div>
                    </transition>
                  </h3>
                </div>
              </div>
            </div>
          </article>

        <article class="image-side">
          <div :class="['image-capsule', 'img-linear-mask']">
            <div class="custom-overlay" :style="{ background: dynamicStyles['--overlay-grad'] }"></div>

            <img v-if="safeData.image" :key="safeData.image" :src="formatImageUrl(safeData.image)"
              :alt="safeData.title">
            <div v-else class="img-placeholder">
              <i class="las la-image"></i>
            </div>
          </div>
        </article>

      </div>
    </div>
  </section>
</template>

<style scoped lang="scss">
.alterno-section {
  background-color: var(--section-bg);
  padding: 80px 0;
  position: relative;
  overflow: hidden;
  transition: background-color 0.3s ease;

  .espacio-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    align-items: center;
    min-height: 600px;
    gap: 20px;
  }

  /* --- Lado del Texto --- */
  .content-side {
    display: flex;
    justify-content: center;
    z-index: 5;
    padding: 20px;
  }

  .text-wrapper {
    width: 100%;
    max-width: 450px;
  }

  .tituloPrincipal {
    color: var(--title-color);
    text-transform: uppercase;
    font-weight: 800;
    font-size: 2.5rem;
    margin-bottom: 50px;
    position: relative;

    &::after {
      content: '';
      display: block;
      width: 70px;
      height: 4px;
      background: var(--title-color);
      margin-top: 10px;
    }
  }

  /* --- Estructura Timeline (ESAN Style) --- */
  .timeline-list {
    position: relative;
  }

  .titulo__time {
    padding: 0 0 25px 30px;
    margin-bottom: 0;
    cursor: pointer;
    position: relative;
    font-size: 1.1rem;
    font-weight: 800;
    color: #333;
    transition: color 0.3s ease;

    /* Línea vertical negra */
    &::before {
      content: '';
      position: absolute;
      left: 0px;
      top: 0;
      height: 100%;
      width: 2px;
      background: #000;
    }

    /* Bullets (Círculo exterior) */
    span::before {
      content: '';
      position: absolute;
      left: -6px;
      top: 5px;
      width: 14px;
      height: 14px;
      background: #000;
      border-radius: 100%;
      z-index: 2;
      transition: all 0.3s ease;
    }

    /* Punto blanco interior */
    span::after {
      content: '';
      position: absolute;
      left: -3px;
      top: 8px;
      width: 8px;
      height: 8px;
      background: #fff;
      border-radius: 100%;
      z-index: 3;
      transition: opacity 0.2s ease;
    }
  }

  /* Estado Activo */
  .titulo__time--activo {
    color: var(--accent-color) !important;

    & span::before {
      width: 18px;
      height: 18px;
      background: var(--accent-color);
      left: -8px;
      top: 3px;
    }

    & span::after {
      display: none;
    }
  }

  /* Detalle expandible (Contenido HTML) */
  .content-detail {
    padding-top: 15px;
    color: #555;
    font-weight: 400;
    font-size: 0.95rem;

    .html-renderer :deep(ul) {
      list-style: none;
      padding: 0;
      margin: 0;

      li {
        position: relative;
        padding-left: 20px;
        margin-bottom: 8px;

        &::before {
          content: '';
          position: absolute;
          left: 0;
          top: 8px;
          width: 5px;
          height: 5px;
          background: #58595B;
          border-radius: 50%;
        }
      }
    }
  }

  /* --- Sección de Imagen y Cápsula --- */
  .image-side {
    position: relative;
    width: 100%;
    height: 100%;
    display: flex;
    align-items: center;
    z-index: 1;
  }

  .image-capsule {
    width: 100%;
    max-width: 650px;
    height: 480px;
    position: relative;
    overflow: hidden;
    box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
    transition: border-radius 0.6s cubic-bezier(0.4, 0, 0.2, 1);

    /* FIX: Cambiado a Blanco para que el blend-mode no oscurezca la foto */
    background-color: #ffffff;
    /* Crea un grupo de renderizado para que el blend-mode solo afecte a lo que hay dentro */
    isolation: isolate;

    img {
      width: 100%;
      height: 100%;
      object-fit: cover;
      display: block;
      position: relative;
      z-index: 1;
      /* Al fondo */
    }

    .custom-overlay {
      position: absolute;
      inset: 0;
      z-index: 2;
      /* Encima de la imagen */
      pointer-events: none;

      /* Mix-blend-mode: soft-light es ideal para aclarar y dar tono */
      mix-blend-mode: soft-light;
      opacity: 0.9;
      /* Un poco menos de 1 para que la foto respire */
      transition: background 0.4s ease;
    }
  }

  /* Lógica de Lados */
  &.side-right {
    .image-capsule {
      border-radius: 40px 0 0 160px;
      margin-left: auto;
    }
  }

  &.side-left {
    .espacio-grid {
      direction: rtl;
    }

    .content-side {
      direction: ltr;
    }

    .image-capsule {
      border-radius: 0 40px 160px 0;
      margin-right: auto;
    }
  }

  /* Animación de los Hitos */
  .expand-enter-active,
  .expand-leave-active {
    transition: all 0.5s cubic-bezier(0.4, 0, 0.2, 1);
    overflow: hidden;
  }

  .expand-enter-from,
  .expand-leave-to {
    opacity: 0;
    max-height: 0;
    transform: translateY(-10px);
  }

  .expand-enter-to,
  .expand-leave-from {
    opacity: 1;
    max-height: 600px;
    transform: translateY(0);
  }

  /* Placeholder */
  .img-placeholder {
    height: 100%;
    background: #f8f9fa;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 4rem;
    color: #ddd;
  }

  /* Responsive */
  @media (max-width: 991px) {
    .espacio-grid {
      grid-template-columns: 1fr;
    }

    .image-side {
      order: -1;
      margin-bottom: 30px;
      height: auto;
    }

    .image-capsule {
      height: 350px;
      max-width: 100%;
      border-radius: 30px !important;
    }
  }

  /* Responsive para móviles */
  @media (max-width: 991px) {
    .espacio-grid {
      grid-template-columns: 1fr;
    }

    .image-side {
      order: -1;
      /* Foto arriba del texto */
      margin-bottom: 30px;
      height: auto;
    }

    .image-capsule {
      height: 350px;
      max-width: 100%;
      border-radius: 30px !important;
    }

    .tituloPrincipal {
      font-size: 2rem;
      text-align: center;

      &::after {
        margin: 10px auto 0;
      }
    }
  }
}
</style>