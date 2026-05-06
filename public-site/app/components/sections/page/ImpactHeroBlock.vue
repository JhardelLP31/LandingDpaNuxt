<script setup lang="ts">
import { computed } from 'vue';
import { formatImageUrl } from '@/helpers/url';

// --- PROPS ---
interface ImpactData {
  tagline?: string;       // "RENOVACIÓN DE LA CERTIFICACIÓN..."
  title?: string;         // "La Unidad de Laboratorio..."
  logoImage?: string;     // logos-juntos.png
  btnText?: string;       // "MÁS INFORMACIÓN"
  btnLink?: string;
  config?: {
    bgImage?: string;
    overlayOpacity?: number;
  };
}

const props = defineProps<{
  data: ImpactData;
  isEditor?: boolean;
}>();

// Estilo del fondo
const sectionStyle = computed(() => ({
  backgroundImage: `url(${formatImageUrl(props.data.config?.bgImage) || 'https://placehold.co/1920x600'})`,
}));
</script>

<template>
  <section class="iso-section position-relative d-flex align-items-center"
    :class="[isEditor ? 'editor-mode' : 'break-out']" :style="sectionStyle">
    <div class="overlay-gradient"></div>

    <div :class="isEditor ? 'w-100 px-3' : 'container'">
      <div class="row">

        <div class="col-lg-1 d-none d-lg-block"></div>

        <div class="col-lg-6 col-md-8 content-column">

          <div v-if="data.title" class="animate-left mb-4">
            <h2 class="addon-title text-center text-md-start">
              {{ data.title }}
            </h2>
          </div>

          <div v-if="data.tagline" class="animate-right mb-3">
            <h3 class="addon-tagline ">
              {{ data.tagline }}
            </h3>
          </div>



          <div class="spacer-block"></div>

          <div v-if="data.logoImage" class="animate-right mb-4">
            <div class="logo-container">
              <img :src="formatImageUrl(data.logoImage)" alt="Logos" class="img-fluid responsive-logo">
            </div>
          </div>

          <div class="spacer-block"></div>

          <div v-if="data.btnText" class="animate-left">
            <a :href="data.btnLink || '#'" class="btn-iso-rounded">
              {{ data.btnText }}
            </a>
          </div>

        </div>

        <div class="col-lg-4 col-md-4"></div>

        <div class="col-lg-1 d-none d-lg-block"></div>

      </div>
    </div>
  </section>
</template>

<style scoped lang="scss">
// Variables (ajusta según tu theme)
$esan-red: #f51445;
$text-white: #ffffff;

// --- ESTRUCTURA FULL WIDTH ---
.iso-section {
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;
  min-height: 550px; // Altura mínima para que respire
  padding: 80px 0;
  overflow: hidden;
}

.break-out {
  width: 100vw;
  position: relative;
  left: 50%;
  right: 50%;
  margin-left: -50vw;
  margin-right: -50vw;
}

.editor-mode {
  width: 100%;
  border-radius: 8px;
  margin: 1rem 0;
  min-height: 400px;
}

// --- ESTILOS VISUALES (Réplica exacta) ---
.overlay-gradient {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  /* Gradiente suave de negro a transparente para leer el texto a la izquierda */
  //background: linear-gradient(90deg, rgba(0, 0, 0, 0.7) 0%, rgba(0, 0, 0, 0.5) 50%, rgba(0, 0, 0, 0.1) 100%);
  z-index: 1;
}

// Para que el contenido quede encima del overlay
.container,
.w-100 {
  position: relative;
  z-index: 2;
}

// TAGLINE (sppb-addon-title h2 pequeño)
.addon-tagline {
    font-family: 'Arial'; // ESAN usa una tipografía muy limpia y estándar

  color: $text-white;
  font-size: 1rem;
  font-weight: 500;
  //letter-spacing: 1px;
  margin: 0;
  text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.5);
  // Simular alineación izquierda original
  text-align: left;
}

// TITLE PRINCIPAL (sppb-addon-title grande)
.addon-title {
  color: $text-white;
  font-size: 2rem;
  font-weight: 900;
  line-height: 1.2;
  text-shadow: 2px 2px 5px rgba(0, 0, 0, 0.5);
}

// LOGOS IMAGE
.responsive-logo {
  max-width: 100%;
  height: auto;
  // En el HTML original tenía clase responsive, aquí limitamos un poco el tamaño visual
  max-height: 70px;
}

// ESPACIADOR (sppb-empty-space)
.spacer-block {
  height: 20px;
  width: 100%;
}

// BOTÓN (sppb-btn-default sppb-btn-rounded)
.btn-iso-rounded {
  display: inline-block;
  background-color: transparent;
  border: 2px solid $text-white;
  color: $text-white;
  padding: 10px 30px;
  border-radius: 50px; // Rounded
  font-size: 0.85rem;
  font-weight: 700;
  text-decoration: none;
  transition: all 0.3s ease;

  &:hover {
    background-color: $esan-red;
    //color: #333;
    border-color: $esan-red;
  }
}

// --- ANIMACIONES (sppb-wow fadeInRight / Left) ---
.animate-right {
  animation: fadeInRight 0.8s ease-out forwards;
  opacity: 0;
}

.animate-left {
  animation: fadeInLeft 0.8s ease-out forwards;
  opacity: 0;
}

@keyframes fadeInRight {
  from {
    opacity: 0;
    transform: translateX(30px);
  }

  to {
    opacity: 1;
    transform: translateX(0);
  }
}

@keyframes fadeInLeft {
  from {
    opacity: 0;
    transform: translateX(-30px);
  }

  to {
    opacity: 1;
    transform: translateX(0);
  }
}

// --- RESPONSIVE ---
@media (max-width: 768px) {
  .addon-title {
    font-size: 1.8rem;
    text-align: center !important;
  }

  .addon-tagline {
    text-align: center;
    margin-bottom: 10px;
  }

  .content-column {
    text-align: center;
  }

  // Centrar todo en móvil
  .logo-container {
    display: flex;
    justify-content: center;
  }
}
</style>