<script setup lang="ts">
import { computed, ref } from 'vue';
import { QuillEditor } from '@vueup/vue-quill';
import '@vueup/vue-quill/dist/vue-quill.snow.css';
import { formatImageUrl } from '@/helpers/url';

// Si tienes un helper global, impórtalo. Si no, usa esta función aquí mismo:

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue', 'select-image']); // <--- Importante: 'select-image'

// Usamos Computed Proxy para que sea reactivo y limpio como en tu ejemplo
const localContent = computed({
  get: () => props.modelValue || {},
  set: (val) => emit('update:modelValue', val)
});

// Actualizar imagen manualmente (cuando se borra)
const updateImage = (url: string) => {
  emit('update:modelValue', { ...localContent.value, image: url });
};

// Configuración de Quill
const toolbarOptions = [
  ['bold', 'italic', 'underline'],
  [{ 'list': 'ordered'}, { 'list': 'bullet' }],
  [{ 'align': [] }],
  ['clean']
];
</script>

<template>
  <div class="card shadow-sm border-0">
    <div class="card-header bg-primary text-white py-2">
      <h6 class="mb-0 small text-uppercase fw-bold">
        <i class="las la-user-graduate me-2"></i>Soporte Alumnos
      </h6>
    </div>
    
    <div class="card-body bg-light">
      
      <div class="mb-3 pb-3 border-bottom">
        <div class="form-check form-switch">
          <input 
            class="form-check-input" 
            type="checkbox" 
            id="invertLayout" 
            v-model="localContent.inverted"
          >
          <label class="form-check-label small fw-bold" for="invertLayout">
            Invertir posición (Imagen a la Izquierda)
          </label>
        </div>
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold small">Título</label>
        <input type="text" class="form-control" v-model="localContent.title">
      </div>

      <div class="p-3 mb-3 border rounded bg-white shadow-sm position-relative overflow-hidden">
        
        <h6 class="fw-bold mb-3 text-dark small text-uppercase">
           <i class="las la-image me-1"></i> Imagen del Bloque
        </h6>
        
        <div class="d-flex align-items-center gap-3">
           <div class="flex-shrink-0">
                <div v-if="localContent.image" class="ratio ratio-1x1 rounded overflow-hidden border shadow-sm" style="width: 80px;">
                   <img :src="formatImageUrl(localContent.image)" class="object-fit-cover">
                </div>
                <div v-else class="ratio ratio-1x1 rounded border bg-light d-flex align-items-center justify-content-center text-muted" style="width: 80px;">
                   <i class="las la-image fs-1 opacity-25"></i>
                </div>
           </div>

           <div class="flex-grow-1">
                <button type="button" 
                        @click="$emit('select-image', { item: localContent, field: 'image' })" 
                        class="btn btn-sm btn-outline-primary w-100 mb-1">
                   <i class="las la-cloud-upload-alt me-1"></i>
                   {{ localContent.image ? 'Cambiar Imagen' : 'Seleccionar Imagen' }}
                </button>
                
                <button v-if="localContent.image" 
                        @click="updateImage('')" 
                        class="btn btn-xs btn-link text-danger text-decoration-none w-100 text-end d-block p-0">
                   <small>Quitar imagen</small>
                </button>
           </div>
        </div>
      </div>

      <div class="mb-0">
        <label class="form-label fw-bold small">Contenido</label>
        <div class="bg-white border rounded">
          <QuillEditor 
            theme="snow"
            v-model:content="localContent.content"
            contentType="html"
            :toolbar="toolbarOptions"
            style="min-height: 150px;" 
          />
        </div>
      </div>

    </div>
  </div>
</template>

<style scoped>
.object-fit-cover {
  object-fit: cover;
  width: 100%;
  height: 100%;
}
.btn-xs {
    font-size: 0.75rem;
}
/* Ajustes Quill */
:deep(.ql-toolbar) {
    background: #f8f9fa;
    border-bottom: 1px solid #dee2e6;
}
:deep(.ql-container) {
    font-size: 14px;
}
</style>