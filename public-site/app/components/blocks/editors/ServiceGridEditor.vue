<template>
  <div class="service-editor p-3 border rounded bg-white">
    <h6 class="fw-bold mb-3 text-primary">
      <i class="las la-th-large me-1"></i> Grilla de Servicios
    </h6>
    
    <div class="alert alert-light border small text-muted">
      <i class="las la-info-circle"></i> Agrega tarjetas para mostrar tus áreas de negocio. Se acomodan automáticamente.
    </div>

    <div v-if="localContent.items && localContent.items.length > 0" class="d-flex flex-column gap-3">
      
      <div 
        v-for="(item, index) in localContent.items" 
        :key="index" 
        class="border rounded p-3 bg-light position-relative"
      >
        <button 
          @click="removeItem(index)" 
          class="btn btn-xs btn-danger position-absolute top-0 end-0 m-2"
          title="Eliminar servicio"
        >
          <i class="las la-trash"></i>
        </button>

        <span class="badge bg-secondary mb-2">Servicio #{{ Number(index) + 1 }}</span>

        <div class="mb-2">
          <label class="small fw-bold text-muted">Título</label>
          <input v-model="item.title" class="form-control form-control-sm" placeholder="Ej: Consultoría Legal">
        </div>

        <div class="mb-2">
          <label class="small fw-bold text-muted">Descripción</label>
          <textarea v-model="item.description" class="form-control form-control-sm" rows="2"></textarea>
        </div>
        
        <div class="mb-2">
          <label class="small fw-bold text-muted">Enlace (Link)</label>
          <input v-model="item.link" class="form-control form-control-sm" placeholder="/servicios/ejemplo">
        </div>

        <div class="mb-2">
           <label class="small fw-bold text-muted">Icono / Imagen</label>
           <div class="d-flex gap-2 align-items-center bg-white p-2 border rounded">
              <img 
                v-if="item.image" 
                :src="formatImageUrl(item.image)" 
                style="width: 40px; height: 40px; object-fit: contain;"
              >
              <i v-else class="las la-image fs-4 text-muted"></i>
              
              <button 
                type="button"
                @click="$emit('select-image', { item: item, field: 'image' })"
                class="btn btn-sm btn-outline-primary w-100"
              >
                {{ item.image ? 'Cambiar' : 'Seleccionar' }}
              </button>
           </div>
        </div>

      </div>

    </div>

    <div v-else class="text-center py-4 text-muted">
      No hay servicios creados.
    </div>

    <button @click="addItem" class="btn btn-outline-primary btn-sm w-100 mt-3 border-dashed">
      <i class="las la-plus-circle"></i> Agregar Nuevo Servicio
    </button>

  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { formatImageUrl } from '@/helpers/url';

const props = defineProps<{
  modelValue: any 
}>();

const emit = defineEmits(['update:modelValue', 'select-image']);

const localContent = computed({
  get: () => {
    // Asegurar estructura inicial si viene vacía
    if(!props.modelValue.items) {
        return { items: [] }; 
    }
    return props.modelValue;
  },
  set: (val) => emit('update:modelValue', val)
});

// Funciones para manejar el array
const addItem = () => {
  // Inicializamos el array si no existe (por seguridad)
  if (!localContent.value.items) localContent.value.items = [];
  
  localContent.value.items.push({
    title: '',
    description: '',
    image: '',
    link: ''
  });
};

const removeItem = (index: any) => {
  if(confirm('¿Borrar este servicio?')) {
    localContent.value.items.splice(index, 1);
  }
};
</script>

<style scoped>
.border-dashed {
  border-style: dashed !important;
}
</style>