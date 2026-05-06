<script setup lang="ts">
import { ref, watch } from 'vue';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue']);

const localData = ref({
  title: props.modelValue?.title || 'campus esan',
  address: props.modelValue?.address || 'Jr. Alonso de Molina 1652, Santiago de Surco 15023',
  mapUrl: props.modelValue?.mapUrl || 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3900.957582531005!2d-76.96347352504892!3d-12.11504954316168!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9105c70ce045a555%3A0xc07ce678248c187!2sUniversidad%20ESAN!5e0!3m2!1ses-419!2spe!4v1700000000000!5m2!1ses-419!2spe',
  backgroundColor: props.modelValue?.backgroundColor || '#ffffff',
  textColor: props.modelValue?.textColor || '#333333',
  invertLayout: props.modelValue?.invertLayout || false // <-- Agregado para invertir
});

watch(localData, (newVal) => {
  emit('update:modelValue', JSON.parse(JSON.stringify(newVal)));
}, { deep: true });

watch(() => props.modelValue, (newVal) => {
  if (!newVal) return;
  if (JSON.stringify(localData.value) !== JSON.stringify(newVal)) {
    localData.value = JSON.parse(JSON.stringify(newVal));
  }
}, { deep: true });
</script>

<template>
  <div class="visitanos-editor p-3">
    <div class="card shadow-sm border-0 bg-light">
      <div class="card-body p-3">
        <h6 class="card-title text-primary fw-bold mb-3"><i class="las la-map-marker"></i> Sección Visítanos</h6>
        
        <div class="row g-3 mb-3">
          <div class="col-12">
            <label class="small text-muted">Título de la sección</label>
            <input type="text" class="form-control form-control-sm" v-model="localData.title" placeholder="Ej. campus esan">
          </div>
          
          <div class="col-12">
            <label class="small text-muted">Dirección</label>
            <textarea class="form-control form-control-sm" v-model="localData.address" rows="2" placeholder="Dirección completa..."></textarea>
          </div>

          <div class="col-12">
            <label class="small text-muted">URL del Mapa (Google Maps "src")</label>
            <input type="text" class="form-control form-control-sm" v-model="localData.mapUrl" placeholder="https://www.google.com/maps/embed?...">
            <small class="text-secondary" style="font-size: 0.75rem;">
              * Ve a Google Maps > Compartir > Insertar un mapa > Copia solo lo que está dentro de <strong>src="..."</strong>
            </small>
          </div>
        </div>

        <h6 class="text-secondary fw-bold mt-4 mb-2 small"><i class="las la-palette"></i> Diseño de la sección</h6>
        
        <div class="row g-2 mb-3">
          <div class="col-12">
            <div class="form-check form-switch border p-2 rounded bg-white d-flex align-items-center">
              <input class="form-check-input ms-1 me-2 mt-0" type="checkbox" id="invertirLado" v-model="localData.invertLayout">
              <label class="form-check-label small text-dark fw-medium mb-0" for="invertirLado">
                Mapa a la Izquierda (Invertir columnas)
              </label>
            </div>
          </div>
        </div>

        <div class="row g-2">
          <div class="col-6">
            <label class="small text-muted">Color de Fondo</label>
            <input type="color" class="form-control form-control-color form-control-sm w-100 p-1" v-model="localData.backgroundColor">
          </div>
          <div class="col-6">
            <label class="small text-muted">Color del Texto</label>
            <input type="color" class="form-control form-control-color form-control-sm w-100 p-1" v-model="localData.textColor">
          </div>
        </div>

      </div>
    </div>
  </div>
</template>