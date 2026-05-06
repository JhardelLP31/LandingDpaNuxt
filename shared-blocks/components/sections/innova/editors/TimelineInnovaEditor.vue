<script setup lang="ts">
import { ref, watch } from 'vue';
import { QuillEditor } from '@vueup/vue-quill';
import { formatImageUrl } from '../../../../helpers/url';
import '@vueup/vue-quill/dist/vue-quill.snow.css';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue', 'select-image']);

const miniToolbar = [['bold', 'italic'], [{ 'list': 'bullet' }], ['clean']];

const safeColor = (color: string, fallback: string) => {
  return (color && color.startsWith('#')) ? color : fallback;
};

// 1. Inicialización con soporte para el Mosaico Triple
const initData = (source: any) => {
  const d = source || {};
  return {
    title: d.title || '',
    contentType: d.contentType || 'timeline',
    imageType: d.imageType || 'single', // 'single' o 'triple'
    image: d.image || '',               // Para modo single
    images: Array.isArray(d.images) ? [...d.images] : ['', '', ''], // Para modo triple (3 slots)
    imageSide: d.imageSide || 'right',
    bgColor: safeColor(d.bgColor, '#ffffff'),
    accentColor: safeColor(d.accentColor, '#2176ff'),
    overlayColor1: safeColor(d.overlayColor1, '#2176ff'),
    overlayColor2: safeColor(d.overlayColor2, '#ff8121'),
    items: Array.isArray(d.items) ? JSON.parse(JSON.stringify(d.items)) : [],
    content: d.content || '', 
    features: Array.isArray(d.features) ? [...d.features] : [] 
  };
};

const localData = ref(initData(props.modelValue));
const newFeatureText = ref('');

// --- SEGURIDAD REACTIVA ---
watch(() => props.modelValue, (newVal) => {
  const currentLocal = JSON.stringify(localData.value);
  const incomingProp = JSON.stringify(newVal);
  if (incomingProp !== currentLocal) {
    localData.value = initData(newVal);
  }
}, { deep: true });

watch(localData, (newVal) => {
  const currentProp = JSON.stringify(props.modelValue);
  const currentLocal = JSON.stringify(newVal);
  if (currentLocal !== currentProp) {
    emit('update:modelValue', JSON.parse(currentLocal));
  }
}, { deep: true });

// --- MÉTODOS ---
const addItem = () => {
  localData.value.items.push({ label: 'Nuevo Título', content: '<ul><li></li></ul>' });
};
const removeItem = (index: number) => {
  localData.value.items.splice(index, 1);
};

// Función para capturar la imagen en un slot específico del array
const selectMosaicImage = (index: number) => {
  emit('select-image', { 
    item: localData.value.images, 
    field: index.toString() 
  });
};
</script>

<template>
  <div class="p-3 bg-white shadow-sm rounded border">
    
    <div class="mb-4">
      <label class="small fw-bold text-muted mb-1">Título de la Sección</label>
      <input v-model="localData.title" type="text" class="form-control form-control-sm mb-3">
      
      <div class="row g-2">
        <div class="col-6">
          <label class="small fw-bold text-primary mb-1">Tipo Contenido</label>
          <select v-model="localData.contentType" class="form-select form-select-sm">
            <option value="timeline">Línea de Tiempo</option>
            <option value="accordion">Acordeón</option>
            <option value="html">Texto Libre</option>
            <option value="list">Lista Checks</option>
          </select>
        </div>
        <div class="col-6">
          <label class="small fw-bold text-primary mb-1">Diseño Visual</label>
          <select v-model="localData.imageType" class="form-select form-select-sm">
            <option value="single">Cápsula (1 Foto)</option>
            <option value="triple">Mosaico (3 Fotos)</option>
          </select>
        </div>
      </div>
    </div>

    <div class="p-3 border rounded bg-light mb-4">
      <h6 class="small fw-bold text-uppercase mb-3">Configuración de Imagen</h6>
      
      <div v-if="localData.imageType === 'single'" class="mb-3">
        <div class="d-flex align-items-center gap-3">
          <div class="preview-box border rounded bg-white">
            <img v-if="localData.image" :src="formatImageUrl(localData.image)">
            <i v-else class="las la-image opacity-25"></i>
          </div>
          <button @click="$emit('select-image', { item: localData, field: 'image' })" class="btn btn-sm btn-primary flex-grow-1">
            Subir Foto Cápsula
          </button>
        </div>
      </div>

      <div v-else class="mb-3">
        <div class="row g-2">
          <div v-for="(img, idx) in 3" :key="idx" class="col-4 text-center">
            <div class="preview-box border rounded bg-white mb-1 w-100" style="height: 60px;">
              <img v-if="localData.images[idx]" :src="formatImageUrl(localData.images[idx])">
              <span v-else class="x-small text-muted">#{{idx + 1}}</span>
            </div>
            <button @click="selectMosaicImage(idx)" class="btn btn-xs btn-outline-primary p-1 w-100">
              Subir
            </button>
          </div>
        </div>
        <div class="form-text x-small mt-2 text-center text-muted">
          1: Arriba-Izquierda | 2: Abajo-Izquierda | 3: Derecha-Vertical
        </div>
      </div>

      <div class="row g-2 pt-2 border-top mt-2">
        <div class="col-6">
          <label class="xs-label">Lado de Imagen</label>
          <select v-model="localData.imageSide" class="form-select form-select-sm">
            <option value="right">Derecha</option>
            <option value="left">Izquierda</option>
          </select>
        </div>
        <div class="col-6">
          <label class="xs-label">Color Acento</label>
          <input type="color" v-model="localData.accentColor" class="form-control form-control-color w-100 p-1">
        </div>
        <div v-if="localData.imageType === 'single'" class="col-12 mt-2">
          <label class="xs-label">Gradiente sobre foto (Solo Cápsula)</label>
          <div class="d-flex gap-2">
            <input type="color" v-model="localData.overlayColor1" class="form-control form-control-color flex-grow-1 p-1">
            <input type="color" v-model="localData.overlayColor2" class="form-control form-control-color flex-grow-1 p-1">
          </div>
        </div>
      </div>
    </div>

    <hr>

    <div v-if="localData.contentType === 'timeline' || localData.contentType === 'accordion'">
      <div class="d-flex justify-content-between align-items-center mb-2">
        <span class="small fw-bold">ITEMS</span>
        <button class="btn btn-success btn-xs" @click="addItem"><i class="las la-plus"></i></button>
      </div>
      <div class="scroll-area">
        <div v-for="(item, index) in localData.items" :key="index" class="card mb-3 border-0 shadow-sm bg-light">
          <div class="card-header bg-transparent border-0 d-flex justify-content-between pb-0 pt-2">
            <span class="badge bg-dark">#{{ Number(index) + 1 }}</span>
            <button class="btn btn-link text-danger p-0" @click="removeItem(Number(index))"><i class="las la-trash-alt"></i></button>
          </div>
          <div class="card-body pt-1">
            <input v-model="item.label" class="form-control form-control-sm mb-2 fw-bold" placeholder="Título">
            <div class="quill-mini-container bg-white rounded border shadow-xs">
              <QuillEditor v-model:content="item.content" contentType="html" theme="snow" :toolbar="miniToolbar" />
            </div>
          </div>
        </div>
      </div>
    </div>

    <div v-else-if="localData.contentType === 'html'">
      <label class="small fw-bold mb-1">Editor Principal</label>
      <div class="bg-white border rounded shadow-sm">
        <QuillEditor v-model:content="localData.content" contentType="html" theme="snow" />
      </div>
    </div>

  </div>
</template>

<style scoped>
.xs-label { font-size: 0.65rem; font-weight: bold; text-transform: uppercase; color: #888; display: block; margin-bottom: 2px; }
.x-small { font-size: 0.65rem; }
.btn-xs { padding: 2px 8px; font-size: 0.75rem; }
.scroll-area { max-height: 400px; overflow-y: auto; padding-right: 5px; }
.form-control-color { height: 32px; cursor: pointer; }
.preview-box { 
  width: 70px; height: 70px; display: flex; align-items: center; justify-content: center; 
  overflow: hidden; 
}
.preview-box img { width: 100%; height: 100%; object-fit: cover; }
.quill-mini-container :deep(.ql-editor) { min-height: 80px; font-size: 0.85rem; padding: 10px; }
.quill-mini-container :deep(.ql-toolbar) { border: none; border-bottom: 1px solid #eee; padding: 2px; }
.quill-mini-container :deep(.ql-container) { border: none; }
</style>