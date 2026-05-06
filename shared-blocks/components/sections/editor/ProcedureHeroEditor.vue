<template>
  <div class="procedure-hero-editor">
    
    <div class="d-flex justify-content-between align-items-center mb-3 p-2 bg-white border rounded">
      <h6 class="m-0 small fw-bold text-muted"><i class="las la-sliders-h"></i> Ajustes</h6>
      
      <div class="d-flex align-items-center gap-3">
        <div class="d-flex align-items-center gap-2">
            <span class="small text-muted">Alto:</span>
            <select v-model="localData.height" class="form-select form-select-sm py-0" style="width: 100px; height: 26px;">
                <option value="200px">Pequeño</option>
                <option value="300px">Mediano</option>
                <option value="450px">Grande</option>
                <option value="100vh">Full</option>
            </select>
        </div>
        
        <div class="d-flex align-items-center gap-2" title="Oscuridad del fondo">
            <i class="las la-adjust small text-muted"></i>
            <input 
                type="range" 
                class="form-range" 
                style="width: 60px;" 
                min="0" max="0.9" step="0.1" 
                v-model.number="localData.overlayOpacity"
            >
            <span class="badge bg-light text-dark border">{{ localData.overlayOpacity }}</span>
        </div>
      </div>
    </div>

    <div class="border rounded overflow-hidden">
        
        <div class="bg-white border-bottom p-2 d-flex align-items-center gap-2">
            <span class="badge bg-primary rounded-pill">1</span>
            <span class="small fw-bold">Contenido Principal</span>
        </div>

        <div class="bg-light p-3">
            
            <div class="mb-3">
              <label class="small fw-bold mb-1">Imagen de Fondo</label>
              <div class="d-flex align-items-center gap-2 p-2 border rounded bg-white">
                
                <div v-if="localData.bgImage" class="flex-shrink-0">
                  <img :src="formatImageUrl(localData.bgImage)" class="rounded border bg-light" style="width: 60px; height: 40px; object-fit: cover;">
                </div>
                <div v-else class="flex-shrink-0 d-flex align-items-center justify-content-center rounded border bg-light text-muted" style="width: 60px; height: 40px;">
                  <i class="las la-image fs-3"></i>
                </div>

                <div class="w-100">
                  <button type="button" @click="$emit('select-image', { item: localData, field: 'bgImage' })" 
                          class="btn btn-sm btn-outline-primary w-100 mb-1">
                    {{ localData.bgImage ? 'Cambiar Imagen' : 'Seleccionar Imagen' }}
                  </button>
                  
                  <button v-if="localData.bgImage" type="button" @click="localData.bgImage = ''" 
                          class="btn btn-xs btn-link text-danger text-decoration-none p-0 w-100 small">
                    <i class="las la-trash"></i> Quitar imagen
                  </button>
                </div>

              </div>
            </div>

            <div class="mb-3">
              <label class="small fw-bold mb-1">Título de Sección</label>
              <input 
                type="text" 
                v-model="localData.title" 
                class="form-control form-control-sm fw-bold" 
                placeholder="Ej: PROCEDIMIENTOS"
              >
            </div>

        </div>
    </div>

  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { formatImageUrl } from '@/helpers/url';

// Props y Emits
const props = defineProps<{
  modelValue: any
}>();

const emit = defineEmits(['update:modelValue', 'select-image']);

// Computed para v-model limpio
const localData = computed({
  get: () => props.modelValue || { 
      title: 'PROCEDIMIENTOS', 
      height: '300px', 
      overlayOpacity: 0.6,
      bgImage: '' 
  },
  set: (val) => emit('update:modelValue', val)
});
</script>

<style scoped>
/* Ajustes finos para que se vea igual a tu ejemplo */
.btn-xs {
    font-size: 0.75rem;
    padding: 2px 5px;
}
</style>