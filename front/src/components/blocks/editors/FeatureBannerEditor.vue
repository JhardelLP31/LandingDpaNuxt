<script setup lang="ts">
import { formatImageUrl } from '@/helpers/url';

// 1. Definimos la interfaz idéntica a la vista
interface FeatureBannerContent {
  title: string;
  buttonText: string;
  buttonLink: string;
  backgroundImage: string;
}

// 2. Props y Emits
const props = defineProps<{
  modelValue: FeatureBannerContent;
}>();

const emit = defineEmits<{
  (e: 'select-image', key: keyof FeatureBannerContent): void;
}>();
</script>

<template>
  <div>
    <div class="mb-3">
      <label class="form-label fw-bold small">Título Principal</label>
      <input 
        v-model="modelValue.title" 
        class="form-control" 
        placeholder="Ej: Más de 250 instituciones..."
      >
    </div>

    <div class="row">
      <div class="col-6 mb-3">
        <label class="form-label fw-bold small">Texto Botón</label>
        <input 
          v-model="modelValue.buttonText" 
          class="form-control" 
          placeholder="Ej: CONTÁCTANOS"
        >
      </div>
      <div class="col-6 mb-3">
        <label class="form-label fw-bold small">Enlace Botón</label>
        <input 
          v-model="modelValue.buttonLink" 
          class="form-control" 
          placeholder="Ej: #contact_section"
        >
      </div>
    </div>

    <div class="mb-3">
      <label class="small fw-bold mb-1">Imagen de Fondo</label>
      <div class="d-flex align-items-center gap-2 p-2 border rounded bg-light">
        
        <div v-if="modelValue.backgroundImage" class="flex-shrink-0">
          <img 
            :src="formatImageUrl(modelValue.backgroundImage)" 
            class="rounded border bg-white" 
            style="width: 50px; height: 50px; object-fit: cover;"
          >
        </div>
        <div v-else class="flex-shrink-0 d-flex align-items-center justify-content-center rounded border bg-white text-muted" style="width: 50px; height: 50px;">
           <i class="las la-image fs-3"></i>
        </div>
        
        <button 
          type="button" 
          @click="emit('select-image', 'backgroundImage')" 
          class="btn btn-sm btn-outline-primary w-100"
        >
          {{ modelValue.backgroundImage ? 'Cambiar Fondo' : 'Seleccionar Fondo' }}
        </button>
      </div>
    </div>

  </div>
</template>