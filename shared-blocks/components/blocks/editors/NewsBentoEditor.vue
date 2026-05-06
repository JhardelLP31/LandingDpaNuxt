<script setup lang="ts">
import { computed } from 'vue';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue']);

// Datos con valores por defecto inteligentes
const localData = computed({
  get: () => {
    return {
      // Si no existe título, ponemos uno por defecto
      title: props.modelValue.title || 'Actualidad & Tendencias',
      // Texto chiquito encima del título
      subtitle: props.modelValue.subtitle || 'Publicaciones Recientes', 
      // Límite de noticias (Mínimo 5 para que el diseño se vea bien)
      limit: props.modelValue.limit || 7
    };
  },
  set: (val) => emit('update:modelValue', val)
});
</script>

<template>
  <div class="bg-white rounded border shadow-sm">
    
    <div class="p-3 border-bottom bg-light d-flex justify-content-between align-items-center">
      <h6 class="fw-bold m-0 text-dark">
        <i class="las la-newspaper me-1"></i> Configuración Bento Grid
      </h6>
      <span class="badge bg-primary">Automático</span>
    </div>

    <div class="p-3">
      
      <div class="mb-4">
        <label class="form-label fw-bold small text-uppercase text-muted">Etiqueta Superior</label>
        <input 
            v-model="localData.subtitle" 
            class="form-control form-control-sm mb-3" 
            placeholder="Ej: Publicaciones Recientes"
        >

        <label class="form-label fw-bold small text-uppercase text-muted">Título Principal</label>
        <input 
            v-model="localData.title" 
            class="form-control fw-bold mb-1" 
            placeholder="Ej: Actualidad & Tendencias"
        >
        <div class="form-text small">Este es el título grande rojo.</div>
      </div>

      <hr class="border-secondary opacity-10 my-4">

      <div class="row align-items-center">
          <div class="col-8">
              <label class="form-label fw-bold small text-uppercase text-muted m-0">
                  <i class="las la-sort-amount-down"></i> Cantidad de Noticias
              </label>
              <div class="form-text small">
                  Recomendado: 20 (1 Grande + 19 en lista).
              </div>
          </div>
          <div class="col-4">
              <input 
                type="number" 
                v-model="localData.limit" 
                min="5" 
                max="100" 
                class="form-control text-center fw-bold"
              >
          </div>
      </div>

      <div class="alert alert-light border mt-4 mb-0 py-2 small text-muted">
          <i class="las la-info-circle text-primary"></i> 
          Este bloque obtendrá automáticamente las últimas <strong>{{ localData.limit }}</strong> noticias publicadas.
      </div>

    </div>
  </div>
</template>