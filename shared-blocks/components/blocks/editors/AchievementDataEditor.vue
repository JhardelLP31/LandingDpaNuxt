<template>
  <div class="achievement-editor">

    <div class="p-3 mb-3 border rounded bg-light">
      <h6 class="fw-bold mb-3 text-primary">
        <i class="las la-trophy me-1"></i> Configuración General
      </h6>

      <div class="row g-2 mb-3">
        <div class="col-md-6">
          <label class="small fw-bold text-muted mb-1">Subtítulo (Rojo)</label>
          <input type="text" v-model="localContent.subtitle" class="form-control form-control-sm" placeholder="Ej: LOGROS">
        </div>
        <div class="col-md-6">
          <label class="small fw-bold text-muted mb-1">Título Principal</label>
          <input type="text" v-model="localContent.title" class="form-control form-control-sm" placeholder="Ej: Nuestra Institución">
        </div>
      </div>

      <div class="mb-3">
        <label class="small fw-bold text-muted mb-1">Imagen de Fondo</label>
        <div class="d-flex align-items-center gap-2 p-2 border rounded bg-white">
          
          <div v-if="localContent.image" class="flex-shrink-0">
            <img :src="formatImageUrl(localContent.image)" 
                 class="rounded border bg-light object-fit-cover" 
                 style="width: 60px; height: 40px;">
          </div>
          <div v-else class="flex-shrink-0 d-flex align-items-center justify-content-center rounded border bg-light text-muted" 
               style="width: 60px; height: 40px;">
            <i class="las la-image fs-4"></i>
          </div>

          <button type="button"
                  @click="$emit('select-image', { item: localContent, field: 'image' })" 
                  class="btn btn-sm btn-outline-primary w-100">
             {{ localContent.image ? 'Cambiar Fondo' : 'Seleccionar Fondo' }}
          </button>
        </div>
      </div>

      <div class="row g-2">
        <div class="col-md-6">
          <label class="small fw-bold text-muted mb-1">Texto Botón</label>
          <input type="text" v-model="localContent.buttonText" class="form-control form-control-sm" placeholder="Opcional">
        </div>
        <div class="col-md-6">
          <label class="small fw-bold text-muted mb-1">Link Botón</label>
          <input type="text" v-model="localContent.buttonLink" class="form-control form-control-sm" placeholder="https://...">
        </div>
      </div>
    </div>

    <div class="border rounded bg-white p-3">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <label class="small fw-bold text-dark m-0">Lista de Contadores</label>
        <span class="badge bg-light text-dark border">{{ localContent.counters?.length || 0 }} ítems</span>
      </div>

      <div v-if="localContent.counters && localContent.counters.length > 0">
        <div v-for="(counter, index) in localContent.counters" :key="index" class="p-3 border rounded bg-light mb-3 position-relative shadow-sm">
            
            <button @click="removeCounter(index)" 
                    class="btn btn-danger btn-xs position-absolute shadow-sm d-flex align-items-center justify-content-center" 
                    style="top: -8px; right: -8px; width: 20px; height: 20px; border-radius: 50%; padding: 0;">
                <i class="las la-times" style="font-size: 10px;"></i>
            </button>
            
            <div class="row g-2">
                <div class="col-4">
                    <label class="x-small fw-bold text-muted">Cifra</label>
                    <input type="number" v-model.number="counter.value" class="form-control form-control-sm fw-bold text-primary">
                </div>
                <div class="col-3">
                    <label class="x-small fw-bold text-muted">Sufijo</label>
                    <input type="text" v-model="counter.suffix" class="form-control form-control-sm text-center" placeholder="+">
                </div>
                <div class="col-12">
                    <label class="x-small fw-bold text-muted">Descripción</label>
                    <input type="text" v-model="counter.description" class="form-control form-control-sm" placeholder="Ej: Años de experiencia">
                </div>
            </div>
        </div>
      </div>

      <div v-else class="text-center text-muted py-3 small border border-dashed rounded mb-3">
        No hay logros registrados.
      </div>

      <button @click="addCounter" class="btn btn-sm btn-primary w-100">
        <i class="las la-plus me-1"></i> Añadir Logro
      </button>
    </div>

  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { formatImageUrl } from '@/helpers/url';
const props = defineProps<{
  modelValue: any
}>();

const emit = defineEmits(['update:modelValue', 'select-image']);

// Proxy para v-model
const localContent = computed({
  get: () => props.modelValue,
  set: (val) => emit('update:modelValue', val)
});

// Acciones
const addCounter = () => {
  if (!localContent.value.counters) localContent.value.counters = [];
  
  localContent.value.counters.push({ 
    id: Date.now(), 
    value: 0, 
    suffix: '+', 
    description: 'Nuevo logro' 
  });
};

const removeCounter = (index: any) => {
  localContent.value.counters.splice(index, 1);
};

// Helper Imagen

</script>

<style scoped>
.x-small {
    font-size: 0.7rem;
}
.object-fit-cover {
    object-fit: cover;
}
.border-dashed {
    border-style: dashed !important;
}
</style>