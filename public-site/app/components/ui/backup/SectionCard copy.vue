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
  item: SectorItem
}>();

// 1. Convertidor Hex a RGB (Números)
const hexToRgb = (hex: string) => {
  let c: any;
  if(/^#([A-Fa-f0-9]{3}){1,2}$/.test(hex)){
      c = hex.substring(1).split('');
      if(c.length === 3){
          c= [c[0], c[0], c[1], c[1], c[2], c[2]];
      }
      c = '0x'+c.join('');
      return [(c>>16)&255, (c>>8)&255, c&255].join(',');
  }
  return '44, 44, 81'; 
}

// 2. Variables Base
const themeColor = computed(() => props.item.color || '#2c2c51');
const themeRgb = computed(() => hexToRgb(themeColor.value));

// 3. --- SOLUCIÓN DEL ERROR ---
// Creamos las cadenas RGBA completas aquí en JS para que Sass no sufra.
const borderColor = computed(() => `rgba(${themeRgb.value}, 0.3)`);
const shadowColorPrimary = computed(() => `rgba(${themeRgb.value}, 0.25)`);
const shadowColorSecondary = computed(() => `rgba(${themeRgb.value}, 0.15)`);
const gradientEnd = computed(() => `rgba(0,0,0,0.8)`); // Negro transparente para el footer
</script>

<template>
  <router-link 
    :to="props.item.url" 
    class="card-link"
  >
    <article class="sector-card">
      
      <div class="card-media">
        <img 
          v-if="props.item.image"
          :src="formatImageUrl(props.item.image)" 
          :alt="props.item.title"
          class="sector-logo"
          loading="lazy"    
          decoding="async"
        >
        <div v-else class="placeholder-state">
           <i class="las la-image"></i>
        </div>

        <div class="action-btn">
          <i class="las la-arrow-right"></i>
        </div>
      </div>

      <div class="card-footer">
        <span class="decoration-line"></span>
        <h6 class="sector-title">{{ props.item.title }}</h6>
      </div>

    </article>
  </router-link>
</template>

<style scoped lang="scss">
// Definimos variables CSS locales para mantener el SCSS limpio
.sector-card {
  --card-theme: v-bind(themeColor);
  --card-border: v-bind(borderColor);
  --card-shadow-1: v-bind(shadowColorPrimary);
  --card-shadow-2: v-bind(shadowColorSecondary);
  --footer-gradient-end: v-bind(gradientEnd);

  position: relative;
  height: 100%;
  background: white;
  border-radius: 16px;
  overflow: hidden;
  transition: all 0.5s cubic-bezier(0.23, 1, 0.32, 1);
  border: 1px solid rgba(0,0,0,0.04);
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.05);

  &:hover {
    transform: translateY(-10px);
    
    // AQUI ESTABA EL ERROR: Ahora usamos la variable CSS directa
    border-color: var(--card-border);
    
    // Usamos las variables pre-calculadas
    box-shadow: 0 20px 40px -5px var(--card-shadow-1),
                0 8px 10px -6px var(--card-shadow-2);

    .sector-logo {
      transform: scale(1.08) translateY(-5px);
      filter: grayscale(0%);
      opacity: 1;
    }

    .action-btn {
      transform: scale(1);
      opacity: 1;
      background: var(--card-theme); 
      border-color: var(--card-theme);
      color: white;
    }

    .decoration-line {
      width: 40px;
      background: rgba(255,255,255,1);
    }
    
    .card-footer {
      // Usamos el color base y un gradiente CSS estándar
      background: linear-gradient(135deg, var(--card-theme) 0%, var(--footer-gradient-end) 120%);
    }
  }
}

.card-link {
  text-decoration: none;
  display: block;
  height: 100%;
  perspective: 1000px;
}

.card-media {
  height: 200px;
  position: relative;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #ffffff;
  padding: 2rem;
  z-index: 1;
  background-image: radial-gradient(#f1f1f1 1px, transparent 1px);
  background-size: 20px 20px;
}

.sector-logo {
  max-width: 80%;
  max-height: 80%;
  object-fit: contain;
  transition: transform 0.6s cubic-bezier(0.34, 1.56, 0.64, 1), 
              filter 0.4s ease, 
              opacity 0.4s ease;
  filter: grayscale(100%);
  opacity: 0.7;
}

.placeholder-state {
  width: 100%;
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: center;
  background: #f8f9fa;
  color: #dee2e6;
  font-size: 3rem;
}

.action-btn {
  position: absolute;
  bottom: -20px;
  right: 20px;
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background: white;
  border: 2px solid #f0f0f0;
  color: #333;
  display: flex;
  align-items: center;
  justify-content: center;
  transform: scale(0.8);
  opacity: 0;
  transition: all 0.4s cubic-bezier(0.175, 0.885, 0.32, 1.275);
  box-shadow: 0 5px 15px rgba(0,0,0,0.1);
  z-index: 10;
  font-size: 1.2rem;
}

.card-footer {
  position: relative;
  z-index: 2;
  padding: 1.5rem 1rem;
  text-align: center;
  
  // Fondo por defecto
  background: linear-gradient(135deg, #2c2c51 0%, #1a1a1a 100%);
  
  color: white;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  transition: background 0.5s ease;
  min-height: 90px;
}

.decoration-line {
  width: 15px;
  height: 3px;
  background: rgba(255,255,255,0.4);
  border-radius: 2px;
  margin-bottom: 0.75rem;
  transition: width 0.3s ease, background 0.3s ease;
}

.sector-title {
  margin: 0;
  font-weight: 700;
  font-size: 0.9rem;
  text-transform: uppercase;
  letter-spacing: 1.5px;
  line-height: 1.4;
  text-shadow: 0 2px 4px rgba(0,0,0,0.2);
}

@media (max-width: 768px) {
  .card-media { height: 160px; }
  .sector-logo { opacity: 1; filter: grayscale(0); }
  .action-btn { opacity: 1; transform: scale(1); bottom: 10px; right: 10px; }
}
</style>