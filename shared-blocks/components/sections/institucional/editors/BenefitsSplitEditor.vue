<script setup lang="ts">
import { ref, watch } from 'vue';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue', 'select-image']);

const localData = ref({
  title: props.modelValue?.title || '¿POR QUÉ ESTUDIAR EN EL DPA?',
  imageSrc: props.modelValue?.imageSrc || '',
  bgColor: props.modelValue?.bgColor || '#f8f9fa',
  titleColor: props.modelValue?.titleColor || '#000000',
  textColor: props.modelValue?.textColor || '#555555',
  features: props.modelValue?.features || []
});

// Sincronización bidireccional
watch(() => props.modelValue, (newVal) => {
  if (!newVal) return;
  if (JSON.stringify(newVal) !== JSON.stringify(localData.value)) {
    localData.value = JSON.parse(JSON.stringify(newVal)); // Deep copy preventivo
  }
}, { deep: true });

watch(localData, (newVal) => {
  emit('update:modelValue', newVal);
}, { deep: true });

// Funciones para manejar la grilla de beneficios
const addFeature = () => {
  localData.value.features.push({ icon: '', title: 'NUEVO BENEFICIO', text: 'Descripción corta del beneficio.' });
};

const removeFeature = (index: number) => {
  localData.value.features.splice(index, 1);
};
</script>

<template>
  <div class="p-3">
    
    <div class="card mb-3 border-0 shadow-sm">
      <div class="card-body">
        <h6 class="fw-bold text-primary mb-3"><i class="las la-cog"></i> Ajustes Generales</h6>
        <div class="mb-3">
          <label class="small text-muted">Título Principal</label>
          <input type="text" v-model="localData.title" class="form-control form-control-sm">
        </div>
        <div class="mb-2">
          <label class="small text-muted d-block">Imagen Lateral Derecha</label>
          <div @click="$emit('select-image', { item: localData, field: 'imageSrc' })" 
               class="media-placeholder border rounded clickable"
               :style="{ backgroundImage: `url(${localData.imageSrc})` }">
            <i v-if="!localData.imageSrc" class="las la-image fs-2 text-muted"></i>
          </div>
        </div>
      </div>
    </div>

    <div class="card mb-3 border-0 shadow-sm bg-light">
      <div class="card-body p-3">
        <div class="d-flex justify-content-between align-items-center mb-3">
          <h6 class="fw-bold text-success m-0"><i class="las la-th-large"></i> Beneficios ({{ localData.features.length }})</h6>
          <button @click="addFeature" class="btn btn-sm btn-success py-0 px-2"><i class="las la-plus"></i> Añadir</button>
        </div>

        <div v-for="(feature, index) in localData.features" :key="index" class="feature-edit-box bg-white p-2 rounded border mb-2 position-relative">
          
          <button @click="removeFeature(Number(index))" class="btn btn-sm btn-danger position-absolute top-0 end-0 m-1 py-0 px-1" title="Eliminar">
            <i class="las la-trash"></i>
          </button>

          <div class="row g-2 align-items-center mt-2">
            <div class="col-3 text-center">
              <label class="x-small text-muted d-block mb-1">Ícono</label>
              <div @click="$emit('select-image', { item: feature, field: 'icon' })" 
                   class="icon-placeholder border rounded clickable mx-auto"
                   :style="{ backgroundImage: `url(${feature.icon})` }">
                <i v-if="!feature.icon" class="las la-star text-muted"></i>
              </div>
            </div>
            
            <div class="col-9">
              <input type="text" v-model="feature.title" class="form-control form-control-sm mb-1 fw-bold" placeholder="Título (Ej. Respaldo ESAN)">
              <textarea v-model="feature.text" class="form-control form-control-sm" rows="2" placeholder="Descripción..."></textarea>
            </div>
          </div>
        </div>

        <div v-if="localData.features.length === 0" class="text-center text-muted small py-3">
          No hay beneficios agregados. Haz clic en "Añadir".
        </div>
      </div>
    </div>

    <div class="card border-0 shadow-sm bg-dark text-white">
      <div class="card-body">
        <h6 class="fw-bold mb-3 text-warning"><i class="las la-palette"></i> Colores de la Sección</h6>
        <div class="row g-2">
          <div class="col-4">
            <label class="x-small d-block mb-1">Fondo Izquierdo</label>
            <input type="color" v-model="localData.bgColor" class="form-control form-control-color w-100 p-1">
          </div>
          <div class="col-4">
            <label class="x-small d-block mb-1">Títulos</label>
            <input type="color" v-model="localData.titleColor" class="form-control form-control-color w-100 p-1">
          </div>
          <div class="col-4">
            <label class="x-small d-block mb-1">Textos Párrafo</label>
            <input type="color" v-model="localData.textColor" class="form-control form-control-color w-100 p-1">
          </div>
        </div>
      </div>
    </div>

  </div>
</template>

<style scoped>
.media-placeholder {
  height: 100px; background-color: #eee; background-size: cover; background-position: center; display: grid; place-items: center; cursor: pointer;
}
.icon-placeholder {
  width: 40px; height: 40px; background-color: #f8f9fa; background-size: contain; background-repeat: no-repeat; background-position: center; display: grid; place-items: center; cursor: pointer;
}
.x-small { font-size: 0.65rem; text-transform: uppercase; font-weight: bold; }
.clickable { cursor: pointer; transition: opacity 0.2s; }
.clickable:hover { opacity: 0.8; }
.feature-edit-box { border: 1px dashed #ced4da; }
</style>