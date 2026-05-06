<template>
    <b-row class="justify-content-center">
        <b-col cols="12">
            <b-card no-body>
                <b-card-header>
                    <b-row class="align-items-center justify-content-between">
                        <b-col lg="3">
                            <b-card-title>🎓 Gestión de Cursos</b-card-title>
                        </b-col>
                        <b-col lg="2" class="text-end">
                            <b-button variant="primary" @click="openModal()">
                                <i class="far fa-plus-square me-2"></i> Nuevo Curso
                            </b-button>
                        </b-col>
                    </b-row>
                </b-card-header>
                <b-card-body class="pt-0">
                    <div class="table-responsive" v-if="course_list.length > 0">
                        <table class="table datatable align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Id</th>
                                    <th style="width: 35%;">Curso</th>
                                    <th>Categoría</th>
                                    <th>Estado</th>
                                    <th class="text-end">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="course in course_list" :key="course.id">
                                    <td>{{ course.id }}</td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img :src="formatImageUrl(course.image_path || course.image_url)"
                                                class="thumb-md rounded me-2"
                                                style="width: 40px; height: 40px; object-fit: cover;" />
                                            <div>
                                                <h6 class="m-0">{{ course.title }}</h6>
                                                <small class="text-muted text-truncate d-block"
                                                    style="max-width: 200px;">/{{ course.slug }}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <b-badge v-if="course.category"
                                            :style="{ backgroundColor: '#' + course.category.color }">
                                            {{ course.category.name }}
                                        </b-badge>
                                    </td>
                                    <td>
                                        <b-badge :variant="course.status === 'published' ? 'success' : 'warning'">
                                            {{ course.status === 'published' ? 'PUBLICADO' : 'BORRADOR' }}
                                        </b-badge>
                                    </td>
                                    <td class="text-end">
                                        <b-button variant="outline-info" size="sm" class="me-1"
                                            @click="openPreviewDetail(course)" title="Vista Previa">
                                            <i class="las la-eye fs-18"></i>
                                        </b-button>

                                        <b-button variant="outline-primary" size="sm" class="me-1"
                                            @click="editCourse(course)" title="Editar Configuración">
                                            <i class="las la-pen fs-18"></i>
                                        </b-button>

                                        <b-button variant="outline-danger" size="sm" @click="destroy(course)"
                                            title="Eliminar Curso">
                                            <i class="las la-trash fs-18"></i>
                                        </b-button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div class="mt-3 d-flex justify-content-between align-items-center" v-if="totalRows > 0">
                        <small class="text-muted">
                            Mostrando {{ course_list.length }} resultados de {{ totalRows }}
                        </small>
                        <b-pagination
                            v-model="currentPage"
                            :total-rows="totalRows"
                            :per-page="perPage"
                            @update:model-value="list" 
                            align="end"
                            size="sm"
                            class="my-0"
                        ></b-pagination>
                    </div>

                    <div v-if="!loading && course_list.length === 0" class="text-center py-4">
                        <p class="text-muted">No se encontraron cursos.</p>
                    </div>
                </b-card-body>
            </b-card>
        </b-col>
    </b-row>

    <b-modal v-model="ModalRegisterPost" :title="course_selected ? 'Editar Curso' : 'Nuevo Curso'" size="xl"
        hide-footer centered>
        <b-row>
            <b-col lg="7" class="border-end pe-4">
                <h5 class="mb-3 text-primary border-bottom pb-2">Información Principal</h5>
                <b-row>
                    <b-col lg="12" class="mb-3">
                        <label class="fw-bold text-dark">Título del Curso *</label>
                        <b-form-input v-model="form.title" placeholder="Ej: Especialización en Civil 3D" autofocus />
                    </b-col>
                    <b-col lg="12" class="mb-3">
                        <label class="fw-bold text-muted">Subtítulo</label>
                        <b-form-input v-model="form.subtitle" />
                    </b-col>
                    <b-col lg="12" class="mb-3">
                        <label class="fw-bold text-muted">Descripción (General)</label>
                        <b-form-textarea v-model="form.description" rows="4" />
                    </b-col>
                    <b-col lg="12" class="mb-3">
                        <label class="fw-bold text-muted"><i class="lab la-youtube text-danger"></i> Video URL</label>
                        <b-form-input v-model="form.video_url" placeholder="https://youtube.com/..." />
                    </b-col>

                    <b-col lg="12" class="mb-3 text-muted bg-light p-3 rounded border">
                        <h6 class="text-dark fw-bold mb-3"><i class="las la-cubes"></i> Bloques de Contenido</h6>
                        <b-row>
                            <b-col lg="12" class="mb-2">
                                <label class="small fw-bold">Ventajas Competitivas</label>
                                <b-form-textarea v-model="form.content_blocks.ventajas" rows="2" />
                            </b-col>
                            <b-col lg="6" class="mb-2">
                                <label class="small fw-bold">Aplicación Práctica</label>
                                <b-form-textarea v-model="form.content_blocks.aplicacion" rows="2" />
                            </b-col>
                            <b-col lg="6" class="mb-2">
                                <label class="small fw-bold">Software / Laboratorios</label>
                                <b-form-textarea v-model="form.content_blocks.laboratorios" rows="2" />
                            </b-col>
                        </b-row>
                    </b-col>
                </b-row>
            </b-col>

            <b-col lg="5" class="ps-4">
                <h5 class="mb-3 text-success border-bottom pb-2">SEO y Configuración</h5>
                <b-row>
                    <b-col lg="12" class="mb-3">
                        <label class="fw-bold text-dark">Unidad Académica *</label>
                        <b-form-select v-model="form.academic_unit_id">
                            <option :value="null">Seleccione una unidad...</option>
                            <option v-for="unit in academic_units_list" :key="unit.id" :value="unit.id">
                                {{ unit.name }}
                            </option>
                        </b-form-select>
                        <small class="text-danger" v-if="errors.academic_unit_id">{{ errors.academic_unit_id[0] }}</small>
                    </b-col>

                    <b-col lg="12" class="mb-3">
                        <label class="fw-bold text-dark">URL Amigable (Slug) *</label>
                        <b-input-group prepend=".../cursos/">
                            <b-form-input v-model="form.slug" />
                            <b-button variant="outline-secondary" @click="regenerateSlug">
                                <i class="las la-sync"></i>
                            </b-button>
                        </b-input-group>
                        <small class="text-danger" v-if="errors.slug">{{ errors.slug[0] }}</small>
                    </b-col>

                    <b-col lg="6" class="mb-3">
                        <label class="fw-bold text-muted">Categoría</label>
                        <b-form-select v-model="form.category_id">
                            <option :value="null">Seleccione...</option>
                            <option v-for="cat in categories_list" :key="cat.id" :value="cat.id">{{ cat.name }}</option>
                        </b-form-select>
                    </b-col>
                    <b-col lg="6" class="mb-3">
                        <label class="fw-bold text-muted">Estado</label>
                        <b-form-select v-model="form.status">
                            <option value="draft">Borrador</option>
                            <option value="published">Publicado</option>
                            <option value="archived">Archivado</option>
                        </b-form-select>
                    </b-col>

                    <b-col lg="12" class="mb-3">
                        <label class="fw-bold text-muted">SEO Title</label>
                        <b-form-input v-model="form.seo_title" />
                    </b-col>
                    <b-col lg="12" class="mb-3">
                        <label class="fw-bold text-muted">SEO Description</label>
                        <b-form-textarea v-model="form.excerpt" rows="3" />
                    </b-col>

                    <b-col lg="12" class="mb-3">
                        <label class="fw-bold text-muted mb-2">Imagen de Portada</label>
                        <div class="border rounded p-3 bg-light text-center">
                            <img v-if="IMAGEN_PREVIZUALIZA" :src="IMAGEN_PREVIZUALIZA"
                                class="img-fluid mb-2 rounded shadow-sm" style="max-height: 140px;" />
                            <b-button variant="outline-primary" size="sm" class="w-100 mt-2"
                                @click="showMediaModal = true">
                                <i class="las la-image"></i> {{ form.image_path ? 'Cambiar Imagen' : 'Seleccionar Imagen' }}
                            </b-button>
                        </div>
                    </b-col>
                </b-row>
            </b-col>

            <b-col lg="12" class="text-end mt-3 border-top pt-3 bg-white sticky-bottom">
                <b-button variant="secondary" class="me-2" @click="ModalRegisterPost = false">Cancelar</b-button>
                <b-button variant="primary" @click="store" :disabled="loading" size="lg" class="px-4">
                    <span v-if="loading" class="spinner-border spinner-border-sm me-1"></span>
                    {{ course_selected ? 'Actualizar' : 'Guardar' }}
                </b-button>
            </b-col>
        </b-row>
    </b-modal>

    <MediaSelector 
        v-if="showMediaModal" 
        :academicUnitId="form.academic_unit_id"
        :collection="'courses'"
        @select="handleMediaSelected" 
        @close="showMediaModal = false" 
    />

    <CoursePreviewModal v-model="ModalPreviewDetail" :course="previewDataDetail" />
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, watch } from "vue";
import HttpClient from "@/helpers/http-client";
import { formatImageUrl } from "@/helpers/url";
import Swal from "sweetalert2";
// IMPORTANTE: Ajusta la ruta según tu estructura
import MediaSelector from "@shared/components/modals/MediaSelector.vue";
import CoursePreviewModal from "@/components/modals/CoursePreviewModal.vue";

// --- ESTADO ---
const loading = ref(false);
const course_list = ref<any[]>([]);
const categories_list = ref<any[]>([]);
const academic_units_list = ref<any[]>([]); // Para el selector de unidades
const errors = ref<any>({});

// Modales
const ModalRegisterPost = ref(false);
const ModalPreviewDetail = ref(false);
const showMediaModal = ref(false);

// Selección y Previsualización
const course_selected = ref<any>(null);
const previewDataDetail = ref<any>(null);
const IMAGEN_PREVIZUALIZA = ref<string | null>(null);

// --- VARIABLES DE PAGINACIÓN ---
const currentPage = ref(1);
const totalRows = ref(0);
const perPage = ref(10);

const form = reactive({
    title: "", 
    slug: "", 
    subtitle: "", 
    excerpt: "", 
    description: "", 
    video_url: "",
    category_id: null as number | null, 
    academic_unit_id: null as number | null, // Campo para MediaSelector
    status: "published", 
    image_path: null as string | null,
    seo_title: "", 
    seo_description: "",
    content_blocks: { ventajas: "", aplicacion: "", laboratorios: "Todos." } as any,
    user_id: 1
});

// --- MÉTODOS ---

const list = async (page: number = 1) => {
    loading.value = true;
    try {
        const res = await HttpClient.get(`courses?page=${page}`);
        course_list.value = res.data.data;

        if (res.data.meta) {
            totalRows.value = res.data.meta.total;
            currentPage.value = res.data.meta.current_page;
            perPage.value = res.data.meta.per_page;
        } else {
            totalRows.value = res.data.total;
            currentPage.value = res.data.current_page;
        }
    } catch (e) {
        console.error("Error al cargar cursos:", e);
    } finally {
        loading.value = false;
    }
};

const store = async () => {
    loading.value = true;
    errors.value = {};
    try {
        if (!form.seo_description) form.seo_description = form.excerpt;
        const url = course_selected.value ? `courses/${course_selected.value.id}` : "courses";

        if (course_selected.value) await HttpClient.put(url, form);
        else await HttpClient.post(url, form);

        Swal.fire({ icon: 'success', title: 'Guardado correctamente', timer: 1500, showConfirmButton: false });
        ModalRegisterPost.value = false;
        list(currentPage.value);
    } catch (e: any) {
        if (e.response && e.response.status === 422) {
            errors.value = e.response.data.errors;
            Swal.fire("Error de Validación", "Revisa los campos requeridos.", "warning");
        } else {
            Swal.fire("Error", "Ocurrió un error inesperado.", "error");
        }
    } finally {
        loading.value = false;
    }
};

const destroy = (course: any) => {
    Swal.fire({
        title: '¿Estás seguro?',
        text: `Eliminarás: "${course.title}".`,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#d33',
        confirmButtonText: 'Sí, eliminar',
        cancelButtonText: 'Cancelar'
    }).then(async (result) => {
        if (result.isConfirmed) {
            try {
                await HttpClient.delete(`courses/${course.id}`);
                Swal.fire('Eliminado!', 'El curso ha sido borrado.', 'success');
                list(currentPage.value);
            } catch (e) {
                Swal.fire('Error', 'No se pudo eliminar.', 'error');
            }
        }
    });
};

const editCourse = (course: any) => {
    course_selected.value = course;
    errors.value = {};
    const blocks = course.content_blocks || {};

    Object.assign(form, {
        ...course,
        video_url: course.video_url || "",
        academic_unit_id: course.academic_unit_id || null, // Mapeamos el ID de la unidad
        content_blocks: {
            ventajas: blocks.ventajas || "",
            aplicacion: blocks.aplicacion || "",
            laboratorios: blocks.laboratorios || ""
        }
    });

    IMAGEN_PREVIZUALIZA.value = formatImageUrl(course.image_path);
    ModalRegisterPost.value = true;
};

const openPreviewDetail = (course: any) => {
    previewDataDetail.value = course;
    ModalPreviewDetail.value = true;
};

const openModal = () => {
    course_selected.value = null;
    resetForm();
    ModalRegisterPost.value = true;
};

const resetForm = () => {
    errors.value = {};
    Object.assign(form, {
        title: "", slug: "", subtitle: "", excerpt: "", description: "", video_url: "",
        category_id: null, academic_unit_id: null, status: "draft", image_path: null,
        seo_title: "", seo_description: "",
        content_blocks: { ventajas: "", aplicacion: "", laboratorios: "" }
    });
    IMAGEN_PREVIZUALIZA.value = null;
};

// Actualizado para recibir el objeto {id, url} del MediaSelector
const handleMediaSelected = (payload: { id: number, url: string }) => {
    form.image_path = payload.url;
    IMAGEN_PREVIZUALIZA.value = payload.url;
    showMediaModal.value = false;
};

const slugify = (text: string) => {
    return text.toString().toLowerCase()
        .replace(/\s+/g, '-')
        .replace(/[^\w\-]+/g, '')
        .replace(/\-\-+/g, '-')
        .replace(/^-+/, '')
        .replace(/-+$/, '');
};

const regenerateSlug = () => { form.slug = slugify(form.title); };

watch(() => form.title, (val) => {
    if (!course_selected.value) { 
        form.slug = slugify(val); 
        form.seo_title = val; 
    }
});

watch(() => form.description, (val) => {
    if (!course_selected.value && val) { 
        form.excerpt = val.length > 160 ? val.substring(0, 157) + '...' : val; 
        form.seo_description = form.excerpt; 
    }
});

onMounted(() => {
    // Carga de categorías
    HttpClient.get("categories?type=course").then(res => categories_list.value = res.data.data);
    
    // NUEVO: Carga de unidades académicas para el MediaSelector
    HttpClient.get("academic-units").then(res => {
        academic_units_list.value = res.data.data;
    });

    list();
});
</script>