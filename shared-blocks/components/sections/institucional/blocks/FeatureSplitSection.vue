<script setup lang="ts">
import { computed } from 'vue';

const props = defineProps<{
  data: any
}>();

// Valores por defecto basados en la imagen y HTML de ESAN DPA Modalidad
const titleColor = computed(() => props.data?.titleColor || '#000000'); // Negro bold
const textColor = computed(() => props.data?.textColor || '#333333'); // Gris oscuro legible
const bgColor = computed(() => props.data?.bgColor || '#ffffff'); // Blanco limpio
const btnColor = computed(() => props.data?.btnColor || '#ff2b2b'); // Rojo DPA

// Prop clave para invertir el diseño
const isInverted = computed(() => props.data?.inverted || false);
</script>

<template>
  <section class="feature-split-section" :style="{ backgroundColor: bgColor }" :class="{ 'layout-inverted': isInverted }">
    
    <div class="feature-split-row align-items-stretch">
        
        <div class="column-media p-0">
          <div class="image-wrapper-full" v-if="props.data?.imageSrc">
            <img 
              :src="props.data.imageSrc" 
              alt="Imagen Destacada" 
              class="full-bleed-img"
            >
          </div>
          <div v-else class="media-placeholder-full bg-light d-flex align-items-center justify-content-center">
            <i class="las la-image fs-1 text-muted"></i>
          </div>
        </div>

        <div class="column-text">
          <div class="text-container-inner">
            <div class="text-content text-start">
              
              <h1 class="section-title" v-if="props.data?.title" :style="{ color: titleColor }" v-html="props.data.title"></h1>
              
              <h4 class="section-description" v-if="props.data?.description" :style="{ color: textColor }">
                {{ props.data.description }}
              </h4>
              
              <div class="action-wrapper mt-4">
                <a v-if="props.data?.btnText" 
                   :href="props.data?.btnUrl || '#'" 
                   target="_blank" 
                   rel="noopener noreferrer" 
                   class="btn-dpa-outlined" 
                   :style="{ backgroundColor: btnColor }">
                  {{ props.data.btnText }}
                </a>
              </div>

            </div>
          </div>
        </div>

    </div>
  </section>
</template>

<style scoped>
/* --- ESTILOS DE LA SECCIÓN --- */
.feature-split-section {
  position: relative;
  overflow: hidden;
  width: 100%;
  min-height: 500px;
  /* Para que el section stretch el flex row interno */
  display: flex; 
  align-items: stretch;
}

/* El row principal que divide la pantalla 50/50 */
.feature-split-row {
  display: flex;
  width: 100%;
  flex: 1;
}

/* Clase dinámica para INVERTIR el orden (Texto L, Imagen R) */
.layout-inverted .feature-split-row {
  flex-direction: row-reverse;
}

/* Base de las columnas */
.column-media,
.column-text {
  flex: 0 0 50%;
  width: 50%;
  max-width: 50%;
}

/* --- COLUMNA DE IMAGEN --- */
.column-media {
  padding: 0 !important; /* Clave: cero padding para chocar con paredes */
  position: relative;
}
.image-wrapper-full {
  width: 100%;
  height: 100%;
}
.full-bleed-img {
  width: 100%;
  height: 100%; /* Ocupa el 100% de la altura de la sección */
  object-fit: cover; /* Clave: rellenar el área sin distorsionarse */
  display: block;
}
.media-placeholder-full {
  height: 100%;
  min-height: 400px;
  border: 2px dashed #ccc;
}

/* --- COLUMNA DE TEXTO --- */
.column-text {
  display: flex;
  align-items: center; /* Centrado vertical del texto dentro de su 50% */
  position: relative;
  /* Espaciado vertical del bloque de texto */
  padding: 60px 0; 
}

/* Contenedor interno para dar aire al texto y simular el col-md-5 + col-md-1 */
.text-container-inner {
  width: 100%;
  display: flex;
}

/* Contenedor final del texto para controlar su ancho máximo */
.text-content {
  max-width: 700px; /* Contain text within col */
  width: 100%;
}

/* -- ALINEACIÓN DEL TEXTO SEGÚN DISEÑO -- */

/* Diseño ESTÁNDAR (Imagen Izquierda, Texto Derecha): Simular el col-md-1 offset */
.feature-split-section:not(.layout-inverted) .text-container-inner {
  padding-left: 100px; /* El 'spacer' col-md-1 aproximado */
  padding-right: 50px; /* Contención a la derecha */
}

/* Diseño INVERTIDO (Texto Izquierda, Imagen Derecha): Texto alineado a la izquierda */
.layout-inverted .text-container-inner {
  padding-right: 100px; /* El 'spacer' col-md-1 aproximado */
  padding-left: 50px; /* Contención a la izquierda */
}

/* --- TEXTOS (Mismos estilos que antes) --- */
.section-title {
  font-size: clamp(32px, 4vw, 40px);
  font-weight: 800;
  line-height: 1.2;
  margin-bottom: 25px;
  text-transform: uppercase;
}
.section-description {
  font-size: 18px;
  font-weight: 300;
  line-height: 1.5;
  margin-bottom: 30px;
  white-space: pre-line;
}

/* --- BOTÓN --- */
.btn-dpa-outlined {
  display: inline-block;
  text-decoration: none;
  color: white;
  padding: 10px 25px;
  border-radius: 4px;
  font-weight: 700;
  font-size: 13px;
  text-transform: uppercase;
  transition: all 0.3s ease;
  text-align: center;
}
.btn-dpa-outlined:hover {
  filter: brightness(1.15);
  transform: translateY(-2px);
}

/* --- RESPONSIVE --- */
@media (max-width: 992px) {
  .feature-split-section {
    padding: 0; /* Quitamos padding vertical de section */
    flex-direction: column;
  }
  .feature-split-row {
    flex-direction: column !important; /* Forzamos columna en móvil siempre */
    height: auto;
  }
  .column-media,
  .column-text {
    flex: 0 0 100%;
    width: 100%;
    max-width: 100%;
  }
  /* mobile ordering handled by flex wrap in CSS, row-reverse reset to row in CSS media query previously */
  .layout-inverted .feature-split-row {
      flex-direction: column-reverse; /* ensure image is standard mobile position usually */
  }

  .full-bleed-img {
    height: auto;
    min-height: 300px;
  }
  .column-text {
    padding: 40px 20px;
    text-align: center;
  }
  .text-container-inner {
    padding: 0 !important; /* reset specific paddings */
    justify-content: center;
  }
  .text-content {
    text-align: center;
    margin: 0 auto;
  }
}
</style>