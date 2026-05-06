<template>
  <div class="about-company-editor">

    <div class="p-3 mb-3 border rounded bg-light">
      <h6 class="fw-bold mb-3 text-primary d-flex align-items-center">
        <i class="las la-pen-alt me-2"></i> Contenido Principal
      </h6>

      <div class="mb-3">
        <label class="small fw-bold text-muted mb-1">Subtítulo (Pequeño)</label>
        <input v-model="localContent.subtitle" 
               class="form-control form-control-sm" 
               placeholder="Ej: SOBRE NOSOTROS">
      </div>

      <div class="mb-3">
        <label class="small fw-bold text-muted mb-1">Título Principal (H2)</label>
        <div class="input-group input-group-sm">
            <span class="input-group-text bg-white"><i class="las la-heading"></i></span>
            <input v-model="localContent.title" 
                   class="form-control" 
                   placeholder="Ej: NUESTRA HISTORIA">
        </div>
      </div>

      <div class="mb-0">
        <label class="small fw-bold text-muted mb-1">Descripción</label>
        
        <div class="bg-white rounded border">
            <QuillEditor 
                v-model:content="localContent.content" 
                contentType="html" 
                theme="snow"
                placeholder="Escribe aquí la historia de la empresa..."
                :toolbar="['bold', 'italic', 'underline', 'link', { 'list': 'ordered'}, { 'list': 'bullet' }]"
            />
        </div>
        
        <div class="form-text x-small text-end mt-1">
            Usa el editor para formatear el texto.
        </div>
      </div>
    </div>

    <div class="p-3 mb-3 border rounded bg-light">
       <h6 class="fw-bold mb-3 text-primary d-flex align-items-center">
        <i class="las la-star me-2"></i> Detalles Destacados
      </h6>

      <div class="mb-3">
         <label class="small fw-bold text-muted mb-1">
            <i class="las la-certificate text-warning"></i> Años de Experiencia
         </label>
         <div class="input-group input-group-sm">
             <input v-model="localContent.yearsExperience" 
                    type="text" 
                    class="form-control" 
                    placeholder="Ej: 15+">
             <span class="input-group-text bg-white text-muted">Años</span>
         </div>
         <div class="form-text x-small">Deja vacío para ocultar el badge flotante.</div>
      </div>

      <div class="mb-0">
         <label class="small fw-bold text-muted mb-1">Lista de Características</label>
         
         <div class="input-group input-group-sm mb-2">
             <input v-model="newFeatureText" 
                    @keyup.enter="addFeature"
                    type="text" 
                    class="form-control" 
                    placeholder="Nueva característica...">
             <button @click="addFeature" class="btn btn-primary" type="button">
                 <i class="las la-plus"></i>
             </button>
         </div>

         <div v-if="localContent.features && localContent.features.length > 0" class="list-group shadow-sm">
             <div v-for="(item, index) in localContent.features" :key="index" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center p-2">
                 <small class="text-truncate me-2"><i class="las la-check text-success me-1"></i> {{ item }}</small>
                 <button @click="removeFeature(Number(index))" class="btn btn-xs btn-outline-danger border-0">
                     <i class="las la-trash"></i>
                 </button>
             </div>
         </div>
         <div v-else class="text-center p-2 border border-dashed rounded bg-white">
             <small class="text-muted fst-italic">Sin características agregadas</small>
         </div>
      </div>
    </div>

    <div class="p-3 border rounded bg-white">
      <h6 class="fw-bold mb-3 text-dark small">
        <i class="las la-image me-1"></i> Imagen Destacada
      </h6>
      
      <div class="d-flex align-items-start gap-3">
        <div class="flex-shrink-0">
             <div v-if="localContent.image" class="ratio ratio-1x1 rounded overflow-hidden border shadow-sm" style="width: 80px;">
                <img :src="formatImageUrl(localContent.image)" class="object-fit-cover">
             </div>
             <div v-else class="ratio ratio-1x1 rounded border bg-light d-flex align-items-center justify-content-center text-muted" style="width: 80px;">
                <i class="las la-image fs-1 opacity-50"></i>
             </div>
        </div>

        <div class="flex-grow-1">
             <div class="mb-2">
                <label class="x-small text-muted">Esta imagen tendrá un efecto flotante en la vista.</label>
             </div>
             <button type="button" 
                     @click="$emit('select-image', { item: localContent, field: 'image' })" 
                     class="btn btn-sm btn-outline-primary w-100">
                <i class="las la-cloud-upload-alt me-1"></i>
                {{ localContent.image ? 'Cambiar Imagen' : 'Seleccionar Imagen' }}
             </button>
             
             <button v-if="localContent.image" 
                     @click="updateImage('')" 
                     class="btn btn-xs btn-link text-danger text-decoration-none mt-1 w-100 text-end">
                <small>Quitar imagen</small>
             </button>
        </div>
      </div>
    </div>

  </div>
</template>

<script setup lang="ts">
import { computed, ref } from 'vue';
import { QuillEditor } from '@vueup/vue-quill';
import { formatImageUrl } from '@/helpers/url';
import '@vueup/vue-quill/dist/vue-quill.snow.css';

const props = defineProps<{
  modelValue: any 
}>();

const emit = defineEmits(['update:modelValue', 'select-image']);

const newFeatureText = ref('');

// Proxy para v-model
const localContent = computed({
  get: () => props.modelValue || {},
  set: (val) => emit('update:modelValue', val)
});

// Features Logic
const addFeature = () => {
    const text = newFeatureText.value.trim();
    if (!text) return;
    const currentFeatures = [...(props.modelValue.features || [])];
    currentFeatures.push(text);
    emit('update:modelValue', { ...props.modelValue, features: currentFeatures });
    newFeatureText.value = ''; 
};

const removeFeature = (index: number) => {
    const currentFeatures = [...(props.modelValue.features || [])];
    currentFeatures.splice(index, 1);
    emit('update:modelValue', { ...props.modelValue, features: currentFeatures });
};

// Image Logic
const updateImage = (url: string) => {
    emit('update:modelValue', { ...props.modelValue, image: url });
};


</script>

<style scoped>
.x-small {
  font-size: 0.75rem;
}
.object-fit-cover {
  object-fit: cover;
  width: 100%;
  height: 100%;
}
.btn-xs {
    padding: 0.1rem 0.4rem;
    font-size: 0.75rem;
}
.border-dashed {
    border-style: dashed !important;
}

/* Ajustes específicos para Quill dentro del editor pequeño */
:deep(.ql-editor) {
    min-height: 150px; /* Asegura altura mínima para escribir cómodo */
    font-size: 0.9rem;
}
:deep(.ql-toolbar) {
    border-top-left-radius: var(--bs-border-radius) !important;
    border-top-right-radius: var(--bs-border-radius) !important;
}
:deep(.ql-container) {
    border-bottom-left-radius: var(--bs-border-radius) !important;
    border-bottom-right-radius: var(--bs-border-radius) !important;
}
</style>