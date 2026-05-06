<script setup lang="ts">
import { ref, watch, computed } from 'vue'; // <--- ¡AQUÍ FALTABA EL COMPUTED!

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue', 'select-image']);

// 1. Cargamos la data inicial
const localData = ref({
  title: props.modelValue?.title || 'POSTULACIÓN',
  description: props.modelValue?.description || '',
  buttonText: props.modelValue?.buttonText || 'Más información',
  buttonLink: props.modelValue?.buttonLink || '#',
  image: props.modelValue?.image || '',
  overlayColor1: props.modelValue?.overlayColor1 || 'rgba(33, 118, 255, 0.8)',
  overlayColor2: props.modelValue?.overlayColor2 || 'rgba(33, 118, 255, 0.8)'
});

// 2. Control de cambios bidireccional (Evita el bucle infinito)
watch(localData, (newVal) => {
  emit('update:modelValue', { ...newVal });
}, { deep: true });

watch(() => props.modelValue, (newVal) => {
  if (!newVal) return;
  if (JSON.stringify(localData.value) !== JSON.stringify(newVal)) {
    localData.value = { ...localData.value, ...newVal };
  }
}, { deep: true });

// 3. Helpers para transformar HEX <-> RGBA
const hexToRgb = (hex: string) => {
  const result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
  return result ? `${parseInt(result[1], 16)}, ${parseInt(result[2], 16)}, ${parseInt(result[3], 16)}` : '33, 118, 255';
};

const rgbaToHex = (rgba: string) => {
  if (!rgba) return '#2176ff';
  const parts = rgba.match(/^rgba?\((\d+),\s*(\d+),\s*(\d+)/);
  if (!parts) return '#2176ff';
  return '#' + [parts[1], parts[2], parts[3]].map(x => parseInt(x).toString(16).padStart(2, '0')).join('');
};

const getOpacity = (rgba: string) => {
  if (!rgba) return 80;
  const parts = rgba.match(/[\d.]+\)$/g);
  return parts ? Math.round(parseFloat(parts[0]) * 100) : 80;
};

// 4. Variables Computadas para el Editor Visual
const opacityLevel = computed({
  get: () => getOpacity(localData.value.overlayColor1),
  set: (val) => {
    const currentRgb1 = localData.value.overlayColor1?.match(/rgba?\((\d+,\s*\d+,\s*\d+)/);
    const currentRgb2 = localData.value.overlayColor2?.match(/rgba?\((\d+,\s*\d+,\s*\d+)/);
    
    const base1 = currentRgb1 ? currentRgb1[1] : '33, 118, 255';
    const base2 = currentRgb2 ? currentRgb2[1] : '33, 118, 255';

    localData.value.overlayColor1 = `rgba(${base1}, ${val / 100})`;
    localData.value.overlayColor2 = `rgba(${base2}, ${val / 100})`;
  }
});

const colorHex1 = computed({
  get: () => rgbaToHex(localData.value.overlayColor1),
  set: (val) => { 
    localData.value.overlayColor1 = `rgba(${hexToRgb(val)}, ${opacityLevel.value / 100})`; 
  }
});

const colorHex2 = computed({
  get: () => rgbaToHex(localData.value.overlayColor2),
  set: (val) => { 
    localData.value.overlayColor2 = `rgba(${hexToRgb(val)}, ${opacityLevel.value / 100})`; 
  }
});
</script>

<template>
  <div class="cta-editor p-3">
    <div class="card shadow-sm mb-3 border-0 bg-light">
      <div class="card-body p-3">
        <h6 class="card-title text-primary fw-bold mb-3"><i class="las la-font"></i> Contenido</h6>
        <div class="mb-2">
          <label class="small text-muted">Título</label>
          <input type="text" class="form-control form-control-sm" v-model="localData.title" placeholder="Ej. POSTULACIÓN">
        </div>
        <div>
          <label class="small text-muted">Descripción</label>
          <textarea class="form-control form-control-sm" v-model="localData.description" rows="3" placeholder="Texto descriptivo..."></textarea>
        </div>
      </div>
    </div>

    <div class="card shadow-sm mb-3 border-0 bg-light">
      <div class="card-body p-3">
        <h6 class="card-title text-primary fw-bold mb-3"><i class="las la-link"></i> Botón</h6>
        <div class="mb-2">
          <label class="small text-muted">Texto del Botón</label>
          <input type="text" class="form-control form-control-sm" v-model="localData.buttonText" placeholder="Ej. Más información">
        </div>
        <div>
          <label class="small text-muted">URL / Enlace</label>
          <input type="url" class="form-control form-control-sm" v-model="localData.buttonLink" placeholder="https://...">
        </div>
      </div>
    </div>

    <div class="card shadow-sm border-0 bg-light">
      <div class="card-body p-3">
        <h6 class="card-title text-primary fw-bold mb-3"><i class="las la-fill-drip"></i> Fondo y Colores</h6>
        
        <button class="btn btn-sm btn-dark w-100 mb-3" @click="$emit('select-image', { item: localData, field: 'image' })">
          <i class="las la-image"></i> {{ localData.image ? 'Cambiar Imagen' : 'Seleccionar Imagen' }}
        </button>

        <div class="row g-3 mb-2">
          <div class="col-6">
            <label class="small text-muted d-block mb-1">Color Arriba</label>
            <input type="color" class="form-control form-control-color form-control-sm w-100 p-1" v-model="colorHex1" title="Elegir color">
          </div>
          <div class="col-6">
            <label class="small text-muted d-block mb-1">Color Abajo</label>
            <input type="color" class="form-control form-control-color form-control-sm w-100 p-1" v-model="colorHex2" title="Elegir color">
          </div>
        </div>

        <div class="mt-3">
          <label class="small text-muted d-flex justify-content-between mb-1">
            <span>Opacidad del color</span>
            <span class="fw-bold text-primary">{{ opacityLevel }}%</span>
          </label>
          <input type="range" class="form-range" min="0" max="100" step="1" v-model="opacityLevel">
          <p class="text-muted mt-1 mb-0" style="font-size: 11px;">
            * Ajusta la barra para dejar ver la imagen trasera.
          </p>
        </div>
        
      </div>
    </div>
  </div>
</template>