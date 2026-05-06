<script setup lang="ts">
import { computed } from 'vue';
import { formatImageUrl } from '@/helpers/url';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue', 'select-image']);

const localContent = computed({
  get: () => props.modelValue || { config: {} },
  set: (val) => emit('update:modelValue', val)
});

const updateConfig = (field: string, value: any) => {
  const newConfig = { ...(localContent.value.config || {}), [field]: value };
  emit('update:modelValue', { ...localContent.value, config: newConfig });
};
</script>

<template>
  <div class="p-2">

    <div class="mb-3 border p-3 rounded bg-light">
      <h6 class="mb-3 fw-bold text-primary">Contenidos</h6>
      
      <div class="row g-2 mb-2">
        <div class="col-6">
           <label class="small fw-bold text-muted">Texto 1 (Delgado)</label>
           <input v-model="localContent.preTitle" class="form-control form-control-sm" placeholder="Ej: NUESTROS">
        </div>
        <div class="col-6">
           <label class="small fw-bold text-muted">Texto 2 (Grueso)</label>
           <input v-model="localContent.title" class="form-control form-control-sm" placeholder="Ej: PROYECTOS">
        </div>
      </div>

      <div class="row g-2">
        <div class="col-6">
           <label class="small fw-bold text-muted">Texto Botón</label>
           <input v-model="localContent.btnText" class="form-control form-control-sm">
        </div>
        <div class="col-6">
           <label class="small fw-bold text-muted">Enlace Botón</label>
           <input v-model="localContent.btnLink" class="form-control form-control-sm">
        </div>
      </div>
    </div>

    <div class="mb-3 border p-3 rounded bg-white shadow-sm">
      <label class="form-label fw-bold small">Imagen Lateral</label>
      <div class="d-flex gap-2 align-items-center">
        <div 
          v-if="localContent.image" 
          class="ratio ratio-4x3 rounded border bg-light"
          style="width: 80px; background-size: cover; background-position: center;"
          :style="{ backgroundImage: `url(${formatImageUrl(localContent.image)})` }"
        ></div>
        
        <button 
            @click="$emit('select-image', { item: localContent, field: 'image' })"
            class="btn btn-sm btn-outline-primary w-100"
        >
          <i class="fas fa-camera me-1"></i> {{ localContent.image ? 'Cambiar Imagen' : 'Seleccionar Imagen' }}
        </button>
      </div>
    </div>

    <div class="mb-3 border p-3 rounded bg-light">
      <h6 class="mb-3 fw-bold text-primary">Diseño</h6>

      <div class="form-check form-switch mb-3">
        <input 
          class="form-check-input" 
          type="checkbox" 
          id="invertSwitch"
          :checked="localContent.config?.invertLayout"
          @change="e => updateConfig('invertLayout', (e.target as HTMLInputElement).checked)"
        >
        <label class="form-check-label small fw-bold" for="invertSwitch">
           Invertir Posición (Imagen Izq / Texto Der)
        </label>
      </div>

      <label class="form-label fw-bold small">Color de Fondo</label>
      <div class="d-flex align-items-center gap-2">
          <input 
            type="color" 
            class="form-control form-control-color" 
            :value="localContent.config?.bgColor || '#ffffff'"
            @input="e => updateConfig('bgColor', (e.target as HTMLInputElement).value)"
            title="Elige un color"
          >
          <button 
             class="btn btn-sm btn-outline-secondary"
             @click="updateConfig('bgColor', 'transparent')"
          >
            Transparente
          </button>
      </div>
    </div>

  </div>
</template>