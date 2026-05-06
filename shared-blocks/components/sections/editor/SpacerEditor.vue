<script setup lang="ts">
import { computed } from 'vue';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue']);

// Data vinculada
const localData = computed({
  get: () => props.modelValue || { height: 50, showLine: false, config: {} },
  set: (val) => emit('update:modelValue', val)
});

// Helper para config profunda
const updateConfig = (field: string, value: any) => {
  const newConfig = { ...(localData.value.config || {}), [field]: value };
  emit('update:modelValue', { ...localData.value, config: newConfig });
};
</script>

<template>
  <div class="p-3">
    
    <div class="mb-4">
      <label class="form-label fw-bold d-flex justify-content-between">
        <span><i class="fas fa-arrows-alt-v"></i> Altura del Espacio</span>
        <span class="badge bg-primary">{{ localData.height }}px</span>
      </label>
      <input 
        type="range" 
        class="form-range" 
        min="10" 
        max="300" 
        step="10"
        v-model.number="localData.height"x
      >
      <div class="d-flex justify-content-between small text-muted">
        <span>10px</span>
        <span>300px</span>
      </div>
    </div>

    <hr>

    <div class="form-check form-switch mb-3">
      <input 
        class="form-check-input" 
        type="checkbox" 
        id="showLineSwitch"
        v-model="localData.showLine"
      >
      <label class="form-check-label fw-bold" for="showLineSwitch">Mostrar Línea Divisoria</label>
    </div>

    <div v-if="localData.showLine" class="p-3 bg-light rounded border">
      
      <div class="mb-2 row align-items-center">
        <label class="col-4 col-form-label small">Color</label>
        <div class="col-8">
           <input 
            type="color" 
            class="form-control form-control-color w-100" 
            :value="localData.config?.lineColor || '#e0e0e0'"
            @input="e => updateConfig('lineColor', (e.target as HTMLInputElement).value)"
          >
        </div>
      </div>

      <div class="mb-2 row align-items-center">
        <label class="col-4 col-form-label small">Estilo</label>
        <div class="col-8">
          <select 
            class="form-select form-select-sm"
            :value="localData.config?.lineStyle || 'solid'"
            @change="e => updateConfig('lineStyle', (e.target as HTMLSelectElement).value)"
          >
            <option value="solid">Sólida (Solid)</option>
            <option value="dashed">Guiones (Dashed)</option>
            <option value="dotted">Puntos (Dotted)</option>
          </select>
        </div>
      </div>

      <!-- Selección dinámica de Ancho (%) -->
      <div class="mb-2 row align-items-center">
        <label class="col-4 col-form-label small">Ancho (%)</label>
        <div class="col-8">
          <select 
            class="form-select form-select-sm"
            :value="localData.config?.lineWidth || '100%'"
            @change="e => updateConfig('lineWidth', (e.target as HTMLSelectElement).value)"
          >
            <!-- Generar opciones dinámicas del 1% al 100% -->
            <option 
              v-for="i in 100" 
              :key="i" 
              :value="i + '%'"
            >
              {{ i }}%
            </option>
          </select>
        </div>
      </div>

      <div class="row align-items-center">
        <label class="col-4 col-form-label small">Grosor</label>
        <div class="col-8">
          <input 
            type="number" 
            class="form-control form-control-sm"
            min="1" max="10"
            :value="localData.config?.lineThickness || 1"
            @input="e => updateConfig('lineThickness', (e.target as HTMLInputElement).value)"
          >
        </div>
      </div>

    </div>

  </div>
</template>
