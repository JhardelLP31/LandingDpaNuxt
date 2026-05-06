<template>
  <div class="article-landing-editor">
    
    <ul class="nav nav-pills nav-fill mb-3 bg-light p-1 rounded-2" id="pills-tab" role="tablist">
      <li class="nav-item">
        <button class="nav-link active py-1 small fw-bold" @click="activeTab = 'design'">
          <i class="las la-palette"></i> Diseño
        </button>
      </li>
      <li class="nav-item">
        <button class="nav-link py-1 small fw-bold" @click="activeTab = 'content'">
          <i class="las la-pen-nib"></i> Redacción
        </button>
      </li>
    </ul>

    <div class="tab-content">
      
      <div v-if="activeTab === 'design'" class="animate-fade-in">
        <div class="mb-3">
          <label class="small fw-bold mb-1">Imagen de Portada (Hero)</label>
          <div class="image-selector-box border rounded p-2 bg-white text-center">
            <img v-if="localContent.imageUrl" :src="formatImageUrl(localContent.imageUrl)" class="img-fluid rounded mb-2 shadow-sm" style="max-height: 120px;">
            <div v-else class="py-4 bg-light rounded mb-2 border-dashed">
              <i class="las la-image fs-1 text-muted"></i>
            </div>
            <button class="btn btn-sm btn-outline-primary w-100" @click="$emit('select-image', { item: localContent, field: 'imageUrl' })">
              <i class="las la-upload"></i> {{ localContent.imageUrl ? 'Cambiar Imagen' : 'Seleccionar Imagen' }}
            </button>
          </div>
        </div>

        <div class="row g-2 mb-3">
          <div class="col-8">
            <label class="small fw-bold mb-1">Categoría</label>
            <input v-model="localContent.category" class="form-control form-control-sm" placeholder="Ej: INNOVACIÓN">
          </div>
          <div class="col-4">
            <label class="small fw-bold mb-1">Color Acento</label>
            <input type="color" v-model="localContent.accentColor" class="form-control form-control-sm form-control-color w-100">
          </div>
        </div>

        <div class="p-3 bg-white border rounded shadow-sm mb-3">
          <h6 class="small fw-bold mb-2 text-muted uppercase">Créditos del Autor</h6>
          <div class="d-flex align-items-center gap-2 mb-2">
            <img :src="localContent.authorImage || 'https://ui-avatars.com/api/?name=' + localContent.author" class="rounded-circle" width="40">
            <button class="btn btn-xs btn-light border" @click="$emit('select-image', { item: localContent, field: 'authorImage' })">Foto</button>
          </div>
          <input v-model="localContent.author" class="form-control form-control-sm mb-2" placeholder="Nombre completo">
          <input v-model="localContent.authorRole" class="form-control form-control-sm" placeholder="Cargo o Especialidad">
        </div>

        <div class="row g-2">
          <div class="col-6">
            <label class="small fw-bold mb-1">Fecha</label>
            <input v-model="localContent.date" class="form-control form-control-sm">
          </div>
          <div class="col-6">
            <label class="small fw-bold mb-1">Tiempo Lectura</label>
            <input v-model="localContent.readTime" class="form-control form-control-sm" placeholder="Ej: 8 min">
          </div>
        </div>
      </div>

      <div v-if="activeTab === 'content'" class="animate-fade-in">
        <div class="mb-3">
          <label class="small fw-bold mb-1">Título de Impacto (H1)</label>
          <textarea v-model="localContent.title" class="form-control form-control-sm fw-bold" rows="3"></textarea>
        </div>

        <div class="mb-3">
          <label class="small fw-bold mb-1">Bajada / Subtítulo</label>
          <textarea v-model="localContent.subtitle" class="form-control form-control-sm" rows="3"></textarea>
        </div>

        <div class="quill-container border rounded bg-white">
          <label class="small fw-bold p-2 border-bottom d-block bg-light">Contenido Enriquecido</label>
          <QuillEditor 
            theme="snow" 
            v-model:content="localContent.content" 
            contentType="html"
            :toolbar="['bold', 'italic', 'underline', { 'header': 2 }, 'blockquote', 'link', 'image', 'clean']"
          />
        </div>
      </div>

    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { QuillEditor } from '@vueup/vue-quill';
import '@vueup/vue-quill/dist/vue-quill.snow.css';
import { formatImageUrl } from '@/helpers/url';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue', 'select-image']);

const activeTab = ref('design');

const localContent = computed({
  get: () => props.modelValue,
  set: (val) => emit('update:modelValue', val)
});
</script>

<style scoped>
.nav-pills .nav-link.active {
  background-color: #000;
  color: white;
}
.nav-link { color: #666; cursor: pointer; }
.border-dashed { border-style: dashed !important; border-width: 2px !important; }
.btn-xs { padding: 0.2rem 0.5rem; font-size: 0.7rem; }
.uppercase { font-size: 0.65rem; letter-spacing: 1px; }

/* Estilo para que el editor Quill no sea gigante en el panel lateral */
:deep(.ql-container) {
  min-height: 300px;
  font-family: 'Georgia', serif;
  font-size: 14px;
}
:deep(.ql-toolbar) {
  border-top: none !important;
  border-left: none !important;
  border-right: none !important;
  background: #f8f9fa;
}

.animate-fade-in {
  animation: fadeIn 0.3s ease;
}
@keyframes fadeIn {
  from { opacity: 0; }
  to { opacity: 1; }
}
</style>