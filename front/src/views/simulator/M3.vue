<script setup lang="ts">
import { ref } from 'vue';

interface Program {
  id: number;
  code: string;
  title: string;
  track: string;
  description: string;
  stats: string[];
}

const programs = ref<Program[]>([
  {
    id: 1,
    code: '01',
    title: 'International MBA',
    track: 'Gerencia Global',
    description: 'Doble grado simultáneo y semanas internacionales en Europa.',
    stats: ['14 Meses', 'Full Time', 'Bilingüe']
  },
  {
    id: 2,
    code: '02',
    title: 'Finanzas Corp.',
    track: 'Mercado de Capitales',
    description: 'Laboratorios Bloomberg y certificación de riesgos avanzada.',
    stats: ['#1 Ranking', 'Hybrid', 'CFA Prep']
  },
  {
    id: 3,
    code: '03',
    title: 'Marketing Digital',
    track: 'Innovation Tech',
    description: 'Growth Hacking y estrategias centradas en el cliente (CX).',
    stats: ['6 Meses', 'Online', 'Proyectos']
  }
]);

const activeId = ref<number | null>(null);

const toggleCard = (id: number) => {
  activeId.value = activeId.value === id ? null : id;
};
</script>

<template>
  <section class="lego-section">
    <div class="container">
      <header class="header">
        <h2 class="main-title">Programa <span class="highlight">Builder</span></h2>
        <p class="subtitle">Selecciona para ensamblar información</p>
      </header>

      <div class="grid-builder">
        <div 
          v-for="item in programs" 
          :key="item.id"
          class="construct-card"
          :class="{ 'is-assembled': activeId === item.id }"
          @click="toggleCard(item.id)"
        >
          <div class="card-closed-view">
            <span class="big-number">{{ item.code }}</span>
            <div class="closed-info">
              <h3>{{ item.title }}</h3>
              <span class="tap-hint">Tap to Build</span>
            </div>
          </div>

          <transition name="construct">
            <div v-if="activeId === item.id" class="card-assembled-view">
              
              <div class="lego-block header-block">
                <span class="badge">ESAN / {{ item.track }}</span>
                <h2>{{ item.title }}</h2>
              </div>

              <div class="lego-block body-block">
                <p>{{ item.description }}</p>
              </div>

              <div class="lego-block stats-block">
                <div v-for="(stat, i) in item.stats" :key="i" class="stat-brick">
                  {{ stat }}
                </div>
              </div>

              <div class="lego-block action-block">
                <button class="btn-construct">
                  <span>Solicitar Malla</span>
                  <div class="icon-box">→</div>
                </button>
              </div>

            </div>
          </transition>
          
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped lang="scss">
// --- Variables ---
$esan-red: #e31140;
$esan-dark: #111;
$esan-white: #fff;
$bg-gray: #f0f2f5;

// La clave del efecto LEGO: "Elastic Snap"
// Esto hace que las piezas reboten al llegar
$snap-ease: cubic-bezier(0.175, 0.885, 0.32, 1.275); 

.lego-section {
  background-color: $esan-white;
  padding: 4rem 1.5rem;
  font-family: 'Arial', sans-serif;
  
  .container { max-width: 1000px; margin: 0 auto; }
}

.header {
  text-align: center;
  margin-bottom: 3rem;
  .main-title { font-size: 2.5rem; font-weight: 900; color: $esan-dark; text-transform: uppercase; }
  .highlight { color: $esan-red; }
  .subtitle { color: #888; margin-top: 0.5rem; letter-spacing: 1px; text-transform: uppercase; font-size: 0.8rem; font-weight: 700;}
}

.grid-builder {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
}

// --- CONTENEDOR MAESTRO ---
.construct-card {
  background-color: $bg-gray;
  border-radius: 12px;
  position: relative;
  min-height: 200px; // Altura inicial compacta
  cursor: pointer;
  transition: all 0.5s $snap-ease; // Transición del contenedor
  overflow: hidden;
  border: 2px solid transparent;

  // Hover en estado cerrado
  &:not(.is-assembled):hover {
    transform: translateY(-5px);
    border-color: rgba($esan-red, 0.2);
    .big-number { color: $esan-red; transform: scale(1.1); }
  }

  // --- ESTADO: ENSAMBLADO (ACTIVO) ---
  &.is-assembled {
    background-color: $esan-white;
    box-shadow: 0 20px 60px rgba(0,0,0,0.15);
    border-color: $esan-red;
    min-height: 420px; // Crece para alojar las piezas
    grid-row: span 2; // Si usas grid auto-flow dense, esto ayuda
  }
}

// --- VISTA CERRADA (Fondo) ---
.card-closed-view {
  position: absolute;
  inset: 0;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  text-align: center;
  padding: 2rem;
  transition: opacity 0.3s ease;
  
  // Cuando se ensambla, lo viejo desaparece
  .construct-card.is-assembled & {
    opacity: 0.05; // Se queda muy sutil de fondo o desaparece
    pointer-events: none;
  }

  .big-number {
    font-size: 5rem;
    font-weight: 900;
    color: #dbdbdb;
    line-height: 1;
    transition: all 0.4s $snap-ease;
  }
  
  .closed-info h3 {
    margin: 1rem 0 0.5rem 0;
    font-size: 1.5rem;
    font-weight: 800;
    color: $esan-dark;
  }

  .tap-hint {
    font-size: 0.75rem;
    text-transform: uppercase;
    letter-spacing: 2px;
    background: $esan-dark;
    color: #fff;
    padding: 4px 8px;
    border-radius: 4px;
  }
}

// --- VISTA ENSAMBLADA (Las Piezas de Lego) ---
.card-assembled-view {
  position: relative;
  z-index: 10;
  padding: 1.5rem;
  height: 100%;
  display: flex;
  flex-direction: column;
  gap: 10px; // Espacio entre "ladrillos"
}

// Estilos genéricos de los bloques
.lego-block {
  background: #fff;
  padding: 1rem;
  border-radius: 8px;
  border: 1px solid #eee;
  box-shadow: 0 4px 10px rgba(0,0,0,0.03);
}

// --- ANIMACIONES DE ENTRADA (La magia del armado) ---

// 1. HEADER: Cae de arriba (Snap Down)
.header-block {
  background-color: $esan-red; // Ladrillo rojo destacado
  color: white;
  border: none;
  
  .badge { font-size: 0.7rem; opacity: 0.8; text-transform: uppercase; letter-spacing: 1px;}
  h2 { margin: 5px 0 0 0; font-size: 1.5rem; line-height: 1.1; }
}

// 2. BODY: Crece (Scale Up)
.body-block {
  flex-grow: 1;
  background-color: #FAFAFA;
  p { margin: 0; color: #555; line-height: 1.5; font-size: 0.95rem; }
}

// 3. STATS: Vienen de los lados (Slide In)
.stats-block {
  display: flex;
  gap: 8px;
  background: transparent;
  border: none;
  box-shadow: none;
  padding: 0;

  .stat-brick {
    flex: 1;
    background: #eee;
    padding: 0.8rem;
    border-radius: 6px;
    font-size: 0.8rem;
    font-weight: 700;
    text-align: center;
    color: $esan-dark;
    // Borde inferior grueso para efecto 3D
    border-bottom: 3px solid #ddd; 
  }
}

// 4. ACTION: Sube de abajo (Snap Up)
.action-block {
  background: transparent;
  border: none;
  box-shadow: none;
  padding: 0;
  margin-top: auto;

  .btn-construct {
    width: 100%;
    background-color: $esan-dark;
    color: white;
    border: none;
    padding: 1rem;
    border-radius: 8px;
    font-weight: 700;
    display: flex;
    justify-content: space-between;
    align-items: center;
    cursor: pointer;
    transition: background 0.2s;

    &:hover { background-color: lighten($esan-dark, 15%); }
    
    .icon-box {
      background: rgba(255,255,255,0.2);
      width: 24px; height: 24px;
      display: flex; align-items: center; justify-content: center;
      border-radius: 4px;
    }
  }
}

// --- KEYFRAMES & TRANSITIONS (La Coreografía) ---

// Al entrar el contenedor padre (transition="construct")
.construct-enter-active {
  transition: all 0.6s ease;
}

// Definimos los retardos para cada pieza individualmente
// "enter-active" es el estado durante la animación
.construct-enter-active {
  .header-block { animation: snap-down 0.5s $snap-ease 0.1s both; }
  .body-block   { animation: scale-in 0.5s $snap-ease 0.2s both; }
  .stat-brick   { 
    &:nth-child(1) { animation: slide-left 0.5s $snap-ease 0.3s both; }
    &:nth-child(2) { animation: slide-up 0.5s $snap-ease 0.35s both; }
    &:nth-child(3) { animation: slide-right 0.5s $snap-ease 0.4s both; }
  }
  .action-block { animation: snap-up 0.5s $snap-ease 0.5s both; }
}

// Definición de las animaciones físicas
@keyframes snap-down {
  0% { opacity: 0; transform: translateY(-50px) scale(0.9); }
  100% { opacity: 1; transform: translateY(0) scale(1); }
}

@keyframes snap-up {
  0% { opacity: 0; transform: translateY(50px); }
  100% { opacity: 1; transform: translateY(0); }
}

@keyframes scale-in {
  0% { opacity: 0; transform: scale(0.8); }
  100% { opacity: 1; transform: scale(1); }
}

@keyframes slide-left {
  0% { opacity: 0; transform: translateX(-20px); }
  100% { opacity: 1; transform: translateX(0); }
}

@keyframes slide-right {
  0% { opacity: 0; transform: translateX(20px); }
  100% { opacity: 1; transform: translateX(0); }
}

@keyframes slide-up {
  0% { opacity: 0; transform: translateY(20px); }
  100% { opacity: 1; transform: translateY(0); }
}
</style>