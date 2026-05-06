<script setup lang="ts">
import { computed } from 'vue';
import { formatImageUrl } from '@/helpers/url';

// --- INTERFACES ---
interface BlockConfig {
  bgColor?: string;       // Color de fondo (hex/rgba)
  invertLayout?: boolean; // false: Texto-Img | true: Img-Texto
}

interface CtaData {
  preTitle?: string;  // Ej: "NUESTROS"
  title?: string;     // Ej: "PROYECTOS"
  btnText?: string;
  btnLink?: string;
  image?: string;
  config?: BlockConfig;
}

const props = defineProps<{
  data: CtaData;
  isEditor?: boolean;
}>();

// Estilo dinámico del contenedor
const sectionStyle = computed(() => ({
  backgroundColor: props.data.config?.bgColor || 'transparent', // Por defecto transparente
}));

// Clases de animación según dirección
const textAnim = computed(() => props.data.config?.invertLayout ? 'animate-left' : 'animate-right');
const imgAnim  = computed(() => props.data.config?.invertLayout ? 'animate-right' : 'animate-left');

</script>

<template>
  <section 
    class="cta-section py-5 position-relative overflow-hidden"
    :style="sectionStyle"
  >
    <div class="container">
      <div class="row align-items-center">

        <template v-if="!data.config?.invertLayout">
          
          <div class="col-lg-2 d-none d-lg-block"></div>

          <div class="col-lg-4 col-md-5 mb-4 mb-md-0 position-relative z-10">
            <div :class="textAnim">
              <h2 v-if="data.preTitle" class="cta-pretitle text-uppercase mb-0">
                {{ data.preTitle }}
              </h2>
              <h2 v-if="data.title" class="cta-title text-uppercase fw-bold mb-4">
                {{ data.title }}
              </h2>
              
              <div v-if="data.btnText" class="mt-4">
                <a :href="data.btnLink || '#'" class="btn-cta-primary">
                  {{ data.btnText }}
                </a>
              </div>
            </div>
          </div>

          <div class="col-lg-5 col-md-6 offset-md-1 offset-lg-0">
            <div class="image-wrapper" :class="imgAnim">
              <img 
                v-if="data.image"
                :src="formatImageUrl(data.image)" 
                class="img-fluid rounded  hover-scale" 
                alt="Proyecto"
              >
            </div>
          </div>

          <div class="col-lg-1 d-none d-lg-block"></div>
        </template>


        <template v-else>
          
          <div class="col-lg-1 d-none d-lg-block"></div>

          <div class="col-lg-5 col-md-6 mb-4 mb-md-0">
            <div class="image-wrapper" :class="imgAnim">
              <img 
                v-if="data.image"
                :src="formatImageUrl(data.image)" 
                class="img-fluid rounded shadow-lg hover-scale" 
                alt="Proyecto"
              >
            </div>
          </div>

          <div class="col-lg-4 col-md-5 offset-md-1 offset-lg-0 position-relative z-10">
            <div :class="textAnim">
              <h2 v-if="data.preTitle" class="cta-pretitle text-uppercase mb-0 text-end-md">
                {{ data.preTitle }}
              </h2>
              <h2 v-if="data.title" class="cta-title text-uppercase  mb-4 text-end-md">
               <strong>{{ data.title }}</strong> 
              </h2>
              
              <div v-if="data.btnText" class="mt-4 text-end-md">
                <a :href="data.btnLink || '#'" class="btn-cta-primary">
                  {{ data.btnText }}
                </a>
              </div>
            </div>
          </div>

           <div class="col-lg-2 d-none d-lg-block"></div>

        </template>

      </div>
    </div>
  </section>
</template>

<style scoped lang="scss">
$primary-color: #f51445; // Rojo ESAN
$text-dark: #333;

.cta-section {
  transition: background-color 0.3s ease;
}

// Tipografía
.cta-pretitle {
  color: $text-dark;
  font-size: 1.5rem;
  font-weight: 500; // Letra delgada
  line-height: 1;
  letter-spacing: -1px;
}

.cta-title {
  color: $primary-color; // "PROYECTOS" en rojo o destacado
  font-size: 2rem;
  font-weight: 900; // Letra gruesa
  line-height: 1;
  letter-spacing: -1px;
}

// Botón Redondeado (sppb-btn-rounded)
.btn-cta-primary {
  display: inline-block;
  background-color: $primary-color;
  color: white;
  padding: 12px 35px;
  border-radius: 50px;
  text-decoration: none;
  font-weight: 600;
  text-transform: uppercase;
  font-size: 0.85rem;
  box-shadow: 0 4px 15px rgba(245, 20, 69, 0.3);
  transition: all 0.3s ease;

  &:hover {
    background-color: darken($primary-color, 10%);
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(245, 20, 69, 0.4);
  }
}

// Imagen
.hover-scale {
  transition: transform 0.5s ease;
  width: 100%;
  &:hover {
    transform: scale(1.02);
  }
}

.z-10 { z-index: 10; }

// Utils responsive
@media (min-width: 768px) {
  .text-end-md { text-align: right; }
}

@media (max-width: 767px) {
  .cta-pretitle, .cta-title { font-size: 2rem; text-align: center; }
  .btn-cta-primary { display: block; width: 100%; text-align: center; }
  .image-wrapper { margin-top: 20px; }
}

// Animaciones (Simulación de WOW.js)
.animate-left { animation: fadeInLeft 0.8s ease-out forwards; opacity: 0; }
.animate-right { animation: fadeInRight 0.8s ease-out forwards; opacity: 0; }

@keyframes fadeInLeft {
  from { opacity: 0; transform: translateX(-40px); }
  to { opacity: 1; transform: translateX(0); }
}

@keyframes fadeInRight {
  from { opacity: 0; transform: translateX(40px); }
  to { opacity: 1; transform: translateX(0); }
}
</style>