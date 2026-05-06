<script setup lang="ts">
import { ref, watch } from 'vue';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue', 'select-image']);

const localData = ref({
  title: props.modelValue?.title || 'ESTUDIAR Y TRABAJAR ES POSIBLE',
  subtitle: props.modelValue?.subtitle || 'ENCUENTRA EL BALANCE PARA CRECER PROFESIONALMENTE SIN DESCUIDAR TU TRABAJO.',
  titleSize: props.modelValue?.titleSize || 30,
  subtitleSize: props.modelValue?.subtitleSize || 15,
  contentWidth: props.modelValue?.contentWidth || 900, // NUEVO: Ancho del contenedor
  bgColor: props.modelValue?.bgColor || '#ffb300',
  bgPattern: props.modelValue?.bgPattern || '',
  bgPatternOpacity: props.modelValue?.bgPatternOpacity ?? 0.15,
  titleColor: props.modelValue?.titleColor || '#000000',
  subtitleColor: props.modelValue?.subtitleColor || '#000000',
  fontFamily: props.modelValue?.fontFamily || 'inherit'
});

// Sincronizar de AFUERA hacia ADENTRO
watch(() => props.modelValue, (newVal) => {
  if (!newVal) return;
  const stringifiedNew = JSON.stringify(newVal);
  const stringifiedLocal = JSON.stringify(localData.value);
  
  if (stringifiedNew !== stringifiedLocal) {
    localData.value = { ...localData.value, ...newVal };
  }
}, { deep: true });

// Sincronizar de ADENTRO hacia AFUERA
watch(localData, (newVal) => {
  emit('update:modelValue', { ...newVal });
}, { deep: true });
</script>

<template>
  <div class="p-3">
    
    <div class="card mb-3 border-0 shadow-sm">
      <div class="card-body">
        <h6 class="fw-bold mb-3 text-primary"><i class="las la-pen"></i> Contenido Escrito</h6>
        
        <div class="mb-3">
          <label class="small text-muted">Título Principal</label>
          <input type="text" v-model="localData.title" class="form-control form-control-sm">
        </div>
        
        <div class="mb-3">
          <label class="small text-muted">Subtítulo</label>
          <textarea v-model="localData.subtitle" class="form-control form-control-sm" rows="2"></textarea>
        </div>
      </div>
    </div>

    <div class="card border-0 shadow-sm bg-dark text-white">
      <div class="card-body">
        <h6 class="fw-bold mb-3 text-warning"><i class="las la-palette"></i> Diseño y Dimensiones</h6>
        
        <div class="mb-3">
          <label class="x-small d-block mb-1">Tipografía del Banner</label>
          <select v-model="localData.fontFamily" class="form-select form-select-sm">
            <option value="inherit">Fuente por defecto del sitio</option>
            <option value="'Montserrat', sans-serif">Montserrat</option>
            <option value="'Open Sans', sans-serif">Open Sans</option>
            <option value="'Roboto', sans-serif">Roboto</option>
            <option value="'Arial', sans-serif">Arial</option>
            <option value="'Georgia', serif">Georgia</option>
          </select>
        </div>

        <div class="row g-2 mb-3 bg-secondary bg-opacity-25 p-2 rounded">
          <div class="col-12">
            <label class="x-small d-block mb-1 text-warning">Tamaño Título: {{ localData.titleSize }}px</label>
            <input type="range" v-model="localData.titleSize" min="16" max="80" step="1" class="form-range">
          </div>
          <div class="col-12 mt-2">
            <label class="x-small d-block mb-1 text-warning">Tamaño Subtítulo: {{ localData.subtitleSize }}px</label>
            <input type="range" v-model="localData.subtitleSize" min="10" max="40" step="1" class="form-range">
          </div>
          <div class="col-12 mt-2">
            <label class="x-small d-block mb-1 text-info">Ancho del Contenido: {{ localData.contentWidth }}px</label>
            <input type="range" v-model="localData.contentWidth" min="400" max="1400" step="10" class="form-range">
          </div>
        </div>

        <div class="row g-2 mb-3">
          <div class="col-6">
            <label class="x-small d-block mb-1">Color Título</label>
            <input type="color" v-model="localData.titleColor" class="form-control form-control-color w-100 p-1">
          </div>
          <div class="col-6">
            <label class="x-small d-block mb-1">Color Subtítulo</label>
            <input type="color" v-model="localData.subtitleColor" class="form-control form-control-color w-100 p-1">
          </div>
        </div>

        <hr class="border-secondary">

        <div class="row g-2 align-items-center mb-3">
          <div class="col-4">
            <label class="x-small d-block mb-1">Color Fondo</label>
            <input type="color" v-model="localData.bgColor" class="form-control form-control-color w-100 p-1">
          </div>
          <div class="col-8">
            <label class="x-small d-block mb-1">Textura (Opcional)</label>
            <div @click="$emit('select-image', { item: localData, field: 'bgPattern' })" 
                 class="media-placeholder border rounded clickable"
                 :style="{ backgroundImage: `url(${localData.bgPattern})`, backgroundColor: '#444' }">
              <i v-if="!localData.bgPattern" class="las la-plus text-white"></i>
            </div>
          </div>
        </div>

        <div class="row">
          <div class="col-12">
            <label class="x-small d-block">Intensidad Textura: {{ Math.round(localData.bgPatternOpacity * 100) }}%</label>
            <input type="range" v-model="localData.bgPatternOpacity" min="0" max="1" step="0.05" class="form-range">
          </div>
        </div>

      </div>
    </div>

  </div>
</template>

<style scoped>
.media-placeholder {
  height: 38px;
  background-color: #eee;
  background-size: cover;
  background-position: center;
  display: grid;
  place-items: center;
  cursor: pointer;
  border: 1px dashed #ccc;
}
.x-small { font-size: 0.65rem; text-transform: uppercase; font-weight: bold; }
.clickable { cursor: pointer; }

.form-range::-webkit-slider-thumb {
  background: #ffc107;
}
</style>