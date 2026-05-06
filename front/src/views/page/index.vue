<template>
    <b-row class="justify-content-center">
        <b-col cols="12">
            <b-card no-body>
                <b-card-header>
                    <b-row class="align-items-center justify-content-between">
                        <b-col lg="3">
                            <b-card-title>📝 Publicaciones (Páginas)</b-card-title>
                        </b-col>
                        <b-col lg="2">
                            <b-button type="button" variant="danger" v-if="useAuth.isPermitedRoute('register_post')"
                                @click="ModalRegisterPost = true">
                                <i class="far fa-plus-square ml-3"></i> Registrar
                            </b-button>
                        </b-col>
                    </b-row>
                </b-card-header>
                <b-card-body class="pt-0">

                    <div class="table-responsive m-0" v-if="post_list && post_list.length > 0">
                        <table class="table datatable">
                            <thead class="table-light">
                                <tr>
                                    <th>Id</th>
                                    <th>Contenido</th>
                                    <th>Tipo</th>
                                    <th>Estado</th>
                                    <th>Fecha Registro</th>
                                    <th>Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="(post, index) in post_list" :key="post.id">
                                    <td>{{ post.id }}</td>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img v-if="post.featured_image" :src="post.featured_image" alt="post"
                                                class="thumb-md rounded me-2" style="object-fit: cover;" />
                                            <div v-else
                                                class="thumb-md rounded me-2 bg-light d-flex align-items-center justify-content-center">
                                                <i class="las la-image text-secondary fs-20"></i>
                                            </div>
                                            <div>
                                                <h6 class="m-0 text-truncate" style="max-width: 200px;">{{
                                                    post.title }}</h6>
                                                <small class="text-muted">/{{ post.slug }}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <b-badge variant="info" class="text-capitalize">{{ post.type }}</b-badge>
                                    </td>
                                    <td>
                                        <b-badge variant="success"
                                            v-if="post.status === 'published'">Publicado</b-badge>
                                        <b-badge variant="warning" v-if="post.status === 'draft'">Borrador</b-badge>
                                        <b-badge variant="secondary"
                                            v-if="post.status === 'archived'">Archivado</b-badge>
                                    </td>
                                    <td>{{ post.created_at }}</td>
                                    <td>
                                        <a href="#" class="text-success me-2" @click.prevent="editPost(post)"
                                            title="Editar Configuración">
                                            <i class="las la-pen fs-20"></i>
                                        </a>

                                        <router-link
                                            :to="{ name: 'comercial.pageseditor', params: { id: post.id } }" class="text-warning me-2" title="Diseñar Contenido">
                                            <i class="las la-pencil-ruler fs-20"></i>
                                        </router-link>

                                        <a href="#" class="text-danger" @click.prevent="deletePost(post)"
                                            title="Eliminar">
                                            <i class="las la-trash-alt fs-20"></i>
                                        </a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div v-else class="text-center p-5">
                        <div class="mb-3">
                            <i class="las la-folder-open text-muted display-4"></i>
                        </div>
                        <h5 class="text-muted">No se encontraron registros.</h5>
                    </div>

                    <b-pagination v-if="totalPage > perPageItem" class="mt-3 justify-content-end"
                        v-model="currentPage" :total-rows="totalPage" :per-page="perPageItem" prev-text="Anterior"
                        next-text="Siguiente" />
                </b-card-body>
            </b-card>
        </b-col>
    </b-row>

    <b-modal v-model="ModalRegisterPost" :title="`📝 ${post_selected ? 'Edición' : 'Registro'} de Post`"
        :header-class="`bg-${themeColor}`" title-class="m-0 text-white" :ok-variant="themeColor" hide-footer
        centered size="lg">

        <b-row>
            <b-col lg="12" class="mb-3">
                <label class="form-label">Título <span class="text-danger">*</span></label>
                <b-form-input type="text" v-model="title" placeholder="Ej: Curso de Vue 3 Avanzado" />
            </b-col>

            <b-col lg="6" class="mb-3">
                <label class="form-label">Slug (URL)</label>
                <b-form-input type="text" v-model="slug" placeholder="ej-curso-de-vue-3" />
                <small class="text-muted" style="font-size: 0.75rem">*Dejar vacío para autogenerar</small>
            </b-col>

            <b-col lg="6" class="mb-3">
                <label class="form-label">Tipo de Contenido</label>
                <b-form-select v-model="type" :options="['page', 'landing']"></b-form-select>
            </b-col>

            <b-col lg="12" class="mb-3">
                <label class="form-label">Resumen Corto (Excerpt)</label>
                <b-form-textarea v-model="excerpt" placeholder="Breve descripción para SEO..."
                    rows="2"></b-form-textarea>
            </b-col>

            <b-col lg="12" class="mb-3">
                <label class="form-label d-block">Estado</label>
                <b-form-radio-group v-model="status" :options="[
                    { text: 'Borrador', value: 'draft' },
                    { text: 'Publicado', value: 'published' },
                    { text: 'Archivado', value: 'archived' }
                ]" button-variant="outline-primary" buttons></b-form-radio-group>
            </b-col>

            <b-col lg="12" class="mb-3">
                <label class="form-label">Imagen Destacada</label>
                <b-input-group class="mb-3">
                    <b-form-file @change="loadFile($event)" accept="image/*" placeholder="Seleccionar archivo..." />
                </b-input-group>

                <div v-if="IMAGEN_PREVIZUALIZA" class="text-center bg-light p-2 rounded border">
                    <img :src="(IMAGEN_PREVIZUALIZA as string)" alt="Preview" style="max-height: 200px; max-width: 100%;"
                        class="rounded" />
                    <br>
                    <b-button size="sm" variant="link" class="text-danger mt-1" @click="clearImage">Quitar imagen</b-button>
                </div>
            </b-col>

            <b-col lg="12">
                <b-alert :model-value="!!warning_alert" variant="danger" dismissible>
                    <i class="fas fa-exclamation-triangle me-1"></i> <strong>Atención:</strong> {{ message_text }}
                </b-alert>
            </b-col>

            <b-col lg="12" class="mt-3 text-end">
                <b-button variant="secondary" class="me-2" @click="ModalRegisterPost = false">Cancelar</b-button>
                <b-button variant="primary" @click="store" :disabled="loading">
                    <span v-if="loading" class="spinner-border spinner-border-sm me-1"></span>
                    {{ post_selected ? 'Guardar Cambios' : 'Registrar Post' }}
                </b-button>
            </b-col>
        </b-row>
    </b-modal>
</template>
<script setup lang="ts">
import { ref, onMounted, watch } from "vue";
import HttpClient from "@/helpers/http-client";
import type { AxiosResponse } from "axios";
import type { Post, PostsResponse } from '@/types/posts';
import Swal from "sweetalert2";
import { useAuthStore } from "@/stores/auth";

import { handleApiError } from "@/helpers/errorHandler";

const useAuth = useAuthStore();
type TVueSwalInstance = typeof Swal;

// --- ESTADO ---
const loading = ref(false);
const post_list = ref<Post[]>([]);
const ModalRegisterPost = ref(false);
const themeColor = ref<string>("primary");
const post_selected = ref<Post | undefined>();

// --- FORMULARIO ---
const title = ref<string>("");
const slug = ref<string>("");
const type = ref<string>("page");
const status = ref<string>("draft");
const excerpt = ref<string>("");
const FILE_IMAGEN = ref<File | undefined>();
const IMAGEN_PREVIZUALIZA = ref<string | ArrayBuffer | null>(null);

// Auto-generar Slug
watch(title, (newVal) => {
    if (!post_selected.value || slug.value === '') { 
        slug.value = newVal
            .toLowerCase()
            .trim()
            .normalize("NFD").replace(/[\u0300-\u036f]/g, "") // Quitar acentos
            .replace(/[^a-z0-9 -]/g, '') // Quitar caracteres especiales
            .replace(/\s+/g, '-') // Espacios por guiones
            .replace(/-+/g, '-'); // Quitar guiones duplicados
    }
});

const message_text = ref<string>("");
const warning_alert = ref<boolean>(false);

// --- PAGINACIÓN ---
const perPageItem = ref(10);
const totalPage = ref(0);
const currentPage = ref(1);

// --- FUNCIONES ---

const list = async () => {
    loading.value = true;
    try {
        const res = await HttpClient.get("pages?page=" + currentPage.value);

        if (res.data && Array.isArray(res.data.data)) {
            post_list.value = res.data.data; 
            
            if (res.data.meta) {
                totalPage.value = res.data.meta.total || 0;
                perPageItem.value = res.data.meta.per_page || 10;
            }
        }
    } catch (e: any) {
        // 🔥 2. Aplicado al listar las páginas
        handleApiError(e, "Error al cargar las páginas");
    } finally {
        loading.value = false;
    }
};

const editPost = (post: Post) => {
    post_selected.value = post;
    ModalRegisterPost.value = true;

    title.value = post.title;
    slug.value = post.slug;
    type.value = post.type;
    status.value = post.status;
    excerpt.value = post.excerpt || "";
    IMAGEN_PREVIZUALIZA.value = post.featured_image ?? null; 
};

const store = async () => {
    warning_alert.value = false;
    // Validaciones del Frontend se quedan igual
    if (!title.value.trim()) {
        message_text.value = "El título es obligatorio.";
        warning_alert.value = true;
        return;
    }

    loading.value = true;
    let formData = new FormData();
    
    // --- LÓGICA DE UNIDAD ACADÉMICA ---
    let unitToSend = useAuth.academicUnitId;

    if (post_selected.value && post_selected.value.academic_unit_id) {
        unitToSend = post_selected.value.academic_unit_id;
    }

    if (unitToSend) {
        formData.append("academic_unit_id", String(unitToSend));
    }
    // ------------------------------------------------

    // Atributos base
    formData.append("title", title.value);
    formData.append("slug", slug.value || "");
    formData.append("type", type.value);
    formData.append("status", status.value);
    formData.append("excerpt", excerpt.value || "");

    if (FILE_IMAGEN.value) {
        formData.append("featured_image", FILE_IMAGEN.value);
    }

    let url = "pages";
    if (post_selected.value) {
        url = `pages/${post_selected.value.id}`;
        formData.append("_method", "PUT");
    }

    try {
        const res: AxiosResponse<any> = await HttpClient.post(url, formData);

        // Si Laravel responde código 200 pero tu API manda "success: false" internamente
        if (res.data.success === false || res.data.code === 403) {
            message_text.value = res.data.message || "No tienes permisos.";
            warning_alert.value = true;
        } else {
            await list(); 
            ModalRegisterPost.value = false;
            (Swal as TVueSwalInstance).fire({
                icon: 'success',
                title: '¡Guardado!',
                text: 'La página se actualizó correctamente.',
                timer: 2000,
                showConfirmButton: false
            });
        }
    } catch (e: any) {
        // 🔥 3. Aplicado al guardar. Atrápara 422 de Laravel, 403 de Spatie, o 500.
        handleApiError(e, "Error al guardar la página");
    } finally {
        loading.value = false;
    }
};

const deletePost = async (post: Post) => {
    const result = await (Swal as TVueSwalInstance).fire({
        title: "¿Estás seguro?",
        text: `Se eliminará: ${post.title}`,
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Sí, eliminar",
        cancelButtonText: "Cancelar"
    });

    if (result.isConfirmed) {
        try {
            const res = await HttpClient.delete(`pages/${post.id}`);
            if (res.data.success !== false) {
                post_list.value = post_list.value.filter(p => p.id !== post.id);
                (Swal as TVueSwalInstance).fire("Eliminado", "La página ha sido borrada.", "success");
            } else {
                (Swal as TVueSwalInstance).fire("Atención", res.data.message, "warning");
            }
        } catch (e: any) {
            // 🔥 4. Aplicado al eliminar
            handleApiError(e, "No se pudo eliminar la página");
        }
    }
};

const loadFile = ($event: any) => {
    const file = $event.target.files[0];
    if (!file) return;
    FILE_IMAGEN.value = file;
    const reader = new FileReader();
    reader.onload = (e) => IMAGEN_PREVIZUALIZA.value = e.target?.result ?? null;
    reader.readAsDataURL(file);
};

const clearImage = () => {
    FILE_IMAGEN.value = undefined;
    IMAGEN_PREVIZUALIZA.value = null;
};

// Reset al cerrar modal
watch(ModalRegisterPost, (val) => {
    if (!val) {
        post_selected.value = undefined;
        title.value = "";
        slug.value = "";
        type.value = "page";
        status.value = "draft";
        excerpt.value = "";
        IMAGEN_PREVIZUALIZA.value = null;
        FILE_IMAGEN.value = undefined;
        warning_alert.value = false; 
    }
});

watch(currentPage, () => list());
onMounted(() => list());
</script>