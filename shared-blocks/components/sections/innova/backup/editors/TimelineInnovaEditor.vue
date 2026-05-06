<script setup lang="ts">
import { ref, watch } from 'vue';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue', 'select-image']);

// Función para asegurar que siempre haya un color HEX válido
const safeColor = (color: string, fallback: string) => {
  return (color && color.startsWith('#')) ? color : fallback;
};

// 1. Inicialización ultra-segura
const initData = (source: any) => {
  const d = source || {};
  return {
    title: d.title || '',
    image: d.image || '',
    imageSide: d.imageSide || 'right',
    bgColor: safeColor(d.bgColor, '#ffffff'),
    accentColor: safeColor(d.accentColor, '#2176ff'),
    overlayColor1: safeColor(d.overlayColor1, '#2176ff'),
    overlayColor2: safeColor(d.overlayColor2, '#ff8121'),
    items: Array.isArray(d.items) ? JSON.parse(JSON.stringify(d.items)) : []
  };
};

const localData = ref(initData(props.modelValue));

// --- PROTECCIÓN ANTI-BUCLE ---

// Escuchar cambios externos (del Padre al Editor)
watch(() => props.modelValue, (newVal) => {
  const currentLocal = JSON.stringify(localData.value);
  const incomingProp = JSON.stringify(newVal);
  
  // Solo actualizamos si el padre tiene algo realmente distinto
  if (incomingProp !== currentLocal) {
    localData.value = initData(newVal);
  }
}, { deep: true });

// Escuchar cambios internos (del Editor al Padre)
watch(localData, (newVal) => {
  const currentProp = JSON.stringify(props.modelValue);
  const currentLocal = JSON.stringify(newVal);
  
  // Solo avisamos al padre si nosotros cambiamos algo real
  if (currentLocal !== currentProp) {
    emit('update:modelValue', JSON.parse(currentLocal));
  }
}, { deep: true });

const addItem = () => {
  localData.value.items.push({ 
    label: 'Nuevo Hito', 
    content: '<ul><li>Información...</li></ul>' 
  });
};

const removeItem = (index: number) => {
  localData.value.items.splice(index, 1);
};
</script>

<template>
  <div class="p-3 bg-white shadow-sm rounded border">
    <div class="mb-3">
      <label class="small fw-bold">Título Principal</label>
      <input v-model="localData.title" type="text" class="form-control form-control-sm">
    </div>

    <div class="row g-2 mb-3">
      <div class="col-6">
        <label class="small fw-bold">Lado Imagen</label>
        <select v-model="localData.imageSide" class="form-select form-select-sm">
          <option value="right">Derecha</option>
          <option value="left">Izquierda</option>
        </select>
      </div>
      <div class="col-6">
        <label class="small fw-bold">Color Activo</label>
        <input type="color" v-model="localData.accentColor" class="form-control form-control-color w-100">
      </div>
    </div>

    <div class="mb-3">
      <label class="small fw-bold d-block mb-1">Gradiente de Imagen</label>
      <div class="d-flex gap-2">
        <input type="color" v-model="localData.overlayColor1" class="form-control form-control-color flex-grow-1">
        <input type="color" v-model="localData.overlayColor2" class="form-control form-control-color flex-grow-1">
      </div>
    </div>

    <button class="btn btn-primary btn-sm w-100 mb-3" @click="$emit('select-image', { item: localData, field: 'image' })">
      <i class="las la-image"></i> {{ localData.image ? 'Cambiar Imagen' : 'Subir Imagen' }}
    </button>

    <hr>

    <div class="d-flex justify-content-between mb-2">
      <span class="small fw-bold">HITOS</span>
      <button class="btn btn-success btn-xs py-0" @click="addItem">+</button>
    </div>

    <div class="hitos-list">
      <div v-for="(item, index) in localData.items" :key="index" class="card mb-2 p-2 bg-light border-0 shadow-sm">
        <div class="d-flex justify-content-between align-items-center mb-1">
          <span class="badge bg-secondary">#{{ index + 1 }}</span>
          <button class="btn btn-link text-danger p-0" @click="removeItem(index)">
            <i class="las la-trash"></i>
          </button>
        </div>
        <input v-model="item.label" class="form-control form-control-sm mb-1 fw-bold" placeholder="Etiqueta">
        <textarea v-model="item.content" class="form-control form-control-sm" rows="2" placeholder="Contenido HTML"></textarea>
      </div>
    </div>
  </div>
</template>

<style scoped>
.btn-xs { padding: 1px 5px; font-size: 0.7rem; }
.hitos-list { max-height: 300px; overflow-y: auto; padding: 5px; }
.form-control-color { height: 31px; padding: 2px; }
</style>