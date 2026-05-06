<template>
  <div class="contact-section-editor">

    <div class="p-3 mb-3 border rounded bg-light">
      <h6 class="fw-bold mb-3 text-primary">
        <i class="las la-palette me-1"></i> Apariencia
      </h6>

      <div class="mb-3">
        <label class="form-label fw-bold small">Título del Formulario</label>
        <input v-model="localContent.title" class="form-control" placeholder="Ej: AGENDEMOS UNA REUNIÓN">
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold small">Subtítulo</label>
        <textarea v-model="localContent.subtitle" class="form-control" rows="2"></textarea>
      </div>

      <div class="mb-3">
        <label class="form-label fw-bold small">Texto del Botón</label>
        <input v-model="localContent.buttonText" class="form-control" placeholder="Ej: ENVIAR MENSAJE">
      </div>

      <div class="mb-2">
        <label class="small fw-bold mb-1">Imagen Lateral</label>
        <div class="d-flex align-items-center gap-2 p-2 border rounded bg-white">
          <div v-if="localContent.image" class="flex-shrink-0">
            <img :src="formatImageUrl(localContent.image)" class="rounded border object-fit-cover" style="width: 40px; height: 40px;">
          </div>
          <div v-else class="flex-shrink-0 d-flex align-items-center justify-content-center rounded border bg-light text-muted" style="width: 40px; height: 40px;">
            <i class="las la-image"></i>
          </div>
          
          <button type="button" @click="$emit('select-image', { item: localContent, field: 'image' })" class="btn btn-sm btn-outline-primary w-100">
            {{ localContent.image ? 'Cambiar' : 'Seleccionar' }}
          </button>
        </div>
      </div>
    </div>

    <div class="border rounded bg-light mb-3">
      
      <div @click="showFields = !showFields" 
           class="p-3 d-flex justify-content-between align-items-center cursor-pointer accordion-header-hover">
        <div class="d-flex align-items-center gap-2">
          <i class="las la-wpforms text-primary fs-4"></i>
          <div>
            <h6 class="fw-bold m-0 text-primary lh-1">Campos del Formulario</h6>
            <small class="text-muted" style="font-size: 0.75rem;">
              {{ localContent.fields?.length || 0 }} campos activos
            </small>
          </div>
        </div>
        <i class="las fs-4 transition-icon" :class="showFields ? 'la-angle-up' : 'la-angle-down'"></i>
      </div>

      <div v-if="showFields" class="p-3 border-top bg-white">
        
        <div class="alert alert-info py-2 small mb-3">
          <i class="las la-info-circle"></i> <b>Nombres internos clave:</b> first_name, last_name, email, phone.
        </div>

        <div v-if="localContent.fields && localContent.fields.length > 0">
          <div v-for="(field, index) in localContent.fields" :key="index" class="card mb-2 shadow-sm border">
            <div class="card-body p-2 bg-light">
              
              <div class="d-flex justify-content-between mb-2 border-bottom pb-2">
                <span class="badge bg-secondary">{{ Number(index) + 1 }}</span>
                <button @click="removeField(Number(index))" class="btn btn-sm btn-outline-danger py-0 px-2 border-0" title="Eliminar">
                  <i class="las la-trash"></i>
                </button>
              </div>

              <div class="row g-2">
                <div class="col-6">
                  <label class="x-small text-muted fw-bold">Label</label>
                  <input v-model="field.label" class="form-control form-control-sm" placeholder="Ej: Tu Nombre">
                </div>
                
                <div class="col-6">
                  <label class="x-small text-muted fw-bold">Name (BD)</label>
                  <input v-model="field.name" class="form-control form-control-sm font-monospace text-primary" placeholder="Ej: cargo">
                </div>

                <div class="col-6">
                  <label class="x-small text-muted fw-bold">Tipo</label>
                  <select v-model="field.type" class="form-select form-select-sm">
                    <option value="text">Texto</option>
                    <option value="email">Email</option>
                    <option value="tel">Teléfono</option>
                    <option value="textarea">Área Texto</option>
                    <option value="select">Select</option>
                    <option value="date">Fecha</option>
                  </select>
                </div>

                <div class="col-6">
                  <label class="x-small text-muted fw-bold">Placeholder</label>
                  <input v-model="field.placeholder" class="form-control form-control-sm">
                </div>

                <div class="col-12" v-if="field.type === 'select'">
                  <label class="x-small text-muted fw-bold">Opciones (separadas por coma)</label>
                  <input class="form-control form-control-sm" 
                         placeholder="Opción 1, Opción 2..."
                         :value="field.options ? field.options.join(', ') : ''" 
                         @input="updateFieldOptions(field, $event)">
                </div>

                <div class="col-12 mt-1">
                  <div class="form-check form-switch">
                    <input v-model="field.required" class="form-check-input" type="checkbox" :id="'req-'+index">
                    <label class="form-check-label small" :for="'req-'+index">Campo Obligatorio</label>
                  </div>
                </div>
              </div>

            </div>
          </div>
        </div>

        <div v-else class="text-center py-3 text-muted small">
          No hay campos configurados.
        </div>

        <button type="button" @click="addField" class="btn btn-sm btn-primary w-100 mt-2">
          <i class="las la-plus"></i> Agregar Campo
        </button>

      </div>
    </div>

  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { formatImageUrl } from '@/helpers/url';
const props = defineProps<{
  modelValue: any // El objeto block.content
}>();

const emit = defineEmits(['update:modelValue', 'select-image']);

// Estado local para el acordeón
const showFields = ref(false);

// Computed para v-model
const localContent = computed({
  get: () => props.modelValue,
  set: (val) => emit('update:modelValue', val)
});

// Acciones de Campos
const addField = () => {
    if (!localContent.value.fields) localContent.value.fields = [];
    
    localContent.value.fields.push({ 
        type: 'text', 
        label: 'Nuevo Campo', 
        name: 'extra_' + Date.now(), 
        required: false 
    });
};

const removeField = (index: number) => {
    localContent.value.fields.splice(index, 1);
};

// Lógica para convertir string a array en el select
const updateFieldOptions = (field: any, event: Event) => {
    const input = event.target as HTMLInputElement;
    field.options = input.value.split(',').map(s => s.trim());
};


</script>

<style scoped>
.x-small {
    font-size: 0.7rem;
}

.cursor-pointer {
    cursor: pointer;
}

.object-fit-cover {
    object-fit: cover;
}

.accordion-header-hover {
    transition: background-color 0.2s;
}

.accordion-header-hover:hover {
    background-color: #e9ecef;
}

.transition-icon {
    transition: transform 0.2s;
}
</style>