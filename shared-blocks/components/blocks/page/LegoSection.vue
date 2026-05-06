<script setup lang="ts">
import { formatImageUrl } from '@/helpers/url';

// Definimos la estructura de datos
interface ColumnContent {
  title: string;
  subtitle: string;
  text: string;
  image: string;
  align: 'text-start' | 'text-center' | 'text-end';
  isCard: boolean; // ¿Encerrar en una cajita blanca con sombra?
  headingSize: 'h1' | 'h2' | 'h3' | 'h4';
}

interface RowConfig {
  layout: '1-col' | '2-col' | '3-col' | '2-1-col'; // Diferentes distribuciones
  columns: ColumnContent[]; 
}

interface LegoData {
  rows: RowConfig[];
  backgroundColor: string; // Para pintar toda la sección si quieres
}

defineProps<{
  data: LegoData;
}>();

// Función auxiliar para saber qué clase de Bootstrap usar según el layout
const getColClass = (layout: string, index: number) => {
  if (layout === '1-col') return 'col-12';
  
  if (layout === '2-col') return 'col-md-6';
  
  if (layout === '3-col') return 'col-md-4';
  
  // Layout asimétrico (2/3 + 1/3)
  if (layout === '2-1-col') {
    return index === 0 ? 'col-lg-8' : 'col-lg-4';
  }
  
  return 'col-12';
};
</script>

<template>
  <div 
    v-if="data && data.rows" 
    class="lego-section section-spacing"
    :style="{ backgroundColor: data.backgroundColor || '#ffffff' }"
  >
    <div class="container">
      
      <div v-for="(row, rIndex) in data.rows" :key="rIndex" class="row g-4 mb-5 align-items-center">
        
        <div 
          v-for="(col, cIndex) in row.columns" 
          :key="cIndex" 
          :class="getColClass(row.layout, cIndex)"
        >
          <div 
            class="lego-item h-100" 
            :class="[col.align, col.isCard ? 'lego-card' : '']"
          >
            


            <component 
              :is="col.headingSize || 'h2'" 
              v-if="col.title" 
              class=" mb-4 lego-title" 
            >
              {{ col.title }}
            </component>

            <h6 v-if="col.subtitle" style="font-size: 20px;" class="text-primary text-uppercase fw-bold ls-1 mb-2">
              {{ col.subtitle }}
            </h6>

            <div v-if="col.text" class="text-muted" v-html="col.text" style="font-size: 16px;"></div>
                        <div v-if="col.image" class="mb-3">
              <img :src="formatImageUrl(col.image)" class="img-fluid rounded" alt="Imagen">
            </div>
          </div>
        </div>

      </div>

    </div>
  </div>
</template>

<style scoped>
.lego-section {
  padding: 60px 0;
}
.lego-item {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
}
.lego-title{
  font-family: "Arial";
  color: #5e5e5e;
  font-size: 24px;
  width: 70%;
  justify-content: center;
}
/* Estilo cuando activas "Modo Card" */
.lego-card {
  background: #fff;
  padding: 2rem;
  border-radius: 12px;
  box-shadow: 0 10px 30px rgba(0,0,0,0.08);
  border: 1px solid rgba(0,0,0,0.02);
  transition: transform 0.3s ease;
}

.lego-card:hover {
  transform: translateY(-5px);
}

.ls-1 { letter-spacing: 1px; }

/* Ajustes responsive */
@media (max-width: 768px) {
  .lego-section { padding: 40px 0; }
  .mb-5 { margin-bottom: 2rem !important; }
}
</style>