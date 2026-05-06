<script setup lang="ts">
import { computed } from 'vue';
import { formatImageUrl } from '../../../../helpers/url';

const getSafeImageUrl = (path: string) => {
  if (!path) return '';
  try { return formatImageUrl(path); } 
  catch (e) { return path; }
};

interface ProgramaItem {
  id: string;
  title: string;
  subtitle: string;
  description: string;
  image: string;
  color1: string;
  color2: string;
}

interface ProgramasData {
  sectionRotulo?: string;
  sectionTitle?: string;
  backgroundColor?: string; // <-- Nuevo: Color de fondo
  titleColor?: string;      // <-- Nuevo: Color de títulos
  items?: ProgramaItem[];
}

const props = defineProps<{ data: ProgramasData }>();

const safeData = computed(() => {
  const d = props.data || {};
  return {
    sectionRotulo: d.sectionRotulo || 'Nuestros',
    sectionTitle: d.sectionTitle || 'PROGRAMAS',
    backgroundColor: d.backgroundColor || '#1a1a1a', // Valor por defecto
    titleColor: d.titleColor || '#ffffff',           // Valor por defecto
    items: d.items && d.items.length > 0 ? d.items : []
  };
});
</script>

<template>
  <section class="programas-wrapper" id="programas" :style="{ backgroundColor: safeData.backgroundColor }">
    
    <div class="programas-header">
      <span class="programas-rotulo" :style="{ color: safeData.titleColor }">{{ safeData.sectionRotulo }}</span>
      <h2 class="programas-titulo" :style="{ color: safeData.titleColor }">{{ safeData.sectionTitle }}</h2>
      <div class="programas-linea-titulo" :style="{ backgroundColor: safeData.titleColor }"></div>
    </div>
    
    <div class="programas-grid">
      <article 
        v-for="(item, index) in safeData.items" 
        :key="item.id || index" 
        class="programa-card"
      >
        <div 
          class="programa-card__bg" 
          :style="{ backgroundImage: `url('${getSafeImageUrl(item.image)}')` }"
        ></div>
        
        <div 
          class="programa-card__overlay" 
          :style="{ background: `linear-gradient(180deg, ${item.color1} 0%, ${item.color2} 100%)` }"
        ></div>

        <a href="javascript:void(0);" class="programa-card__btn">
          <i class="fa-solid fa-plus"></i>
        </a>    
        
        <div class="programa-card__content">
          <h4 class="programa-card__title">{{ item.title }}</h4>
          <span class="programa-card__subtitle">{{ item.subtitle }}</span>
          
          <div class="programa-card__linea"></div>
          
          <div class="programa-card__hidden-text" v-html="item.description"></div>
        </div>      
      </article>            
    </div>
    
  </section>
</template>

<style scoped>
/* Contenedor principal oscuro */
.programas-wrapper { 
  /* Eliminé el background-color fijo de aquí */
  padding: 60px 20px;
  font-family: inherit;
  display: flex;
  flex-direction: column;
  align-items: center;
  width: 100%;
  transition: background-color 0.3s ease; /* Le da un efecto suave al cambiar color */
}

/* HEADER Y TÍTULO CENTRADOS */
.programas-header {
  text-align: center;
  margin-bottom: 50px;
  display: flex;
  flex-direction: column;
  align-items: center;
}

.programas-rotulo {
  /* Eliminé el color fijo de aquí */
  font-size: 1.2rem;
  font-weight: 300;
  margin-bottom: 2px;
}

.programas-titulo {
  /* Eliminé el color fijo de aquí */
  font-size: 2.2rem;
  font-weight: 700;
  text-transform: uppercase;
  margin: 0 0 12px 0;
  letter-spacing: 1px;
}

.programas-linea-titulo {
  width: 50px;
  height: 2px;
  /* Eliminé el background-color fijo de aquí */
}

/* GRID DE TARJETAS */
.programas-grid {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  justify-content: space-evenly;
  width: 100%;
}

/* TARJETA INDIVIDUAL */
.programa-card {
  height: 380px; 
  width: calc(18% - 20px); 
  min-width: 250px;
  border-radius: 12px; 
  position: relative;
  overflow: hidden;
  display: flex;
  flex-direction: column;
  justify-content: flex-end;
}

/* Ajustes exactos del fondo e imagen */
.programa-card__bg {
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  background-size: cover;
  background-position: center;
  z-index: 1;
}

.programa-card__overlay {
  position: absolute;
  top: 0; left: 0; right: 0; bottom: 0;
  z-index: 2;
}

/* Botón oscuro con la cruz blanca (+) */
.programa-card__btn {
  position: absolute;
  top: 15px;
  right: 15px;
  color: #fff;
  background-color: #111;
  width: 28px;
  height: 28px;
  border-radius: 50%;
  display: flex;
  align-items: center;
  justify-content: center;
  text-decoration: none;
  z-index: 4;
  transition: background 0.3s;
}

.programa-card__btn:hover { background-color: #000; }
.programa-card__btn i { font-size: 0.85rem; }

/* Textos dentro de la tarjeta */
.programa-card__content { 
  position: relative;
  z-index: 3;
  padding: 0 20px 25px; 
  color: #fff;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  text-align: left;
}

.programa-card__title {
  color: #fff;
  font-size: 1.15rem;
  font-weight: 700;
  text-transform: uppercase;
  margin: 0 0 4px 0;
}

.programa-card__subtitle {
  color: #fff;
  font-size: 0.9rem;
  font-weight: 400;
  margin-bottom: 12px;
}

/* Línea blanca interna de la tarjeta */
.programa-card__linea {
  width: 35px;
  height: 2px;
  background-color: #fff;
  margin-bottom: 0px;
}

/* Texto que aparece en hover */
.programa-card__hidden-text { 
  font-size: 0.85rem; 
  line-height: 1.4;
  color: #e0e0e0;
  max-height: 0;
  opacity: 0;
  overflow: hidden;
  transition: max-height 0.4s ease, opacity 0.4s ease, margin-top 0.4s ease;
}

/* HOVER EFFECT */
.programa-card:hover { cursor: pointer; }
.programa-card:hover .programa-card__hidden-text { 
  max-height: 250px; 
  opacity: 1;
  margin-top: 15px; 
}

/* RESPONSIVE */
@media (max-width: 1024px) {
  .programa-card { width: calc(50% - 20px); }
}

@media (max-width: 600px) {         
  .programa-card { width: 100%; margin: 0 10px; }
  .programa-card__hidden-text { 
    max-height: 250px; 
    opacity: 1; 
    margin-top: 15px; 
  }
}
</style>