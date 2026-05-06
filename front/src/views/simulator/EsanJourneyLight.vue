<script setup lang="ts">
import { ref, computed } from 'vue';

const steps = [
  {
    id: 1,
    year: 'Fase 1',
    title: 'Advising & Match',
    description: 'Entrevista de perfilamiento directivo.',
    icon: '🎯'
  },
  {
    id: 2,
    year: 'Fase 2',
    title: 'Core Management',
    description: 'Dominio de fundamentos estratégicos.',
    icon: '⚡'
  },
  {
    id: 3,
    year: 'Fase 3',
    title: 'International',
    description: 'Viaje inmersivo a Silicon Valley.',
    icon: '✈️'
  },
  {
    id: 4,
    year: 'Fase 4',
    title: 'Business Project',
    description: 'Consultoría real aplicada.',
    icon: '🏆'
  }
];

const activeIndex = ref(0);

const setActive = (index: number) => {
  activeIndex.value = index;
};

// Barra de progreso roja
const progressStyle = computed(() => {
  const percentage = (activeIndex.value / (steps.length - 1)) * 100;
  return { width: `${percentage}%` };
});

// El "Aura" de fondo (ahora es una mancha sutil pastel)
const ambientStyle = computed(() => {
  return { left: `${(activeIndex.value / (steps.length - 1)) * 75 + 12}%` };
});
</script>

<template>
  <section class="journey-light">
    
    <div class="moving-aura" :style="ambientStyle"></div>

    <div class="container">
      <header class="header">
        <h2 class="title">Tu Ruta al <span class="highlight">Éxito</span></h2>
        <p class="subtitle">Descubre tu evolución profesional paso a paso</p>
      </header>

      <div class="timeline-track">
        <div class="line-base"></div>
        
        <div class="line-progress" :style="progressStyle"></div>

        <div class="nodes-wrapper">
          <div 
            v-for="(step, index) in steps" 
            :key="step.id"
            class="step-item"
            :class="{ 
              'is-active': activeIndex === index,
              'is-passed': activeIndex > index
            }"
            @click="setActive(index)"
          >
            <div class="indicator-dot">
              <div class="inner-dot"></div>
            </div>

            <div class="clean-card">
              <div class="card-content">
                <span class="step-icon">{{ step.icon }}</span>
                <span class="step-meta">{{ step.year }}</span>
                <h3 class="step-title">{{ step.title }}</h3>
                <p class="step-desc">{{ step.description }}</p>
              </div>
            </div>
            
          </div>
        </div>
      </div>
      
      <div class="nav-controls">
         <button class="nav-btn" @click="activeIndex = Math.max(0, activeIndex - 1)" :disabled="activeIndex === 0">←</button>
         <button class="nav-btn" @click="activeIndex = Math.min(steps.length - 1, activeIndex + 1)" :disabled="activeIndex === steps.length - 1">→</button>
      </div>

    </div>
  </section>
</template>

<style scoped lang="scss">
// --- PALETA LIGHT MODE ---
$bg-color: #ffffff;
$card-bg: #ffffff;
$text-primary: #111111;
$text-secondary: #666666;
$esan-red: #e31140;
$line-gray: #e5e7eb;
$shadow-soft: 0 10px 30px -10px rgba(0, 0, 0, 0.08);
$shadow-active: 0 25px 50px -12px rgba(227, 17, 64, 0.25); // Sombra roja suave

.journey-light {
  background-color: $bg-color;
  padding: 6rem 1rem;
  font-family: 'Helvetica Neue', Arial, sans-serif;
  position: relative;
  overflow: hidden;
  color: $text-primary;
}

// --- ATMÓSFERA ---
.moving-aura {
  position: absolute;
  top: 50%;
  width: 500px;
  height: 500px;
  background: radial-gradient(circle, rgba($esan-red, 0.08) 0%, rgba(255,255,255,0) 70%); // Muy sutil
  transform: translate(-50%, -50%);
  border-radius: 50%;
  pointer-events: none;
  transition: left 1s cubic-bezier(0.22, 1, 0.36, 1);
  z-index: 0;
}

.container {
  max-width: 1100px;
  margin: 0 auto;
  position: relative;
  z-index: 2;
}

.header {
  text-align: center;
  margin-bottom: 5rem;
  
  .title {
    font-size: 3rem;
    font-weight: 800;
    letter-spacing: -1px;
    margin: 0;
    
    .highlight {
      color: $esan-red;
      position: relative;
      display: inline-block;
      
      // Subrayado creativo
      &::after {
        content: '';
        position: absolute;
        bottom: 5px;
        left: 0;
        width: 100%;
        height: 8px;
        background: rgba($esan-red, 0.15);
        z-index: -1;
        transform: rotate(-2deg);
      }
    }
  }
  .subtitle { color: $text-secondary; font-size: 1.1rem; margin-top: 0.5rem; }
}

// --- TRACK SYSTEM ---
.timeline-track {
  position: relative;
  padding: 2rem 0;
}

.line-base {
  position: absolute;
  top: 30px;
  left: 0;
  width: 100%;
  height: 2px;
  background-color: $line-gray;
  z-index: 1;
}

.line-progress {
  position: absolute;
  top: 30px;
  left: 0;
  height: 2px;
  background-color: $esan-red;
  z-index: 2;
  transition: width 0.6s cubic-bezier(0.65, 0, 0.35, 1);
}

// --- NODOS ---
.nodes-wrapper {
  display: flex;
  justify-content: space-between;
  position: relative;
  z-index: 3;
}

.step-item {
  flex: 1;
  display: flex;
  flex-direction: column;
  align-items: center;
  cursor: pointer;
  position: relative;
  
  // Hover sutil en items inactivos
  &:not(.is-active):hover .clean-card {
    transform: translateY(-5px);
    box-shadow: 0 10px 20px rgba(0,0,0,0.05);
  }
}

// INDICADOR DE PUNTO
.indicator-dot {
  width: 20px;
  height: 20px;
  border-radius: 50%;
  background: #fff;
  border: 2px solid #ccc;
  margin-bottom: 2.5rem;
  position: relative;
  transition: all 0.4s ease;
  z-index: 10;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-top: 21px; // Alinear con línea
  
  .inner-dot {
    width: 0;
    height: 0;
    background: $esan-red;
    border-radius: 50%;
    transition: all 0.3s ease;
  }
}

// ESTADOS DEL PUNTO
.step-item.is-passed .indicator-dot {
  border-color: $esan-red;
  background: $esan-red;
}

.step-item.is-active .indicator-dot {
  border-color: $esan-red;
  transform: scale(1.3);
  box-shadow: 0 0 0 8px rgba($esan-red, 0.1); // Anillo suave externo
  
  .inner-dot {
    width: 8px;
    height: 8px;
  }
}

// --- LA TARJETA LIMPIA ---
.clean-card {
  width: 100%;
  max-width: 240px;
  background: #fff;
  border-radius: 16px;
  padding: 6px; // Padding externo para borde simulado
  transition: all 0.5s cubic-bezier(0.34, 1.56, 0.64, 1); // Efecto rebote suave
  opacity: 0.6; // Inactivos semi-transparentes
  transform: scale(0.95);
  filter: grayscale(100%); // Inactivos en gris
}

.card-content {
  background: #fff;
  padding: 1.5rem;
  border-radius: 12px;
  height: 220px;
  border: 1px solid transparent; // Preparar borde
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  text-align: left;
}

// ESTADO ACTIVO DE LA TARJETA
.step-item.is-active .clean-card {
  opacity: 1;
  transform: scale(1.05) translateY(-10px); // Sube y crece
  filter: grayscale(0%);
  box-shadow: $shadow-active; // Sombra roja elegante

  .card-content {
    border-color: rgba($esan-red, 0.1); // Borde rojo muy sutil
    background: linear-gradient(to bottom right, #fff, #fffafa);
  }
  
  .step-icon {
    transform: scale(1.2) rotate(-5deg);
  }
}

.step-icon {
  font-size: 2.5rem;
  margin-bottom: 1rem;
  display: block;
  transition: transform 0.4s ease;
}

.step-meta {
  font-size: 0.75rem;
  text-transform: uppercase;
  font-weight: 700;
  color: $esan-red;
  letter-spacing: 1px;
  margin-bottom: 0.5rem;
  display: block;
}

.step-title {
  font-size: 1.25rem;
  font-weight: 800;
  color: $text-primary;
  margin: 0 0 0.5rem 0;
  line-height: 1.2;
}

.step-desc {
  font-size: 0.9rem;
  color: $text-secondary;
  line-height: 1.5;
}

// --- CONTROLES ---
.nav-controls {
  display: flex;
  justify-content: center;
  gap: 1rem;
  margin-top: 4rem;
  
  .nav-btn {
    width: 48px;
    height: 48px;
    border-radius: 50%;
    border: 1px solid #e0e0e0;
    background: #fff;
    color: #333;
    font-size: 1.2rem;
    cursor: pointer;
    transition: all 0.2s;
    box-shadow: 0 4px 6px rgba(0,0,0,0.05);

    &:hover:not(:disabled) {
      border-color: $esan-red;
      color: $esan-red;
      transform: translateY(-2px);
      box-shadow: 0 6px 12px rgba(0,0,0,0.1);
    }
    
    &:disabled {
      opacity: 0.3;
      cursor: default;
      box-shadow: none;
    }
  }
}

// RESPONSIVE
@media (max-width: 768px) {
  .nodes-wrapper {
    flex-direction: column;
    align-items: stretch;
    padding-left: 30px; // Espacio para línea vertical
  }
  
  .timeline-track {
    // Convertir línea horizontal en vertical
    .line-base, .line-progress {
      width: 2px;
      height: 100%; // Altura completa
      left: 10px; // Posición izquierda
      top: 0;
    }
    
    .line-base { height: 100%; width: 2px;}
    .line-progress { width: 2px; height: 50%; transition: height 0.5s;}
  }

  .step-item {
    flex-direction: row;
    margin-bottom: 2rem;
    align-items: flex-start;
  }

  .indicator-dot {
    margin-top: 0;
    margin-right: 1rem;
    position: absolute;
    left: -30px; // Alinear con la línea vertical
  }

  .clean-card {
    max-width: 100%;
    transform: none !important;
  }
  
  .moving-aura { display: none; } // Ocultar aura en móvil para rendimiento
}
</style>