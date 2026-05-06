<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue';

// Referencias para el movimiento
const containerRef = ref<HTMLElement | null>(null);
const mouseX = ref(0);
const mouseY = ref(0);

// Estado para animación de contadores
const stats = ref({
  alumni: 12500,
  ranking: 1,
  partners: 75
});

// Manejo del mouse para la perspectiva 3D
const handleMouseMove = (e: MouseEvent) => {
  if (!containerRef.value) return;
  const { innerWidth, innerHeight } = window;
  
  // Normalizamos coordenadas de -1 a 1
  mouseX.value = (e.clientX / innerWidth) * 2 - 1;
  mouseY.value = (e.clientY / innerHeight) * 2 - 1;
};

// Computamos transformaciones CSS basadas en el mouse
const sceneStyle = computed(() => {
  const rotateX = mouseY.value * -10; // Inclinación vertical (max 10deg)
  const rotateY = mouseX.value * 10;  // Inclinación horizontal
  
  return {
    transform: `rotateX(${rotateX}deg) rotateY(${rotateY}deg)`
  };
});

// Computamos la luz que sigue al mouse en el grid
const spotLightStyle = computed(() => {
  // Convertimos de vuelta a porcentaje para el gradiente
  const x = (mouseX.value + 1) * 50;
  const y = (mouseY.value + 1) * 50;
  return {
    background: `radial-gradient(circle at ${x}% ${y}%, rgba(227, 17, 64, 0.3) 0%, transparent 40%)`
  };
});

</script>

<template>
  <section 
    class="holo-section" 
    @mousemove="handleMouseMove"
    ref="containerRef"
  >
    <div class="space-bg"></div>
    
    <div class="particles">
      <div class="p p1"></div><div class="p p2"></div><div class="p p3"></div>
    </div>

    <div class="stage-3d">
      <div class="content-plane" :style="sceneStyle">
        
        <div class="grid-floor">
          <div class="grid-light" :style="spotLightStyle"></div>
          <div class="grid-lines"></div>
        </div>

        <div class="floating-ui">
          
          <div class="glass-card card-left">
            <div class="card-header">
              <span class="icon">📊</span>
              <span class="label">PERFORMANCE</span>
            </div>
            <div class="stat-row">
              <h3 class="stat-val">TOP {{ stats.ranking }}</h3>
              <p class="stat-desc">Escuela de Negocios en Perú</p>
            </div>
            <div class="stat-row">
              <h3 class="stat-val">+{{ stats.partners }}</h3>
              <p class="stat-desc">Convenios Internacionales</p>
            </div>
            <div class="mini-chart">
              <div class="bar" style="height: 40%"></div>
              <div class="bar" style="height: 70%"></div>
              <div class="bar" style="height: 50%"></div>
              <div class="bar active" style="height: 100%"></div>
            </div>
          </div>

          <div class="hero-center">
            <h2 class="glitch-title" data-text="ECOSYSTEM">ECOSYSTEM</h2>
            <p class="hero-subtitle">
              Donde la <span class="txt-red">Innovación</span> converge con la <span class="txt-red">Estrategia</span>.
            </p>
            <button class="cta-hologram">
              <span class="btn-txt">EXPLORAR CAMPUS</span>
              <div class="btn-glare"></div>
            </button>
          </div>

          <div class="glass-card card-right">
            <div class="card-header">
              <span class="icon">🌍</span>
              <span class="label">NETWORK</span>
            </div>
            <div class="network-grid">
              <div class="avatar" style="background-image: url('https://i.pravatar.cc/100?img=33')"></div>
              <div class="avatar" style="background-image: url('https://i.pravatar.cc/100?img=47')"></div>
              <div class="avatar" style="background-image: url('https://i.pravatar.cc/100?img=12')"></div>
              <div class="avatar plus">+12k</div>
            </div>
            <p class="stat-desc mt-2">Líderes transformando industrias globalmente.</p>
            
            <div class="live-indicator">
              <span class="dot"></span> LIVE CONNECT
            </div>
          </div>

        </div>
      </div>
    </div>
  </section>
</template>

<style scoped lang="scss">
// --- VARIABLES ---
$esan-red: #e31140;
$dark-bg: #050505;
$glass-bg: rgba(20, 20, 25, 0.6);
$glass-border: rgba(255, 255, 255, 0.1);
$neon-shadow: 0 0 20px rgba(227, 17, 64, 0.4);

.holo-section {
  position: relative;
  height: 100vh;
  min-height: 700px;
  background-color: $dark-bg;
  overflow: hidden;
  display: flex;
  justify-content: center;
  align-items: center;
  font-family: 'Rajdhani', 'Helvetica Neue', sans-serif; // Fuente tecnológica
  color: white;
  perspective: 1200px; // Clave para la profundidad
}

.space-bg {
  position: absolute;
  inset: 0;
  background: radial-gradient(circle at center, #1a1a20 0%, #000 100%);
  z-index: 0;
}

// --- ESCENARIO 3D ---
.stage-3d {
  width: 100%;
  height: 100%;
  display: flex;
  justify-content: center;
  align-items: center;
  transform-style: preserve-3d;
}

.content-plane {
  position: relative;
  width: 90%;
  max-width: 1200px;
  height: 600px;
  transform-style: preserve-3d;
  transition: transform 0.1s linear; // Movimiento suave
}

// --- SUELO GRID (TRON STYLE) ---
.grid-floor {
  position: absolute;
  width: 200%; // Más ancho para que no se vea el corte al girar
  height: 200%;
  top: -50%;
  left: -50%;
  transform: rotateX(60deg) translateZ(-100px); // Acostado
  z-index: 0;
  pointer-events: none;
  
  .grid-lines {
    width: 100%;
    height: 100%;
    background-image: 
      linear-gradient(rgba(255, 255, 255, 0.05) 1px, transparent 1px),
      linear-gradient(90deg, rgba(255, 255, 255, 0.05) 1px, transparent 1px);
    background-size: 50px 50px;
    mask-image: radial-gradient(circle, black 30%, transparent 70%); // Desvanece bordes
  }

  .grid-light {
    position: absolute;
    inset: 0;
    mix-blend-mode: screen;
    transition: background 0.1s linear;
  }
}

// --- INTERFAZ FLOTANTE ---
.floating-ui {
  position: relative;
  display: grid;
  grid-template-columns: 300px 1fr 300px;
  gap: 2rem;
  align-items: center;
  height: 100%;
  z-index: 10;
  transform-style: preserve-3d;

  @media (max-width: 1024px) {
    grid-template-columns: 1fr;
    text-align: center;
    gap: 4rem;
  }
}

// --- ESTILOS DE TARJETAS (GLASSMORPHISM) ---
.glass-card {
  background: $glass-bg;
  backdrop-filter: blur(12px); // Desenfoque potente
  border: 1px solid $glass-border;
  border-radius: 16px;
  padding: 2rem;
  box-shadow: 0 20px 50px rgba(0,0,0,0.5);
  transform: translateZ(50px); // Flota más cerca de la cámara
  transition: all 0.3s ease;
  position: relative;
  overflow: hidden;

  // Brillo en borde al hover
  &:hover {
    border-color: rgba($esan-red, 0.5);
    box-shadow: $neon-shadow;
    transform: translateZ(80px) scale(1.02); // Se acerca más
  }

  // Reflejo diagonal
  &::before {
    content: '';
    position: absolute;
    top: 0; left: -100%;
    width: 100%; height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.1), transparent);
    transition: left 0.5s;
  }
  &:hover::before { left: 100%; }
}

// Animación de flotación independiente
.card-left { animation: float 6s ease-in-out infinite; }
.card-right { animation: float 6s ease-in-out infinite 3s; } // Delay para desincronizar

// --- CONTENIDO DE TARJETAS ---
.card-header {
  display: flex;
  align-items: center;
  gap: 0.8rem;
  margin-bottom: 1.5rem;
  color: #888;
  font-size: 0.9rem;
  font-weight: 700;
  letter-spacing: 1px;
}

.stat-val {
  font-size: 2.5rem;
  margin: 0;
  font-weight: 800;
  background: linear-gradient(to right, #fff, #aaa);
  -webkit-background-clip: text;
  color: transparent;
}

.stat-desc {
  font-size: 0.9rem;
  color: #bbb;
  margin-top: 0.2rem;
  margin-bottom: 1.5rem;
}

.mini-chart {
  display: flex;
  align-items: flex-end;
  gap: 8px;
  height: 60px;
  margin-top: 1rem;
  
  .bar {
    width: 10px;
    background: rgba(255,255,255,0.1);
    border-radius: 4px;
    &.active { 
      background: $esan-red; 
      box-shadow: 0 0 10px $esan-red;
    }
  }
}

.network-grid {
  display: flex;
  gap: -10px; // Avatar stack
  margin-bottom: 1rem;
  .avatar {
    width: 40px; height: 40px;
    border-radius: 50%;
    border: 2px solid $dark-bg;
    background-size: cover;
    &.plus {
      background: #333;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 0.8rem;
      font-weight: bold;
    }
  }
}

.live-indicator {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  font-size: 0.8rem;
  color: $esan-red;
  font-weight: bold;
  
  .dot {
    width: 8px; height: 8px;
    background: $esan-red;
    border-radius: 50%;
    animation: blink 2s infinite;
  }
}

// --- CENTRO HERO ---
.hero-center {
  text-align: center;
  transform: translateZ(0); // Plano base
}

.glitch-title {
  font-size: 5rem;
  font-weight: 900;
  letter-spacing: -2px;
  margin: 0;
  position: relative;
  color: white;
  text-shadow: 0 0 20px rgba(255,255,255,0.2);
  
  // Efecto decorativo
  &::after {
    content: attr(data-text);
    position: absolute;
    left: 2px; text-shadow: -1px 0 red;
    top: 0; color: white;
    background: $dark-bg;
    overflow: hidden;
    clip: rect(0, 900px, 0, 0);
    animation: glitch 3s infinite linear alternate-reverse;
  }
}

.hero-subtitle {
  font-size: 1.2rem;
  color: #aaa;
  margin: 1.5rem 0 2.5rem 0;
  .txt-red { color: $esan-red; text-shadow: 0 0 10px rgba($esan-red, 0.5); }
}

// BOTÓN HOLOGRAMA
.cta-hologram {
  background: transparent;
  border: 1px solid $esan-red;
  color: $esan-red;
  padding: 1rem 2.5rem;
  font-size: 1rem;
  font-weight: 700;
  letter-spacing: 2px;
  text-transform: uppercase;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: all 0.3s;
  box-shadow: 0 0 10px rgba($esan-red, 0.2);

  &:hover {
    background: $esan-red;
    color: white;
    box-shadow: 0 0 30px $esan-red;
  }
}

// --- PARTICULAS ---
.p {
  position: absolute;
  background: white;
  border-radius: 50%;
  opacity: 0.3;
}
.p1 { width: 4px; height: 4px; top: 20%; left: 20%; animation: float 10s infinite; }
.p2 { width: 3px; height: 3px; top: 60%; right: 10%; animation: float 15s infinite reverse; }
.p3 { width: 6px; height: 6px; bottom: 10%; left: 40%; animation: float 12s infinite 1s; }

// --- KEYFRAMES ---
@keyframes float {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-20px); }
}

@keyframes blink {
  0%, 100% { opacity: 1; }
  50% { opacity: 0.3; }
}

@keyframes glitch {
  0% { clip: rect(20px, 9999px, 10px, 0); }
  5% { clip: rect(50px, 9999px, 80px, 0); }
  10% { clip: rect(0, 0, 0, 0); }
  100% { clip: rect(0, 0, 0, 0); }
}

// MOBILE
@media (max-width: 768px) {
  .glitch-title { font-size: 3rem; }
  .grid-floor { display: none; } // Ahorro de batería en móvil
  .glass-card { margin-bottom: 2rem; }
  .holo-section { height: auto; padding: 4rem 1rem; }
}
</style>