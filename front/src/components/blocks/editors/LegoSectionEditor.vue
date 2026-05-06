<template>
  <div class="p-3 border rounded bg-white">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <h6 class="fw-bold text-dark m-0"><i class="las la-cubes"></i> Constructor LEGO</h6>
      <div class="form-check form-switch small">
        <input class="form-check-input" type="checkbox" v-model="localData.useGrayBg">
        <label class="form-check-label text-muted">Fondo Gris</label>
      </div>
    </div>

    <div v-for="(row, rIndex) in localData.rows" :key="rIndex" class="card mb-3 border-secondary">
      
      <div class="card-header bg-light d-flex justify-content-between align-items-center py-2">
        <span class="badge bg-secondary">Fila {{ rIndex + 1 }}</span>
        
        <select 
          v-model="row.layout" 
          @change="updateColumns(row)" 
          class="form-select form-select-sm w-auto d-inline-block mx-2"
        >
          <option value="1-col">[ 100% ] Una Columna</option>
          <option value="2-col">[ 50% | 50% ] Dos Columnas</option>
          <option value="2-1-col">[ 66% | 33% ] Asimétrico</option>
          <option value="3-col">[ 33% | 33% | 33% ] Tres Columnas</option>
        </select>

        <button @click="removeRow(rIndex)" class="btn btn-xs btn-danger"><i class="las la-trash"></i></button>
      </div>

      <div class="card-body p-2">
        <div class="row g-2">
          
          <div 
            v-for="(col, cIndex) in row.columns" 
            :key="cIndex" 
            class="col-12 border-bottom pb-3 mb-2"
          >
            <div class="d-flex justify-content-between mb-1">
              <strong class="small text-primary">Columna {{ cIndex + 1 }}</strong>
              
              <div class="btn-group btn-group-sm">
                <button @click="col.align = 'text-start'" :class="{active: col.align==='text-start'}" class="btn btn-outline-secondary btn-xs"><i class="las la-align-left"></i></button>
                <button @click="col.align = 'text-center'" :class="{active: col.align==='text-center'}" class="btn btn-outline-secondary btn-xs"><i class="las la-align-center"></i></button>
                <button @click="col.align = 'text-end'" :class="{active: col.align==='text-end'}" class="btn btn-outline-secondary btn-xs"><i class="las la-align-right"></i></button>
                
                <button 
                  @click="col.isCard = !col.isCard" 
                  class="btn btn-xs ms-1" 
                  :class="col.isCard ? 'btn-primary' : 'btn-outline-secondary'"
                  title="Activar Modo Tarjeta"
                >
                  <i class="las la-square"></i> Card
                </button>
              </div>
            </div>

            <div class="row g-2">
              <div class="col-2">
                <div 
                  class="ratio ratio-1x1 bg-light border rounded d-flex align-items-center justify-content-center cursor-pointer"
                  @click="$emit('select-image', { item: col, field: 'image' })"
                >
                  <img v-if="col.image" :src="formatImageUrl(col.image)" class="w-100 h-100 object-fit-cover rounded">
                  <i v-else class="las la-image fs-4 text-muted"></i>
                </div>
              </div>
              
              <div class="col-10">
                <div class="input-group input-group-sm mb-1">
                   <select v-model="col.headingSize" class="form-select" style="max-width: 60px;">
                     <option value="h1">H1</option>
                     <option value="h2">H2</option>
                     <option value="h3">H3</option>
                     <option value="h4">H4</option>
                   </select>
                   <input v-model="col.title" class="form-control fw-bold" placeholder="Título Principal...">
                </div>
                <input v-model="col.subtitle" class="form-control form-control-sm mb-1" placeholder="Subtítulo (Opcional)">
                <textarea v-model="col.text" class="form-control form-control-sm" rows="2" placeholder="Texto del párrafo..."></textarea>
              </div>
            </div>

          </div>
        </div>
      </div>
    </div>

    <button @click="addRow" class="btn btn-dark w-100 btn-sm">
      <i class="las la-plus-circle"></i> Agregar Nueva Fila
    </button>
  </div>
</template>

<script setup lang="ts">
import { computed, watch } from 'vue';
import { formatImageUrl } from '@/helpers/url';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue', 'select-image']);

const localData = computed({
  get: () => {
    if (!props.modelValue.rows) props.modelValue.rows = [];
    return props.modelValue;
  },
  set: (val) => {
    // Si se activa fondo gris
    val.backgroundColor = val.useGrayBg ? '#f8f9fa' : '#ffffff';
    emit('update:modelValue', val)
  }
});

// Estructura vacía de una columna
const createEmptyCol = () => ({
  title: '', subtitle: '', text: '', image: '', 
  align: 'text-start', isCard: false, headingSize: 'h2'
});

const addRow = () => {
  localData.value.rows.push({
    layout: '2-col',
    columns: [createEmptyCol(), createEmptyCol()] // Empieza con 2 columnas
  });
};

const removeRow = (index: number) => {
  localData.value.rows.splice(index, 1);
};

// Ajustar el número de objetos "columna" cuando cambia el layout
const updateColumns = (row: any) => {
  let needed = 1;
  if (row.layout === '2-col' || row.layout === '2-1-col') needed = 2;
  if (row.layout === '3-col') needed = 3;

  const current = row.columns.length;
  
  if (current < needed) {
    for (let i = 0; i < needed - current; i++) {
      row.columns.push(createEmptyCol());
    }
  } else if (current > needed) {
    row.columns = row.columns.slice(0, needed);
  }
};
</script>