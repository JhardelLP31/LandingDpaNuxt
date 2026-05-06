<script setup lang="ts">
import { computed } from 'vue';
import { formatImageUrl } from '@/helpers/url'; 

export interface SectorItem {
  id: number;
  title: string;
  image: string;
  url: string;
  color: string;
}

const props = defineProps<{
  item: SectorItem;
}>();

// --- HELPERS DE COLOR ---
const hexToRgb = (hex: string) => {
  let c: any;
  if(!/^#([A-Fa-f0-9]{3}){1,2}$/.test(hex)) return '44, 44, 81';
  c = hex.substring(1).split('');
  if(c.length === 3) c = [c[0], c[0], c[1], c[1], c[2], c[2]];
  c = '0x' + c.join('');
  return [(c>>16)&255, (c>>8)&255, c&255].join(',');
}

const themeColor = computed(() => props.item.color || '#2c2c51');
const themeRgb = computed(() => hexToRgb(themeColor.value));

</script>

<template>
  <router-link :to="props.item.url" class="hex-wrapper">
    
    <div class="hex-container">
      
      <div class="hex-border-spinner"></div>
      
      <div class="hex-content">
        <div class="hex-image-mask">
          <img 
            v-if="props.item.image"
            :src="formatImageUrl(props.item.image)" 
            :alt="props.item.title"
            class="sector-img"
            loading="lazy"
          >
          <div v-else class="fallback-icon">
            <i class="las la-cube"></i>
          </div>
        </div>
        
        <div class="hex-overlay">
            <i class="las la-arrow-right action-icon"></i>
        </div>
      </div>

    </div>

    <div class="text-content">
      <h5 class="title">{{ props.item.title }}</h5>
      <div class="decoration-dots">
        <span></span><span></span><span></span>
      </div>
    </div>

  </router-link>
</template>

<style scoped lang="scss">
.hex-wrapper {
  // Variables CSS Nativas
  --hex-color: v-bind(themeColor);
  --hex-rgb: v-bind(themeRgb);
  
  display: flex;
  flex-direction: column;
  align-items: center;
  text-decoration: none;
  cursor: pointer;
  padding: 1rem;
  group: hex; // Para referencias
}

.hex-container {
  position: relative;
  width: 200px;
  height: 230px; // El hexágono es más alto que ancho
  display: flex;
  align-items: center;
  justify-content: center;
  transition: transform 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

// --- LA MAGIA DEL HEXÁGONO ---
// Usamos clip-path para cortar todo en forma de hexágono
.hex-content {
  width: 190px;
  height: 220px;
  background: #f1f1f1; // Color de fondo si la imagen no carga
  
  // Coordenadas del polígono hexagonal
  clip-path: polygon(50% 0%, 100% 25%, 100% 75%, 50% 100%, 0% 75%, 0% 25%);
  
  position: relative;
  z-index: 2;
  transition: all 0.3s ease;
}

.hex-image-mask {
  width: 100%;
  height: 100%;
  background: white;
  display: flex;
  align-items: center;
  justify-content: center;
}

.sector-img {
  width: 100%;
  height: 100%;
  object-fit: cover; // Cubre todo el hexágono
  transition: transform 0.5s ease, filter 0.5s ease;
  filter: grayscale(100%) contrast(1.1); // B/N estilizado
}

.fallback-icon {
  font-size: 4rem;
  color: #ddd;
}

// --- BORDE GIRATORIO ---
.hex-border-spinner {
  position: absolute;
  inset: -5px; // Un poco más grande que el contenido
  background: conic-gradient(from 0deg, transparent 0%, var(--hex-color) 50%, transparent 100%);
  
  // Aplicamos la misma forma pero al contenedor del borde
  clip-path: polygon(50% 0%, 100% 25%, 100% 75%, 50% 100%, 0% 75%, 0% 25%);
  
  opacity: 0; // Invisible por defecto
  z-index: 1;
  transition: opacity 0.3s ease;
  animation: spin 4s linear infinite; // Gira constantemente
}

// --- OVERLAY ---
.hex-overlay {
  position: absolute;
  inset: 0;
  background: rgba(var(--hex-rgb), 0.9); // Color sólido con poca transparencia
  display: flex;
  align-items: center;
  justify-content: center;
  opacity: 0;
  transition: opacity 0.3s ease;
}

.action-icon {
  color: white;
  font-size: 2.5rem;
  transform: scale(0) rotate(-45deg);
  transition: transform 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
}

// --- TEXTO ---
.text-content {
  margin-top: 1rem;
  text-align: center;
}

.title {
  color: #333;
  font-weight: 800;
  text-transform: uppercase;
  font-size: 1rem;
  letter-spacing: 1px;
  margin-bottom: 0.5rem;
  transition: color 0.3s ease;
}

.decoration-dots span {
  display: inline-block;
  width: 6px;
  height: 6px;
  background: #ddd;
  border-radius: 50%;
  margin: 0 3px;
  transition: background 0.3s ease;
}

// --- HOVER EFFECTS ---
.hex-wrapper:hover {
  
  .hex-container {
    transform: scale(1.05); // Crece un poco
    filter: drop-shadow(0 15px 30px rgba(var(--hex-rgb), 0.4)); // Sombra brillante del color del sector
  }

  .hex-border-spinner {
    opacity: 1; // Aparece el borde giratorio
  }

  .sector-img {
    filter: grayscale(0%); // Recupera color
    transform: scale(1.1);
  }

  .hex-overlay {
    opacity: 1;
  }

  .action-icon {
    transform: scale(1) rotate(0deg);
  }

  .title {
    color: var(--hex-color);
  }

  // Puntos decorativos se colorean en secuencia
  .decoration-dots span {
    background: var(--hex-color);
  }
  .decoration-dots span:nth-child(2) { transition-delay: 0.1s; }
  .decoration-dots span:nth-child(3) { transition-delay: 0.2s; }
}

@keyframes spin {
  from { transform: rotate(0deg); }
  to { transform: rotate(360deg); }
}
</style>