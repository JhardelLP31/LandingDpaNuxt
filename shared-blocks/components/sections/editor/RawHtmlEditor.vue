<script setup lang="ts">
import { computed, ref } from 'vue';
import { formatImageUrl } from '@/helpers/url';
import { QuillEditor } from '@vueup/vue-quill';
import '@vueup/vue-quill/dist/vue-quill.snow.css';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue', 'select-image']);

const activeTab = ref<'visual' | 'code'>('code');

const localData = computed({
  get: () => props.modelValue || { htmlCode: '', config: { fullWidth: false }, helperImage: '' },
  set: (val) => emit('update:modelValue', val)
});

const updateConfig = (field: string, value: any) => {
  const newConfig = { ...(localData.value.config || {}), [field]: value };
  emit('update:modelValue', { ...localData.value, config: newConfig });
};

const triggerImageSelect = () => {
  emit('select-image', { item: localData.value, field: 'helperImage' });
};

const copyImageToClipboard = () => {
  if (!localData.value.helperImage) return;
  navigator.clipboard.writeText(localData.value.helperImage);
  alert('Ruta copiada. Si es para CSS usa: url(\'' + localData.value.helperImage + '\')');
};

// --- CONFIGURACIÓN FULL TOOLBAR PARA QUILL ---
const fullToolbar = [
  ['bold', 'italic', 'underline', 'strike'],
  ['blockquote', 'code-block'],
  [{ 'header': 1 }, { 'header': 2 }],
  [{ 'list': 'ordered'}, { 'list': 'bullet' }],
  [{ 'script': 'sub'}, { 'script': 'super' }],
  [{ 'indent': '-1'}, { 'indent': '+1' }],
  [{ 'size': ['small', false, 'large', 'huge'] }],
  [{ 'header': [1, 2, 3, 4, 5, 6, false] }],
  [{ 'color': [] }, { 'background': [] }],
  [{ 'font': [] }],
  [{ 'align': [] }],
  ['clean'],
  ['link', 'image', 'video']
];
</script>

<template>
  <div class="p-2">
    <div class="d-flex border-bottom mb-3">
      <button 
        class="btn btn-sm pb-2 px-3 rounded-0 border-0"
        :class="activeTab === 'code' ? 'border-bottom border-primary text-primary fw-bold' : 'text-muted'"
        @click="activeTab = 'code'"
      >
        <i class="fas fa-code me-1"></i> Código HTML
      </button>
      <button 
        class="btn btn-sm pb-2 px-3 rounded-0 border-0"
        :class="activeTab === 'visual' ? 'border-bottom border-primary text-primary fw-bold' : 'text-muted'"
        @click="activeTab = 'visual'"
      >
        <i class="fas fa-eye me-1"></i> Editor Visual
      </button>
    </div>

    <div class="mb-3 border rounded bg-white p-2">
      <div v-if="activeTab === 'code'">
        <textarea 
          v-model="localData.htmlCode" 
          class="form-control font-monospace border-0 bg-light" 
          style="font-size: 13px; min-height: 350px; line-height: 1.5;"
          placeholder="<section style='...'>...</section>"
          spellcheck="false"
        ></textarea>
      </div>

      <div v-if="activeTab === 'visual'">
        <QuillEditor 
          v-model:content="localData.htmlCode" 
          contentType="html"
          theme="snow" 
          :toolbar="fullToolbar" 
          style="min-height: 300px;"
        />
      </div>
    </div>

    <div class="mb-3 border p-3 rounded bg-light shadow-sm">
      <h6 class="fw-bold text-dark mb-2" style="font-size: 0.85rem;">
        <i class="fas fa-images"></i> Selector de Rutas
      </h6>
      <div class="input-group input-group-sm">
        <button class="btn btn-outline-secondary" type="button" @click="triggerImageSelect">Buscar</button>
        <input type="text" class="form-control bg-white" readonly :value="localData.helperImage || ''">
        <button class="btn btn-primary" type="button" :disabled="!localData.helperImage" @click="copyImageToClipboard">Copiar</button>
      </div>
    </div>

    <div class="border-top pt-3 mt-3">
       <div class="row g-2">
          <div class="col-12 mb-2">
            <div class="form-check form-switch p-3 border rounded bg-white shadow-sm">
              <input 
                class="form-check-input ms-0 me-2" 
                type="checkbox" 
                id="fullWidthSwitch"
                :checked="!!localData.config?.fullWidth" 
                @change="e => updateConfig('fullWidth', (e.target as HTMLInputElement).checked)"
              >
              <label class="form-check-label fw-bold text-primary" for="fullWidthSwitch">
                Forzar Ancho Total (Pantalla Completa)
              </label>
              <div class="text-muted small">Ignora los márgenes del sitio y expande el HTML de borde a borde.</div>
            </div>
          </div>

          <div class="col-6">
            <label class="small fw-bold text-muted">Contenedor Interno</label>
            <select 
              class="form-select form-select-sm" 
              :value="localData.config?.container || 'none'"
              @change="e => updateConfig('container', (e.target as HTMLSelectElement).value)"
            >
              <option value="none">Sin Contenedor (Flush)</option>
              <option value="container">Con Márgenes (Container)</option>
              <option value="container-fluid">Fluido (Fluid)</option>
            </select>
          </div>
          <div class="col-6">
            <label class="small fw-bold text-muted">Espaciado Vertical</label>
            <select 
              class="form-select form-select-sm" 
              :value="localData.config?.paddingY || 'py-0'"
              @change="e => updateConfig('paddingY', (e.target as HTMLSelectElement).value)"
            >
              <option value="py-0">Sin Padding</option>
              <option value="py-5">Padding Estándar</option>
            </select>
          </div>
       </div>
    </div>

  </div>
</template>