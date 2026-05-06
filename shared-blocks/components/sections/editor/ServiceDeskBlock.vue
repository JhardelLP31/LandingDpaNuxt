<script setup lang="ts">
import { ref, watch } from 'vue';
import { QuillEditor } from '@vueup/vue-quill';
import '@vueup/vue-quill/dist/vue-quill.snow.css';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue']);

// Estructura de datos separada
const form = ref({
  title: props.modelValue?.title || '',
  description: props.modelValue?.description || '', // Aquí va el HTML
  buttonText: props.modelValue?.buttonText || '',
  buttonUrl: props.modelValue?.buttonUrl || '',
  videoUrl: props.modelValue?.videoUrl || ''
});

// Configuración básica para Quill (Negritas, Listas, Links)
const toolbarOptions = [
  ['bold', 'italic', 'underline'],
  [{ 'list': 'ordered'}, { 'list': 'bullet' }],
  ['link', 'clean']
];

watch(form, (val) => emit('update:modelValue', val), { deep: true });
</script>

<template>
  <div class="card shadow-sm border-0">
    <div class="card-header bg-primary text-white py-2">
      <h6 class="mb-0 small text-uppercase fw-bold"><i class="las la-headset me-2"></i>Editar Service Desk</h6>
    </div>
    
    <div class="card-body bg-light">
      
      <div class="mb-3">
        <label class="form-label fw-bold small">Título Principal</label>
        <input type="text" class="form-control" v-model="form.title">
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold small">Descripción (Texto y Nota)</label>
        <div class="bg-white border rounded">
          <QuillEditor 
            theme="snow"
            v-model:content="form.description"
            contentType="html"
            :toolbar="toolbarOptions"
            style="min-height: 200px;" 
          />
        </div>
        <div class="form-text x-small text-muted">Aquí puedes editar el párrafo y la nota de contacto.</div>
      </div>

      <div class="row g-2 mb-3">
        <div class="col-md-6">
          <label class="form-label fw-bold small">Texto Botón</label>
          <input type="text" class="form-control form-control-sm" v-model="form.buttonText">
        </div>
        <div class="col-md-6">
          <label class="form-label fw-bold small">Link Botón</label>
          <input type="text" class="form-control form-control-sm" v-model="form.buttonUrl">
        </div>
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold small">URL Video (YouTube)</label>
        <div class="input-group input-group-sm">
          <span class="input-group-text bg-white"><i class="lab la-youtube text-danger"></i></span>
          <input type="text" class="form-control" v-model="form.videoUrl">
        </div>
      </div>

    </div>
  </div>
</template>

<style scoped>
/* Arreglo visual para el toolbar de Quill dentro del panel */
:deep(.ql-toolbar) {
  border-bottom: 1px solid #ddd;
  background: #f8f9fa;
}
:deep(.ql-container) {
  font-family: inherit;
  font-size: 14px;
}
</style>