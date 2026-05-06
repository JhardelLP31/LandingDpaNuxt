<template>
  <div class="partner-slider-editor p-1">
    
    <div class="row g-3">
      
      <div class="col-12">
        <label class="small fw-bold mb-1">Título del Bloque</label>
        <input v-model="localContent.title" class="form-control form-control-sm shadow-sm" placeholder="Ej: Ranking y Acreditaciones">
      </div>

      <div class="col-12">
        <div class="d-flex justify-content-between align-items-end mb-2">
            <label class="small fw-bold">Logos de Partners ({{ localContent.partners?.length || 0 }})</label>
        </div>
        
        <div class="d-flex flex-wrap gap-3 p-3 bg-light rounded border">
            
            <div v-for="(partner, i) in localContent.partners" :key="i" 
                 class="partner-item position-relative border rounded p-2 bg-white shadow-sm">
                
                <button @click="removePartner(i)" 
                        class="btn btn-danger btn-xs position-absolute top-0 end-0 m-1 shadow-sm z-3" 
                        style="padding: 0px 5px; font-size: 10px;">
                    <i class="las la-times"></i>
                </button>

                <div class="image-preview-container cursor-pointer" 
                     @click="$emit('select-image', { item: partner, field: 'image' })">
                    
                    <img v-if="partner.image" 
                         :src="formatImageUrl(partner.image)" 
                         class="img-fluid object-fit-contain" 
                         style="width: 100%; height: 100%;">
                    
                    <div v-else class="d-flex align-items-center justify-content-center h-100 text-muted">
                        <i class="las la-image fs-1 opacity-25"></i>
                    </div>

                    <div class="overlay d-flex align-items-center justify-content-center">
                        <span class="badge bg-primary">Cambiar</span>
                    </div>
                </div>

                <input v-model="partner.alt" 
                       class="form-control form-control-xs mt-2 text-center border-0 bg-light p-0" 
                       style="font-size: 0.7rem;" 
                       placeholder="Nombre empresa">
            </div>

            <button @click="addPartner" 
                    class="btn btn-outline-primary d-flex flex-column align-items-center justify-content-center rounded border-dashed partner-add-btn">
                <i class="las la-plus-circle fs-2 mb-1"></i>
                <span class="small fw-bold">Añadir</span>
            </button>
        </div>
      </div>

      <div class="col-md-6">
        <label class="small fw-bold mb-1">Color de Fondo</label>
        <div class="input-group input-group-sm">
            <span class="input-group-text p-1">
                <input type="color" v-model="localContent.bgColor" class="form-control-color border-0 p-0" title="Elegir color">
            </span>
            <input type="text" v-model="localContent.bgColor" class="form-control font-monospace">
        </div>
      </div>

    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { formatImageUrl } from '@/helpers/url';
const props = defineProps<{
  modelValue: any 
}>();

const emit = defineEmits(['update:modelValue', 'select-image']);

// 1. Computed para v-model limpio
const localContent = computed({
  get: () => props.modelValue,
  set: (val) => emit('update:modelValue', val)
});

// 2. Acciones
const addPartner = () => {
    if (!localContent.value.partners) localContent.value.partners = [];
    localContent.value.partners.push({ image: '', alt: '' });
};

const removePartner = (index: any) => {
    localContent.value.partners.splice(index, 1);
};


</script>

<style scoped>
/* Estilos Específicos para este componente */
.partner-item, .partner-add-btn {
    width: 120px;
    height: 140px; /* Altura fija para uniformidad */
}

.border-dashed {
    border-style: dashed !important;
}

.image-preview-container {
    width: 100%;
    height: 80px; /* Espacio para la imagen */
    position: relative;
    overflow: hidden;
    border-radius: 4px;
    background-color: #f8f9fa;
}

/* Efecto Overlay */
.overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.6);
    opacity: 0;
    transition: opacity 0.2s ease;
    cursor: pointer;
}

.image-preview-container:hover .overlay {
    opacity: 1;
}

.cursor-pointer {
    cursor: pointer;
}

.z-3 {
    z-index: 3;
}
</style>