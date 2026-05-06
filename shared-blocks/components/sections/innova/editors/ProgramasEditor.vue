<script setup lang="ts">
import { ref, watch } from 'vue';
import { QuillEditor } from '@vueup/vue-quill';
import '@vueup/vue-quill/dist/vue-quill.snow.css';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue', 'select-image']);

const defaultItem = {
  id: '',
  title: 'Nuevo Programa',
  subtitle: 'Subtítulo',
  description: '<p>Descripción del programa...</p>',
  image: '',
  color1: 'rgba(33, 118, 255, 0.60)',
  color2: 'rgba(0, 33, 77, 0.60)'
};

const localData = ref({
  sectionRotulo: props.modelValue?.sectionRotulo || 'Nuestros',
  sectionTitle: props.modelValue?.sectionTitle || 'programas',
  backgroundColor: props.modelValue?.backgroundColor || '#1a1a1a', // <-- Nuevo
  titleColor: props.modelValue?.titleColor || '#ffffff',           // <-- Nuevo
  items: props.modelValue?.items || [{ ...defaultItem, id: Date.now().toString() }]
});

// Evitar loop infinito
watch(localData, (newVal) => {
  emit('update:modelValue', JSON.parse(JSON.stringify(newVal)));
}, { deep: true });

watch(() => props.modelValue, (newVal) => {
  if (!newVal) return;
  if (JSON.stringify(localData.value) !== JSON.stringify(newVal)) {
    localData.value = JSON.parse(JSON.stringify(newVal));
  }
}, { deep: true });

// Funciones del array
const addItem = () => {
  localData.value.items.push({ ...defaultItem, id: Date.now().toString() });
};
const removeItem = (index: number) => {
  localData.value.items.splice(index, 1);
};

// Helpers de Color adaptados para Array
const hexToRgb = (hex: string) => {
  const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
  return result ? `${parseInt(result[1], 16)}, ${parseInt(result[2], 16)}, ${parseInt(result[3], 16)}` : '33, 118, 255';
};

const updateItemColor = (index: number, field: 'color1' | 'color2', event: Event) => {
  const hex = (event.target as HTMLInputElement).value;
  const currentRgba = localData.value.items[index][field];
  const opacityMatch = currentRgba.match(/[\d.]+\)$/g);
  const opacity = opacityMatch ? parseFloat(opacityMatch[0]) : 0.6;
  localData.value.items[index][field] = `rgba(${hexToRgb(hex)}, ${opacity})`;
};

const updateItemOpacity = (index: number, event: Event) => {
  const opacity = parseInt((event.target as HTMLInputElement).value) / 100;
  const item = localData.value.items[index];
  
  const rgb1 = item.color1.match(/rgba?\((\d+,\s*\d+,\s*\d+)/);
  const rgb2 = item.color2.match(/rgba?\((\d+,\s*\d+,\s*\d+)/);
  
  const base1 = rgb1 ? rgb1[1] : '33, 118, 255';
  const base2 = rgb2 ? rgb2[1] : '0, 33, 77';

  item.color1 = `rgba(${base1}, ${opacity})`;
  item.color2 = `rgba(${base2}, ${opacity})`;
};

const getHexFromRgba = (rgba: string) => {
  const parts = rgba?.match(/^rgba?\((\d+),\s*(\d+),\s*(\d+)/);
  if (!parts) return '#2176ff';
  return '#' + [parts[1], parts[2], parts[3]].map(x => parseInt(x).toString(16).padStart(2, '0')).join('');
};

const getOpacityFromRgba = (rgba: string) => {
  const parts = rgba?.match(/[\d.]+\)$/g);
  return parts ? Math.round(parseFloat(parts[0]) * 100) : 60;
};
</script>

<template>
  <div class="programas-editor p-3">
    
    <div class="card shadow-sm mb-4 border-0 bg-light">
      <div class="card-body p-3">
        <h6 class="card-title text-primary fw-bold mb-3"><i class="las la-heading"></i> Configuración de la Sección</h6>
        <div class="row g-2">
          <div class="col-6">
            <label class="small text-muted">Rótulo (Ej. Nuestros)</label>
            <input type="text" class="form-control form-control-sm" v-model="localData.sectionRotulo">
          </div>
          <div class="col-6">
            <label class="small text-muted">Título (Ej. programas)</label>
            <input type="text" class="form-control form-control-sm" v-model="localData.sectionTitle">
          </div>
        </div>

        <div class="row g-2 mt-2">
          <div class="col-6">
            <label class="small text-muted">Color de Fondo General</label>
            <input type="color" class="form-control form-control-color form-control-sm w-100 p-1" v-model="localData.backgroundColor">
          </div>
          <div class="col-6">
            <label class="small text-muted">Color del Título Principal</label>
            <input type="color" class="form-control form-control-color form-control-sm w-100 p-1" v-model="localData.titleColor">
          </div>
        </div>

      </div>
    </div>

    <h6 class="text-secondary fw-bold mb-3 d-flex justify-content-between align-items-center">
      <span><i class="las la-layer-group"></i> Tarjetas de Programas</span>
      <button class="btn btn-sm btn-success" @click="addItem"><i class="las la-plus"></i> Añadir</button>
    </h6>

    <div v-for="(item, index) in localData.items" :key="item.id" class="card shadow-sm mb-3 border-secondary border-opacity-25">
      <div class="card-header bg-white d-flex justify-content-between align-items-center p-2">
        <span class="fw-bold small text-dark"><i class="las la-grip-vertical text-muted"></i> Programa {{ Number(index) + 1 }}</span>
        <button class="btn btn-sm btn-outline-danger py-0 px-2" @click="removeItem(Number(index))" title="Eliminar tarjeta"><i class="las la-trash"></i></button>
      </div>
      
      <div class="card-body p-3 bg-light">
        <div class="row g-2 mb-2">
          <div class="col-6">
            <label class="small text-muted">Nombre</label>
            <input type="text" class="form-control form-control-sm" v-model="item.title" placeholder="Ej. Start">
          </div>
          <div class="col-6">
            <label class="small text-muted">Subtítulo</label>
            <input type="text" class="form-control form-control-sm" v-model="item.subtitle" placeholder="Ej. Descubre oportunidades">
          </div>
        </div>

        <div class="mb-3 quill-wrapper">
          <label class="small text-muted d-block mb-1">Descripción</label>
          <QuillEditor
            theme="snow"
            v-model:content="item.description"
            contentType="html"
            :toolbar="['bold', 'italic', 'underline', 'link', { list: 'bullet' }]"
          />
        </div>

        <button class="btn btn-sm btn-dark w-100 mb-3" @click="$emit('select-image', { item: item, field: 'image' })">
          <i class="las la-image"></i> {{ item.image ? 'Cambiar Fondo' : 'Seleccionar Fondo' }}
        </button>

        <div class="row g-3 mb-2">
          <div class="col-6">
            <label class="small text-muted d-block mb-1">Color Arriba</label>
            <input type="color" class="form-control form-control-color form-control-sm w-100 p-1" :value="getHexFromRgba(item.color1)" @input="updateItemColor(Number(index), 'color1', $event)">
          </div>
          <div class="col-6">
            <label class="small text-muted d-block mb-1">Color Abajo</label>
            <input type="color" class="form-control form-control-color form-control-sm w-100 p-1" :value="getHexFromRgba(item.color2)" @input="updateItemColor(Number(index), 'color2', $event)">
          </div>
        </div>
        <div class="mt-2">
          <label class="small text-muted d-flex justify-content-between mb-1">
            <span>Opacidad del gradiente</span>
            <span class="fw-bold text-primary">{{ getOpacityFromRgba(item.color1) }}%</span>
          </label>
          <input type="range" class="form-range" min="0" max="100" step="1" :value="getOpacityFromRgba(item.color1)" @input="updateItemOpacity(Number(index), $event)">
        </div>

      </div>
    </div>

  </div>
</template>

<style scoped>
.quill-wrapper :deep(.ql-container) {
  min-height: 100px;
  background-color: #fff;
  border-bottom-left-radius: 4px;
  border-bottom-right-radius: 4px;
  font-family: inherit;
  font-size: 0.875rem; 
}
.quill-wrapper :deep(.ql-toolbar) {
  background-color: #f8f9fa;
  border-top-left-radius: 4px;
  border-top-right-radius: 4px;
  padding: 4px 8px; 
}
.quill-wrapper :deep(.ql-formats) {
  margin-right: 10px;
}
</style>