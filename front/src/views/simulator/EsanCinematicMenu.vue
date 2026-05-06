<script setup lang="ts">
import { ref, computed } from 'vue';

// --- DATOS DEL MENÚ ---
// Aquí configuras las secciones, imágenes y enlaces.
const menuItems = [
  { 
    id: 1, 
    title: 'INNOVACIÓN', 
    subtitle: 'FabLabs, IA y Transformación Digital',
    // Imagen tecnológica
    image: 'https://images.unsplash.com/photo-1451187580459-43490279c0fa?q=80&w=2072&auto=format&fit=crop', 
    link: '/innovacion' 
  },
  { 
    id: 2, 
    title: 'NETWORKING', 
    subtitle: 'Conecta con líderes de la industria',
    // Imagen corporativa/reunión
    image: 'https://images.unsplash.com/photo-1515187029135-18ee286d815b?q=80&w=2070&auto=format&fit=crop', 
    link: '/networking'
  },
  { 
    id: 3, 
    title: 'CAMPUS', 
    subtitle: 'Infraestructura de clase mundial',
    // Imagen arquitectura moderna
    image: 'https://images.unsplash.com/photo-1492538368677-f6e0afe31dcc?q=80&w=2070&auto=format&fit=crop', 
    link: '/campus'
  },
  { 
    id: 4, 
    title: 'GLOBAL', 
    subtitle: 'Semanas internacionales en 5 continentes',
    // Imagen viaje/mundo
    image: 'https://images.unsplash.com/photo-1502602898657-3e91760cbb34?q=80&w=2073&auto=format&fit=crop', 
    link: '/internacional'
  }
];

// --- ESTADOS REACTIVOS ---
const hoverIndex = ref<number | null>(null); // Cuál item miramos
const mouseX = ref(0); // Posición X del mouse
const mouseY = ref(0); // Posición Y del mouse
const isClicking = ref(false); // Si está presionando click

// --- MÉTODOS ---

// 1. Rastrear movimiento del mouse
const handleMouseMove = (e: MouseEvent) => {
  mouseX.value = e.clientX;
  mouseY.value = e.clientY;
};

// 2. Controlar Hover
const setHover = (index: number) => { hoverIndex.value = index; };
const clearHover = () => { hoverIndex.value = null; };

// 3. Navegación (Simulada)
const navigateTo = (item: any) => {
  console.log('Navegando a:', item.link);
  // EN PRODUCCIÓN USA TU ROUTER:
  // router.push(item.link);
  alert(`Redirigiendo a la sección: ${item.title}`);
};

// --- COMPUTED ---
// Calcula la posición y escala del círculo rojo
const cursorStyle = computed(() => ({
  transform: `translate(${mouseX.value}px, ${mouseY.value}px) scale(${isClicking.value ? 0.75 : 1})`,
  opacity: hoverIndex.value !== null ? 1 : 0 // Solo visible sobre la lista
}));
</script>

<template>
  <section 
    class="cinematic-section" 
    @mousemove="handleMouseMove"
    @mousedown="isClicking = true"
    @mouseup="isClicking = false"
  >
    
    <div class="bg-gallery">
      <div class="bg-image default-bg" :class="{ 'is-hidden': hoverIndex !== null }"></div>

      <div 
        v-for="(item, index) in menuItems" 
        :key="item.id"
        class="bg-image"
        :style="{ backgroundImage: `url(${item.image})` }"
        :class="{ 'is-visible': hoverIndex === index }"
      >
        <div class="overlay"></div>
      </div>
    </div>

    <div class="content-container">
      <ul class="menu-list">
        <li 
          v-for="(item, index) in menuItems" 
          :key="item.id"
          class="menu-item"
          @mouseenter="setHover(index)"
          @mouseleave="clearHover"
          @click="navigateTo(item)"
        >
          <div class="item-wrapper">
            <span class="item-index">0{{ index + 1 }}</span>
            
            <h2 class="item-title">
              <span class="text-fill">{{ item.title }}</span>
              <span class="text-stroke">{{ item.title }}</span>
            </h2>

            <span class="arrow-icon">→</span>
          </div>

          <div class="item-meta">
            <p>{{ item.subtitle }}</p>
          </div>
        </li>
      </ul>
    </div>

    <div class="custom-cursor" :style="cursorStyle">
      <span class="cursor-text">VER</span>
    </div>

  </section>
</template>

<style scoped lang="scss">
// --- VARIABLES DE DISEÑO ---
$color-bg: #0b0b0b;
$color-text: #ffffff;
$color-red: #e31140; // Rojo ESAN
$font-primary: 'Arial Black', 'Helvetica Neue', sans-serif;

// --- ESTRUCTURA PRINCIPAL ---
.cinematic-section {
  position: relative;
  height: 100vh;
  min-height: 600px;
  background-color: $color-bg;
  overflow: hidden;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: none; // OCULTA EL CURSOR DEL SISTEMA
  user-select: none;
}

// --- FONDOS ---
.bg-gallery {
  position: absolute;
  inset: 0;
  z-index: 0;
}

.bg-image {
  position: absolute;
  inset: 0;
  background-size: cover;
  background-position: center;
  opacity: 0;
  transform: scale(1.15); // Zoom inicial
  transition: opacity 0.6s ease, transform 8s ease-out; // Efecto Ken Burns

  &.default-bg {
    background-color: #111;
    opacity: 1;
    z-index: 1;
    &.is-hidden { opacity: 0.3; } // Se oscurece al hacer hover en algo
  }

  &.is-visible {
    opacity: 0.7; // Un poco transparente para leer el texto
    transform: scale(1); // Zoom hacia atrás
    z-index: 2;
  }

  .overlay {
    position: absolute;
    inset: 0;
    // Degradado para mejorar legibilidad del texto
    background: linear-gradient(to right, rgba(0,0,0,0.85) 0%, rgba(0,0,0,0.4) 100%);
  }
}

// --- LISTA DE CONTENIDO ---
.content-container {
  position: relative;
  z-index: 10;
  width: 100%;
  max-width: 1200px;
  padding: 0 2rem;
}

.menu-list {
  list-style: none;
  padding: 0;
  margin: 0;
}

.menu-item {
  border-bottom: 1px solid rgba(255,255,255,0.15);
  padding: 2rem 0;
  position: relative;
  cursor: none; // Aseguramos cursor oculto en los items
  
  // HOVER STATE
  &:hover {
    .item-title .text-fill {
      opacity: 1;
      color: white;
      transform: translateX(30px);
      -webkit-text-stroke: 0;
    }
    .text-stroke {
      opacity: 0;
      transform: translateX(30px);
    }
    .arrow-icon {
      opacity: 1;
      transform: translateX(0);
    }
    .item-meta {
      opacity: 1;
      transform: translateY(0);
    }
    .item-index {
      color: $color-red;
    }
  }
}

.item-wrapper {
  display: flex;
  align-items: center;
  gap: 3rem;
  overflow: hidden;
}

.item-index {
  font-family: monospace;
  color: #666;
  font-size: 1.2rem;
  transition: color 0.3s;
}

.item-title {
  font-family: $font-primary;
  font-size: 5.5rem; // Tamaño Gigante
  text-transform: uppercase;
  margin: 0;
  position: relative;
  line-height: 0.9;
  letter-spacing: -2px;

  @media (max-width: 768px) { font-size: 3rem; }

  // Texto Relleno (aparece al hover)
  .text-fill {
    color: $color-text;
    display: block;
    // Inicialmente transparente con borde
    color: transparent;
    -webkit-text-stroke: 1px rgba(255,255,255,0.5); 
    transition: all 0.5s cubic-bezier(0.165, 0.84, 0.44, 1);
  }

  // Texto Stroke (visible por defecto)
  .text-stroke {
    position: absolute;
    top: 0;
    left: 0;
    color: transparent;
    -webkit-text-stroke: 1px rgba(255,255,255,0.2); // Borde sutil
    pointer-events: none;
    transition: all 0.5s ease;
  }
}

.arrow-icon {
  font-size: 4rem;
  color: $color-red;
  opacity: 0;
  transform: translateX(-80px);
  transition: all 0.5s cubic-bezier(0.165, 0.84, 0.44, 1);
}

.item-meta {
  margin-top: 1rem;
  margin-left: 6rem; // Alinear visualmente
  opacity: 0;
  transform: translateY(20px);
  transition: all 0.4s ease 0.1s; // Delay ligero

  p {
    margin: 0;
    color: #ccc;
    font-size: 1.1rem;
    letter-spacing: 1px;
    font-weight: 300;
  }
}

// --- CURSOR FLOTANTE ---
.custom-cursor {
  position: fixed;
  top: 0;
  left: 0;
  width: 100px;
  height: 100px;
  background-color: $color-red;
  border-radius: 50%;
  pointer-events: none; // CRUCIAL
  z-index: 9999;
  display: flex;
  align-items: center;
  justify-content: center;
  
  // Centrar el div en la punta del mouse
  margin-left: -50px;
  margin-top: -50px;
  
  // mix-blend-mode: exclusion; // Descomenta esto si quieres que invierta colores (efecto artístico)
  box-shadow: 0 0 30px rgba(227, 17, 64, 0.4);

  // Animación suave de posición, rápida de escala
  transition: opacity 0.3s ease, transform 0.1s cubic-bezier(0.1, 0.9, 0.2, 1);

  .cursor-text {
    color: white;
    font-weight: 800;
    font-size: 0.9rem;
    letter-spacing: 2px;
    text-transform: uppercase;
  }
}
</style>