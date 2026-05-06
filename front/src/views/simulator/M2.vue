<script setup lang="ts">
import { ref } from 'vue';

interface Program {
  id: number;
  code: string;
  name: string;
  category: string;
  description: string;
  features: string[];
}

const programs = ref<Program[]>([
  {
    id: 1,
    code: 'MBA',
    name: 'International MBA',
    category: 'Maestría',
    description: 'La experiencia que redefine tu liderazgo global. Doble grado y semanas internacionales.',
    features: ['Tiempo Completo', '14 Meses', 'Doble Grado']
  },
  {
    id: 2,
    code: 'FIN',
    name: 'M. en Finanzas',
    category: 'Especialización',
    description: 'Domina los mercados de capitales con tecnología Bloomberg y Thomson Reuters.',
    features: ['Ranking #1', 'Bolsa de Valores', 'Networking']
  },
  {
    id: 3,
    code: 'MKT',
    name: 'Marketing Digital',
    category: 'Ejecutivo',
    description: 'Estrategias de Growth y Analítica para la era de la inteligencia artificial.',
    features: ['Híbrido', 'Casos Reales', 'Certificación']
  }
]);

const activeId = ref<number | null>(null);

const toggleTile = (id: number) => {
  // Si tocas el mismo, se cierra. Si tocas otro, se abre ese y cierra el anterior.
  activeId.value = activeId.value === id ? null : id;
};
</script>

<template>
  <section class="esan-bento">
    <div class="container">
      <header class="grid-header">
        <h2 class="title">Excelencia <span class="highlight">Académica</span></h2>
        <p class="subtitle">Descubre tu próximo paso profesional</p>
      </header>

      <div class="bento-grid">
        <article 
          v-for="item in programs" 
          :key="item.id"
          class="bento-tile"
          :class="{ 'is-active': activeId === item.id }"
          @click="toggleTile(item.id)"
        >
          <div class="tile-front">
            <div class="top-badge">
              <span class="dot"></span>
              {{ item.category }}
            </div>
            <h3 class="big-code">{{ item.code }}</h3>
            <div class="front-footer">
              <p class="program-name">{{ item.name }}</p>
              <button class="btn-circle">
                <span class="plus-icon">+</span>
              </button>
            </div>
          </div>

          <div class="tile-back">
            <div class="back-content">
              <h3 class="back-title">{{ item.name }}</h3>
              <p class="back-desc">{{ item.description }}</p>
              
              <div class="features-list">
                <span v-for="feat in item.features" :key="feat" class="pill">
                  {{ feat }}
                </span>
              </div>

              <button class="btn-cta">
                Ver Malla Curricular
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
                  <path d="M5 12h14M12 5l7 7-7 7"/>
                </svg>
              </button>
            </div>
            
            <div class="watermark">{{ item.code }}</div>
          </div>
        </article>
      </div>
    </div>
  </section>
</template>

<style scoped lang="scss">
// --- Variables ---
$esan-red: #e31140;
$esan-black: #111111;
$esan-white: #ffffff;
$esan-gray: #f4f4f4;

// Curvas de animación "Apple-style"
$ease-bounce: cubic-bezier(0.34, 1.56, 0.64, 1);
$ease-smooth: cubic-bezier(0.4, 0, 0.2, 1);

.esan-bento {
  background-color: #fff;
  padding: 5rem 1.5rem;
  font-family: 'Helvetica Neue', Arial, sans-serif; // Fuente limpia

  .container {
    max-width: 1100px;
    margin: 0 auto;
  }
}

.grid-header {
  text-align: center;
  margin-bottom: 4rem;

  .title {
    font-size: 3rem;
    font-weight: 800;
    margin: 0;
    letter-spacing: -1px;
    color: $esan-black;
    .highlight { color: $esan-red; }
  }
  .subtitle { color: #888; margin-top: 0.5rem; font-size: 1.1rem; }
}

// --- GRID LAYOUT ---
.bento-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 2rem;
}

// --- LA TARJETA INTELIGENTE ---
.bento-tile {
  position: relative;
  height: 380px; // Tarjetas altas/cuadradas
  background-color: $esan-gray;
  border-radius: 24px; // Bordes muy redondeados (Modern UI)
  cursor: pointer;
  overflow: hidden;
  transition: transform 0.4s $ease-bounce, box-shadow 0.4s ease;
  user-select: none;

  // Hover en estado inactivo
  &:not(.is-active):hover {
    transform: translateY(-8px);
    box-shadow: 0 15px 30px rgba(0,0,0,0.1);
    
    .btn-circle {
      background-color: $esan-black;
      color: $esan-white;
      transform: scale(1.1);
    }
  }

  // --- ESTADO ACTIVO (Click) ---
  &.is-active {
    background-color: $esan-red; // ¡CAMBIO DE COLOR DRAMÁTICO!
    box-shadow: 0 20px 50px rgba(227, 17, 64, 0.3);
    
    // Animación de salida de la capa frontal
    .tile-front {
      transform: translateY(-50px);
      opacity: 0;
      pointer-events: none;
    }

    // Animación de entrada de la capa trasera
    .tile-back {
      opacity: 1;
      transform: translateY(0);
      
      // Staggering de hijos (Efecto "Armado")
      .back-title { opacity: 1; transform: translateY(0); transition-delay: 0.1s; }
      .back-desc { opacity: 1; transform: translateY(0); transition-delay: 0.2s; }
      .features-list { opacity: 1; transform: translateY(0); transition-delay: 0.3s; }
      .btn-cta { opacity: 1; transform: translateY(0); transition-delay: 0.4s; }
      .watermark { opacity: 0.1; transform: scale(1) rotate(-10deg); transition-delay: 0.2s; }
    }
  }
}

// --- CAPA FRONTAL (Minimalista) ---
.tile-front {
  position: absolute;
  inset: 0;
  padding: 2.5rem;
  display: flex;
  flex-direction: column;
  justify-content: space-between;
  transition: all 0.5s $ease-smooth;
  
  .top-badge {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 0.85rem;
    font-weight: 600;
    color: #666;
    text-transform: uppercase;
    letter-spacing: 1px;

    .dot {
      width: 8px;
      height: 8px;
      background-color: $esan-red;
      border-radius: 50%;
    }
  }

  .big-code {
    font-size: 5rem; // Tipografía gigante
    font-weight: 900;
    color: rgba(0,0,0,0.05); // Muy sutil
    margin: 0;
    line-height: 1;
    align-self: flex-start;
  }

  .front-footer {
    display: flex;
    justify-content: space-between;
    align-items: flex-end;
  }

  .program-name {
    font-size: 1.5rem;
    font-weight: 800;
    color: $esan-black;
    line-height: 1.1;
    max-width: 70%;
  }

  .btn-circle {
    width: 48px;
    height: 48px;
    border-radius: 50%;
    border: none;
    background-color: #fff;
    box-shadow: 0 4px 10px rgba(0,0,0,0.05);
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.5rem;
    transition: all 0.3s ease;
    cursor: pointer;
  }
}

// --- CAPA TRASERA (Detalles) ---
.tile-back {
  position: absolute;
  inset: 0;
  padding: 2.5rem;
  opacity: 0; // Oculto al inicio
  transform: translateY(20px); // Baja un poco al inicio
  transition: all 0.5s $ease-bounce;
  display: flex;
  flex-direction: column;
  justify-content: center;
  color: $esan-white; // Texto blanco sobre fondo rojo
  overflow: hidden;

  // Elementos internos (inicialmente ocultos para el stagger)
  .back-title, .back-desc, .features-list, .btn-cta {
    opacity: 0;
    transform: translateY(20px);
    transition: all 0.4s ease;
    position: relative;
    z-index: 2;
  }

  .back-title {
    font-size: 2rem;
    font-weight: 800;
    margin: 0 0 1rem 0;
    line-height: 1.1;
  }

  .back-desc {
    font-size: 1rem;
    line-height: 1.5;
    opacity: 0.9;
    margin-bottom: 2rem;
  }

  .features-list {
    display: flex;
    flex-wrap: wrap;
    gap: 0.5rem;
    margin-bottom: 2rem;

    .pill {
      background: rgba(255,255,255, 0.2);
      padding: 0.4rem 0.8rem;
      border-radius: 20px;
      font-size: 0.8rem;
      font-weight: 600;
      backdrop-filter: blur(4px);
    }
  }

  .btn-cta {
    background-color: $esan-white;
    color: $esan-red;
    border: none;
    padding: 1rem 1.5rem;
    border-radius: 12px;
    font-weight: 700;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    width: fit-content;
    transition: transform 0.2s;

    &:hover {
      transform: scale(1.05);
    }
  }

  // Marca de agua decorativa
  .watermark {
    position: absolute;
    bottom: -20px;
    right: -20px;
    font-size: 10rem;
    font-weight: 900;
    color: #fff;
    opacity: 0;
    z-index: 1;
    transform: scale(0.5) rotate(0deg);
    transition: all 0.6s $ease-bounce;
    pointer-events: none;
  }
}
</style>