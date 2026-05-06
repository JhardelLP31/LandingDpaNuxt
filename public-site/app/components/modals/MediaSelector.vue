<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import HttpClient from "@/helpers/http-client";
import Swal from "sweetalert2";

// --- PROPS Y EMITS ---
const props = defineProps<{
  collection?: string; // Ej: 'courses', 'posts'
}>();

const emit = defineEmits<{
  (e: 'select', url: string): void;
  (e: 'close'): void;
}>();

// --- ESTADO ---
const library = ref<any[]>([]);
const loading = ref(false);
const uploading = ref(false);
const searchQuery = ref('');
const fileInput = ref<HTMLInputElement | null>(null);

// --- UTILIDAD DE FORMATEO (Tu versión optimizada) ---
  const formatImageUrl = (url: any) => {
      if (!url) return 'https://placehold.co/600x400?text=Sin+Imagen';

    // 1. Caso especial: Si ya es una URL externa (no local)
    if (url.startsWith('http') && !url.includes('/storage/')) {
      return url;
    }

    // 2. Extraer solo la parte importante: media/foto.jpg
    // Buscamos lo que esté después de /storage/ o storage/
    let cleanPath = url;
    if (url.includes('storage/')) {
      cleanPath = url.split('storage/').pop() || ''; 
    }

    // 3. Obtener la Base URL del .env (ej: http://127.0.0.1:8000)
    const baseUrl = import.meta.env.VITE_API_URL.replace(/\/+$/, ""); 
    
    // 4. Limpieza del path
    // Quitamos 'public/', barras al inicio, y barras duplicadas
    cleanPath = cleanPath
      .replace('public/', "")
      .replace(/^\/+/, "") // Quita todas las barras al inicio
      .replace(/\/+/g, "/"); // Convierte cualquier // en / dentro del path

    // 5. Reconstrucción forzada
    // Esto garantiza que solo haya UNA barra entre el dominio y el storage
    return `${baseUrl}/storage/${cleanPath}`;
  };

// --- LÓGICA DE DATOS ---
const loadMedia = async () => {
  loading.value = true;
  try {
    // Filtramos por colección si viene en las props
    const params = props.collection ? { collection: props.collection } : {};
    const { data } = await HttpClient.get('media', { params });
    library.value = data.data || data;
  } finally {
    loading.value = false;
  }
};

const handleUpload = async (event: any) => {
  const file = event.target.files[0];
  if (!file) return;

  uploading.value = true;
  const formData = new FormData();  
  formData.append('image', file);
  
  // Enviamos la colección para mantener el orden en la DB
  if (props.collection) {
    formData.append('collection', props.collection);
  }

  try {
    const { data } = await HttpClient.post('upload-media', formData);
    // Agregamos al inicio de la lista y notificamos selección
    library.value.unshift(data.media_item); 
    emit('select', data.url);
  } catch (e) {
    Swal.fire("Error", "No se pudo subir la imagen", "error");
  } finally {
    uploading.value = false;
    if (fileInput.value) fileInput.value.value = ''; // Reset input
  }
};

const filteredLibrary = computed(() => {
  if (!searchQuery.value) return library.value;
  const query = searchQuery.value.toLowerCase();
  return library.value.filter(img => 
    img.filename.toLowerCase().includes(query)
  );
});

onMounted(loadMedia);
</script>

<template>
  <div class="modal fade show d-block" style="background: rgba(0,0,0,0.8); z-index: 1070;">
    <div class="modal-dialog modal-xl modal-dialog-scrollable shadow-lg">
      <div class="modal-content border-0">
        
        <div class="modal-header bg-dark text-white border-0 py-3">
          <div class="d-flex align-items-center justify-content-between w-100">
            <div class="d-flex align-items-center">
              <i class="las la-images fs-3 me-2 text-primary"></i>
              <h5 class="modal-title fw-bold">Biblioteca de Medios 
                <span v-if="props.collection" class="badge bg-primary fs-6 ms-2 text-uppercase">{{ props.collection }}</span>
              </h5>
            </div>
            
            <div class="d-flex gap-2 align-items-center">
              <button class="btn btn-primary btn-sm px-3 fw-bold shadow-sm" @click="fileInput?.click()" :disabled="uploading">
                <i class="las la-cloud-upload-alt me-1"></i> 
                {{ uploading ? 'SUBIENDO...' : 'SUBIR NUEVA' }}
              </button>
              <button type="button" class="btn-close btn-close-white ms-2" @click="$emit('close')"></button>
            </div>
          </div>
          <input type="file" ref="fileInput" class="d-none" @change="handleUpload" accept="image/*,application/pdf">
        </div>

        <div class="modal-body bg-light p-4">
          <div class="row mb-4">
            <div class="col-12">
              <div class="input-group shadow-sm">
                <span class="input-group-text bg-white border-end-0"><i class="las la-search text-muted"></i></span>
                <input v-model="searchQuery" type="text" class="form-control border-start-0 ps-0" placeholder="Buscar en esta colección...">
              </div>
            </div>
          </div>

          <div v-if="loading" class="text-center py-5">
            <div class="spinner-grow text-primary" role="status"></div>
            <p class="mt-3 text-muted fw-bold">Accediendo a la nube...</p>
          </div>

          <div v-else class="row g-3">
            <div v-for="img in filteredLibrary" :key="img.id" class="col-xl-2 col-lg-3 col-md-4 col-6">
              <div class="card h-100 media-card border-0 shadow-sm" @click="$emit('select', img.url)">
                <div class="img-container bg-white d-flex align-items-center justify-content-center border-bottom" style="height: 140px; position: relative;">
                  
                  <span v-if="img.mime_type === 'image/webp'" class="badge bg-info position-absolute top-0 start-0 m-1" style="font-size: 0.6rem;">WEBP</span>

                  <img 
                    :src="formatImageUrl(img.url)" 
                    class="img-fluid object-fit-contain h-100 w-100 p-2"
                    @error="(e: any) => e.target.src = 'https://placehold.co/200x200?text=Error+404'"
                  >
                </div>
                <div class="card-footer bg-white border-0 p-2 text-center">
                  <small class="text-muted d-block text-truncate fw-bold" style="font-size: 0.65rem;">
                    {{ img.filename }}
                  </small>
                </div>
              </div>
            </div>
          </div>

          <div v-if="!loading && filteredLibrary.length === 0" class="text-center py-5">
            <i class="las la-search-minus display-3 text-muted"></i>
            <h4 class="mt-3 fw-bold">No hay archivos aquí</h4>
            <p class="text-muted">Sube una imagen o cambia los filtros.</p>
          </div>

        </div>
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
.media-card {
  cursor: pointer;
  transition: all 0.25s ease;
  &:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;
    border: 1px solid #0d6efd !important;
  }
}
</style>