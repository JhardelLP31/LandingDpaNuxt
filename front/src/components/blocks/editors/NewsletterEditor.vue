<template>
  <div class="newsletter-editor p-3 border rounded bg-white">
    <h6 class="fw-bold mb-3 text-danger">
      <i class="las la-envelope-open-text me-1"></i> Sección Newsletter
    </h6>

    <div class="row g-3">
      <div class="col-12">
        <label class="small fw-bold text-muted mb-1">Título Principal</label>
        <input v-model="localContent.title" class="form-control" placeholder="Ej: ÚNETE A NOSOTROS">
      </div>

      <div class="col-12">
        <label class="small fw-bold text-muted mb-1">Subtítulo / Bajada</label>
        <textarea v-model="localContent.subtitle" class="form-control" rows="2" placeholder="Ej: Recibe noticias y actualizaciones..."></textarea>
      </div>

      <div class="col-12">
        <label class="small fw-bold text-muted mb-1">Texto del Botón</label>
        <div class="input-group input-group-sm">
          <span class="input-group-text bg-light"><i class="las la-mouse mb-0"></i></span>
          <input v-model="localContent.buttonText" class="form-control" placeholder="Ej: SUSCRIBIRSE">
        </div>
      </div>
    </div>

    <div class="mt-3 p-2 bg-light rounded border border-dashed text-center small text-muted">
      <i class="las la-info-circle"></i> Esta sección usará el fondo rojo corporativo automáticamente.
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';

const props = defineProps<{
  modelValue: any
}>();

const emit = defineEmits(['update:modelValue']);

const localContent = computed({
  get: () => props.modelValue,
  set: (val) => emit('update:modelValue', val)
});
</script>

<style scoped>
.border-dashed {
  border-style: dashed !important;
}
</style>