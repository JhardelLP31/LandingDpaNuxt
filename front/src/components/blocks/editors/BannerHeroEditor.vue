<template>
  <div class="banner-hero-editor">
    
    <div class="d-flex justify-content-between align-items-center mb-3 p-2 bg-white border rounded">
      <h6 class="m-0 small fw-bold text-muted"><i class="las la-clock"></i> Configuración</h6>
      <div class="d-flex align-items-center gap-2">
        <span class="small">Velocidad (ms):</span>
        <input type="number" v-model="localContent.autoPlayInterval" class="form-control form-control-sm" style="width: 80px;">
      </div>
    </div>

    <div class="accordion" id="accordion-hero">
      <div v-for="(slide, i) in localContent.slides" :key="i" class="accordion-item border-bottom">
        
        <h2 class="accordion-header">
          <button class="accordion-button py-2" type="button" 
                  :class="{ 'collapsed': activeSlide !== i }"
                  @click="toggleSlide(i)">
            
            <div class="d-flex align-items-center gap-2 w-100">
              <span class="badge bg-dark rounded-pill">{{ Number(i) + 1 }}</span>
              
              <img v-if="slide.imageUrl" 
                   :src="formatImageUrl(slide.imageUrl)" 
                   class="rounded object-fit-cover border bg-white" 
                   width="35" height="25">
              <div v-else class="bg-light border rounded d-flex align-items-center justify-content-center" style="width: 35px; height: 25px;">
                <i class="las la-image text-muted small"></i>
              </div>

              <span class="small fw-bold text-truncate" style="max-width: 150px;">
                {{ slide.title ? slide.title.replace(/<br>/g, ' ') : 'Nuevo Slide' }}
              </span>
            </div>
          </button>
        </h2>

        <div class="accordion-collapse collapse" :class="{ 'show': activeSlide === i }">
          <div class="accordion-body bg-light p-3 border-top">
            
            <div class="mb-3">
              <label class="small fw-bold mb-1">Imagen de Fondo</label>
              <div class="d-flex align-items-center gap-2 p-2 border rounded bg-white">
                <div v-if="slide.imageUrl" class="flex-shrink-0">
                  <img :src="formatImageUrl(slide.imageUrl)" class="rounded border bg-light" style="width: 60px; height: 40px; object-fit: cover;">
                </div>
                <div v-else class="flex-shrink-0 d-flex align-items-center justify-content-center rounded border bg-light text-muted" style="width: 60px; height: 40px;">
                  <i class="las la-image fs-3"></i>
                </div>

                <div class="w-100">
                  <button type="button" @click="$emit('select-image', { item: slide, field: 'imageUrl' })" 
                          class="btn btn-sm btn-outline-primary w-100 mb-1">
                    {{ slide.imageUrl ? 'Cambiar Imagen' : 'Seleccionar Imagen' }}
                  </button>
                  <button v-if="slide.imageUrl" type="button" @click="slide.imageUrl = ''" 
                          class="btn btn-xs btn-link text-danger text-decoration-none p-0 w-100 small">
                    <i class="las la-trash"></i> Quitar imagen
                  </button>
                </div>
              </div>
            </div>

            <div class="mb-3">
              <label class="small fw-bold mb-1">Tipo de Diseño</label>
              <select v-model="slide.layout" class="form-select form-select-sm">
                <option value="standard-mode">Estándar (Texto Centrado/Izq)</option>
                <option value="stats-mode">Con Estadística (Caja Lateral)</option>
              </select>
            </div>

            <div v-if="slide.layout === 'stats-mode'" class="row g-2 mb-3 bg-white p-2 border rounded mx-0 shadow-sm">
              <div class="col-4">
                <label class="small text-muted fw-bold" style="font-size: 0.65rem;">NÚMERO</label>
                <input v-model="slide.statsNumber" class="form-control form-control-sm border-0 bg-light fw-bold text-center" placeholder="23">
              </div>
              <div class="col-8">
                <label class="small text-muted fw-bold" style="font-size: 0.65rem;">TEXTO</label>
                <input v-model="slide.statsLabel" class="form-control form-control-sm border-0 bg-light" placeholder="AÑOS">
              </div>
            </div>

            <div v-if="slide.layout === 'standard-mode'" class="mb-3">
              <label class="small fw-bold mb-1">Pre-Título</label>
              <input v-model="slide.preTitle" class="form-control form-control-sm" placeholder="Ej: Líderes en...">
            </div>

            <div class="mb-3">
              <label class="small fw-bold mb-1">Título Principal (HTML)</label>
              <textarea v-model="slide.title" class="form-control form-control-sm font-monospace" rows="2"></textarea>
              <div class="form-text" style="font-size: 0.7rem;">Usa &lt;br&gt; para saltos de línea.</div>
            </div>

            <div class="row g-2">
              <div class="col-6">
                <label class="small fw-bold mb-1">Botón</label>
                <input v-model="slide.btnText" class="form-control form-control-sm">
              </div>
              <div class="col-6">
                <label class="small fw-bold mb-1">Link</label>
                <input v-model="slide.btnLink" class="form-control form-control-sm">
              </div>
            </div>

            <div class="text-end mt-3 pt-2 border-top">
              <button @click="localContent.slides.splice(i, 1)" class="btn btn-xs btn-outline-danger border-0">
                <i class="las la-trash-alt me-1"></i> Eliminar Slide
              </button>
            </div>

          </div>
        </div>
      </div>
    </div>

    <button @click="addSlide" class="btn btn-sm btn-outline-primary w-100 mt-3 border-dashed">
      <i class="las la-plus-circle"></i> Agregar Slide
    </button>

  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { formatImageUrl } from '@/helpers/url';

// Props y Emits
const props = defineProps<{
  modelValue: any // O define tu interfaz BannerHeroContent si la tienes
}>();

const emit = defineEmits(['update:modelValue', 'select-image']);

// 1. Computed para v-model limpio
const localContent = computed({
  get: () => props.modelValue,
  set: (val) => emit('update:modelValue', val)
});

// 2. Lógica del Acordeón Local
const activeSlide = ref<number | null>(0); // Empieza abierto el primero

const toggleSlide = (index: any) => {
  activeSlide.value = activeSlide.value === index ? null : index;
};

// 3. Agregar nuevo slide
const addSlide = () => {
  if (!localContent.value.slides) localContent.value.slides = [];
  
  localContent.value.slides.push({
    layout: 'standard-mode',
    title: 'Nuevo Slide',
    btnText: 'Ver más',
    btnLink: '#'
  });
  
  // Abrir automáticamente el nuevo slide
  activeSlide.value = localContent.value.slides.length - 1;
};


</script>

<style scoped>
.border-dashed {
  border-style: dashed !important;
}
</style>