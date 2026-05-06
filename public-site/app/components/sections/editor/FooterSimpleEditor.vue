<script setup lang="ts">
import { computed } from 'vue';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue']);

// Proxy reactivo
const localContent = computed({
  get: () => props.modelValue || { socials: [], config: {} },
  set: (val) => emit('update:modelValue', val)
});

const updateConfig = (field: string, value: any) => {
  const newConfig = { ...(localContent.value.config || {}), [field]: value };
  emit('update:modelValue', { ...localContent.value, config: newConfig });
};

// --- LOGICA REDES SOCIALES ---
const addSocial = () => {
  const newSocials = [...(localContent.value.socials || [])];
  newSocials.push({ platform: 'Nueva Red', url: '#', iconClass: 'fas fa-link' });
  emit('update:modelValue', { ...localContent.value, socials: newSocials });
};

const removeSocial = (index: number) => {
  const newSocials = [...(localContent.value.socials || [])];
  newSocials.splice(index, 1);
  emit('update:modelValue', { ...localContent.value, socials: newSocials });
};

// Iconos comunes para ayuda rápida
const commonIcons = [
  { label: 'Facebook', class: 'fab fa-facebook' },
  { label: 'YouTube', class: 'fab fa-youtube' },
  { label: 'Instagram', class: 'fab fa-instagram' },
  { label: 'LinkedIn', class: 'fab fa-linkedin' },
  { label: 'Twitter/X', class: 'fab fa-x-twitter' },
];

const setIcon = (index: number, iconClass: string) => {
  const newSocials = [...localContent.value.socials];
  newSocials[index].iconClass = iconClass;
  emit('update:modelValue', { ...localContent.value, socials: newSocials });
};
</script>

<template>
  <div class="p-2">
    
    <div class="mb-3 border p-3 rounded bg-light">
      <h6 class="fw-bold text-primary mb-3">Contenido Footer</h6>
      <label class="small text-muted fw-bold">Texto Copyright</label>
      <div class="small text-muted mb-1">Usa <code>{year}</code> para el año actual.</div>
      <textarea 
        v-model="localContent.copyrightText" 
        class="form-control" 
        rows="3"
        placeholder="© Copyright {year} ESANDATA..."
      ></textarea>
    </div>

    <div class="mb-3 border p-3 rounded bg-white shadow-sm">
      <div class="d-flex justify-content-between align-items-center mb-3">
        <h6 class="fw-bold text-primary m-0">Redes Sociales</h6>
        <button @click="addSocial" class="btn btn-sm btn-outline-primary">
          <i class="fas fa-plus"></i> Agregar
        </button>
      </div>

      <div v-if="!localContent.socials?.length" class="text-center text-muted small py-2">
        No hay redes configuradas.
      </div>

      <div v-for="(item, index) in localContent.socials" :key="index" class="mb-3 border-bottom pb-3">
        <div class="d-flex justify-content-between mb-2">
          <span class="badge bg-secondary">{{ Number(index) + 1 }}</span>
          <button @click="removeSocial(Number(index))" class="btn btn-xs btn-link text-danger p-0">
            <i class="fas fa-trash"></i>
          </button>
        </div>

        <div class="mb-2 d-flex gap-1 flex-wrap">
             <button 
                v-for="icon in commonIcons" 
                :key="icon.class"
                @click="setIcon(Number(index), icon.class)"
                class="btn btn-sm"
                :class="item.iconClass === icon.class ? 'btn-primary' : 'btn-outline-secondary'"
                :title="icon.label"
             >
                <i :class="icon.class"></i>
             </button>
        </div>
        
        <input v-model="item.url" class="form-control form-control-sm mb-1" placeholder="URL (https://...)">
        
        <input v-model="item.iconClass" class="form-control form-control-sm text-muted fst-italic" placeholder="Clase Icono (ej: fab fa-tiktok)">
      </div>
    </div>

    <div class="mb-3 border p-3 rounded bg-light">
      <h6 class="fw-bold text-primary mb-3">Colores</h6>
      
      <div class="row g-2 align-items-center mb-2">
        <div class="col-8"><label class="small">Fondo Footer</label></div>
        <div class="col-4">
           <input type="color" 
             class="form-control form-control-color w-100" 
             :value="localContent.config?.bgColor || '#1a1a1a'"
             @input="e => updateConfig('bgColor', (e.target as HTMLInputElement).value)">
        </div>
      </div>

      <div class="row g-2 align-items-center mb-2">
        <div class="col-8"><label class="small">Texto General</label></div>
        <div class="col-4">
           <input type="color" 
             class="form-control form-control-color w-100" 
             :value="localContent.config?.textColor || '#ffffff'"
             @input="e => updateConfig('textColor', (e.target as HTMLInputElement).value)">
        </div>
      </div>

      <div class="row g-2 align-items-center">
        <div class="col-8"><label class="small">Iconos Social</label></div>
        <div class="col-4">
           <input type="color" 
             class="form-control form-control-color w-100" 
             :value="localContent.config?.iconColor || '#ffffff'"
             @input="e => updateConfig('iconColor', (e.target as HTMLInputElement).value)">
        </div>
      </div>
    </div>

  </div>
</template>