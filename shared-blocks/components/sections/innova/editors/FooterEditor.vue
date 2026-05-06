<script setup lang="ts">
import { ref, watch } from 'vue';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue', 'select-image']);

const localData = ref({
  // Imágenes
  logoUrl: props.modelValue?.logoUrl || '',
  respaldoLogoUrl: props.modelValue?.respaldoLogoUrl || '',
  reclamacionesLogoUrl: props.modelValue?.reclamacionesLogoUrl || '', // <-- Agregado
  // Redes
  linkedinUrl: props.modelValue?.linkedinUrl || 'https://www.linkedin.com/',
  instagramUrl: props.modelValue?.instagramUrl || 'https://www.instagram.com/',
  // Listas
  siteMapLinks: props.modelValue?.siteMapLinks || [
    { text: 'Home', url: '#' }, { text: '¿Quienes somos?', url: '#' }
  ],
  masEsanLinks: props.modelValue?.masEsanLinks || [
    { text: 'Posgrado', url: '#' }, { text: 'Pregrado', url: '#' }
  ],
  // Contacto
  address: props.modelValue?.address || 'Alonso de Molina 1652...',
  phone: props.modelValue?.phone || '317-7200',
  email: props.modelValue?.email || 'innovaesan@esan.edu.pe',
  reclamacionesUrl: props.modelValue?.reclamacionesUrl || 'https://intranet.esan.edu.pe/...',
  // Diseño
  copyrightText: props.modelValue?.copyrightText || '© Copyright 2025...',
  backgroundColor: props.modelValue?.backgroundColor || '#1a1a1a',
  textColor: props.modelValue?.textColor || '#ffffff'
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

// Funciones para añadir/quitar links
const addSiteMapLink = () => { localData.value.siteMapLinks.push({ text: 'Nuevo Link', url: '#' }); };
const removeSiteMapLink = (index: number) => { localData.value.siteMapLinks.splice(index, 1); };

const addMasEsanLink = () => { localData.value.masEsanLinks.push({ text: 'Nuevo Link', url: '#' }); };
const removeMasEsanLink = (index: number) => { localData.value.masEsanLinks.splice(index, 1); };
</script>

<template>
  <div class="footer-editor p-3">
    
    <div class="card shadow-sm mb-4 border-0 bg-light">
      <div class="card-body p-3">
        <h6 class="card-title text-primary fw-bold mb-3"><i class="las la-palette"></i> Diseño General</h6>
        <div class="row g-2">
          <div class="col-6">
            <label class="small text-muted">Fondo del Footer</label>
            <input type="color" class="form-control form-control-color form-control-sm w-100 p-1" v-model="localData.backgroundColor">
          </div>
          <div class="col-6">
            <label class="small text-muted">Color del Texto</label>
            <input type="color" class="form-control form-control-color form-control-sm w-100 p-1" v-model="localData.textColor">
          </div>
        </div>
      </div>
    </div>

    <div class="card shadow-sm mb-4 border-0">
      <div class="card-header bg-white"><h6 class="mb-0 fw-bold text-secondary"><i class="las la-image"></i> Logos y Redes</h6></div>
      <div class="card-body p-3">
        <button class="btn btn-sm btn-outline-dark w-100 mb-2" @click="$emit('select-image', { item: localData, field: 'logoUrl' })">
          <i class="las la-image"></i> Cambiar Logo Principal
        </button>
        <button class="btn btn-sm btn-outline-dark w-100 mb-2" @click="$emit('select-image', { item: localData, field: 'respaldoLogoUrl' })">
          <i class="las la-image"></i> Cambiar Logo Respaldo
        </button>
        <button class="btn btn-sm btn-outline-dark w-100 mb-3" @click="$emit('select-image', { item: localData, field: 'reclamacionesLogoUrl' })">
          <i class="las la-book"></i> Logo Libro de Reclamaciones
        </button>
        
        <label class="small text-muted mt-2">LinkedIn URL</label>
        <input type="text" class="form-control form-control-sm mb-2" v-model="localData.linkedinUrl">
        
        <label class="small text-muted">Instagram URL</label>
        <input type="text" class="form-control form-control-sm mb-2" v-model="localData.instagramUrl">
      </div>
    </div>

    <div class="card shadow-sm mb-4 border-0">
      <div class="card-header bg-white"><h6 class="mb-0 fw-bold text-secondary"><i class="las la-address-book"></i> Contacto y Legal</h6></div>
      <div class="card-body p-3">
        <label class="small text-muted">Dirección</label>
        <textarea class="form-control form-control-sm mb-2" v-model="localData.address" rows="2"></textarea>
        
        <label class="small text-muted">Teléfono</label>
        <input type="text" class="form-control form-control-sm mb-2" v-model="localData.phone">
        
        <label class="small text-muted">Correo</label>
        <input type="email" class="form-control form-control-sm mb-2" v-model="localData.email">

        <hr class="my-3 text-muted">

        <label class="small text-muted">URL Libro de Reclamaciones</label>
        <input type="text" class="form-control form-control-sm" v-model="localData.reclamacionesUrl">
      </div>
    </div>

    <div class="card shadow-sm mb-4 border-0">
      <div class="card-header bg-white d-flex justify-content-between align-items-center">
        <h6 class="mb-0 fw-bold text-secondary"><i class="las la-link"></i> Mapa de Sitio</h6>
        <button class="btn btn-sm btn-success py-0" @click="addSiteMapLink"><i class="las la-plus"></i></button>
      </div>
      <div class="card-body p-2">
        <div v-for="(link, index) in localData.siteMapLinks" :key="'sm-'+index" class="d-flex gap-2 mb-2">
          <input type="text" class="form-control form-control-sm" v-model="link.text" placeholder="Texto">
          <input type="text" class="form-control form-control-sm" v-model="link.url" placeholder="URL">
          <button class="btn btn-sm btn-outline-danger" @click="removeSiteMapLink(Number(index))"><i class="las la-times"></i></button>
        </div>
      </div>
    </div>

    <div class="card shadow-sm mb-4 border-0">
      <div class="card-header bg-white d-flex justify-content-between align-items-center">
        <h6 class="mb-0 fw-bold text-secondary"><i class="las la-link"></i> Más de ESAN</h6>
        <button class="btn btn-sm btn-success py-0" @click="addMasEsanLink"><i class="las la-plus"></i></button>
      </div>
      <div class="card-body p-2">
        <div v-for="(link, index) in localData.masEsanLinks" :key="'me-'+index" class="d-flex gap-2 mb-2">
          <input type="text" class="form-control form-control-sm" v-model="link.text" placeholder="Texto">
          <input type="text" class="form-control form-control-sm" v-model="link.url" placeholder="URL">
          <button class="btn btn-sm btn-outline-danger" @click="removeMasEsanLink(Number(index))"><i class="las la-times"></i></button>
        </div>
      </div>
    </div>

    <div class="card shadow-sm border-0 bg-light">
      <div class="card-body p-3">
        <label class="small text-muted fw-bold">Texto de Copyright</label>
        <input type="text" class="form-control form-control-sm" v-model="localData.copyrightText">
      </div>
    </div>

  </div>
</template>