<template>
  <section class="hero-section break-out position-relative d-flex align-items-center text-center"
           :style="heroStyle">

    <div class="hero-overlay position-absolute top-0 start-0 w-100 h-100"></div>

    <div class="container position-relative z-2">
      <div class="row justify-content-center">
        <div class="col-lg-10 col-xl-8">
          
          <h1 class="hero-title text-white text-uppercase fw-bolder mb-3 animate__animated animate__fadeInDown">
            {{ data.title || 'TÍTULO DE IMPACTO AQUÍ' }}
          </h1>

          <div class="separator mx-auto mb-4 animate__animated animate__fadeIn animate__delay-1s"></div>

          <p class="hero-subtitle text-white lead fs-4 mb-5 opacity-90 fw-light animate__animated animate__fadeInUp animate__delay-1s">
            {{ data.subtitle || 'Subtítulo descriptivo que engancha al usuario y explica el valor de este curso o página.' }}
          </p>

          <div v-if="data.ctaText" class="animate__animated animate__fadeInUp animate__delay-2s">
            <button class="btn btn-esan-cta btn-lg px-5 py-3 fw-bold text-uppercase rounded-0">
              {{ data.ctaText }}
            </button>
          </div>

        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { formatImageUrl } from '@/helpers/url';



const props = defineProps<{
  data: {
    title?: string;
    subtitle?: string;
    ctaText?: string;
    image?: string;
  }
}>();
const heroStyle = computed(() => ({
  // Envolvemos la variable en formatImageUrl()
  backgroundImage: props.data.image ? `url(${formatImageUrl(props.data.image)})` : 'none',
}));
/*const heroStyle = computed(() => ({
    backgroundImage: props.data.image ? `url(${props.data.image})` : 'none',
}));
*/
</script>

<style scoped lang="scss">
// COLORES CORPORATIVOS
$esan-red: #cc0000; // Rojo intenso
$esan-dark: #111;

// --- TRUCO MAGICO: ROMPER EL CONTAINER PADRE ---
// Esto hace que el div ocupe todo el ancho de la pantalla (viewport)
// sin importar si está dentro de un col-12 o un container.
.break-out {
    width: 100vw; /* Ocupar todo el ancho de la pantalla */
    position: relative;
    left: 50%;
    right: 50%;
    margin-left: -50vw;
    margin-right: -50vw;
    
    // Altura y Propiedades
    min-height: 70vh; /* Reducir el alto para evitar que se desborde demasiado */
    background-size: contain; /* La imagen se ajustará sin recortarse */
    background-position: center; /* Mantener la imagen centrada */
    background-repeat: no-repeat;
    overflow: hidden; /* Evitar scroll horizontal accidental */
}

// --- OVERLAY ---
// Fondo con gradiente para oscurecer la imagen
.hero-overlay {
    background: linear-gradient(180deg, rgba(0,0,0,0.7) 0%, rgba(56, 4, 4, 0.85) 100%);
    backdrop-filter: blur(2px); /* Desenfoque leve para un toque moderno */
}

// --- TIPOGRAFÍA ---
// Estilos para el título en el Hero
.hero-title {
    font-size: 3.5rem; /* Tamaño escritorio */
    letter-spacing: -1px;
    text-shadow: 0 4px 10px rgba(0,0,0,0.5);

    @media (max-width: 768px) {
        font-size: 2.2rem; /* Tamaño móvil */
    }
}

.hero-subtitle {
    text-shadow: 0 2px 5px rgba(0,0,0,0.5);
    line-height: 1.6;
}

// --- ELEMENTOS DECORATIVOS ---
// La línea roja debajo del título
.separator {
    width: 80px;
    height: 4px;
    background-color: $esan-red;
}

// --- BOTÓN CTA ---
// Estilo del botón de llamada a la acción
.btn-esan-cta {
    background-color: $esan-red;
    color: white;
    border: 2px solid $esan-red;
    letter-spacing: 1px;
    transition: all 0.3s ease;
    box-shadow: 0 5px 15px rgba(0,0,0,0.3);

    &:hover {
        background-color: transparent;
        border-color: white;
        color: white;
        transform: scale(1.05); /* Crecimiento del botón en hover */
    }
}

// --- Z-INDEX ---
// Asegura que el contenido tenga un buen nivel sobre el overlay
.z-2 { z-index: 2; }

</style>