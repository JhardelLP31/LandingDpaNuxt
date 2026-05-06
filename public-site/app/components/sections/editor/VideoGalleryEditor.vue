<script setup lang="ts">
import { computed, ref } from 'vue';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue']);

// Input temporal
const newVideoInput = ref('');

// Computed para leer/escribir el array de videos
const localVideos = computed({
  get: () => props.modelValue?.videos || [],
  set: (newArray) => emit('update:modelValue', { ...props.modelValue, videos: newArray })
});

// --- HELPER: Detectar ID de Youtube y convertir a Embed ---
const convertToEmbed = (url: string): string | null => {
    if (!url) return null;
    // Regex que soporta youtu.be, watch?v=, embed, etc.
    const match = url.match(/^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=|&v=)([^#&?]*).*/);
    return (match && match[2].length === 11) ? `https://www.youtube.com/embed/${match[2]}` : null;
};

// --- AÑADIR ---
const handleAddVideo = () => {
    const rawUrl = newVideoInput.value.trim();
    if (!rawUrl) return;

    const embedUrl = convertToEmbed(rawUrl);

    if (embedUrl) {
        // Creamos el objeto simple
        const newVideo = {
            url: embedUrl,
            title: `Video ${localVideos.value.length + 1}`
        };
        
        // Actualizamos array
        localVideos.value = [...localVideos.value, newVideo];
        newVideoInput.value = ''; // Limpiar input
    } else {
        alert('Por favor ingresa un link válido de YouTube.');
    }
};

// --- ELIMINAR ---
const removeVideo = (index: number) => {
    const updatedList = [...localVideos.value];
    updatedList.splice(index, 1);
    localVideos.value = updatedList;
};
</script>

<template>
  <div class="video-gallery-editor">
    
    <div class="p-3 mb-3 border rounded bg-primary text-white shadow-sm d-flex justify-content-between align-items-center">
      <h6 class="fw-bold mb-0"><i class="las la-photo-video me-2"></i>Galería de Videos</h6>
      <span class="badge bg-white text-primary rounded-pill">{{ localVideos.length }} items</span>
    </div>

    <div class="row g-3">
      
      <div class="col-md-7">
          <label class="form-label fw-bold small text-muted">Lista de Videos</label>
          
          <div v-if="localVideos.length > 0" class="list-group shadow-sm" style="max-height: 350px; overflow-y: auto;">
            
            <div v-for="(video, index) in localVideos" :key="index" class="list-group-item d-flex align-items-center p-2">
                
                <div class="flex-shrink-0 me-2 position-relative" style="width: 60px;">
                    <div class="ratio ratio-16x9 bg-dark rounded overflow-hidden">
                       <iframe :src="video.url" style="pointer-events: none;" tabindex="-1"></iframe>
                    </div>
                </div>
                
                <div class="flex-grow-1 text-truncate" style="line-height: 1.2;">
                    <small class="fw-bold d-block text-dark">{{ video.title }}</small>
                    <small class="text-muted" style="font-size: 0.7rem;">{{ video.url }}</small>
                </div>
                
                <button @click="removeVideo(Number(index))" class="btn btn-sm btn-light text-danger border-0 ms-1" title="Eliminar">
                    <i class="las la-trash-alt"></i>
                </button>
            </div>

          </div>
          
          <div v-else class="text-center p-4 border border-dashed rounded bg-light">
            <small class="text-muted">No hay videos añadidos aún.</small>
          </div>
      </div>

      <div class="col-md-5">
          <div class="p-3 border rounded bg-white shadow-sm">
             <label class="form-label fw-bold small text-primary mb-2">AÑADIR VIDEO</label>

             <div class="mb-2">
                <input 
                  type="text" 
                  class="form-control form-control-sm" 
                  v-model="newVideoInput"
                  @keyup.enter="handleAddVideo"
                  placeholder="Pega URL de YouTube..."
                >
             </div>

             <button @click="handleAddVideo" class="btn btn-sm btn-primary w-100 fw-bold" :disabled="!newVideoInput">
                 <i class="las la-plus me-1"></i> Agregar
             </button>
             
             <div class="mt-2 text-muted" style="font-size: 0.7rem; line-height: 1.2;">
                <i class="las la-info-circle"></i> Acepta links normales (watch?v=...) y cortos (youtu.be/...).
             </div>
          </div>
      </div>

    </div>
  </div>
</template>

<style scoped>
.border-dashed { border-style: dashed !important; }
</style>