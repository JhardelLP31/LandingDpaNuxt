<script setup lang="ts">
import { ref, computed } from 'vue';
import { formatImageUrl } from '@/helpers/url'; 

export interface SectorItem {
  id: number;
  title: string;
  image: string;
  url: string;
  color: string;
}

const props = defineProps<{
  items: SectorItem[] // Recibimos la lista completa, no item por item
}>();

// Estado
const activeIndex = ref<number | null>(null);
const cursorX = ref(0);
const cursorY = ref(0);
const isHovering = ref(false);

// Obtenemos el item activo actual
const activeItem = computed(() => {
  return activeIndex.value !== null ? props.items[activeIndex.value] : null;
});

// Manejo del mouse (Optimizado)
const handleMouseMove = (e: MouseEvent) => {
  cursorX.value = e.clientX;
  cursorY.value = e.clientY;
};

const handleMouseEnter = (index: number) => {
  activeIndex.value = index;
  isHovering.value = true;
};

const handleMouseLeaveList = () => {
  activeIndex.value = null;
  isHovering.value = false;
};

// Estilos dinámicos para el portal (El círculo flotante)
const portalStyle = computed(() => ({
  top: `${cursorY.value}px`,
  left: `${cursorX.value}px`,
  opacity: isHovering.value ? 1 : 0,
  transform: `translate(-50%, -50%) scale(${isHovering.value ? 1 : 0})`,
  borderColor: activeItem.value ? activeItem.value.color : 'transparent'
}));

// Estilo para el fondo global (Cambia de color)
const bgStyle = computed(() => ({
  backgroundColor: activeItem.value ? activeItem.value.color : '#0a0a0a'
}));

</script>

<template>
  <section 
    class="magnetic-section" 
    :style="bgStyle"
    @mousemove="handleMouseMove"
  >
    <div class="noise-overlay"></div>

    <div class="container h-100 d-flex align-items-center">
      <ul class="sector-list" @mouseleave="handleMouseLeaveList">
        <li 
          v-for="(item, index) in props.items" 
          :key="item.id"
          class="sector-item"
          @mouseenter="handleMouseEnter(index)"
        >
          <router-link :to="item.url" class="sector-link">
            <span class="index">0{{ index + 1 }}</span>
            <h2 class="title">{{ item.title }}</h2>
            <span class="arrow">→</span>
          </router-link>
        </li>
      </ul>
    </div>

    <div class="portal-cursor" :style="portalStyle">
      <transition name="fade" mode="out-in">
        <img 
          v-if="activeItem"
          :key="activeItem.id"
          :src="formatImageUrl(activeItem.image)" 
          class="portal-image"
          alt=""
        />
      </transition>
      
      <div class="portal-label">VER SECTOR</div>
    </div>

  </section>
</template>

<style scoped lang="scss">
// --- CONFIGURACIÓN BASE ---
.magnetic-section {
  position: relative;
  min-height: 80vh; // Ocupa buena parte de la pantalla
  width: 100%;
  overflow: hidden;
  transition: background-color 0.8s cubic-bezier(0.16, 1, 0.3, 1); // Transición de color MUY suave
  cursor: none; // OCULTAMOS EL CURSOR REAL PARA USAR EL NUESTRO
  display: flex;
  align-items: center;
}

.noise-overlay {
  position: absolute;
  inset: 0;
  opacity: 0.05;
  background-image: url("data:image/svg+xml,%3Csvg viewBox='0 0 200 200' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='noiseFilter'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.65' numOctaves='3' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23noiseFilter)'/%3E%3C/svg%3E");
  pointer-events: none;
}

// --- LISTA TIPOGRÁFICA ---
.sector-list {
  list-style: none;
  padding: 0;
  margin: 0;
  width: 100%;
  position: relative;
  z-index: 10; // Encima del fondo, debajo del portal
}

.sector-item {
  border-bottom: 1px solid rgba(255, 255, 255, 0.2);
  transition: opacity 0.3s;
  
  // Cuando hacemos hover en LA LISTA, los items NO activos se opacan
  .sector-list:hover & {
    opacity: 0.3;
  }
  .sector-list:hover &:hover {
    opacity: 1; // El activo brilla
  }
}

.sector-link {
  display: flex;
  align-items: baseline;
  text-decoration: none;
  padding: 2.5rem 0; // Espaciado generoso
  color: white;
  transition: transform 0.4s ease;
  will-change: transform;

  &:hover {
    transform: translateX(30px); // Pequeño desplazamiento a la derecha
  }
}

.index {
  font-family: 'Courier New', monospace;
  font-size: 1rem;
  margin-right: 2rem;
  opacity: 0.6;
}

.title {
  font-size: 4.5rem; // Tamaño masivo
  font-weight: 800;
  text-transform: uppercase;
  margin: 0;
  letter-spacing: -2px;
  line-height: 1;
  font-family: 'Helvetica Neue', sans-serif; // O tu fuente principal
  
  @media (max-width: 768px) {
    font-size: 2.5rem;
  }
}

.arrow {
  margin-left: auto;
  font-size: 2rem;
  opacity: 0;
  transform: translateX(-20px);
  transition: all 0.4s ease;
}

.sector-link:hover .arrow {
  opacity: 1;
  transform: translateX(0);
}

// --- EL PORTAL (MAGIA VISUAL) ---
.portal-cursor {
  position: fixed; // Flota sobre todo
  width: 350px;
  height: 450px;
  border-radius: 12px; // Rectángulo vertical
  overflow: hidden;
  pointer-events: none; // IMPORTANTE: Deja pasar los clicks al texto de abajo
  z-index: 20;
  transform-origin: center center;
  transition: 
    transform 0.1s linear, // Movimiento rápido
    width 0.3s ease, 
    height 0.3s ease,
    opacity 0.3s ease;
  box-shadow: 0 30px 60px rgba(0,0,0,0.5);
  background: #000;
  border: 2px solid transparent; // Borde que tomará el color del sector
}

.portal-image {
  width: 100%;
  height: 100%;
  object-fit: cover;
  transform: scale(1.1); // Un poco de zoom para efecto
}

.portal-label {
  position: absolute;
  bottom: 20px;
  left: 50%;
  transform: translateX(-50%);
  background: rgba(0,0,0,0.7);
  color: white;
  padding: 5px 15px;
  border-radius: 20px;
  font-size: 0.8rem;
  text-transform: uppercase;
  letter-spacing: 1px;
  backdrop-filter: blur(5px);
}

// --- TRANSICIONES DE IMAGEN ---
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.2s ease, transform 0.3s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
  transform: scale(1.05);
}

// RESPONSIVE (Móvil)
@media (max-width: 768px) {
  .magnetic-section {
    cursor: auto; // Devolvemos el cursor en móvil
  }
  .portal-cursor {
    display: none; // Ocultamos el portal en móvil (muy pesado/raro tactílmente)
  }
  // En móvil volvemos a un estilo más normal o mantenemos la lista limpia
  .sector-item {
    opacity: 1 !important;
  }
  .sector-link {
    padding: 1.5rem 0;
  }
}
</style>