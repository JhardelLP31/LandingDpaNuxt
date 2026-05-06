<script setup lang="ts">
import { computed } from 'vue';
import { formatImageUrl } from '@/helpers/url';

// CONFIGURACIÓN TIPO LEGO
interface GridConfig {
  columns: number;      // 2, 3, o 4
  cardStyle: 'swipe-red' | 'minimal-border' | 'glass-dark'; 
  textAlign: 'left' | 'center';
}

interface GridItem {
  title: string;
  description: string;
  image: string;
  link: string;
}

interface UniversalGridData {
  config: GridConfig;
  items: GridItem[];
}

const props = defineProps<{
  data: UniversalGridData;
}>();

// 1. Calculamos la clase de columna de Bootstrap dinámicamente
const colClass = computed(() => {
  const cols = props.data.config?.columns || 3; // 3 por defecto
  if (cols === 2) return 'col-md-6';
  if (cols === 4) return 'col-md-6 col-lg-3';
  return 'col-md-6 col-lg-4'; // 3 columnas
});

// 2. Definimos el estilo base según la elección
const cardClass = computed(() => {
  return props.data.config?.cardStyle || 'swipe-red';
});

// 3. Alineación de texto
const alignClass = computed(() => {
  return props.data.config?.textAlign === 'center' ? 'text-center' : 'text-start';
});

</script>

<template>
  <div v-if="data && data.items.length > 0" class="universal-section section-spacing">
    <div class="container">
      
      <div class="row g-4 justify-content-center">
        
        <div 
          v-for="(item, index) in data.items" 
          :key="index" 
          :class="colClass"
        >
          <a :href="item.link || '#'" class="master-card" :class="[cardClass, alignClass]">
            
            <div class="card-bg"></div>

            <div class="card-content">
              
              <div class="icon-wrap mb-3" :class="alignClass === 'text-center' ? 'mx-auto' : ''">
                 <img 
                  v-if="item.image" 
                  :src="formatImageUrl(item.image)" 
                  class="img-fluid custom-img" 
                  alt="icon"
                >
                <i v-else class="las la-cube default-icon"></i>
              </div>

              <h4 class="card-title fw-bold">{{ item.title }}</h4>
              <p class="card-desc mb-0">{{ item.description }}</p>
            </div>

          </a>
        </div>

      </div>
    </div>
  </div>
</template>


<style scoped>
.universal-section {
  padding: 80px 0;
  /*background-color: #f8f9fa;*/
}

/* =========================================
   ESTRUCTURA BASE DE LA TARJETA
   ========================================= */
.master-card {
  display: block;
  position: relative;
  text-decoration: none;
  height: 100%;
  padding: 2.5rem 2rem;
  border-radius: 12px;
  transition: all 0.4s ease;
  overflow: hidden;
  z-index: 1;
}

.icon-wrap {
  width: 60px;
  height: 60px;
  display: flex;
  align-items: center;
  justify-content: center; /* Centra el contenido dentro del wrap */
}

.custom-img {
  max-height: 100%;
  width: auto;
  transition: 0.4s;
}

.default-icon {
  font-size: 3rem;
  transition: 0.4s;
}

/* =========================================
   ESTILO 1: SWIPE RED (El que te gustó)
   ========================================= */
.swipe-red {
  background: #fff;
  box-shadow: 0 10px 30px rgba(0,0,0,0.05);
}

.swipe-red .card-bg {
  position: absolute;
  top: 0; left: 0; width: 100%; height: 100%;
  background: linear-gradient(135deg, #e31140 0%, #c20b32 100%);
  z-index: -1;
  transform: scaleY(0);
  transform-origin: bottom;
  transition: transform 0.4s ease;
}

.swipe-red:hover .card-bg { transform: scaleY(1); }
.swipe-red:hover { transform: translateY(-10px); }

/* Colores iniciales */
.swipe-red .card-title { color: #1a1a1a; font-size: 1.25rem; transition: 0.3s; }
.swipe-red .card-desc { color: #666; font-size: 0.9rem; transition: 0.3s; }
.swipe-red .default-icon { color: #e31140; }

/* Colores Hover */
.swipe-red:hover .card-title,
.swipe-red:hover .card-desc { color: #fff; }
.swipe-red:hover .default-icon { color: #fff; transform: rotate(-10deg); }
.swipe-red:hover .custom-img { filter: brightness(0) invert(1); transform: scale(1.1); }


/* =========================================
   ESTILO 2: MINIMAL BORDER (Limpio, Apple Style)
   ========================================= */
.minimal-border {
  background: #fff;
  border: 1px solid #e5e5e5;
}

.minimal-border:hover {
  border-color: #e31140;
  box-shadow: 0 5px 20px rgba(227, 17, 64, 0.15);
  transform: translateY(-5px);
}

.minimal-border .card-title { color: #1a1a1a; font-size: 1.2rem; }
.minimal-border .card-desc { color: #555; }
.minimal-border .default-icon { color: #222; }

.minimal-border:hover .card-title { color: #e31140; } /* Solo el título cambia de color */
.minimal-border:hover .default-icon { color: #e31140; transform: scale(1.1); }


/* =========================================
   ESTILO 3: GLASS DARK (Moderno Oscuro)
   ========================================= */
.glass-dark {
  background: #2c3e50;
  color: #fff;
  border: 1px solid rgba(255,255,255,0.1);
}

.glass-dark:hover {
  background: #1a252f;
  border-color: #e31140; /* Borde rojo al hover */
}

.glass-dark .card-title { color: #fff; margin-bottom: 1rem; }
.glass-dark .card-desc { color: #ccc; }
.glass-dark .default-icon { color: #fff; opacity: 0.7; }

.glass-dark:hover .default-icon { opacity: 1; color: #e31140; text-shadow: 0 0 10px rgba(227,17,64,0.5); }

</style>