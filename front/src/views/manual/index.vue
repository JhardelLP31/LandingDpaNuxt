<template>
    <b-row class="justify-content-center">
        <b-col cols="12">
            <b-card no-body shadow class="border-0">
                <b-card-header class="bg-white border-bottom py-3">
                    <b-row class="align-items-center justify-content-between">
                        <b-col lg="3">
                            <h4 class="m-0 fw-bold text-dark">📚 Gestión de Manuales</h4>
                        </b-col>
                        <b-col lg="4">
                            <b-input-group size="sm">
                                <b-form-input v-model="searchQuery" placeholder="Buscar manual..."
                                    @keyup.enter="list(1)" />
                                <b-button variant="primary" @click="list(1)">
                                    <i class="las la-search"></i>
                                </b-button>
                            </b-input-group>
                        </b-col>
                        <b-col lg="2" class="text-end">
                            <b-button variant="primary" class="px-3 shadow-sm" @click="openModal()">
                                <i class="las la-plus-circle me-1 fs-18"></i> Nuevo Manual
                            </b-button>
                        </b-col>

                    </b-row>
                </b-card-header>
                <b-card-body class="pt-0">
                    <div class="table-responsive" v-if="manual_list.length > 0">
                        <table class="table datatable align-middle table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th class="border-0">Id</th>
                                    <th class="border-0" style="width: 35%;">Manual</th>
                                    <th class="border-0">Categoría</th>
                                    <th class="border-0">Estado</th>
                                    <th class="border-0 text-end">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="item in manual_list" :key="item.id">
                                    <td><span class="text-muted fw-bold">#{{ item.id }}</span></td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <div class="bg-light rounded me-3 d-flex align-items-center justify-content-center shadow-sm"
                                                style="width: 48px; height: 48px; overflow: hidden;">
                                                <img v-if="item.image_path" :src="formatImageUrl(item.image_path)"
                                                    class="img-fluid"
                                                    style="object-fit: cover; height: 100%; width: 100%;" />
                                                <i v-else class="las la-book fs-24 text-secondary"></i>
                                            </div>
                                            <div>
                                                <h6 class="m-0 text-dark fw-bold">{{ item.title }}</h6>
                                                <small class="text-muted text-truncate d-block"
                                                    style="max-width: 200px;">/{{ item.slug }}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <b-badge v-if="item.category" pill
                                            :style="{ backgroundColor: '#' + item.category.color, color: '#fff', padding: '5px 12px' }">
                                            {{ item.category.name }}
                                        </b-badge>
                                        <span v-else class="text-muted small">Sin categoría</span>
                                    </td>
                                    <td>
                                        <b-badge pill :variant="item.status === 'published' ? 'success' : 'warning'"
                                            class="text-uppercase px-2" style="font-size: 10px;">
                                            <i class="las la-circle me-1"></i>
                                            {{ item.status === 'published' ? 'Publicado' : 'Borrador' }}
                                        </b-badge>
                                    </td>
                                    <td class="text-end">
                                        <div class="d-flex justify-content-end gap-1">
                                            <b-button variant="outline-info" size="sm" @click="openPreviewDetail(item)"
                                                title="Vista Previa">
                                                <i class="las la-eye fs-18"></i>
                                            </b-button>
                                            <b-button variant="outline-primary" size="sm" @click="editManual(item)"
                                                title="Editar">
                                                <i class="las la-pen fs-18"></i>
                                            </b-button>
                                            <b-button variant="outline-danger" size="sm" @click="destroy(item)"
                                                title="Eliminar">
                                                <i class="las la-trash fs-18"></i>
                                            </b-button>
                                        </div>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        <div class="mt-3 d-flex justify-content-center">
                            <b-pagination v-model="currentPage" :total-rows="totalRows" :per-page="perPage"
                                @update:model-value="list"></b-pagination>
                        </div>
                    </div>
                    <div v-else class="text-center py-5">
                        <i class="las la-folder-open fs-60 text-muted mb-3 d-block"></i>
                        <h5 class="text-muted">No se encontraron manuales registrados</h5>
                    </div>
                </b-card-body>
            </b-card>
        </b-col>
    </b-row>

    <b-modal v-model="ModalRegister" :title="manual_selected ? '✏️ Editar Manual' : '📘 Nuevo Manual'" size="xl"
        hide-footer centered no-close-on-backdrop header-class="border-bottom-0 pt-4 px-4" body-class="pt-0 px-4 pb-4">

        <b-row>
            <b-col lg="7" class="border-end mt-4 pe-lg-4">
                <div class="mb-4">
                    <h5 class="mb-3 text-primary d-flex align-items-center">
                        <i class="las la-info-circle me-2"></i> Información Principal
                    </h5>
                    <b-row>
                        <b-col lg="12" class="mb-3">
                            <label class="form-label fw-bold text-dark">Título del Manual <span
                                    class="text-danger">*</span></label>
                            <b-form-input v-model="form.title" placeholder="Ej: Manual de Configuración Router X"
                                class="form-control-lg" />
                            <small class="text-danger" v-if="errors.title">{{ errors.title[0] }}</small>
                        </b-col>

                        <b-col lg="12" class="mb-3">
                            <label class="form-label fw-bold text-muted">Descripción o Contenido</label>
                            <b-form-textarea v-model="form.description" rows="6"
                                placeholder="Escribe aquí los detalles o instrucciones..." />
                        </b-col>

                        <b-col lg="12" class="mb-3">
                            <div class="bg-light p-3 rounded-3 border border-dashed">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <h6 class="text-dark fw-bold m-0">
                                        <i class="las la-file-pdf text-danger fs-20 me-1"></i> Documentos PDF para
                                        Descarga
                                    </h6>
                                    <b-button size="sm" variant="dark" @click="addDownloadLink" class="rounded-pill">
                                        <i class="las la-plus me-1"></i> Agregar Archivo
                                    </b-button>
                                </div>

                                <div v-for="(link, index) in form.download_links" :key="index"
                                    class="p-2 border rounded-3 mb-2 bg-white shadow-sm border-start-4"
                                    style="border-left: 4px solid #f0643b !important;">
                                    <b-row class="align-items-center g-2">
                                        <b-col md="4">
                                            <b-form-input v-model="link.label" placeholder="Nombre (Ej: Guía Técnica)"
                                                size="sm" />
                                        </b-col>
                                        <b-col md="6">
                                            <b-input-group size="sm">
                                                <b-form-input v-model="link.url" placeholder="Subir archivo..." readonly
                                                    class="bg-light" />
                                                <template #append>
                                                    <input type="file" :id="'file-' + index" class="d-none"
                                                        accept=".pdf" @change="uploadBrochure($event, link)" />

                                                    <b-button variant="success" @click="triggerUpload(index)"
                                                        :disabled="isUploading" v-b-tooltip.hover title="Subir PDF">
                                                        <i class="las la-cloud-upload-alt"></i>
                                                    </b-button>

                                                    <b-button variant="info" @click="viewPdf(link.url)"
                                                        :disabled="!link.url" v-b-tooltip.hover title="Abrir PDF">
                                                        <i class="las la-external-link-alt text-white"></i>
                                                    </b-button>
                                                </template>
                                            </b-input-group>
                                        </b-col>
                                        <b-col md="2" class="text-end">
                                            <b-button variant="soft-danger" size="sm" @click="removeDownloadLink(index)"
                                                class="rounded-circle">
                                                <i class="las la-trash fs-16"></i>
                                            </b-button>
                                        </b-col>
                                    </b-row>
                                </div>
                                <div v-if="form.download_links.length === 0" class="text-center py-2">
                                    <small class="text-muted italic">No hay archivos adjuntos</small>
                                </div>
                                <div v-if="isUploading" class="mt-2">
                                    <b-progress :value="100" variant="success" animated height="4px"></b-progress>
                                    <small class="text-success fw-bold">Subiendo archivo, por favor espere...</small>
                                </div>
                            </div>
                        </b-col>
                    </b-row>
                </div>
            </b-col>

            <b-col lg="5" class="ps-lg-4 mt-4">
                <div class="mb-4">
                    <h5 class="mb-3 text-success d-flex align-items-center">
                        <i class="las la-cog me-2"></i> Configuración y SEO
                    </h5>

                    <b-row>
                        <b-col lg="12" class="mb-3">
                            <label class="form-label fw-bold">URL Amigable (Slug) <span
                                    class="text-danger">*</span></label>
                            <b-input-group>
                                <b-form-input v-model="form.slug" class="bg-light" />
                                <b-button variant="outline-secondary" @click="regenerateSlug">
                                    <i class="las la-sync"></i>
                                </b-button>
                            </b-input-group>
                            <small class="text-danger" v-if="errors.slug">{{ errors.slug[0] }}</small>
                        </b-col>

                        <b-col lg="6" class="mb-3">
                            <label class="form-label fw-bold">Categoría</label>
                            <b-form-select v-model="form.category_id" class="form-select">
                                <option :value="null">Seleccione...</option>
                                <option v-for="cat in categories_list" :key="cat.id" :value="cat.id">{{ cat.name }}
                                </option>
                            </b-form-select>
                        </b-col>

                        <b-col lg="6" class="mb-3">
                            <label class="form-label fw-bold">Estado</label>
                            <b-form-select v-model="form.status" class="form-select">
                                <option value="published">Publicado</option>
                                <option value="draft">Borrador</option>
                            </b-form-select>
                        </b-col>

                        <b-col lg="12" class="mb-4">
                            <label class="form-label fw-bold">Imagen de Portada</label>
                            <div class="border-2 border-dashed rounded-3 p-2 bg-light text-center position-relative"
                                style="min-height: 180px;">
                                <img v-if="IMAGEN_PREVIZUALIZA" :src="IMAGEN_PREVIZUALIZA"
                                    class="img-fluid rounded shadow-sm mb-2"
                                    style="max-height: 160px; width: 100%; object-fit: cover;" />
                                <div v-else class="py-4">
                                    <i class="las la-image fs-60 text-muted"></i>
                                    <p class="small text-muted mb-0">No hay imagen seleccionada</p>
                                </div>
                                <b-button variant="primary" size="sm" class="w-100 mt-2 rounded-pill shadow-sm"
                                    @click="isMediaModalOpen = true">
                                    <i class="las la-photo-video me-1"></i> Seleccionar de Galería
                                </b-button>
                            </div>
                        </b-col>

                        <b-col lg="12">
                            <div class="bg-soft-info p-3 rounded-3">
                                <label class="form-label fw-bold text-info"><i class="las la-search me-1"></i> SEO
                                    Básico</label>
                                <div class="mb-2">
                                    <small class="fw-bold text-dark">SEO Title</small>
                                    <b-form-input v-model="form.seo_title" size="sm"
                                        placeholder="Título para buscadores" />
                                </div>
                                <div>
                                    <small class="fw-bold text-dark">SEO Description</small>
                                    <b-form-textarea v-model="form.seo_description" rows="2" size="sm"
                                        placeholder="Resumen breve para Google..." />
                                </div>
                            </div>
                        </b-col>
                    </b-row>
                </div>
            </b-col>

            <b-col lg="12" class="text-end mt-2 pt-3 border-top d-flex justify-content-end gap-2">
                <b-button variant="light" class="px-4 fw-bold" @click="ModalRegister = false">Cancelar</b-button>
                <b-button variant="primary" @click="store" :disabled="loading" class="px-5 fw-bold shadow">
                    <span v-if="loading" class="spinner-border spinner-border-sm me-2"></span>
                    {{ manual_selected ? 'Actualizar Manual' : 'Guardar Manual' }}
                </b-button>
            </b-col>
        </b-row>
    </b-modal>

    <MediaSelector :collection="'manuals'" v-if="isMediaModalOpen" @close="isMediaModalOpen = false"
        @select="handleMediaSelected" />

    <CoursePreviewModal v-model="ModalPreviewDetail" :course="previewDataDetail" />
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, watch } from "vue";
import HttpClient from "@/helpers/http-client";
import { formatImageUrl } from "@/helpers/url";
import Swal from "sweetalert2";
import MediaSelector from "@/components/modals/MediaSelector.vue";
import CoursePreviewModal from "@/components/modals/CoursePreviewModal.vue";

// --- REFERENCIAS ---
const loading = ref(false);
const isUploading = ref(false);
const manual_list = ref<any[]>([]);
const categories_list = ref<any[]>([]);
const ModalRegister = ref(false);
const ModalPreviewDetail = ref(false);
const previewDataDetail = ref<any>(null);
const isMediaModalOpen = ref(false);
const manual_selected = ref<any>(null);
const IMAGEN_PREVIZUALIZA = ref<string | null>(null);
const errors = ref<any>({});
const currentPage = ref(1);
const totalRows = ref(0);
const perPage = ref(10);
const searchQuery = ref("");
const categoryFilter = ref(null);
// --- FORMULARIO ---
const form = reactive({
    id: null,
    user_id: 1,
    category_id: null as number | null,
    title: "",
    slug: "",
    description: "",
    image_path: null as string | null,
    download_links: [] as any[],
    status: "published",
    seo_title: "",
    seo_description: "",
});

// --- LÓGICA DE PDFS ---
const addDownloadLink = () => {
    form.download_links.push({ label: '', url: '', brochureId: null });
};

const removeDownloadLink = (index: number) => {
    form.download_links.splice(index, 1);
};

const triggerUpload = (index: number) => {
    document.getElementById(`file-${index}`)?.click();
};

const viewPdf = (url: string) => {
    if (url) window.open(url, '_blank');
};

const uploadBrochure = async (event: any, targetContent: any) => {
    const file = event.target.files[0];
    if (!file) return;

    const categoryObj = categories_list.value.find(c => c.id == form.category_id);
    const categoryName = categoryObj ? categoryObj.name : 'General';
    const manualTitle = form.title || 'Manual';

    const formData = new FormData();
    formData.append('file', file);
    formData.append('custom_title', manualTitle);
    formData.append('custom_category', categoryName);

    isUploading.value = true;
    try {
        const { data } = await HttpClient.post('upload-media', formData);
        targetContent.url = data.url;
        targetContent.brochureId = data.media_item.id;
        if (!targetContent.label) targetContent.label = "Descargar Documento";

        Swal.fire({ icon: 'success', title: 'Archivo subido', timer: 1000, showConfirmButton: false, toast: true, position: 'top-end' });
    } catch (e: any) {
        Swal.fire("Error", "No se pudo subir el archivo", "error");
    } finally {
        isUploading.value = false;
        event.target.value = '';
    }
};

// --- CRUD ---
const list = async (page = 1) => {
    loading.value = true;
    try {
        const res = await HttpClient.get("manuals", {
            params: {
                page: page,
                search: searchQuery.value,
                category_id: categoryFilter.value
            }
        });

        // Tu backend devuelve: { total, manual: { data: [...] }, categories }
        if (res.data) {
            manual_list.value = res.data.manual.data || res.data.manual;
            totalRows.value = res.data.total;
            currentPage.value = page;
        }
    } catch (e) {
        console.error("Error cargando manuales:", e);
    } finally {
        loading.value = false;
    }
};
const store = async () => {
    loading.value = true;
    errors.value = {};
    try {
        const url = manual_selected.value ? `manuals/${manual_selected.value.id}` : "manuals";
        const method = manual_selected.value ? 'put' : 'post';

        await HttpClient[method](url, form);

        Swal.fire({ icon: 'success', title: '¡Hecho!', text: 'El manual se guardó correctamente', timer: 2000 });
        ModalRegister.value = false;
        list();
    } catch (e: any) {
        console.error("ERROR COMPLETO:", e.response); // Esto imprimirá el error en la consola
        if (e.response?.status === 422) {
            errors.value = e.response.data.errors;
        } else {
            // Esto te mostrará el mensaje real de Laravel en el alert
            const message = e.response?.data?.message || "Error desconocido";
            Swal.fire("Error 500", message, "error");
        }
    } finally {
        loading.value = false;
    }
};

const editManual = (item: any) => {
    manual_selected.value = item;
    errors.value = {};
    Object.assign(form, {
        ...item,
        download_links: typeof item.download_links === 'string' ? JSON.parse(item.download_links) : (item.download_links || [])
    });
    IMAGEN_PREVIZUALIZA.value = formatImageUrl(item.image_path);
    ModalRegister.value = true;
};

const destroy = (item: any) => {
    Swal.fire({
        title: '¿Estás seguro?',
        text: "El manual se eliminará permanentemente",
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#ef4444',
        confirmButtonText: 'Sí, eliminar',
        cancelButtonText: 'Cancelar'
    }).then(async (result) => {
        if (result.isConfirmed) {
            await HttpClient.delete(`manuals/${item.id}`);
            list();
            Swal.fire('Eliminado', 'El registro ha sido borrado', 'success');
        }
    });
};

// --- UTILS ---
const openModal = () => {
    manual_selected.value = null;
    resetForm();
    ModalRegister.value = true;
};

const resetForm = () => {
    errors.value = {};
    Object.assign(form, {
        id: null, user_id: 1, category_id: null, title: "", slug: "",
        description: "", image_path: null, download_links: [],
        status: "published", seo_title: "", seo_description: "",
    });
    IMAGEN_PREVIZUALIZA.value = null;
};

const handleMediaSelected = (path: string) => {
    form.image_path = path;
    IMAGEN_PREVIZUALIZA.value = formatImageUrl(path);
    isMediaModalOpen.value = false;
};

const openPreviewDetail = (item: any) => {
    previewDataDetail.value = item;
    ModalPreviewDetail.value = true;
};

const slugify = (text: string) => {
    return text.toString().toLowerCase().trim().replace(/\s+/g, '-').replace(/[^\w\-]+/g, '').replace(/\-\-+/g, '-');
};

const regenerateSlug = () => { form.slug = slugify(form.title); };

watch(() => form.title, (val) => {
    if (!manual_selected.value) {
        form.slug = slugify(val);
        form.seo_title = val;
    }
});

onMounted(() => {
    HttpClient.get("categories?type=manual").then(res => categories_list.value = res.data.data || res.data);
    list();
});
</script>

<style scoped>
.border-dashed {
    border-style: dashed !important;
}

.border-start-4 {
    border-left-width: 4px !important;
}

.bg-soft-info {
    background-color: rgba(53, 163, 242, 0.1);
}

.thumb-md {
    object-fit: cover;
}

.fs-18 {
    font-size: 18px;
}

.fs-20 {
    font-size: 20px;
}

.fs-60 {
    font-size: 60px;
}
</style>