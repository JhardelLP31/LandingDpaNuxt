<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import HttpClient from "@/helpers/http-client";
import { formatImageUrl } from '@/helpers/url';
import Swal from "sweetalert2";
import { useAuthStore } from "@/stores/auth";

// --- INTERFACES ---
interface MediaFolder {
  id: number;
  name: string;
  parent_id: number | null;
}

interface MediaItem {
  id: number;
  url: string;
  filename: string;
  mime_type: string;
  size: number;
}

// --- ESTADO Y STORE ---
const authStore = useAuthStore();
const effectiveUnitId = computed(() => authStore.academicUnitId || 1);

const folders = ref<MediaFolder[]>([]);
const files = ref<MediaItem[]>([]);
const loading = ref(false);
const uploading = ref(false);
const searchQuery = ref('');
const fileInput = ref<HTMLInputElement | null>(null);

const currentFolderId = ref<number | null>(null);
const parentFolderId = ref<number | null>(null);
const breadcrumbPath = ref<{id: number, name: string}[]>([]);

// --- CARGAR DATOS ---
const loadMedia = async () => {
    loading.value = true;
    try {
        const url = currentFolderId.value 
            ? `media-manager/${effectiveUnitId.value}?folder_id=${currentFolderId.value}&t=${Date.now()}`
            : `media-manager/${effectiveUnitId.value}?t=${Date.now()}`;
            
        const response = await HttpClient.get(url);
        const data = response.data;

        folders.value = data.folders || data.data?.folders || [];
        files.value = data.files || data.data?.files || [];
        parentFolderId.value = data.parent_id ?? data.data?.parent_id ?? null;
    } catch (error) {
        console.error("Error cargando medios:", error);
        Swal.fire("Error", "No se pudo cargar la galería", "error");
    } finally {
        loading.value = false;
    }
};

// --- SUBIR ARCHIVO ---
const handleUpload = async (event: Event) => {
  const target = event.target as HTMLInputElement;
  const file = target.files?.[0];
  if (!file) return;

  if (file.size > 5 * 1024 * 1024) {
    Swal.fire("Archivo muy grande", "El peso máximo es 5MB", "warning");
    if (fileInput.value) fileInput.value.value = '';
    return;
  }

  uploading.value = true;
  const formData = new FormData();  
  formData.append('academic_unit_id', String(effectiveUnitId.value));
  formData.append('files[]', file); 
  
  if (currentFolderId.value) {
      formData.append('folder_id', String(currentFolderId.value));
  }

  try {
    await HttpClient.post('media/upload', formData, {
        headers: { 'Content-Type': 'multipart/form-data' }
    });
    searchQuery.value = ''; 
    await loadMedia(); 
    Swal.fire({ toast: true, position: 'top-end', icon: 'success', title: 'Archivo subido', showConfirmButton: false, timer: 2000 });
  } catch (e) {
    Swal.fire("Error", "Hubo un problema al subir el archivo", "error");
  } finally {
    uploading.value = false;
    if (fileInput.value) fileInput.value.value = ''; 
  }
};

// --- NAVEGACIÓN ---
const openFolder = (folder: MediaFolder) => {
    currentFolderId.value = folder.id;
    breadcrumbPath.value.push({id: folder.id, name: folder.name});
    searchQuery.value = '';
    loadMedia();
};

const goUp = () => {
    currentFolderId.value = parentFolderId.value;
    breadcrumbPath.value.pop();
    searchQuery.value = '';
    loadMedia();
};

const goToRoot = () => {
    currentFolderId.value = null;
    breadcrumbPath.value = [];
    searchQuery.value = '';
    loadMedia();
};

// --- CREAR CARPETA ---
const createFolder = async () => {
    const { value: name } = await Swal.fire({
        title: 'Nueva Carpeta',
        input: 'text',
        inputPlaceholder: 'Nombre de la carpeta',
        showCancelButton: true,
        confirmButtonText: 'Crear',
        cancelButtonText: 'Cancelar'
    });

    if (name) {
        try {
            await HttpClient.post('media-folders', {
                academic_unit_id: effectiveUnitId.value,
                parent_id: currentFolderId.value,
                name: name
            });
            searchQuery.value = '';
            await loadMedia();
            Swal.fire({ toast: true, position: 'top-end', icon: 'success', title: 'Carpeta creada', showConfirmButton: false, timer: 2000 });
        } catch (e: any) {
            Swal.fire('Error', 'No se pudo crear la carpeta', 'error');
        }
    }
};

// --- ELIMINAR ARCHIVO ---
const deleteFile = async (item: MediaItem) => {
    const result = await Swal.fire({
        title: '¿Eliminar archivo?',
        text: `Se borrará "${item.filename}". Esta acción no se puede deshacer.`,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#dc3545',
        confirmButtonText: 'Sí, eliminar',
        cancelButtonText: 'Cancelar'
    });

    if (result.isConfirmed) {
        try {
            await HttpClient.delete(`media/${item.id}`);
            files.value = files.value.filter(f => f.id !== item.id);
            Swal.fire({ toast: true, position: 'top-end', icon: 'success', title: 'Archivo eliminado', showConfirmButton: false, timer: 2000 });
        } catch (error) {
            Swal.fire('Error', 'No se pudo eliminar el archivo', 'error');
        }
    }
};

// --- ELIMINAR CARPETA ---
const deleteFolder = async (folder: MediaFolder) => {
    const result = await Swal.fire({
        title: '¿Eliminar carpeta?',
        text: `Se borrará "${folder.name}". Asegúrate de que no contenga archivos vitales.`,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#dc3545',
        confirmButtonText: 'Sí, eliminar',
        cancelButtonText: 'Cancelar'
    });

    if (result.isConfirmed) {
        try {
            await HttpClient.delete(`media-folders/${folder.id}`);
            await loadMedia();
            Swal.fire({ toast: true, position: 'top-end', icon: 'success', title: 'Carpeta eliminada', showConfirmButton: false, timer: 2000 });
        } catch (error) {
            Swal.fire('Error', 'No se pudo eliminar la carpeta. Puede que necesites vaciarla primero.', 'error');
        }
    }
};

// --- COPIAR URL ---
const copyUrl = (url: string) => {
    const fullUrl = formatImageUrl(url);
    navigator.clipboard.writeText(fullUrl);
    Swal.fire({ toast: true, position: 'top-end', icon: 'info', title: 'URL Copiada al portapapeles', showConfirmButton: false, timer: 2000 });
};

// --- FILTROS DE BÚSQUEDA ---
const filteredFiles = computed(() => {
  if (!searchQuery.value) return files.value;
  return files.value.filter(item => item.filename.toLowerCase().includes(searchQuery.value.toLowerCase()));
});

const filteredFolders = computed(() => {
  if (!searchQuery.value) return folders.value;
  return folders.value.filter(item => item.name.toLowerCase().includes(searchQuery.value.toLowerCase()));
});

onMounted(loadMedia);
</script>

<template>
  <div class="container-fluid py-4 h-100">
    <div class="card shadow-sm border-0 rounded-3 overflow-hidden" style="min-height: 80vh;">
      
      <div class="card-header bg-white border-bottom py-3 d-flex flex-wrap align-items-center justify-content-between gap-3">
        <div class="d-flex align-items-center">
            <div class="bg-primary bg-opacity-10 p-2 rounded me-3 text-primary">
                <i class="las la-server fs-3"></i>
            </div>
            <div>
                <h5 class="mb-0 fw-bold text-dark">Explorador de Medios</h5>
                <small class="text-muted">Gestiona los archivos de tu Unidad Académica</small>
            </div>
        </div>
        
        <div class="d-flex gap-2">
          <div class="input-group input-group-sm shadow-sm me-2" style="width: 250px;">
            <span class="input-group-text bg-white border-end-0"><i class="las la-search text-muted"></i></span>
            <input v-model="searchQuery" type="text" class="form-control border-start-0 focus-ring-none" placeholder="Buscar...">
          </div>
          <button class="btn btn-outline-secondary btn-sm d-flex align-items-center" @click="createFolder" :disabled="uploading">
            <i class="las la-folder-plus fs-5 me-1"></i> Nueva Carpeta
          </button>
          <button class="btn btn-primary btn-sm px-3 fw-bold shadow-sm d-flex align-items-center" @click="fileInput?.click()" :disabled="uploading || !effectiveUnitId">
            <span v-if="uploading" class="spinner-border spinner-border-sm me-2"></span>
            <i v-else class="las la-cloud-upload-alt fs-5 me-1"></i> Subir
          </button>
          <input type="file" ref="fileInput" class="d-none" @change="handleUpload" accept="image/*,application/pdf">
        </div>
      </div>

      <div class="row g-0 flex-grow-1">
        
        <div class="col-md-3 col-lg-2 bg-light border-end p-3 d-flex flex-column">
            <span class="text-uppercase text-muted fw-bold mb-3" style="font-size: 0.75rem; letter-spacing: 1px;">Accesos Rápidos</span>
            
            <ul class="list-unstyled mb-4 sidebar-menu">
                <li class="p-2 rounded cursor-pointer transition-all" 
                    :class="{ 'bg-primary text-white': currentFolderId === null, 'text-dark hover-bg': currentFolderId !== null }"
                    @click="goToRoot">
                    <i class="las la-hdd fs-5 me-2 align-middle"></i> Directorio Raíz
                </li>
            </ul>

            <span class="text-uppercase text-muted fw-bold mb-3" style="font-size: 0.75rem; letter-spacing: 1px;">Subcarpetas Actuales</span>
            <ul class="list-unstyled sidebar-menu flex-grow-1 overflow-auto">
                <li v-if="folders.length === 0" class="text-muted small ms-2 fst-italic">
                    No hay carpetas aquí.
                </li>
                <li v-for="folder in folders" :key="'nav-'+folder.id" 
                    class="p-2 rounded cursor-pointer text-dark hover-bg text-truncate"
                    @click="openFolder(folder)">
                    <i class="las la-folder text-warning fs-5 me-2 align-middle"></i> {{ folder.name }}
                </li>
            </ul>
        </div>

        <div class="col-md-9 col-lg-10 d-flex flex-column bg-white">
            
            <div class="bg-light bg-opacity-50 border-bottom px-4 py-2 d-flex align-items-center">
                <button v-if="currentFolderId" class="btn btn-sm btn-light border shadow-sm me-3" @click="goUp">
                    <i class="las la-level-up-alt fs-6"></i> Subir nivel
                </button>
                <div class="breadcrumb mb-0 fs-6 fw-medium d-flex align-items-center">
                    <span class="cursor-pointer text-primary hover-underline" @click="goToRoot">Raíz</span>
                    <span v-for="crumb in breadcrumbPath" :key="'bc-'+crumb.id" class="d-flex align-items-center text-secondary">
                        <i class="las la-angle-right mx-2 small"></i>
                        {{ crumb.name }}
                    </span>
                </div>
            </div>

            <div v-if="!effectiveUnitId" class="alert alert-warning m-4 text-center">
                Debes seleccionar una Unidad Académica antes de explorar los archivos.
            </div>

            <div v-else-if="loading" class="d-flex flex-column align-items-center justify-content-center flex-grow-1 py-5">
                <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status"></div>
                <p class="mt-3 text-muted fw-medium">Sincronizando archivos...</p>
            </div>

            <div v-else class="p-4 flex-grow-1 overflow-auto">
                
                <div class="row g-3">
                    <div v-for="folder in filteredFolders" :key="'f-'+folder.id" class="col-xl-2 col-lg-3 col-md-4 col-sm-6">
                        <div class="card h-100 folder-card border border-light shadow-sm position-relative group-hover">
                            <button class="btn btn-sm btn-danger position-absolute top-0 end-0 m-1 opacity-0 transition-opacity z-index-2 btn-delete" 
                                    @click.stop="deleteFolder(folder)" title="Eliminar carpeta">
                                <i class="las la-trash-alt"></i>
                            </button>
                            
                            <div class="card-body text-center p-3" @click="openFolder(folder)">
                                <i class="las la-folder text-warning display-3 mb-2"></i>
                                <div class="text-truncate fw-medium small text-dark" :title="folder.name">{{ folder.name }}</div>
                            </div>
                        </div>
                    </div>

                    <div v-for="item in filteredFiles" :key="'m-'+item.id" class="col-xl-2 col-lg-3 col-md-4 col-sm-6">
                        <div class="card h-100 media-card border border-light shadow-sm position-relative group-hover">
                            
                            <button class="btn btn-sm btn-danger position-absolute top-0 end-0 m-1 opacity-0 transition-opacity z-index-2 btn-delete" 
                                    @click.stop="deleteFile(item)" title="Eliminar archivo">
                                <i class="las la-trash-alt"></i>
                            </button>

                            <div class="img-container bg-light d-flex align-items-center justify-content-center border-bottom rounded-top cursor-pointer" 
                                 style="height: 130px; position: relative;" @click="copyUrl(item.url)">
                                
                                <span v-if="item.mime_type.includes('webp')" class="badge bg-info position-absolute top-0 start-0 m-1" style="font-size: 0.65rem;">WEBP</span>

                                <div v-if="item.mime_type === 'application/pdf'" class="text-danger d-flex flex-column align-items-center">
                                    <i class="las la-file-pdf display-3"></i>
                                </div>
                                                                
                                <img v-else-if="item.mime_type.includes('image')"
                                    :src="formatImageUrl(item.url)"
                                    class="img-fluid object-fit-contain h-100 w-100 p-2"
                                    @error="(e: any) => e.target.src = 'https://placehold.co/200x200?text=Error'"
                                    alt="media"
                                >
                                                                
                                <i v-else class="las la-file-alt display-3 text-secondary"></i>
                                
                                <div class="copy-overlay position-absolute w-100 h-100 d-flex align-items-center justify-content-center bg-dark bg-opacity-50 opacity-0 transition-opacity">
                                    <span class="badge bg-primary fs-6"><i class="las la-link"></i> Copiar URL</span>
                                </div>
                            </div>

                            <div class="card-footer bg-white border-0 p-2 text-center rounded-bottom">
                                <small class="text-muted d-block text-truncate fw-medium" style="font-size: 0.75rem;" :title="item.filename">
                                    {{ item.filename }}
                                </small>
                            </div>
                        </div>
                    </div>
                </div>

                <div v-if="!loading && filteredFiles.length === 0 && filteredFolders.length === 0" class="d-flex flex-column align-items-center justify-content-center py-5 h-100">
                    <div class="bg-light rounded-circle p-4 mb-3 border border-dashed">
                        <i class="las la-folder-open display-1 text-secondary"></i>
                    </div>
                    <h5 class="fw-bold text-dark">Directorio vacío</h5>
                    <p class="text-muted">Arrastra archivos aquí o haz clic en subir.</p>
                </div>
                
            </div>
        </div>
      </div>
    </div>
  </div>
</template>

<style scoped lang="scss">
.border-dashed { border-style: dashed !important; border-width: 2px !important; border-color: #dee2e6 !important; }
.focus-ring-none:focus { box-shadow: none !important; outline: none !important; }
.cursor-pointer { cursor: pointer; }
.transition-all { transition: all 0.2s ease-in-out; }
.transition-opacity { transition: opacity 0.2s ease-in-out; }
.hover-underline:hover { text-decoration: underline; }
.z-index-2 { z-index: 2; }

/* Efecto hover en el sidebar */
.hover-bg:hover { background-color: #f8f9fa; color: #0d6efd !important; }

/* Tarjetas de archivos y carpetas */
.folder-card, .media-card {
  transition: all 0.2s ease-in-out;
  
  &:hover {
    transform: translateY(-3px);
    box-shadow: 0 .5rem 1rem rgba(0,0,0,.15) !important;
    border-color: #dee2e6 !important;
    
    .btn-delete {
        opacity: 1; /* Muestra el botón de eliminar al pasar el mouse */
    }
    
    .copy-overlay {
        opacity: 1; /* Muestra el mensaje de copiar URL */
    }
  }
}
</style>