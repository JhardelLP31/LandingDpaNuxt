<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import HttpClient from "@/helpers/http-client";
import { formatImageUrl } from '@/helpers/url'; // <--- IMPORTADO
import Swal from "sweetalert2";

const emit = defineEmits<{
  (e: 'select', url: string): void;
  (e: 'close'): void;
}>();

// --- ESTADO ---
const library = ref<any[]>([]);
const loading = ref(false);
const uploading = ref(false);
const deleting = ref<number | null>(null); // Para saber cuál se está borrando
const searchQuery = ref('');
const fileInput = ref<HTMLInputElement | null>(null);

// --- BUSCADOR ---
const filteredLibrary = computed(() => {
  if (!searchQuery.value) return library.value;
  const query = searchQuery.value.toLowerCase();
  return library.value.filter(img => 
    (img.filename || '').toLowerCase().includes(query)
  );
});

// --- CARGAR IMÁGENES ---
const loadMedia = async () => {
  loading.value = true;
  try {
    const { data } = await HttpClient.get('media');
    // Aseguramos que sea un array, a veces las APIs devuelven paginación
    library.value = Array.isArray(data) ? data : (data.data || []);
  } catch (e) {
    console.error(e);
    Swal.fire('Error', 'No se pudo cargar la galería', 'error');
  } finally {
    loading.value = false;
  }
};

// --- SUBIR IMAGEN ---
const handleUpload = async (event: any) => {
  const file = event.target.files[0];
  if (!file) return;

  uploading.value = true;
  const formData = new FormData();  
  formData.append('image', file);

  try {
    const { data } = await HttpClient.post('upload-media', formData);
    
    // Agregamos la nueva imagen al principio de la lista
    library.value.unshift(data.media_item || data); 
    
    // Feedback visual
    const Toast = Swal.mixin({
      toast: true, position: 'top-end', showConfirmButton: false, timer: 3000
    });
    Toast.fire({ icon: 'success', title: 'Imagen subida correctamente' });

    // Opcional: Seleccionarla automáticamente
    // emit('select', data.url); 
  } catch (e) {
    Swal.fire("Error", "No se pudo subir la imagen", "error");
  } finally {
    uploading.value = false;
    // Limpiamos el input para poder subir el mismo archivo si es necesario
    if (fileInput.value) fileInput.value.value = ''; 
  }
};

// --- BORRAR IMAGEN (NUEVO) ---
const deleteImage = async (id: number, event: Event) => {
    event.stopPropagation(); // Evita que se seleccione la imagen al hacer click en borrar
    
    const result = await Swal.fire({
        title: '¿Eliminar imagen?',
        text: "No podrás recuperar este archivo.",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#dc3545',
        confirmButtonText: 'Sí, borrar',
        cancelButtonText: 'Cancelar'
    });

    if (result.isConfirmed) {
        deleting.value = id;
        try {
            await HttpClient.delete(`media/${id}`); // Asegúrate tener esta ruta en Laravel
            library.value = library.value.filter(img => img.id !== id);
            
            const Toast = Swal.mixin({ toast: true, position: 'top-end', showConfirmButton: false, timer: 2000 });
            Toast.fire({ icon: 'success', title: 'Imagen eliminada' });
        } catch (e) {
            Swal.fire('Error', 'No se pudo eliminar la imagen', 'error');
        } finally {
            deleting.value = null;
        }
    }
};

onMounted(loadMedia);
</script>

<template>
  <div class="modal fade show d-block" style="background: rgba(0,0,0,0.85); z-index: 1070;" @click.self="$emit('close')">
    <div class="modal-dialog modal-xl modal-dialog-scrollable shadow-lg">
      <div class="modal-content border-0 overflow-hidden">
        
        <div class="modal-header bg-dark text-white border-0 py-3">
          <div class="d-flex align-items-center justify-content-between w-100">
            <div class="d-flex align-items-center gap-3">
              <div class="bg-primary bg-opacity-25 p-2 rounded">
                  <i class="las la-images fs-3 text-primary"></i>
              </div>
              <div>
                  <h5 class="modal-title fw-bold m-0 lh-1">Biblioteca de Medios</h5>
                  <small class="text-white-50" style="font-size: 0.75rem;">{{ library.length }} archivos disponibles</small>
              </div>
            </div>
            
            <div class="d-flex gap-2 align-items-center">
              <button 
                class="btn btn-primary btn-sm px-4 fw-bold shadow-sm d-flex align-items-center gap-2" 
                @click="fileInput?.click()" 
                :disabled="uploading"
              >
                <i v-if="uploading" class="las la-spinner la-spin"></i>
                <i v-else class="las la-cloud-upload-alt fs-5"></i> 
                {{ uploading ? 'SUBIENDO...' : 'SUBIR NUEVA' }}
              </button>
              <button type="button" class="btn btn-dark border border-secondary ms-2" @click="$emit('close')">
                <i class="las la-times"></i>
              </button>
            </div>
          </div>
          <input type="file" ref="fileInput" class="d-none" accept="image/*" @change="handleUpload">
        </div>

        <div class="bg-white p-3 border-bottom sticky-top" style="z-index: 10;">
            <div class="input-group">
                <span class="input-group-text bg-light border-end-0"><i class="las la-search text-muted"></i></span>
                <input 
                  v-model="searchQuery" 
                  type="text" 
                  class="form-control border-start-0 bg-light" 
                  placeholder="Buscar por nombre de archivo..."
                >
            </div>
        </div>

        <div class="modal-body bg-light p-4">
          
          <div v-if="loading" class="text-center py-5">
            <div class="spinner-border text-primary" role="status"></div>
            <p class="mt-3 text-muted fw-bold small">Cargando biblioteca...</p>
          </div>

          <div v-else-if="filteredLibrary.length === 0" class="text-center py-5">
            <div class="p-5 border-dashed rounded-4 bg-white shadow-sm mx-auto" style="max-width: 400px;">
              <i class="las la-image display-4 text-muted opacity-25"></i>
              <h5 class="mt-3 fw-bold text-muted">Sin resultados</h5>
              <p class="small text-muted mb-0">No hay imágenes que coincidan con tu búsqueda.</p>
            </div>
          </div>

          <div v-else class="row g-3">
            <div v-for="img in filteredLibrary" :key="img.id" class="col-xl-2 col-lg-3 col-md-4 col-6">
              
              <div class="media-card card h-100 border-0 shadow-sm position-relative group">
                
                <button 
                    @click="deleteImage(img.id, $event)"
                    class="btn-delete btn btn-danger btn-sm position-absolute top-0 end-0 m-2 shadow-sm"
                    title="Eliminar imagen permanentemente"
                    :disabled="deleting === img.id"
                >
                    <i v-if="deleting === img.id" class="las la-spinner la-spin"></i>
                    <i v-else class="las la-trash"></i>
                </button>

                <div @click="$emit('select', img.url)" class="h-100 d-flex flex-column">
                    <div class="img-wrapper bg-white d-flex align-items-center justify-content-center border-bottom rounded-top overflow-hidden" style="height: 140px;">
                      <img 
                        :src="formatImageUrl(img.url || img.path)" 
                        class="img-fluid"
                        style="max-height: 100%; max-width: 100%; object-fit: contain;"
                        loading="lazy"
                        @error="(e: any) => e.target.src = 'https://placehold.co/200x200?text=Error'"
                      >
                    </div>
                    <div class="card-footer bg-white border-0 p-2">
                      <p class="text-dark small text-truncate mb-0 fw-medium" :title="img.filename">
                        {{ img.filename }}
                      </p>
                      <small class="text-muted" style="font-size: 0.65rem;">
                          {{ new Date(img.created_at).toLocaleDateString() }}
                      </small>
                    </div>
                </div>

              </div>
            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
.border-dashed { border: 2px dashed #dee2e6 !important; }

/* Transiciones elegantes para las tarjetas */
.media-card {
  cursor: pointer;
  transition: all 0.2s ease-in-out;
  border: 1px solid transparent !important;
  overflow: hidden;

  &:hover {
    transform: translateY(-3px);
    box-shadow: 0 10px 20px rgba(0,0,0,0.08) !important;
    border-color: var(--bs-primary) !important;
    
    /* Mostrar botón de eliminar al hover */
    .btn-delete {
        opacity: 1;
        transform: scale(1);
    }
  }
}

/* El botón de eliminar empieza oculto */
.btn-delete {
    opacity: 0;
    transform: scale(0.8);
    transition: all 0.2s cubic-bezier(0.175, 0.885, 0.32, 1.275);
    z-index: 10;
    width: 32px;
    height: 32px;
    padding: 0;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
}

.img-wrapper img {
    transition: transform 0.3s ease;
}
.media-card:hover .img-wrapper img {
    transform: scale(1.05);
}

.modal-content {
    border-radius: 1rem;
}

/* Scrollbar personalizada para el modal */
.modal-body::-webkit-scrollbar {
  width: 8px;
}
.modal-body::-webkit-scrollbar-track {
  background: #f1f1f1;
}
.modal-body::-webkit-scrollbar-thumb {
  background: #cbd5e0;
  border-radius: 4px;
}
.modal-body::-webkit-scrollbar-thumb:hover {
  background: #a0aec0;
}
</style>