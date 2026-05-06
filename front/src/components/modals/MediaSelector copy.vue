  <script setup lang="ts">
  import { ref, onMounted, computed } from 'vue';
  import HttpClient from "@/helpers/http-client";
  import Swal from "sweetalert2";

  const emit = defineEmits<{
    (e: 'select', url: string): void;
    (e: 'close'): void;
  }>();

  // --- ESTADO ---
  const library = ref<any[]>([]);
  const loading = ref(false);
  const uploading = ref(false);
  const searchQuery = ref(''); // Estado para el buscador
  const fileInput = ref<HTMLInputElement | null>(null);

  // --- LÓGICA DE URLs (Seguridad y Portabilidad) ---
const formatImageUrl = (input: any) => {
  // LOG DE EMERGENCIA: Ver qué tipo de dato llega
  

  if (!input) {
    return 'https://placehold.co/600x400?text=Sin+Ruta+en+DB';
  }

  // Si nos pasaron el objeto completo por error, extraemos la url o el path
  const url = typeof input === 'object' ? (input.url || input.path) : input;

  if (!url) return 'https://placehold.co/600x400?text=Propiedad+No+Encontrada';

  if (url.startsWith('http')) {
    // Limpiamos la doble barra que vimos en tus logs anteriores
    return url.replace(/([^:]\/)\/+/g, "$1");
  }

  const baseUrl = import.meta.env.VITE_API_BASE_URL || 'http://127.0.0.1:8000';
  let cleanPath = url.replace('public/', 'storage/');
  if (!cleanPath.startsWith('/')) cleanPath = '/' + cleanPath;
  
  const finalUrl = `${baseUrl}${cleanPath}`;
  return finalUrl.replace(/([^:]\/)\/+/g, "$1"); // Limpieza final de dobles barras
};
  // --- BUSCADOR FILTRADO ---
  const filteredLibrary = computed(() => {
    if (!searchQuery.value) return library.value;
    const query = searchQuery.value.toLowerCase();
    return library.value.filter(img => 
      img.filename.toLowerCase().includes(query)
    );
  });

  const loadMedia = async () => {
    loading.value = true;
    try {
      const { data } = await HttpClient.get('media');
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

    try {
      const { data } = await HttpClient.post('upload-media', formData);
      library.value.unshift(data.media_item); 
      emit('select', data.url);
    } catch (e) {
      Swal.fire("Error", "No se pudo subir la imagen", "error");
    } finally {
      uploading.value = false;
    }
  };

  onMounted(loadMedia);
  </script>

  <template>
    <div class="modal fade show d-block" style="background: rgba(0,0,0,0.8); z-index: 1070;">
      <div class="modal-dialog modal-xl modal-dialog-scrollable shadow-lg">
        <div class="modal-content border-0">
          
        <div class="modal-header bg-dark text-white border-0 py-3">
          <div class="d-flex align-items-center justify-content-between w-100">
            <!-- Parte izquierda: Ícono y Título -->
            <div class="d-flex align-items-center">
              <i class="las la-images fs-3 me-2 text-primary"></i>
              <h5 class="modal-title fw-bold">Biblioteca de Medios</h5>
            </div>
            
            <!-- Parte derecha: Botones -->
            <div class="d-flex gap-2 align-items-center">
              <button class="btn btn-primary btn-sm px-3 fw-bold shadow-sm" @click="fileInput?.click()" :disabled="uploading">
                <i class="las la-cloud-upload-alt me-1"></i> 
                {{ uploading ? 'SUBIENDO...' : 'SUBIR NUEVA' }}
              </button>
              <button type="button" class="btn-close btn-close-white ms-2" @click="$emit('close')"></button>
            </div>
          </div>

          <!-- Input para cargar archivo (oculto) -->
          <input type="file" ref="fileInput" class="d-none" @change="handleUpload">
        </div>


          <div class="modal-body bg-light p-4">
            
            <div class="row mb-4">
              <div class="col-12">
                <div class="input-group shadow-sm">
                  <span class="input-group-text bg-white border-end-0"><i class="las la-search text-muted"></i></span>
                  <input 
                    v-model="searchQuery" 
                    type="text" 
                    class="form-control border-start-0 ps-0" 
                    placeholder="Buscar archivos por nombre..."
                  >
                </div>
              </div>
            </div>

            <div v-if="loading" class="text-center py-5 mt-5">
              <div class="spinner-grow text-primary" role="status"></div>
              <p class="mt-3 text-muted fw-bold">Accediendo a la nube...</p>
            </div>

            <div v-else-if="filteredLibrary.length === 0" class="text-center py-5">
              <div class="p-5 border-dashed rounded-4 bg-white shadow-sm mx-auto" style="max-width: 500px;">
                <i class="las la-search-minus display-3 text-muted"></i>
                <h4 class="mt-3 fw-bold">No encontramos resultados</h4>
                <p class="text-muted">Intenta con otro nombre o sube una imagen nueva.</p>
              </div>
            </div>

            <div v-else class="row g-3">
              <div v-for="img in filteredLibrary" :key="img.id" class="col-xl-2 col-lg-3 col-md-4 col-6">
                <div class="card h-100 media-card border-0 shadow-sm" @click="$emit('select', img.url)">
                  <div class="img-container bg-white d-flex align-items-center justify-content-center border-bottom" style="height: 140px;">
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

          </div>
        </div>
      </div>
    </div>
  </template>

  <style scoped lang="scss">
  .border-dashed { border: 2px dashed #dee2e6 !important; }

  .media-card {
    cursor: pointer;
    transition: all 0.25s cubic-bezier(0.165, 0.84, 0.44, 1);
    border: 2px solid transparent !important;

    &:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 30px rgba(0,0,0,0.1) !important;
      border-color: #0d6efd !important;
      
      img { transform: scale(1.05); }
    }

    img {
      transition: transform 0.3s ease;
    }
  }

  // Estilo para el input de búsqueda
  .form-control:focus {
    box-shadow: none;
    border-color: #dee2e6;
  }
  </style>