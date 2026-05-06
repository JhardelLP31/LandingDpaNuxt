<script setup lang="ts">
import { ref, onMounted, watch } from 'vue';
import { formatImageUrl } from '@/helpers/url'; 

export interface SectorItem {
  id: number;
  title: string;
  image: string; // Tienen fondo blanco
  url: string;
  color: string;
}

const props = defineProps<{
  items: SectorItem[];
}>();

const activeItem = ref<SectorItem | null>(null);

onMounted(() => {
  if (props.items.length > 0) activeItem.value = props.items[0];
});

watch(() => props.items, (newItems) => {
  if (newItems.length > 0 && !activeItem.value) activeItem.value = newItems[0];
});

const handleHover = (item: SectorItem) => {
  activeItem.value = item;
};
</script>

<template>
  <section class="dashboard-light">
    <div class="container py-5">
      
      <div class="text-center mb-5">
        <h6 class="text-muted text-uppercase ls-3">Nuestras Soluciones</h6>
      </div>

      <div class="grid-controls mb-5">
        <div 
          v-for="item in props.items" 
          :key="item.id"
          class="control-item"
          :class="{ 'is-active': activeItem?.id === item.id }"
          @mouseenter="handleHover(item)"
          :style="{ '--sector-color': item.color }"
        >
          <div class="icon-box">
             <img 
               v-if="item.image"
               :src="formatImageUrl(item.image)" 
               class="control-img blend-multiply" 
               alt="icon"
             />
             <i v-else class="las la-cube fs-3 text-dark"></i>
          </div>
          <span class="mini-label">{{ item.title }}</span>
        </div>
      </div>

      <div class="stage-area">
        <Transition name="fade-up" mode="out-in">
          
          <div v-if="activeItem" :key="activeItem.id" class="stage-content">
            
            <div class="stage-info">
              <div class="accent-line" :style="{ background: activeItem.color }"></div>
              <h2 class="display-title">{{ activeItem.title }}</h2>
              <p class="text-muted">Explora las soluciones especializadas diseñadas para este sector.</p>
              
              <router-link :to="activeItem.url" class="btn-clean" :style="{ color: activeItem.color, borderColor: activeItem.color }">
                Ver Sector <i class="las la-arrow-right"></i>
              </router-link>
            </div>

            <div class="stage-visual">
              <div class="bg-shape" :style="{ background: activeItem.color }"></div>
              
              <img 
                :src="formatImageUrl(activeItem.image)" 
                class="hero-image blend-multiply" 
                alt="Sector Hero" 
              />
            </div>

          </div>

        </Transition>
      </div>

    </div>
  </section>
</template>

<style scoped lang="scss">
// --- CONFIGURACIÓN GENERAL ---
.dashboard-light {
  background: #ffffff; // Fondo BLANCO PURO
  color: #333; // Texto oscuro
  min-height: 600px;
  position: relative;
  
  // Patrón de puntos sutil para que no se vea vacío
  background-image: radial-gradient(#e5e5e5 1px, transparent 1px);
  background-size: 20px 20px;
}

.ls-3 { letter-spacing: 3px; font-size: 0.75rem; font-weight: 700; }

// --- LA SOLUCIÓN AL FONDO BLANCO DE TUS IMÁGENES ---
.blend-multiply {
  // ESTO ES LA MAGIA:
  // Hace que todo lo blanco de la imagen se vuelva transparente.
  // Solo funciona si el fondo detrás de la imagen es claro.
  mix-blend-mode: multiply; 
  filter: contrast(1.05); // Un poco de contraste extra ayuda
  display: block;
}

// --- BOTONERA ---
.grid-controls {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  gap: 1rem;
  padding-bottom: 2rem;
  border-bottom: 1px solid #eee;
}

.control-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  cursor: pointer;
  opacity: 0.6;
  transition: all 0.3s ease;
  width: 90px;

  &:hover, &.is-active {
    opacity: 1;
    transform: translateY(-5px);
  }
}

.icon-box {
  width: 70px;
  height: 70px;
  background: #f8f9fa; // Gris muy clarito
  border-radius: 16px; // Bordes suaves
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 10px; // Espacio interno para que la imagen respire
  border: 2px solid transparent;
  transition: all 0.3s ease;
  box-shadow: 0 4px 6px rgba(0,0,0,0.02); // Sombra ultra sutil

  // Imagen dentro del botón
  .control-img {
    width: 100%;
    height: 100%;
    object-fit: contain;
  }

  // Estado Activo: Borde de color
  .control-item.is-active & {
    background: #fff;
    border-color: var(--sector-color);
    box-shadow: 0 10px 20px rgba(0,0,0,0.08); // Sombra más fuerte
  }
}

.mini-label {
  margin-top: 8px;
  font-size: 0.7rem;
  font-weight: 600;
  text-align: center;
  color: #888;
  transition: color 0.3s;

  .control-item.is-active & {
    color: var(--sector-color);
  }
}

// --- ESCENARIO ---
.stage-area {
  min-height: 350px;
  position: relative;
}

.stage-content {
  display: grid;
  grid-template-columns: 1fr 1fr;
  align-items: center;
  gap: 4rem;
  padding: 0 2rem;
}

// Info Texto
.stage-info {
  text-align: left;
}

.accent-line {
  width: 50px;
  height: 4px;
  margin-bottom: 1.5rem;
  border-radius: 2px;
}

.display-title {
  font-size: 3.5rem;
  font-weight: 800;
  color: #111;
  line-height: 1.1;
  margin-bottom: 1rem;
  letter-spacing: -1px;
}

.btn-clean {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  margin-top: 1.5rem;
  text-decoration: none;
  font-weight: 700;
  padding: 10px 24px;
  border: 2px solid;
  border-radius: 50px;
  transition: all 0.3s ease;
  background: white;
  
  &:hover {
    background: currentColor; // Se rellena del color del texto
    color: white !important; // Texto se vuelve blanco
  }
}

// Visual Derecha
.stage-visual {
  position: relative;
  height: 400px;
  display: flex;
  align-items: center;
  justify-content: center;
}

.bg-shape {
  position: absolute;
  width: 320px;
  height: 320px;
  border-radius: 50%; // Círculo perfecto
  opacity: 0.08; // MUY suave, color pastel
  transform: scale(1);
  transition: background 0.5s ease;
}

.hero-image {
  position: relative;
  z-index: 2;
  max-width: 100%;
  max-height: 320px;
  object-fit: contain;
  // Animación de flotar suave
  animation: floatLight 5s ease-in-out infinite; 
}

// --- TRANSICIONES Y ANIMACIONES ---
.fade-up-enter-active,
.fade-up-leave-active {
  transition: all 0.4s cubic-bezier(0.25, 0.46, 0.45, 0.94);
}

.fade-up-enter-from {
  opacity: 0;
  transform: translateY(15px);
}

.fade-up-leave-to {
  opacity: 0;
  transform: translateY(-15px);
}

@keyframes floatLight {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-10px); }
}

// Responsive
@media (max-width: 992px) {
  .stage-content {
    grid-template-columns: 1fr;
    text-align: center;
    gap: 2rem;
  }
  .stage-info { 
    display: flex; 
    flex-direction: column; 
    align-items: center; 
    order: 2;
  }
  .stage-visual { order: 1; height: 250px; }
  .display-title { font-size: 2.5rem; }
}
</style>