<template>
  <div class="p-3 border rounded bg-white">
    <div class="d-flex justify-content-between align-items-center mb-3">
      <h6 class="fw-bold text-primary m-0"><i class="las la-cubes"></i> Grid Universal (Lego)</h6>
    </div>

    <div class="bg-light p-3 rounded mb-3 border">
      <small class="text-uppercase fw-bold text-muted d-block mb-2">Configuración de Diseño</small>
      
      <div class="row g-2">
        <div class="col-6">
          <label class="small text-muted">Columnas</label>
          <select v-model="localConfig.columns" class="form-select form-select-sm">
            <option :value="2">2 Columnas</option>
            <option :value="3">3 Columnas (Estándar)</option>
            <option :value="4">4 Columnas (Compacto)</option>
          </select>
        </div>

        <div class="col-6">
          <label class="small text-muted">Alineación</label>
          <select v-model="localConfig.textAlign" class="form-select form-select-sm">
            <option value="left">Izquierda</option>
            <option value="center">Centrado</option>
          </select>
        </div>

        <div class="col-12">
          <label class="small text-muted">Estilo Visual (Tema)</label>
          <select v-model="localConfig.cardStyle" class="form-select form-select-sm">
            <option value="swipe-red">🔥 Barrido Rojo (Dinámico)</option>
            <option value="minimal-border">🍏 Borde Minimal (Limpio)</option>
            <option value="glass-dark">🌑 Dark Glass (Oscuro)</option>
          </select>
        </div>
      </div>
    </div>

    <div class="d-flex flex-column gap-2">
      <div v-for="(item, index) in localItems" :key="index" class="border rounded p-2 bg-white position-relative">
        <button @click="removeItem(index)" class="btn btn-xs btn-outline-danger position-absolute top-0 end-0 m-1 border-0">
          <i class="las la-times"></i>
        </button>
        
        <div class="d-flex gap-2 mb-2">
           <div 
             class="bg-light border rounded d-flex align-items-center justify-content-center" 
             style="width: 40px; height: 40px; cursor: pointer;"
             @click="$emit('select-image', { item: item, field: 'image' })"
           >
              <img v-if="item.image" :src="formatImageUrl(item.image)" style="width: 100%; height: 100%; object-fit: contain;">
              <i v-else class="las la-image text-muted"></i>
           </div>
           
           <div class="w-100">
             <input v-model="item.title" class="form-control form-control-sm mb-1 fw-bold" placeholder="Título">
             <input v-model="item.description" class="form-control form-control-sm" placeholder="Descripción corta...">
           </div>
        </div>
      </div>
    </div>

    <button @click="addItem" class="btn btn-sm btn-primary w-100 mt-2">
      <i class="las la-plus"></i> Agregar Elemento
    </button>

  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { formatImageUrl } from '@/helpers/url';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue', 'select-image']);

// Proxy para los Items
const localItems = computed({
  get: () => {
    if (!props.modelValue.items) props.modelValue.items = [];
    return props.modelValue.items;
  },
  set: (val) => { props.modelValue.items = val; emit('update:modelValue', props.modelValue); }
});

// Proxy para la Configuración
const localConfig = computed({
  get: () => {
    if (!props.modelValue.config) {
      // Valores por defecto si no existen
      props.modelValue.config = { columns: 3, cardStyle: 'swipe-red', textAlign: 'left' };
    }
    return props.modelValue.config;
  },
  set: (val) => { props.modelValue.config = val; emit('update:modelValue', props.modelValue); }
});

const addItem = () => {
  localItems.value.push({ title: 'Nuevo Item', description: '', image: '', link: '' });
};

const removeItem = (index: number) => {
  localItems.value.splice(index, 1);
};
</script>