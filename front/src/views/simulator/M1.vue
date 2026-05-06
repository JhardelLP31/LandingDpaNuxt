<script setup lang="ts">
import { ref } from 'vue';

interface Program {
  id: number;
  code: string;
  title: string;
  tagline: string;
  description: string;
  stats: { label: string; value: string }[];
}

const programs = ref<Program[]>([
  {
    id: 1,
    code: 'MBA',
    title: 'International MBA',
    tagline: 'Visión Global Estratégica',
    description: 'Transforma tu carrera con la maestría N°1. Doble grado internacional y semanas intensivas en Europa y Asia.',
    stats: [
      { label: 'Duración', value: '14 Meses' },
      { label: 'Formato', value: 'Full Time' }
    ]
  },
  {
    id: 2,
    code: 'FIN',
    title: 'Maestría en Finanzas',
    tagline: 'Lidera el Mercado',
    description: 'Domina la banca de inversión y finanzas corporativas con acceso a laboratorios Bloomberg en tiempo real.',
    stats: [
      { label: 'Ranking', value: '#1 Perú' },
      { label: 'Sedes', value: 'Lima / Online' }
    ]
  },
  {
    id: 3,
    code: 'MKT',
    title: 'Marketing Digital',
    tagline: 'Innovación Disruptiva',
    description: 'Aprende Growth Hacking, Analítica Avanzada y Estrategia Omnicanal con directores de las top tech.',
    stats: [
      { label: 'Inicio', value: '25 Agosto' },
      { label: 'Certifica', value: 'ESAN/Data' }
    ]
  }
]);

const activeId = ref<number | null>(null);

const toggleCard = (id: number) => {
  activeId.value = activeId.value === id ? null : id;
};
</script>

<template>
  <section class="wow-experience">
    <div class="container">
      <h2 class="section-title">Experiencia <span class="highlight">ESAN</span></h2>
      
      <div class="cards-grid">
        <div 
          v-for="item in programs" 
          :key="item.id"
          class="morph-card"
          :class="{ 'is-open': activeId === item.id }"
          @click="toggleCard(item.id)"
        >
          <div class="card-backdrop"></div>

          <div class="card-content">
            
            <div class="card-header">
              <div class="icon-box">
                <span class="icon-text">{{ item.code }}</span>
              </div>
              <div class="header-text">
                <h3 class="title">{{ item.title }}</h3>
                <span class="tagline">{{ item.tagline }}</span>
              </div>
              <div class="expand-indicator">
                <div class="plus-line vertical"></div>
                <div class="plus-line horizontal"></div>
              </div>
            </div>

            <div class="card-body">
              <div class="body-inner">
                <p class="description">{{ item.description }}</p>
                
                <div class="stats-row">
                  <div v-for="(stat, index) in item.stats" :key="index" class="stat-item">
                    <span class="stat-value">{{ stat.value }}</span>
                    <span class="stat-label">{{ stat.label }}</span>
                  </div>
                </div>

                <button class="action-btn">
                  Ver Plan de Estudios 
                  <span class="arrow">→</span>
                </button>
              </div>
            </div>

          </div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped lang="scss">
// --- Variables ---
$esan-red: #e31140;
$esan-black: #111111;
$esan-white: #ffffff;
$text-gray: #666;
$card-bg: #F8F9FA;

// --- Physics (El secreto del WOW) ---
// Un rebote elástico para la apertura
$bounce-ease: cubic-bezier(0.68, -0.55, 0.265, 1.55); 
// Una curva suave para los elementos internos
$smooth-ease: cubic-bezier(0.25, 0.8, 0.25, 1);

.wow-experience {
  background-color: #ffffff;
  padding: 5rem 1.5rem;
  font-family: 'Arial', sans-serif;
  color: $esan-black;

  .container {
    max-width: 900px;
    margin: 0 auto;
  }

  .section-title {
    text-align: center;
    font-size: 2.5rem;
    font-weight: 800;
    margin-bottom: 3rem;
    letter-spacing: -1px;
    .highlight { color: $esan-red; }
  }
}

.cards-grid {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

// --- LA TARJETA MAESTRA ---
.morph-card {
  position: relative;
  background: $card-bg;
  border-radius: 20px;
  cursor: pointer;
  overflow: hidden; // Vital para contener el efecto
  transform: translateZ(0); // Acelerar GPU
  transition: box-shadow 0.3s ease, transform 0.3s ease;
  border: 1px solid transparent;

  &:hover {
    transform: translateY(-4px);
    box-shadow: 0 10px 30px rgba(0,0,0,0.08);
  }

  // --- ESTADO: ABIERTO (LA MAGIA) ---
  &.is-open {
    background: $esan-white; // Cambio sutil de fondo
    box-shadow: 0 20px 60px rgba(227, 17, 64, 0.15); // Sombra roja difusa
    border-color: rgba($esan-red, 0.1);
    cursor: default; // Ya está abierto
    transform: scale(1.02); // Un pequeño pop hacia el usuario

    // 1. El Backdrop rojo se expande
    .card-backdrop {
      transform: scaleY(1);
    }

    // 2. El Icono se transforma y mueve
    .icon-box {
      background-color: $esan-white;
      color: $esan-red;
      transform: scale(0.8); // Se hace un poco más chico pero cambia colores
    }

    // 3. El indicador se vuelve un "Menos" y gira
    .expand-indicator {
      transform: rotate(180deg);
      background-color: rgba(255,255,255, 0.2); // Sutil sobre el rojo
      .vertical { transform: scaleY(0); } // Desaparece la línea vertical
      .plus-line { background-color: $esan-white; }
    }

    // 4. El Título se vuelve blanco (porque el fondo es rojo ahora arriba)
    .title { color: $esan-white; transform: translateX(10px); }
    .tagline { color: rgba(255,255,255, 0.8); transform: translateX(10px); }

    // 5. El Cuerpo se revela con "Stagger" (uno por uno)
    .card-body {
      grid-template-rows: 1fr;
    }
    
    // Secuencia de entrada (La sensación de "armado")
    .description { opacity: 1; transform: translateY(0); transition-delay: 0.2s; }
    .stats-row { opacity: 1; transform: translateY(0); transition-delay: 0.3s; }
    .action-btn { opacity: 1; transform: translateY(0); transition-delay: 0.4s; }
  }
}

// Fondo rojo animado
.card-backdrop {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 110px; // Altura del header aprox
  background: linear-gradient(135deg, $esan-red, darken($esan-red, 10%));
  transform: scaleY(0); // Oculto al inicio
  transform-origin: top;
  transition: transform 0.5s $bounce-ease; // Efecto rebote al bajar
  z-index: 0;
}

.card-content {
  position: relative;
  z-index: 1;
  padding: 1.5rem;
}

// --- HEADER ---
.card-header {
  display: flex;
  align-items: center;
  gap: 1.5rem;
  height: 80px; // Altura fija para el estado cerrado
}

.icon-box {
  width: 60px;
  height: 60px;
  background-color: $esan-black;
  color: $esan-white;
  border-radius: 16px;
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 800;
  font-size: 1rem;
  flex-shrink: 0;
  transition: all 0.5s $bounce-ease;
  box-shadow: 0 5px 15px rgba(0,0,0,0.2);
}

.header-text {
  flex-grow: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;

  .title {
    margin: 0;
    font-size: 1.4rem;
    font-weight: 800;
    color: $esan-black;
    transition: all 0.4s ease; // Suavidad en el cambio de color y posición
  }
  
  .tagline {
    font-size: 0.9rem;
    color: $text-gray;
    text-transform: uppercase;
    letter-spacing: 1px;
    font-weight: 600;
    transition: all 0.4s ease;
  }
}

// Botón + / -
.expand-indicator {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-color: #eee;
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  transition: all 0.5s $bounce-ease;

  .plus-line {
    position: absolute;
    background-color: $esan-black;
    border-radius: 2px;
    transition: all 0.3s ease;

    &.horizontal { width: 14px; height: 2px; }
    &.vertical { width: 2px; height: 14px; }
  }
}

// --- BODY (La parte oculta) ---
.card-body {
  display: grid;
  grid-template-rows: 0fr; // Truco CSS Grid
  transition: grid-template-rows 0.6s $smooth-ease;
}

.body-inner {
  overflow: hidden;
  padding-top: 0; // Inicialmente 0
}

// Elementos internos con estado inicial "fuera de escena"
.description, .stats-row, .action-btn {
  opacity: 0;
  transform: translateY(20px);
  transition: opacity 0.4s ease, transform 0.4s ease;
}

.description {
  margin-top: 1.5rem;
  line-height: 1.6;
  color: #444;
  font-size: 1.05rem;
}

.stats-row {
  display: flex;
  gap: 2rem;
  margin: 2rem 0;
  padding: 1.5rem;
  background-color: #f0f2f5;
  border-radius: 12px;
  
  .stat-item {
    display: flex;
    flex-direction: column;
  }
  
  .stat-value {
    font-size: 1.2rem;
    font-weight: 800;
    color: $esan-black;
  }
  
  .stat-label {
    font-size: 0.8rem;
    color: #888;
    text-transform: uppercase;
  }
}

.action-btn {
  width: 100%;
  padding: 1rem;
  background-color: $esan-black;
  color: $esan-white;
  border: none;
  border-radius: 8px;
  font-weight: 700;
  font-size: 1rem;
  cursor: pointer;
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 10px;
  transition: background-color 0.2s;

  &:hover {
    background-color: lighten($esan-black, 10%);
    .arrow { transform: translateX(5px); }
  }

  .arrow {
    transition: transform 0.2s ease;
  }
}
</style>