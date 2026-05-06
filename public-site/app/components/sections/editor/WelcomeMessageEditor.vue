<script setup lang="ts">
import { computed } from 'vue';
import { formatImageUrl } from '@/helpers/url';
import { QuillEditor } from '@vueup/vue-quill';
import '@vueup/vue-quill/dist/vue-quill.snow.css';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue', 'select-image']);

const localContent = computed({
  get: () => props.modelValue || { config: {} },
  set: (val) => emit('update:modelValue', val)
});

// --- CONFIGURACIÓN DE QUILL ---
const editorOptions = {
  modules: {
    toolbar: [
      [{ 'header': [1, 2, 3, false] }],
      ['bold', 'italic', 'underline'],
      [{ 'color': [] }, { 'background': [] }],          // Colores
      [{ 'size': ['small', false, 'large', 'huge'] }], // Tamaños
      [{ 'list': 'ordered' }, { 'list': 'bullet' }],
      [{ 'align': [] }],
      ['clean']                                        // Borrar formato
    ]
  },
  placeholder: 'Escribe el contenido aquí...'
};

const updateConfig = (field: string, value: any) => {
  const newConfig = { ...(localContent.value.config || {}), [field]: value };
  emit('update:modelValue', { ...localContent.value, config: newConfig });
};
</script>

<template>
  <div class="p-2 editor-container">
    
    <div class="mb-3 border p-3 rounded bg-light">
      <h6 class="fw-bold text-primary mb-3">Contenido</h6>
      <div class="bg-white">
        <QuillEditor 
          v-model:content="localContent.content" 
          contentType="html"
          theme="snow" 
          :options="editorOptions"
          style="min-height: 200px;"
        />
      </div>
      <div class="form-check form-switch mt-2">
        <input 
          class="form-check-input" 
          type="checkbox" 
          id="justifySwitch"
          :checked="localContent.config?.textAlign !== 'left'" 
          @change="e => updateConfig('textAlign', (e.target as HTMLInputElement).checked ? 'justify' : 'left')"
        >
        <label class="form-check-label small" for="justifySwitch">Justificar Texto</label>
      </div>
    </div>

    <div class="mb-3 border p-3 rounded bg-white shadow-sm">
      <h6 class="fw-bold text-primary mb-3">Diseño y Colores</h6>
      <label class="small fw-bold text-muted d-block mb-1">Fondo Externo (Pantalla Completa)</label>
      <div class="row g-2 mb-3">
        <div class="col-6">
           <label class="small text-muted" style="font-size: 0.75rem;">Parte Superior</label>
           <div class="d-flex align-items-center gap-1">
             <input type="color" 
                class="form-control form-control-color form-control-sm w-100" 
                :value="localContent.config?.bgSplitTop || '#ffffff'"
                @input="e => updateConfig('bgSplitTop', (e.target as HTMLInputElement).value)">
             <button class="btn btn-sm btn-outline-secondary px-1" title="Transparente" @click="updateConfig('bgSplitTop', 'transparent')">
                <i class="fas fa-ban fa-xs"></i>
             </button>
           </div>
        </div>
        <div class="col-6">
           <label class="small text-muted" style="font-size: 0.75rem;">Parte Inferior</label>
           <div class="d-flex align-items-center gap-1">
             <input type="color" 
                class="form-control form-control-color form-control-sm w-100" 
                :value="localContent.config?.bgSplitBottom || '#ffffff'"
                @input="e => updateConfig('bgSplitBottom', (e.target as HTMLInputElement).value)">
             <button class="btn btn-sm btn-outline-secondary px-1" title="Transparente" @click="updateConfig('bgSplitBottom', 'transparent')">
                <i class="fas fa-ban fa-xs"></i>
             </button>
           </div>
        </div>
      </div>

      <label class="small fw-bold text-muted d-block mb-1">Fondo de la Tarjeta (Contenido)</label>
      <div class="d-flex align-items-center gap-2">
         <input type="color" 
            class="form-control form-control-color w-50" 
            :value="localContent.config?.cardBgColor || '#ffffff'"
            @input="e => updateConfig('cardBgColor', (e.target as HTMLInputElement).value)">
         <span class="small text-muted">Color de la caja</span>
      </div>
    </div>

    <div class="mb-3 border p-3 rounded bg-light">
      <h6 class="fw-bold text-primary mb-3">Imágenes</h6>
      <label class="small fw-bold">Imagen Principal</label>
      <button 
          @click="$emit('select-image', { item: localContent, field: 'mainImage' })"
          class="btn btn-sm btn-outline-primary w-100 mb-3"
      >
        <i class="fas fa-image"></i> {{ localContent.mainImage ? 'Cambiar Imagen' : 'Seleccionar Imagen' }}
      </button>

      <label class="small fw-bold">Firma</label>
      <input v-model="localContent.signatureTitle" class="form-control form-control-sm mb-2" placeholder="Cargo">
      <div class="d-flex gap-2">
         <div v-if="localContent.signatureImage" class="bg-white border p-1 rounded">
             <img :src="formatImageUrl(localContent.signatureImage)" style="height: 30px;">
         </div>
         <button 
             @click="$emit('select-image', { item: localContent, field: 'signatureImage' })"
             class="btn btn-sm btn-outline-secondary flex-grow-1"
         >
           Subir Firma
         </button>
      </div>
    </div>

  </div>
</template>

<style scoped>
/* Forzamos Arial en el editor y en la visualización del mismo */
:deep(.ql-editor) {
  font-family: 'Arial', sans-serif !important;
  font-size: 16px;
}

/* Estilos para que el menú de Quill se vea bien */
:deep(.ql-container) {
  border-bottom-left-radius: 4px;
  border-bottom-right-radius: 4px;
}
:deep(.ql-toolbar) {
  border-top-left-radius: 4px;
  border-top-right-radius: 4px;
  background-color: #f8f9fa;
}
</style>