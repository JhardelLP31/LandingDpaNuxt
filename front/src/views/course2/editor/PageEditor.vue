<template>
  <div class="editor-container d-flex h-100">
    
    <div class="editor-sidebar bg-light border-end" style="width: 400px; overflow-y: auto;">
      <div class="p-3">
        <div class="justify-content-between">
        <button class="btn btn-sm mb-3 btn-outline-dark" 
                    @click="$router.go(-1)">
                    <i class="las la-arrow-left"></i> Volver
                </button>
                
        <h5 class="mb-3 font-weight-bold">EDITOR DE CURSO</h5>
        </div>
        
        
        <div v-for="(block, index) in blocks" :key="block.id" class="mb-4">
          
          <div v-if="block.isEditing">
            
            <div class="d-flex justify-content-between align-items-center mb-2">
              <span class="badge bg-primary">{{ block.type === 'CourseDetailBlock' ? 'Información Principal' : block.type }}</span>
              <div>
                <button v-if="block.type !== 'CourseDetailBlock'" @click="removeBlock(index)" class="btn btn-sm btn-danger text-white">x</button>
              </div>
            </div>

            <div v-if="block.type === 'CourseDetailBlock'">
                <div class="p-3 bg-white border mb-3 shadow-sm rounded">
                    
                    <div class="row g-2 mb-3">
                        <div class="col-6">
                            <label class="small fw-bold text-muted">Categoría <span class="text-danger">*</span></label>
                            <select class="form-select form-select-sm" v-model="post.category_id">
                                <option value="" disabled>Seleccionar...</option>
                                <option v-for="cat in categories" :key="cat.id" :value="cat.id">{{ cat.name }}</option>
                            </select>
                        </div>
                        
                        <div class="col-6">
                            <label class="small fw-bold text-muted">Título <span class="text-danger">*</span></label>
                            <input v-model="post.title" class="form-control form-control-sm" placeholder="Título Principal">
                        </div>
                        
                        <div class="col-12">
                            <label class="small fw-bold text-muted">Tipo de Formación</label>
                            <select v-model="post.subtitle" class="form-control form-control-sm">
                                <option :value="null" disabled>Seleccione un tipo...</option>
                                <option value="Curso">Curso</option>
                                <option value="Diplomado">Diplomado</option>
                                <option value="Programa">Programa</option>
                            </select>
                        </div>
                        
                        <div class="col-4">
                            <label class="small fw-bold text-muted">Inicio</label>
                            <input v-model="post.start_date_display" class="form-control form-control-sm" placeholder="Ej: 20 Dic">
                        </div>
                        <div class="col-4">
                            <label class="small fw-bold text-muted">Duración</label>
                            <input v-model="block.content.duration" class="form-control form-control-sm" placeholder="Ej: 20 Horas">
                        </div>
                        <div class="col-4">
                            <label class="small fw-bold text-muted">Precio (S/.)</label>
                            <input v-model="post.price" type="number" class="form-control form-control-sm" placeholder="0.00">
                        </div>

                        <div class="col-6">
                            <label class="small fw-bold text-muted">Whatsapp #</label>
                            <input v-model="block.content.whatsappNumber" class="form-control form-control-sm" placeholder="51999...">
                        </div>
                        <div class="col-6">
                            <label class="small fw-bold text-muted">Texto Wsp</label>
                            <input v-model="block.content.whatsappDisplay" class="form-control form-control-sm" placeholder="Ej: Asesora María">
                        </div>

                        <div class="col-12">
                            <label class="small fw-bold text-muted">Horario</label>
                            <textarea v-model="block.content.schedule" class="form-control form-control-sm" rows="1"></textarea>
                        </div>
                        <div class="col-12 mt-3 border-top pt-3">
                            <label class="small fw-bold text-muted d-block mb-2">Brochure del Curso (PDF)</label>
                            
                            <div class="d-grid gap-2">
                                <input 
                                    type="file" 
                                    :id="'brochure-' + block.id" 
                                    class="d-none" 
                                    accept=".pdf" 
                                    @change="uploadBrochure($event, block.content)"
                                >
                                
                                <label 
                                    :for="'brochure-' + block.id" 
                                    class="btn btn-sm" 
                                    :class="block.content.brochureUrl ? 'btn-outline-success' : 'btn-outline-primary'"
                                    style="cursor: pointer"
                                >
                                    <i v-if="isUploadingBrochure" class="las la-spinner la-spin"></i>
                                    <i v-else :class="block.content.brochureUrl ? 'las la-check-circle' : 'las la-file-pdf'"></i>
                                    {{ isUploadingBrochure ? ' Subiendo...' : (block.content.brochureUrl ? ' Cambiar Brochure' : ' Subir Brochure PDF') }}
                                </label>

                                <div v-if="block.content.brochureUrl" class="d-flex align-items-center justify-content-between mt-1 p-2 bg-light rounded border">
                                    <span class="small text-truncate" style="max-width: 200px;">
                                        <i class="las la-file-pdf text-danger"></i> Brochure listo
                                    </span>
                                    <button @click="block.content.brochureUrl = ''" class="btn btn-sm text-danger p-0">
                                        <i class="las la-trash"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

               <div class="mb-3 border p-2 bg-white rounded shadow-sm rich-text-editor">
                    <label class="small fw-bold mb-2 d-block">Presentación</label>
                    <QuillEditor 
                        v-model:content="block.content.presentation" 
                        contentType="html" 
                        theme="snow"
                        :toolbar="['bold', 'italic', 'underline', 'link', { 'list': 'ordered'}, { 'list': 'bullet' }]"
                    />
                </div>
                <div class="mb-3 border p-2 bg-white rounded shadow-sm">
                    <label class="small fw-bold">Certificación</label>
                    <textarea v-model="block.content.certification" class="form-control font-monospace" rows="4"></textarea>
                </div>   
                <div class="row g-2 mb-3">
                    <div class="col-6" v-for="(label, key) in {
                        'objectives': 'Objetivos', 
                        'curriculum': 'Temario', 
                        'profile': 'Perfil', 
                        'benefits': 'Beneficios'
                    }" :key="key">
                        <div class="border p-2 rounded bg-white h-100 shadow-sm">
                            <label class="small fw-bold text-primary">{{ label }}</label>
                            
                            <div v-if="block.content[key]">
                                <div v-for="(item, i) in block.content[key]" :key="i" class="d-flex mb-1">
                                    <input v-model="block.content[key][i]" class="form-control form-control-sm me-1">
                                    <button @click="block.content[key].splice(i, 1)" class="btn btn-sm text-danger p-0 border px-2">x</button>
                                </div>
                            </div>
                            
                            <button 
                                @click="block.content[key] ? block.content[key].push('Nuevo Item') : block.content[key] = ['Nuevo Item']" 
                                class="btn btn-sm btn-light w-100 text-primary small mt-1"
                            >
                                + Agregar
                            </button>
                        </div>
                    </div>
                </div>
                <div class="row g-2 mb-3">
                    <div class="col-12" v-for="(label, key) in {
                        'importantNotes': 'Importante'
                    }" :key="key">
                        <div class="border p-2 rounded bg-white h-100 shadow-sm">
                            <label class="small fw-bold text-primary">{{ label }}</label>
                            
                            <div v-if="block.content[key]">
                                <div v-for="(item, i) in block.content[key]" :key="i" class="d-flex mb-1">
                                    <input v-model="block.content[key][i]" class="form-control form-control-sm me-1">
                                    <button @click="block.content[key].splice(i, 1)" class="btn btn-sm text-danger p-0 border px-2">x</button>
                                </div>
                            </div>
                            
                            <button 
                                @click="block.content[key] ? block.content[key].push('Nuevo Item') : block.content[key] = ['Nuevo Item']" 
                                class="btn btn-sm btn-light w-100 text-primary small mt-1"
                            >
                                + Agregar
                            </button>
                        </div>
                    </div>
                </div>
                <div class="border p-2 rounded bg-white shadow-sm">
                    <label class="small fw-bold">Docentes</label>
                    
                    <div v-if="block.content.teachers">
                        <div v-for="(teacher, i) in block.content.teachers" :key="i" class="border-bottom pb-2 mb-2">
                            <div class="d-flex gap-2 mb-1 align-items-start">
                                
                                <div class="position-relative">
                                    <img 
                                        :src="formatImageUrl(teacher.image)" 
                                        class="rounded-circle object-fit-cover border"
                                        width="50" 
                                        height="50" 
                                        alt="Foto docente"
                                    >
                                </div>

                                <div class="w-100">
                                    <div class="input-group input-group-sm mb-1">
                                        
                                        <button 
                                            @click="openMediaPicker(teacher, 'image')" 
                                            class="btn btn-outline-secondary form-control text-start text-truncate"
                                        >
                                            <i class="las la-image"></i> {{ teacher.image ? 'Cambiar' : 'Elegir Foto' }}
                                        </button>

                                        <button @click="block.content.teachers.splice(i, 1)" class="btn btn-outline-danger">
                                            <i class="las la-trash"></i>
                                        </button>
                                    </div>
                                    
                                    <input v-model="teacher.name" class="form-control form-control-sm mb-1" placeholder="Nombre">
                                    <input v-model="teacher.role" class="form-control form-control-sm mb-1" placeholder="Cargo">
                                </div>
                            </div>
                        </div>
                    </div>

                    <button 
                        @click="block.content.teachers ? block.content.teachers.push({name:'', role:'', image:''}) : block.content.teachers = [{name:'', role:'', image:''}]" 
                        class="btn btn-sm btn-primary w-100"
                    >
                        + Agregar Docente
                    </button>
                </div>

            </div> 
            </div> 
          <div v-else class="p-2 border rounded bg-white d-flex justify-content-between align-items-center cursor-pointer" @click="block.isEditing = true">
            <span class="fw-bold">{{ block.type === 'CourseDetailBlock' ? 'Información Principal' : block.type }}</span>
            <span class="text-muted small">Clic para editar</span>
          </div>

        </div> <div class="mt-4 pt-3 border-top sticky-bottom bg-light">
             <button @click="savePage" class="btn btn-success w-100 py-2 fw-bold" :disabled="saving">
                {{ saving ? 'GUARDANDO...' : 'GUARDAR CURSO' }}
             </button>
        </div>

      </div>
    </div>

    <div class="canvas flex-grow-1 bg-secondary bg-opacity-10 p-4" style="overflow-y: auto;">
        <component 
            v-for="block in blocks" 
            :key="block.id"
            :is="resolveBlockComponent(block.type)" 
            :data="block.content"
        />
    </div>
    <MediaSelector 
    :collection="'courses'"
    v-if="isMediaModalOpen" 
    @close="isMediaModalOpen = false" 
    />
  </div>
</template>

<script setup lang="ts">
import { watch, ref, onMounted } from 'vue';
import { useRoute } from 'vue-router';
import HttpClient from "@/helpers/http-client"; 
import Swal from "sweetalert2";
import { resolveBlock } from '@shared/core/BlockRegistry';

// --- NUEVAS IMPORTACIONES ---
import MediaSelector from '@/components/modals/MediaSelector.vue'; // Asegúrate de tener este componente
import { formatImageUrl } from '@/helpers/url'; // Tu helper de URLs
import { QuillEditor } from '@vueup/vue-quill'
import '@vueup/vue-quill/dist/vue-quill.snow.css';
const route = useRoute();

// --- ESTADO ---
const saving = ref(false);
// const pendingUploads... -> ELIMINADO (Ya no lo necesitamos)
const categories = ref<any[]>([]); 

// --- ESTADO PARA GALERÍA DE MEDIOS (NUEVO) ---
const isMediaModalOpen = ref(false);
const activeSelectionTarget = ref<{obj: any, key: string} | null>(null);

// Objeto GLOBAL del Curso (Mantenemos el tuyo intacto)
const post = ref<any>({
    id: null,
    title: '',
    slug: '',
    subtitle: '',
    category_id: '', 
    start_date_display: '', 
    price: 0,
    video_url: '',     
    type: 'course',    
    status: 'draft',   
    status_course: 'EN VENTA', 
    excerpt: '',
    start_date: '', 
    end_date: '',
    featured_image_path: '',
    brochure_path: '' 
});
// --- ESTADO ---
const isUploadingBrochure = ref(false);

// --- FUNCIÓN PARA SUBIR PDF ---
const uploadBrochure = async (event: any, targetContent: any) => {
    const file = event.target.files[0];
    if (!file) return;

    // 1. Obtener datos para el nombre dinámico
    const categoryName = categories.value.find(c => c.id == post.value.category_id)?.name || 'Especializacion';
    const courseTitle = post.value.title || 'Curso Sin Titulo';
    const courseSubtitle = post.value.subtitle || 'General';

    // 2. Pre-visualizar el nombre que se enviará (Slugificado conceptualmente)
    const previewName = `${categoryName} | ${courseSubtitle} en Especialización de ${courseTitle}`;
    
    // --- ALERTA DE PRUEBA ---
    await Swal.fire({
        title: 'Preparando archivo',
        html: `El archivo se guardará como:<br><b>${previewName}.pdf</b><br><br><small>Campo extra: "Texto X de prueba"</small>`,
        icon: 'info',
        confirmButtonText: 'Subir ahora'
    });

    const formData = new FormData();
    formData.append('file', file); // <--- El backend busca 'file'
    formData.append('custom_title', post.value.title); // <--- El backend busca 'custom_title'
    formData.append('custom_category', categoryName); 
    formData.append('custom_subtitle', post.value.subtitle);
    
    // CAMPO X: Ejemplo de cómo enviar cualquier otro dato al backend
    formData.append('extra_info', 'Este es el texto X de configuración'); 

    isUploadingBrochure.value = true;
    const toast = Swal.mixin({ toast: true, position: 'top-end', showConfirmButton: false });

    try {
        const { data } = await HttpClient.post('upload-media', formData);
        
        // Guardamos la URL para el previo y el ID para el link de descarga directa
        targetContent.brochureUrl = data.url; 
        targetContent.brochureId = data.media_item.id; // <--- AGREGAR ESTO
        
        toast.fire({ icon: 'success', title: 'Brochure subido' });
    } catch (e: any) {
        console.error(e);
        toast.fire({ icon: 'error', title: 'Error al subir: ' + (e.response?.data?.message || 'Error desconocido') });
    } finally {
        isUploadingBrochure.value = false;
        event.target.value = ''; 
    }
};

// Lista de bloques visuales
const blocks = ref<any[]>([]);

// --- 0. WATCHER: SINCRONIZACIÓN AUTOMÁTICA (INTACTO) ---
watch(() => post.value, (newVal) => {
    const detailBlock = blocks.value.find((b: any) => b.type === 'CourseDetailBlock');
    if (detailBlock && detailBlock.content) {
        detailBlock.content.title = newVal.title;
        detailBlock.content.subtitle = newVal.subtitle;
        detailBlock.content.price = newVal.price;
        detailBlock.content.startDate = newVal.start_date_display;

        const selectedCat = categories.value.find((c: any) => c.id == newVal.category_id);
        if (selectedCat) {
            detailBlock.content.category = selectedCat.name;
            detailBlock.content.categoryColor = selectedCat.color;
        }
    }
}, { deep: true });


// --- 1. CARGA DE DATOS (INTACTO) ---
onMounted(async () => {
    try {
        // A. Cargar Categorías
        try {
            const catRes = await HttpClient.get('categories'); 
            categories.value = catRes.data.data || catRes.data || [];
        } catch (err) {
            console.warn("Error cargando categorías, usando dummy");
            categories.value = [];
        }

        // B. Cargar Curso
        const response = await HttpClient.get(`courses/${route.params.slug}`); 
        const loadedPost = response.data.data || response.data;
        
        post.value = {
            id: loadedPost.id,
            title: loadedPost.title,
            slug: loadedPost.slug,
            subtitle: loadedPost.subtitle || '',
            category_id: loadedPost.category_id || (loadedPost.category ? loadedPost.category.id : '') || '',
            price: loadedPost.price || 0,
            start_date_display: loadedPost.start_date_display || loadedPost.start_date || '',
            video_url: loadedPost.video_url || '',
            type: 'course', 
            status: loadedPost.status || 'draft',
            status_course: loadedPost.status_course || 'EN VENTA', 
            excerpt: loadedPost.excerpt || '',
            featured_image_path: loadedPost.featured_image || ''
        };
        // C. Procesar Bloques
        let rawBlocks = loadedPost.content_blocks;
        if (rawBlocks) {
            let loaded = (typeof rawBlocks === 'string') ? JSON.parse(rawBlocks) : rawBlocks;
            if (Array.isArray(loaded)) {
                 blocks.value = loaded.map((b: any) => {
                    if(b.content) {
                        b.content.teachers = b.content.teachers || [];
                        b.content.benefits = b.content.benefits || [];
                        b.content.objectives = b.content.objectives || [];
                        b.content.curriculum = b.content.curriculum || [];
                    }
                    return { ...b, isEditing: false };
                });
            }
        }

        if (blocks.value.length === 0) {
        } else {
            blocks.value[0].isEditing = true; 
        }

    } catch (e) {
        console.error("Error cargando:", e);
        Swal.fire("Error", "No se pudo cargar el curso.", "error");
    }
});

// ==========================================
// 2. LÓGICA DE IMÁGENES (AQUÍ ESTÁ LA MEJORA)
// ==========================================

// A. Abrir Modal de Galería
const openMediaPicker = (targetObject: any, keyName: string) => {
    activeSelectionTarget.value = { obj: targetObject, key: keyName };
    isMediaModalOpen.value = true;
};

// B. Seleccionar desde Galería
const handleMediaSelected = (url: string) => {
    if (activeSelectionTarget.value) {
        const { obj, key } = activeSelectionTarget.value;
        obj[key] = url; // Asignación reactiva directa
    }
    isMediaModalOpen.value = false;
    activeSelectionTarget.value = null;
};

// C. Subida Directa (Input File) - REFACTORIZADO
// Ya no usa pendingUploads. Sube directo al servidor.
const handleImageUpload = async (event: any, targetObject: any, keyName: string) => {
    const file = event.target.files[0];
    if (!file) return;

    // Feedback visual rápido
    const toast = Swal.mixin({ toast: true, position: 'top-end', showConfirmButton: false });
    toast.fire({ icon: 'info', title: 'Subiendo...' });

    try {
        const formData = new FormData();
        formData.append('file', file); // Asegúrate que tu API espera 'file' o 'image'
        
        // Petición al backend
        const { data } = await HttpClient.post('upload-media', formData);
        
        // Asignación directa de la URL devuelta
        targetObject[keyName] = data.url; 
        
        toast.fire({ icon: 'success', title: 'Imagen lista', timer: 1000 });
    } catch (e) {
        console.error(e);
        toast.fire({ icon: 'error', title: 'Error al subir imagen' });
    } finally {
        event.target.value = ''; // Limpiar input
    }
};

// ==========================================
// 3. GUARDAR CURSO (MODIFICADO LIGERAMENTE)
// ==========================================
const savePage = async () => {
    saving.value = true;
    const toast = Swal.mixin({ toast: true, position: 'top-end', showConfirmButton: false });

    try {
        // --- ELIMINADO: Bloque "Subir imágenes pendientes" ---
        // Como ahora subimos al instante con handleImageUpload, esto ya no hace falta.

        // B. Preparar Datos
        const cleanBlocks = blocks.value.map(({ isEditing, ...rest }) => rest);
        
        const dataToSend = {
            title: post.value.title || 'Sin Título',
            slug: post.value.slug,
            subtitle: post.value.subtitle || '',
            category_id: post.value.category_id,
            price: post.value.price || 0,
            start_date: post.value.start_date_display,
            type: 'course',
            content_blocks: cleanBlocks 
        };

        const identifier = post.value.id || route.params.slug;

        // C. Enviamos la petición
        await HttpClient.put(`courses/${identifier}`, dataToSend);
        
        toast.fire({ icon: 'success', title: '¡Guardado correctamente!', timer: 2000 });

    } catch (e: any) {
        console.error("Error al guardar:", e);

        // Manejo de errores (Intacto)
        if (e.response && e.response.status === 422) {
            const errores = e.response.data.errors;
            let mensajeError = "";
            if (errores) {
                Object.keys(errores).forEach(key => {
                    mensajeError += `• ${errores[key][0]}\n`;
                });
            }
            Swal.fire({
                icon: 'warning',
                title: 'Faltan datos obligatorios',
                html: `<pre style="text-align:left; font-family:sans-serif">${mensajeError}</pre>`
            });
        } else {
            Swal.fire("Error", "Ocurrió un error inesperado.", "error");
        }
    } finally {
        saving.value = false;
    }
};

// --- 4. UTILIDADES DE BLOQUES (INTACTO) ---
const resolveBlockComponent = (type: string) => resolveBlock(type);



const removeBlock = (i: number) => { 
    if(confirm('¿Seguro de borrar este bloque?')) blocks.value.splice(i, 1);
};
</script>

<style scoped>
.editor-sidebar { height: 100vh; overflow-y: auto; }
.canvas { height: 100vh; overflow-y: auto; position: relative; }
.cursor-pointer { cursor: pointer; }
</style>