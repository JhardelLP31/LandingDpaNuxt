<template>
  <div class="our-teacher-editor">

    <div class="p-3 mb-3 border rounded bg-light">
      <h6 class="fw-bold mb-3 text-primary">
        <i class="las la-chalkboard-teacher me-1"></i> Configuración General
      </h6>
      
      <div class="mb-3">
        <label class="small fw-bold text-muted mb-1">Título de la Sección</label>
        <input v-model="localContent.title" class="form-control form-control-sm" placeholder="Ej: Nuestro Equipo Docente">
      </div>
      
      <div class="mb-0">
        <label class="small fw-bold text-muted mb-1">Descripción Introductoria</label>
        <textarea v-model="localContent.description" class="form-control form-control-sm" rows="2" placeholder="Breve texto sobre el equipo..."></textarea>
      </div>
    </div>

    <div class="border rounded bg-white p-3">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <label class="small fw-bold text-dark m-0">Miembros del Equipo</label>
        <span class="badge bg-light text-dark border">{{ localContent.items?.length || 0 }} Personas</span>
      </div>

      <div v-if="localContent.items && localContent.items.length > 0">
        <div v-for="(item, index) in localContent.items" :key="index" class="card mb-3 shadow-sm border-light bg-light">
          
          <div class="card-header bg-white py-2 px-3 border-bottom-0 d-flex justify-content-between align-items-center">
            <span class="fw-bold text-muted small"><i class="las la-user me-1"></i> Miembro #{{ Number(index) + 1 }}</span>
            <button @click="removeItem(index)" class="btn btn-xs text-danger p-1" title="Eliminar miembro">
              <i class="las la-trash"></i> Eliminar
            </button>
          </div>

          <div class="card-body p-3 pt-0">
            <div class="row g-3">
              
              <div class="col-md-8">
                <div class="row g-2">
                  <div class="col-6">
                    <label class="x-small fw-bold text-muted">Nombre</label>
                    <input v-model="item.name" class="form-control form-control-sm" placeholder="Nombre completo">
                  </div>
                  <div class="col-6">
                    <label class="x-small fw-bold text-muted">Cargo</label>
                    <input v-model="item.position" class="form-control form-control-sm" placeholder="Ej: Directora">
                  </div>
                  <div class="col-12">
                    <label class="x-small fw-bold text-muted">Descripción (Hover)</label>
                    <input v-model="item.hover_text" class="form-control form-control-sm" placeholder="Texto que aparece al pasar el mouse">
                  </div>
                  <div class="col-12">
                    <label class="x-small fw-bold text-muted">LinkedIn URL</label>
                    <div class="input-group input-group-sm">
                      <span class="input-group-text bg-white text-primary"><i class="lab la-linkedin-in"></i></span>
                      <input v-model="item.linkedin" class="form-control" placeholder="https://linkedin.com/in/...">
                    </div>
                  </div>
                </div>
              </div>

              <div class="col-md-4">
                <label class="x-small fw-bold text-muted mb-1">Fotografía</label>
                <div class="border rounded bg-white p-2 text-center">
                  <div class="mb-2 d-flex justify-content-center">
                     <div v-if="item.image" class="ratio ratio-1x1 rounded overflow-hidden border" style="width: 60px;">
                        <img :src="formatImageUrl(item.image)" class="object-fit-cover">
                     </div>
                     <div v-else class="ratio ratio-1x1 rounded border bg-light d-flex align-items-center justify-content-center text-muted" style="width: 60px;">
                        <i class="las la-user-circle fs-2"></i>
                     </div>
                  </div>
                  
                  <button type="button"
                          @click="$emit('select-image', { item: item, field: 'image' })" 
                          class="btn btn-xs btn-outline-primary w-100 text-truncate">
                    {{ item.image ? 'Cambiar' : 'Subir Foto' }}
                  </button>
                </div>
              </div>

            </div>
          </div>
        </div>
      </div>

      <div v-else class="text-center py-4 border border-dashed rounded bg-light mb-3">
        <div class="text-muted small">No hay miembros en el equipo aún.</div>
      </div>

      <button @click="addItem" class="btn btn-sm btn-primary w-100">
        <i class="las la-user-plus me-1"></i> Agregar Miembro
      </button>

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

// Proxy para v-model
const localContent = computed({
  get: () => props.modelValue,
  set: (val) => emit('update:modelValue', val)
});

// Acciones
const addItem = () => {
  if (!localContent.value.items) localContent.value.items = [];
  
  localContent.value.items.push({ 
    name: '', 
    position: '', 
    hover_text: '', 
    linkedin: '', 
    image: '' 
  });
};

const removeItem = (index: any) => {
  if(confirm('¿Estás seguro de eliminar a este miembro?')) {
    localContent.value.items.splice(index, 1);
  }
};


</script>

<style scoped>
.x-small {
  font-size: 0.7rem;
}
.btn-xs {
  font-size: 0.75rem;
  padding: 0.2rem 0.4rem;
}
.object-fit-cover {
  object-fit: cover;
  width: 100%;
  height: 100%;
}
.border-dashed {
    border-style: dashed !important;
}
</style>