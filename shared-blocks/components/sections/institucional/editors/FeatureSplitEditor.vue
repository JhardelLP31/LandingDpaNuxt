<script setup lang="ts">
import { ref, watch } from 'vue';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue', 'select-image']);

const localData = ref({
  // Valores por defecto basados en ESAN DPA Modalidad
  title: props.modelValue?.title || 'MODALIDAD PRESENCIAL Y SEMIPRESENCIAL',
  description: props.modelValue?.description || 'Estudia en el campus, en tu casa o\n en el lugar que desees.',
  imageSrc: props.modelValue?.imageSrc || '',
  btnText: props.modelValue?.btnText || 'MÁS INFORMACIÓN',
  btnUrl: props.modelValue?.btnUrl || '#',
  
  // Ajustes Visuales
  bgColor: props.modelValue?.bgColor || '#ffffff',
  btnColor: props.modelValue?.btnColor || '#ff2b2b',
  textColor: props.modelValue?.textColor || '#333333',
  titleColor: props.modelValue?.titleColor || '#000000',
  inverted: props.modelValue?.inverted || false // Prop clave para la inversión
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
    
    <div class="card mb-3 bg-light border-0 shadow-sm">
      <div class="card-body">
        <h6 class="fw-bold text-primary mb-3"><i class="las la-image"></i> Multimedia</h6>
        <label class="x-small d-block mb-2">Imagen Principal</label>
        <div @click="$emit('select-image', { item: localData, field: 'imageSrc' })" 
             class="media-placeholder border rounded mb-2 clickable"
             :style="{ backgroundImage: `url(${localData.imageSrc})` }">
          <i v-if="!localData.imageSrc" class="las la-plus fs-2 text-muted"></i>
        </div>
      </div>
    </div>

    <div class="card mb-3 border-0 shadow-sm bg-info text-dark">
      <div class="card-body">
        <div class="form-check form-switch mb-0 d-flex align-items-center gap-2">
          <input class="form-check-input fs-5" type="checkbox" role="switch" id="invertLayout" v-model="localData.inverted">
          <label class="form-check-label fw-bold small text-uppercase m-0" for="invertLayout">
            <i class="las la-exchange-alt me-1"></i> Invertir Diseño (Texto a la izquierda)
          </label>
        </div>
      </div>
    </div>

    <div class="card mb-3 border-0 shadow-sm">
      <div class="card-body">
        <h6 class="fw-bold mb-3 text-primary"><i class="las la-pen"></i> Contenido Escrito</h6>
        
        <div class="mb-3">
          <label class="small text-muted">Título Principal</label>
          <input type="text" v-model="localData.title" class="form-control form-control-sm" placeholder="MODALIDAD PRESENCIAL Y SEMIPRESENCIAL">
        </div>
        
        <div class="mb-3">
          <label class="small text-muted">Descripción / Subtítulo</label>
          <textarea v-model="localData.description" class="form-control form-control-sm" rows="3" placeholder="Estudia en el campus..."></textarea>
        </div>
      </div>
    </div>

    <div class="card mb-3 border-0 shadow-sm">
      <div class="card-body">
        <h6 class="fw-bold mb-3 text-primary"><i class="las la-link"></i> Acción y Archivo (PDF)</h6>
        
        <div class="row g-2 mb-2">
          <div class="col-12"><input type="text" v-model="localData.btnText" class="form-control form-control-sm" placeholder="MÁS INFORMACIÓN"></div>
        </div>
        <div class="mb-2">
          <label class="small text-muted d-block">Subir PDF Broshure (o Imagen)</label>
          <div @click="$emit('select-image', { item: localData, field: 'btnUrl' })" 
               class="media-placeholder border rounded mb-2 clickable"
               :style="{ backgroundImage: `url(${localData.btnUrl})`, backgroundColor: '#444' }">
            <i v-if="!localData.btnUrl" class="las la-file-upload fs-3 text-white"></i>
          </div>
        </div>
        <div class="input-group input-group-sm">
          <span class="input-group-text bg-light text-muted">URL Archivo</span>
          <input type="text" v-model="localData.btnUrl" class="form-control form-control-sm" placeholder="https://...">
        </div>
      </div>
    </div>

    <div class="card border-0 shadow-sm bg-dark text-white">
      <div class="card-body">
        <h6 class="fw-bold mb-3 text-warning"><i class="las la-palette"></i> Diseño y Colores</h6>
        
        <div class="row g-2 mb-3">
          <div class="col-4">
            <label class="x-small d-block mb-1">Fondo Bloque</label>
            <input type="color" v-model="localData.bgColor" class="form-control form-control-color w-100 p-1">
          </div>
          <div class="col-4">
            <label class="x-small d-block mb-1">Color Botón</label>
            <input type="color" v-model="localData.btnColor" class="form-control form-control-color w-100 p-1">
          </div>
          <div class="col-4">
            <label class="x-small d-block mb-1">Color Título</label>
            <input type="color" v-model="localData.titleColor" class="form-control form-control-color w-100 p-1">
          </div>
        </div>

        <div class="row mt-3">
          <div class="col-12">
             <label class="x-small d-block mb-1">Color Texto (Descripción)</label>
             <input type="color" v-model="localData.textColor" class="form-control form-control-color w-100 p-1">
          </div>
        </div>
      </div>
    </div>

  </div>
</template>

<style scoped>
/* --- ESTILOS DEL EDITOR --- */
.media-placeholder {
  height: 90px;
  background-color: #eee;
  background-size: cover;
  background-position: center;
  display: grid;
  place-items: center;
  cursor: pointer;
  border: 2px dashed #ccc;
}
.x-small { font-size: 0.65rem; text-transform: uppercase; font-weight: bold; }
.clickable { cursor: pointer; }
</style>