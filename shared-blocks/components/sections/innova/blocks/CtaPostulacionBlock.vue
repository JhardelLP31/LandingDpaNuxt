<script setup lang="ts">
import { computed } from 'vue';
// Ajusta la ruta a tu helper si es necesario
import { formatImageUrl } from '../../../../helpers/url';

// 1. HELPER DE IMAGEN A PRUEBA DE FALLOS
const getSafeImageUrl = (path: string) => {
  if (!path) return '';
  try { 
    return formatImageUrl(path); 
  } catch (e) { 
    return path; // Si el helper falla, devolvemos la ruta cruda para que no se rompa el CSS
  }
};

interface CtaData {
  title?: string;
  description?: string;
  buttonText?: string;
  buttonLink?: string;
  image?: string;
  overlayColor1?: string;
  overlayColor2?: string;
}

const props = defineProps<{ data: CtaData }>();

const safeData = computed(() => {
  const d = props.data || {};
  return {
    title: d.title || 'POSTULACIÓN',
    description: d.description || 'La postulación a la convocatoria del concurso es totalmente gratuita y abierta a todas las personas que deseen postular y que cumplan los requisitos.',
    buttonText: d.buttonText,
    buttonLink: d.buttonLink,
    image: d.image || '',
    overlayColor1: d.overlayColor1 || 'rgba(33, 118, 255, 0.8)',
    overlayColor2: d.overlayColor2 || 'rgba(33, 118, 255, 0.8)',
  };
});

// 2. CORRECCIÓN EN EL CÁLCULO DEL BACKGROUND
const dynamicStyles = computed(() => {
  const imageUrl = getSafeImageUrl(safeData.value.image);
  const bgImage = imageUrl ? `url('${imageUrl}')` : 'none';
  
  return {
    background: `linear-gradient(0deg, ${safeData.value.overlayColor1} 0%, ${safeData.value.overlayColor2} 100%), ${bgImage} lightgray`,
    backgroundSize: 'cover',
    backgroundPosition: 'center',
    backgroundRepeat: 'no-repeat'
  };
});
</script>

<template>
  <div class="cta-wrapper">
    <div class="decoracion-trasera"></div>

    <section class="indicadores-cta" :style="dynamicStyles">
      <div class="container text-center">
        <div class="espacio">
          
          <h2 class="titulo-principal text-white mb-4">
            {{ safeData.title }}
          </h2>
          
          <p class="descripcion-texto mx-auto">
            {{ safeData.description }}
          </p>
          
          <a v-if="safeData.buttonText" :href="safeData.buttonLink" target="_blank" class="btn-enlace mt-4">
            {{ safeData.buttonText }} <i class="fa-solid fa-angle-right ms-2"></i>
          </a>

        </div>
      </div>
    </section>
  </div>
</template>

<style scoped lang="scss">
.cta-wrapper {
  position: relative;
  margin: 80px 0;
  z-index: 1;

  .decoracion-trasera {
    content: ''; 
    width: 150px; 
    height: 150px; 
    display: block; 
    position: absolute; 
    top: 0; 
    right: 0; 
    background-color: transparent; /* var(--negro10) de tu código */
    z-index: -1; 
  }
}

.indicadores-cta {
  padding: 70px 0; 
  border-radius: 0 130px 0 130px; /* Arreglado para que recorte la esquina derecha superior */
  position: relative;
  z-index: 2;

  .espacio {
    display: flex; 
    flex-flow: column; 
    align-items: center; 
    justify-content: center;
    gap: 15px;
  }

  .titulo-principal {
    font-weight: 600;
    font-size: 2.5rem;
    text-transform: uppercase;
    text-shadow: 0px 2px 4px rgba(0, 0, 0, 0.3);
  }

  .descripcion-texto {
    color: #fff; 
    font-size: 1.15rem; 
    text-shadow: 0px 4px 8px rgba(0, 0, 0, 0.25); 
    max-width: 900px; 
    text-align: center;
    line-height: 1.6;
    margin-bottom: 0;
  }

  .btn-enlace {
    display: inline-flex;
    align-items: center;
    background-color: #222; /* --negro80 */
    color: #fff;
    padding: 14px 30px;
    border-radius: 5px;
    font-weight: 700;
    text-decoration: none;
    text-transform: uppercase;
    font-size: 0.95rem;
    transition: all 0.3s ease;

    &:hover {
      background-color: #000;
      transform: translateY(-2px);
      color: #fff;
    }
  }

  /* Responsive para replicar tu versión móvil */
  @media (max-width: 768px) {
    border-radius: 0 75px 0 75px;
    padding: 50px 0;

    .titulo-principal { font-size: 2rem; }
    .cta-wrapper .decoracion-trasera { width: 100px; height: 100px; }
  }
}
</style>