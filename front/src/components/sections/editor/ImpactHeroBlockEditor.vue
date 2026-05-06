<script setup lang="ts">
import { computed } from 'vue';
import { formatImageUrl } from '@/helpers/url';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue', 'select-image']);

// Proxy para v-model (Mantiene la reactividad perfecta)
const localContent = computed({
  get: () => props.modelValue || { config: {} },
  set: (val) => emit('update:modelValue', val)
});

// Helper para actualizar config profunda sin perder reactividad
const updateConfig = (field: string, value: any) => {
  const newConfig = { ...(localContent.value.config || {}), [field]: value };
  emit('update:modelValue', { ...localContent.value, config: newConfig });
};
</script>

<template>
  <div class="p-2">

    <div class="mb-3 border p-3 rounded bg-light">
      <h6 class="mb-3 fw-bold text-primary">Contenido Principal</h6>

      <label class="form-label fw-bold small text-muted">1. Título Grande</label>
      <textarea v-model="localContent.title" class="form-control mb-3" rows="3"
        placeholder="Ej: La Unidad de Laboratorio..."></textarea>

      <label class="form-label fw-bold small text-muted">2. Texto</label>
      <input v-model="localContent.tagline" class="form-control form-control-sm mb-3"
        placeholder="Ej: RENOVACIÓN DE CERTIFICACIÓN...">



      <div class="row g-2">
        <div class="col-12">
          <label class="form-label fw-bold small text-muted">Botón</label>
        </div>
        <div class="col-6">
          <input v-model="localContent.btnText" class="form-control form-control-sm" placeholder="Texto (Ej: Ver más)">
        </div>
        <div class="col-6">
          <input v-model="localContent.btnLink" class="form-control form-control-sm" placeholder="Enlace (URL)">
        </div>
      </div>
    </div>

    <div class="mb-3 border p-3 rounded bg-white shadow-sm">
      <h6 class="mb-3 fw-bold text-primary">Imágenes</h6>

      <label class="form-label fw-bold small">Imagen de Fondo</label>
      <div class="d-flex gap-2 align-items-center mb-3">
        <div class="ratio ratio-1x1 rounded border bg-secondary" style="width: 60px; background-size: cover;"
          :style="{ backgroundImage: localContent.config?.bgImage ? `url(${formatImageUrl(localContent.config.bgImage)})` : 'none' }">
        </div>

        <button @click="$emit('select-image', { item: localContent.config, field: 'bgImage' })"
          class="btn btn-sm btn-outline-primary flex-grow-1">
          <i class="fas fa-image me-1"></i> Seleccionar Fondo
        </button>
      </div>

      <label class="form-label fw-bold small">Logos / Sellos (ISO)</label>
      <div class="d-flex gap-2 align-items-center">
        <div v-if="localContent.logoImage" class="ratio ratio-1x1 rounded border bg-light"
          style="width: 60px; background-size: contain; background-repeat: no-repeat; background-position: center;"
          :style="{ backgroundImage: `url(${formatImageUrl(localContent.logoImage)})` }"></div>

        <button @click="$emit('select-image', { item: localContent, field: 'logoImage' })"
          class="btn btn-sm btn-outline-dark flex-grow-1">
          {{ localContent.logoImage ? 'Cambiar Logos' : 'Subir Logos' }}
        </button>

        <button v-if="localContent.logoImage" @click="localContent.logoImage = null" class="btn btn-sm btn-danger"
          title="Borrar logo">
          <i class="fas fa-trash"></i>
        </button>
      </div>
    </div>

    <div class="mb-3 border p-3 rounded bg-light">
      <h6 class="mb-3 fw-bold text-primary">Ajustes</h6>

      <label class="small text-muted d-flex justify-content-between">
        Oscuridad del Fondo
        <span>{{ (localContent.config?.overlayOpacity || 0.5) * 100 }}%</span>
      </label>
      <input type="range" class="form-range" min="0" max="0.9" step="0.1"
        :value="localContent.config?.overlayOpacity || 0.5"
        @input="e => updateConfig('overlayOpacity', parseFloat((e.target as HTMLInputElement).value))">

      <div class="row g-2 mt-2">
        <div class="col-6">
          <label class="small text-muted">Padding Arriba (px)</label>
          <input type="number" :value="localContent.config?.paddingTop || 80"
            @input="e => updateConfig('paddingTop', (e.target as HTMLInputElement).value)"
            class="form-control form-control-sm">
        </div>
        <div class="col-6">
          <label class="small text-muted">Padding Abajo (px)</label>
          <input type="number" :value="localContent.config?.paddingBottom || 80"
            @input="e => updateConfig('paddingBottom', (e.target as HTMLInputElement).value)"
            class="form-control form-control-sm">
        </div>
      </div>
    </div>

  </div>
</template>