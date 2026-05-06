<template>
    <b-row class="justify-content-center">
        <b-col cols="12">
            <b-card no-body>
                <b-card-header>
                    <b-row class="align-items-center justify-content-between">
                        <b-col lg="6">
                            <b-card-title>📝 Gestión de Noticias y Eventos</b-card-title>
                        </b-col>
                        <b-col lg="2" class="text-end">
                            <b-button type="button" variant="danger" v-if="useAuth.isPermitedRoute('register_news')"
                                @click="openModal">
                                <i class="far fa-plus-square me-2"></i> Registrar
                            </b-button>
                        </b-col>
                    </b-row>
                </b-card-header>
                <b-card-body class="pt-0">

                    <div class="table-responsive m-0" v-if="post_list && post_list.length > 0">
                        <table class="table datatable align-middle">
                            <thead class="table-light">
                                <tr>
                                    <th>Id</th>
                                    <th>Categoria</th>
                                    <th>Miniatura</th>
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
                                        <b-badge variant="light" class="text-dark border" v-if="post.category">
                                            {{ post.category.name }}
                                        </b-badge>
                                        <span v-else class="text-muted">-</span>
                                    </td>
                                    <td>
                                        <div v-if="post.featured_image_path" class="ratio ratio-1x1 rounded overflow-hidden shadow-sm" style="width: 40px;">
                                            <img :src="formatImageUrl(post.featured_image_path) || 'https://placehold.co/40x40?text=Err'" 
                                                 class="object-fit-cover w-100 h-100" 
                                                 alt="img"
                                                 @error="handleImageFallback">
                                        </div>
                                        <div v-else class="rounded bg-secondary text-white d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                            <i class="las la-image"></i>
                                        </div>
                                    </td>
                                    <td>
                                        <div>
                                            <h6 class="m-0 text-truncate" style="max-width: 200px;">{{ post.title }}</h6>
                                            <small class="text-muted d-block mb-1">/{{ post.slug }}</small>
                                            
                                            <div v-if="post.start_date">
                                                <small class="text-primary fw-bold" style="font-size: 0.75rem;">
                                                    <i :class="post.type === 'event' ? 'las la-clock' : 'las la-calendar-day'"></i> 
                                                    {{ post.start_date.replace('T', ' ').substring(0, 16) }}
                                                </small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <b-badge :variant="getTypeBadge(post.type)" class="text-capitalize">{{ post.type }}</b-badge>
                                    </td>
                                    <td>
                                        <b-badge variant="success" v-if="post.status === 'published'">Publicado</b-badge>
                                        <b-badge variant="warning" v-if="post.status === 'draft'">Borrador</b-badge>
                                        <b-badge variant="secondary" v-if="post.status === 'archived'">Archivado</b-badge>
                                    </td>
                                    <td>{{ post.created_at }}</td>
                                    <td>
                                        <a href="#" class="text-success me-2" @click.prevent="editPost(post)" title="Editar">
                                            <i class="las la-pen fs-20"></i>
                                        </a>
                                        <router-link :to="{ name: 'comercial.newseditor', params: { id: post.id } }"
                                                    class="text-warning me-2" title="Diseñar Contenido">
                                            <i class="las la-pencil-ruler fs-20"></i>
                                        </router-link>
                                        <a href="#" class="text-danger" @click.prevent="deletePost(post)" title="Eliminar">
                                            <i class="las la-trash-alt fs-20"></i>
                                        </a>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>

                    <div v-else class="text-center p-5">
                        <i class="las la-folder-open text-muted display-4"></i>
                        <h5 class="text-muted mt-2">No se encontraron registros.</h5>
                    </div>

                    <b-pagination v-if="totalPage > perPageItem" class="mt-3 justify-content-end"
                        v-model="currentPage" :total-rows="totalPage" :per-page="perPageItem" prev-text="Anterior"
                        next-text="Siguiente" />
                </b-card-body>
            </b-card>
        </b-col>
    </b-row>

    <b-modal v-model="ModalRegisterPost" :title="`📝 ${post_selected ? 'Edición' : 'Registro'} de Contenido`"
        :header-class="`bg-${themeColor}`" title-class="m-0 text-white" hide-footer centered size="lg">

        <b-row>
            <b-col lg="12" class="mb-3">
                <label class="form-label">Título <span class="text-danger">*</span></label>
                <b-form-input type="text" v-model="form.title" placeholder="Ej: Nueva noticia de hoy" />
            </b-col>

            <b-col lg="5" class="mb-3">
                <label class="form-label">Tipo de Contenido</label>
                <b-form-select v-model="form.type" @change="onChangeType" :options="[
                    { value: 'news', text: 'Noticia' },
                    { value: 'event', text: 'Evento' },
                ]"></b-form-select>
            </b-col>
            
            <b-col lg="6" class="mb-3">
                <label class="form-label">Categoría <span class="text-danger">*</span></label>
                <b-form-select 
                    v-model="form.category_id" 
                    :options="categories_options"
                    :disabled="loadingCategories" 
                    required
                >
                    <template #first>
                        <b-form-select-option :value="null" disabled>
                            {{ loadingCategories ? 'Cargando...' : '-- Seleccione --' }}
                        </b-form-select-option>
                    </template>
                </b-form-select>
            </b-col>

            <b-col lg="7" class="mb-3" v-if="form.type === 'event'">
                <label class="form-label text-primary fw-bold">
                    <i class="las la-calendar-check me-1"></i> Fecha del Evento
                </label>
                <b-form-input type="datetime-local" v-model="form.start_date" />
            </b-col>

            <b-col lg="7" class="mb-3" v-else>
                <label class="form-label fw-bold">
                    <i class="las la-newspaper me-1"></i> Fecha de la Noticia
                </label>
                <b-form-input type="date" v-model="form.start_date" />
            </b-col>

            <b-col lg="5" class="mb-3">
                 <label class="form-label text-danger">Fecha Fin / Archivo</label>
                <b-form-input type="date" v-model="form.end_date" />
            </b-col>

            <b-col lg="12" class="mb-3">
                <label class="form-label">Slug (URL)</label>
                <b-form-input type="text" v-model="form.slug" />
            </b-col>

            <b-col lg="12" class="mb-3">
                <label class="form-label">Resumen Corto</label>
                <b-form-textarea v-model="form.excerpt" rows="2"></b-form-textarea>
            </b-col>
            
            <b-col lg="6" class="mb-3">
                <label class="form-label">Imagen Destacada</label>
                <div class="d-flex align-items-center border p-2 rounded bg-light">
                    <div v-if="form.featured_image_path" class="me-3 position-relative">
                        <img :src="formatImageUrl(form.featured_image_path) || 'https://placehold.co/60x60?text=Err'" 
                             class="rounded" 
                             style="width: 60px; height: 60px; object-fit: cover;" 
                             @error="handleImageFallback" />                            
                        <b-badge variant="danger" class="position-absolute top-0 start-100 translate-middle rounded-pill cp" @click="form.featured_image_path = ''" style="cursor:pointer">x</b-badge>
                    </div>
                    
                    <div v-else class="me-3 bg-secondary rounded d-flex align-items-center justify-content-center" style="width: 60px; height: 60px;">
                        <i class="las la-image text-white fs-24"></i>
                    </div>
                    <div>
                        <b-button variant="primary" size="sm" @click="showMediaModal = true">
                            <i class="las la-search me-1"></i> Seleccionar
                        </b-button>
                    </div>
                </div>
            </b-col>
            
            <b-col lg="6" class="mb-3">
                <label class="form-label d-block">Estado</label>
                <b-form-radio-group v-model="form.status" :options="[
                    { text: 'Borrador', value: 'draft' },
                    { text: 'Publicado', value: 'published' }
                ]" button-variant="outline-primary" buttons></b-form-radio-group>
            </b-col>

            <b-col lg="12" class="mt-3 text-end border-top pt-3">
                <b-button variant="secondary" class="me-2" @click="ModalRegisterPost = false">Cancelar</b-button>
                <b-button variant="primary" @click="store" :disabled="loading">
                    <b-spinner small v-if="loading" class="me-1"></b-spinner>
                    {{ post_selected ? 'Guardar Cambios' : 'Registrar' }}
                </b-button>
            </b-col>
        </b-row>
    </b-modal>

    <MediaSelector 
        :collection="'news'"
        v-if="showMediaModal" 
        @close="showMediaModal = false" 
        @select="handleMediaSelect" 
    />
</template>

<script setup lang="ts">
import DefaultLayout from "@/layouts/DefaultLayout.vue";
import { ref, onMounted, watch, reactive } from "vue";
import HttpClient from "@/helpers/http-client";
import type { Post } from '@/types/posts';
import MediaSelector from "@/components/modals/MediaSelector.vue";
import Swal from "sweetalert2/dist/sweetalert2.js";
import { formatImageUrl } from "@/helpers/url";

const useAuth = { isPermitedRoute: (r: string) => true }; 
const loading = ref(false);
const loadingCategories = ref(false);
const post_list = ref<Post[]>([]);
const ModalRegisterPost = ref(false);
const showMediaModal = ref(false);
const post_selected = ref<Post | null>(null);
const themeColor = "primary"; 
const categories_options = ref<{value: number, text: string}[]>([]);

const form = reactive({
    title: "",
    slug: "",
    type: "news",
    category_id: null as number | null,
    status: "draft",
    excerpt: "",
    featured_image_path: "",
    start_date: "",
    end_date: ""
});

const resetForm = () => {
    Object.assign(form, {
        title: "", slug: "", type: "news", category_id: null,
        status: "draft", excerpt: "", featured_image_path: "",
        start_date: "", end_date: ""
    });
};

// CORRECCIÓN: Función para evitar que la imagen se rompa si el link no sirve
const handleImageFallback = (e: Event) => {
    const target = e.target as HTMLImageElement;
    if (!target.src.includes('placehold.co')) {
        target.src = 'https://placehold.co/60x60?text=Err';
    }
};

const loadCategories = async (type: string) => {
    loadingCategories.value = true;
    categories_options.value = [];
    try {
        const res = await HttpClient.get(`categories?type=${type}`);
        const data = res.data.data || res.data; 
        categories_options.value = data.map((c: any) => ({
            value: c.id,
            text: c.name
        }));
    } catch (e) {
        console.error("Error cargando categorías", e);
    } finally {
        loadingCategories.value = false;
    }
};

const onChangeType = (newType: string) => {
    form.category_id = null;
    loadCategories(newType);
};

const openModal = () => {
    post_selected.value = null;
    resetForm();
    loadCategories('news');
    ModalRegisterPost.value = true;
}

const editPost = async (item: any) => {
    post_selected.value = item;
    
    await loadCategories(item.type);

    const sDate = item.start_date ? item.start_date.substring(0, 16) : "";
    const eDate = item.end_date ? item.end_date.substring(0, 10) : "";
    const catId = item.category ? item.category.id : null;

    Object.assign(form, {
        title: item.title,
        slug: item.slug,
        type: item.type,
        category_id: catId, 
        status: item.status, 
        excerpt: item.excerpt || "",
        featured_image_path: item.featured_image_path || "",
        start_date: sDate, 
        end_date: eDate
    });

    ModalRegisterPost.value = true;
};

const store = async () => {
    if (!form.title) return Swal.fire('Error', 'El título es obligatorio', 'warning');
    if (!form.category_id) return Swal.fire('Error', 'Selecciona una categoría', 'warning');

    loading.value = true;
    try {
        const isUpdate = !!post_selected.value;
        const url = isUpdate ? `posts/${post_selected.value!.id}` : "posts"; 
        
        // AQUÍ ESTÁ LA MAGIA: Agregamos academic_unit_id leyendo del localStorage
        // OJO: Cambia 'academic_unit_id' por el nombre exacto de la llave que uses en tu proyecto
        const payload = { 
            ...form, 
            academic_unit_id: localStorage.getItem('academic_unit_id'), 
            _method: isUpdate ? "PUT" : "POST" 
        };
        
        await HttpClient.post(url, payload);
        
        ModalRegisterPost.value = false;
        list();
        Swal.fire('Éxito', 'Guardado correctamente', 'success');
    } catch(e) { 
        console.error(e);
        Swal.fire('Error', 'Ocurrió un error al guardar', 'error');
    } finally { 
        loading.value = false; 
    }
};

const list = async () => {
    loading.value = true;
    try {
        const res = await HttpClient.get(`posts?page=${currentPage.value}`);
        
        if (res.data) {
            post_list.value = res.data.data || [];            
            const meta = res.data.meta || res.data; 
            totalPage.value = meta.total || 0; 
            perPageItem.value = meta.per_page || 10;
        }
    } catch (e) { console.error(e); }
    finally { loading.value = false; }
};

const deletePost = async (post: Post) => {
    const confirm = await Swal.fire({ title: '¿Eliminar?', icon: 'warning', showCancelButton: true });
    if (confirm.isConfirmed) {
        await HttpClient.delete(`posts/${post.id}`); 
        list();
    }
};

const handleMediaSelect = (payload: { id: number; url: string }) => {
    form.featured_image_path = payload.url; 
    
    // Cerramos el modal
    showMediaModal.value = false;
};

const currentPage = ref(1);
const totalPage = ref(0);
const perPageItem = ref(10);

watch(currentPage, list);

watch(() => form.title, (val) => {
    if (!post_selected.value) form.slug = val.toLowerCase().trim().replace(/[^\w ]+/g, '').replace(/ +/g, '-');
});

const getTypeBadge = (type: string) => {
    if (type === 'news') return 'info';
    if (type === 'event') return 'primary';
    return 'secondary';
};

onMounted(() => {
    list();
});
</script>