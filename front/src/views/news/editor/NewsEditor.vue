<template>
    <div class="page-editor-container vh-100 d-flex flex-column overflow-hidden bg-light text-dark">
        <header class="border-bottom px-4 py-3 d-flex justify-content-between align-items-center bg-white shadow-sm flex-shrink-0" style="z-index: 1020;">
            <div class="d-flex align-items-center gap-3">
                <button class="btn btn-sm btn-outline-secondary" @click="$router.go(-1)" title="Volver">
                    <i class="las la-arrow-left"></i>
                </button>
                
                <button class="btn btn-sm btn-light border shadow-sm fw-bold text-secondary" @click="showLeftSidebar = !showLeftSidebar">
                    <i class="las" :class="showLeftSidebar ? 'la-angle-double-left' : 'la-pen'"></i>
                    {{ showLeftSidebar ? 'Ocultar Editor' : 'Mostrar Editor' }}
                </button>

                <h5 class="m-0 fw-bold ms-2 text-truncate" style="max-width: 300px;">
                    <i class="las la-newspaper text-primary me-1"></i>
                    {{ localData.title || 'Nueva Noticia' }}
                </h5>
            </div>

            <div class="d-flex align-items-center gap-3">
                <span class="badge bg-success bg-opacity-10 text-success border border-success d-flex align-items-center px-3">
                    <i class="las la-sync-alt me-1"></i> Previa en Vivo
                </span>
                
                <button class="btn btn-sm btn-light border shadow-sm fw-bold text-secondary" @click="showRightSidebar = !showRightSidebar">
                    <i class="las" :class="showRightSidebar ? 'la-angle-double-right' : 'la-cog'"></i>
                    {{ showRightSidebar ? 'Ocultar Ajustes' : 'Mostrar Ajustes' }}
                </button>

                <button @click="saveToStore" :disabled="isSaving" class="btn btn-primary btn-sm fw-bold px-4 shadow-sm ms-2">
                    <span v-if="isSaving" class="spinner-border spinner-border-sm me-2"></span>
                    <i v-else class="las la-save me-1"></i>
                    {{ isSaving ? 'GUARDANDO...' : 'PUBLICAR' }}
                </button>
            </div>
        </header>

        <div class="d-flex flex-grow-1 w-100 overflow-hidden" style="min-height: 0;">
            
            <transition name="panel-left">
                <aside v-if="showLeftSidebar" class="sidebar border-end d-flex flex-column shadow-sm bg-white" 
                      style="width: 380px; min-width: 380px; height: 100%;">
                    
                    <div class="p-3 border-bottom bg-light flex-shrink-0">
                        <h6 class="text-uppercase fw-bold m-0 small text-secondary">
                            <i class="las la-pen-nib me-1"></i> Contenido
                        </h6>
                    </div>

                    <div class="p-3 flex-grow-1 overflow-y-auto custom-scrollbar d-flex flex-column gap-4">
                        <div class="px-1">
                            <label class="x-small fw-bold text-muted d-block mb-1">TÍTULO PRINCIPAL</label>
                            <textarea class="form-control border bg-light fs-6 fw-bold shadow-none text-dark"
                                placeholder="Escribe el título aquí..." v-model="localData.title"
                                rows="2" style="resize: none;"></textarea>
                        </div>

                        <div class="px-1">
                            <label class="x-small fw-bold text-muted d-block mb-1">EXTRACTO / BAJADA</label>
                            <textarea class="form-control border bg-light fs-7 text-muted shadow-none"
                                placeholder="Añade un subtítulo breve..." v-model="localData.subtitle" rows="3"
                                style="resize: none;"></textarea>
                        </div>

                        <div class="quill-wrapper px-1 pb-5">
                            <label class="x-small fw-bold text-muted d-block mb-1">CUERPO DE LA NOTICIA</label>
                            <QuillEditor theme="snow" v-model:content="localData.content" contentType="html"
                                :toolbar="minimalToolbarOptions" placeholder="Escribe tu historia..." />
                        </div>
                    </div>
                </aside>
            </transition>

            <main class="canvas-container flex-grow-1 overflow-y-auto position-relative p-4 bg-secondary bg-opacity-10 custom-scrollbar d-flex justify-content-center">
                <div class="bg-white shadow-lg border rounded-3 overflow-hidden w-100 preview-container" 
                     :style="{ maxWidth: (!showLeftSidebar && !showRightSidebar) ? '100%' : '1000px' }"
                     style="min-height: fit-content; height: max-content; transition: max-width 0.4s ease-in-out; margin-bottom: 100px;">
                    <component 
                        :is="resolveArticleLayout(localData.layout_type)" 
                        :data="previewData" 
                    />
                </div>
            </main>

            <transition name="panel-right">
                <aside v-if="showRightSidebar" class="inspector-panel border-start d-flex flex-column shadow-sm bg-white"
                    style="width: 320px; min-width: 320px; height: 100%;">
                    
                    <div class="p-3 border-bottom bg-light flex-shrink-0">
                        <h6 class="text-uppercase fw-bold m-0 small text-secondary">
                            <i class="las la-cog me-1"></i> Ajustes
                        </h6>
                    </div>

                    <div class="flex-grow-1 overflow-y-auto custom-scrollbar">
                        <div class="border-bottom">
                            <div class="p-3 bg-light d-flex justify-content-between align-items-center cursor-pointer accordion-header" 
                                 @click="toggleSection('design')">
                                <h6 class="text-uppercase fw-bold m-0 x-small text-primary">DISEÑO VISUAL</h6>
                                <i class="las text-muted" :class="sections.design ? 'la-angle-up' : 'la-angle-down'"></i>
                            </div>
                            <div v-show="sections.design" class="p-3">
                                <div class="d-flex flex-column gap-2">
                                    <label v-for="layout in layouts" :key="layout.id"
                                        class="border rounded p-2 d-flex align-items-center cursor-pointer layout-option"
                                        :class="{ 'border-primary bg-primary bg-opacity-10': localData.layout_type === layout.id }">
                                        <input type="radio" v-model="localData.layout_type" :value="layout.id" class="form-check-input me-2 mt-0">
                                        <span class="fw-bold small"><i :class="layout.icon" class="me-1"></i> {{ layout.label }}</span>
                                    </label>
                                </div>
                            </div>
                        </div>

                        <div class="border-bottom">
                            <div class="p-3 bg-light d-flex justify-content-between align-items-center cursor-pointer accordion-header" @click="toggleSection('cover')">
                                <h6 class="text-uppercase fw-bold m-0 x-small text-secondary">IMAGEN PORTADA</h6>
                                <i class="las text-muted" :class="sections.cover ? 'la-angle-up' : 'la-angle-down'"></i>
                            </div>
                            <div v-show="sections.cover" class="p-3">
                                <div class="border border-dashed rounded text-center p-2 cursor-pointer bg-light position-relative" @click="openMediaSelector('cover')">
                                    <img v-if="localData.imageUrl" :src="formatImageUrl(localData.imageUrl)" class="img-fluid rounded shadow-sm" style="max-height: 120px;">
                                    <div v-else class="py-3 text-muted">
                                        <i class="las la-image fs-2"></i><br><small>Subir Portada</small>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="border-bottom">
                            <div class="p-3 bg-light d-flex justify-content-between align-items-center cursor-pointer accordion-header" @click="toggleSection('classification')">
                                <h6 class="text-uppercase fw-bold m-0 x-small text-secondary">CLASIFICACIÓN</h6>
                                <i class="las text-muted" :class="sections.classification ? 'la-angle-up' : 'la-angle-down'"></i>
                            </div>
                            <div v-show="sections.classification" class="p-3 d-flex flex-column gap-3">
                                <div>
                                    <label class="x-small fw-bold text-muted mb-1">Categoría</label>
                                    <select v-model="localData.category" class="form-select form-select-sm">
                                        <option value="">Seleccionar...</option>
                                        <option v-for="cat in categories" :key="cat.id" :value="cat.id">{{ cat.name }}</option>
                                    </select>
                                </div>
                                <div>
                                    <label class="x-small fw-bold text-muted mb-1">Fecha</label>
                                    <input type="date" v-model="localData.date" class="form-control form-control-sm">
                                </div>
                                <div>
                                    <label class="x-small fw-bold text-muted mb-1">Etiquetas (Enter)</label>
                                    <input type="text" v-model="tagInput" @keyup.enter="addTag" class="form-control form-control-sm mb-2">
                                    <div class="d-flex flex-wrap gap-1">
                                        <span v-for="(tag, index) in localData.tags" :key="index" class="badge bg-light text-dark border small">
                                            #{{ tag }} <i class="las la-times ms-1 cursor-pointer text-danger" @click="removeTag(Number(index))"></i>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="border-bottom">
                            <div class="p-3 bg-light d-flex justify-content-between align-items-center cursor-pointer accordion-header" @click="toggleSection('author')">
                                <h6 class="text-uppercase fw-bold m-0 x-small text-secondary">AUTORÍA</h6>
                                <i class="las text-muted" :class="sections.author ? 'la-angle-up' : 'la-angle-down'"></i>
                            </div>
                            <div v-show="sections.author" class="p-3 d-flex flex-column gap-2">
                                <input type="text" v-model="localData.author" class="form-control form-control-sm" placeholder="Nombre del autor">
                                <input type="text" v-model="localData.authorRole" class="form-control form-control-sm" placeholder="Cargo (Ej: Editor)">
                                <div class="d-flex align-items-center gap-2 mt-2">
                                    <img :src="localData.authorAvatar ? formatImageUrl(localData.authorAvatar) : 'https://ui-avatars.com/api/?name=' + localData.author" 
                                         class="rounded-circle border" width="40" height="40" style="object-fit: cover;">
                                    <button class="btn btn-xs btn-outline-primary" @click="openMediaSelector('avatar')">Cambiar Foto</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </aside>
            </transition>
        </div>

        <MediaSelector collection="posts" v-if="isMediaModalOpen" @select="handleMediaSelected" @close="isMediaModalOpen = false" />
    </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, computed } from 'vue';
import { useRoute } from 'vue-router';
import HttpClient from "@/helpers/http-client";
import Swal from "sweetalert2";
import { QuillEditor } from '@vueup/vue-quill';
import '@vueup/vue-quill/dist/vue-quill.snow.css';
import MediaSelector from '@/components/modals/MediaSelector.vue';
import { getAvailableArticleLayouts, resolveArticleLayout } from '@shared/core/ArticleRegistry';
import { formatImageUrl } from '@shared/helpers/url';

// --- ESTADO ---
const route = useRoute();
const layouts = ref(getAvailableArticleLayouts());
const categories = ref<any[]>([]);
const tagInput = ref('');
const isMediaModalOpen = ref(false);
const currentMediaTarget = ref<'cover' | 'avatar'>('cover');
const isSaving = ref(false);
const showLeftSidebar = ref(true);
const showRightSidebar = ref(true);

const sections = reactive({ design: true, cover: true, classification: true, author: true });
const localData = reactive<any>({
    id: null, category: '', title: '', subtitle: '', content: '', imageUrl: '',
    date: new Date().toISOString().split('T')[0],
    author: '', authorAvatar: '', authorRole: '',
    readTime: '5 min', tags: [],
    layout_type: layouts.value.length > 0 ? layouts.value[0].id : 'classic'
});

// --- COMPUTED PARA PREVIA ---
const previewData = computed(() => ({
    title: localData.title || 'Título de la noticia...',
    excerpt: localData.subtitle || 'El subtítulo aparecerá aquí...',
    start_date: localData.date,
    featured_image_path: localData.imageUrl,
    category_name: categories.value.find(c => c.id == localData.category)?.name || 'Sin Categoría',
    body: {
        html: localData.content || '<p>Escribe el contenido aquí...</p>',
        author: { name: localData.author, role: localData.authorRole, avatar: localData.authorAvatar },
        extra: { read_time: localData.readTime, tags: localData.tags || [] },
        layout: localData.layout_type
    }
}));

// --- MÉTODOS ---
const toggleSection = (s: keyof typeof sections) => { sections[s] = !sections[s]; };
const openMediaSelector = (t: 'cover' | 'avatar') => { currentMediaTarget.value = t; isMediaModalOpen.value = true; };

const handleMediaSelected = (p: any) => {
    if (currentMediaTarget.value === 'cover') localData.imageUrl = p.url;
    else localData.authorAvatar = p.url;
    isMediaModalOpen.value = false;
};

const addTag = () => { 
    if (tagInput.value.trim() && !localData.tags?.includes(tagInput.value.trim())) {
        localData.tags?.push(tagInput.value.trim());
    }
    tagInput.value = ''; 
};

const removeTag = (i: number) => localData.tags?.splice(i, 1);

const minimalToolbarOptions = [
    ['bold', 'italic', 'underline', 'strike'],
    [{ 'header': 1 }, { 'header': 2 }],
    [{ 'list': 'ordered'}, { 'list': 'bullet' }],
    ['blockquote', 'code-block', 'link', 'image'],
    ['clean']
];

// --- GUARDAR (LÓGICA REFORZADA) ---
const saveToStore = async () => {
    if (!localData.title) return Swal.fire("Atención", "El título es obligatorio", "warning");

    isSaving.value = true;
    try {
        const dynamicContent = {
            html: localData.content,
            layout: localData.layout_type,
            author: { 
                name: localData.author, 
                role: localData.authorRole, 
                avatar: localData.authorAvatar 
            },
            extra: { 
                read_time: localData.readTime, 
                tags: localData.tags 
            }
        };

        const dataToSend = {
            title: localData.title,
            slug: localData.title.toLowerCase().trim().replace(/ /g, '-').replace(/[^\w-]+/g, ''),
            excerpt: localData.subtitle || '',
            featured_image_path: localData.imageUrl,
            start_date: localData.date,
            category_id: localData.category,
            academic_unit_id: localStorage.getItem('academic_unit_id'), // RECUERDA ESTO
            type: 'news',
            status: 'published',
            body: JSON.stringify(dynamicContent) // OJO: Tu DB espera esto en 'body'
        };

        const currentId = localData.id || route.params.id;
        let response;

        if (currentId && currentId !== 'new') {
            response = await HttpClient.put(`posts/${currentId}`, dataToSend);
        } else {
            response = await HttpClient.post('posts', dataToSend);
            if (response.data?.id) localData.id = response.data.id;
        }

        Swal.fire({
            icon: 'success',
            title: '¡Publicado con éxito!',
            toast: true,
            position: 'top-end',
            timer: 3000,
            showConfirmButton: false
        });

    } catch (error: any) {
        console.error("Error al guardar:", error.response?.data || error);
        let errorMsg = error.response?.data?.message || "No se pudo guardar la noticia.";
        Swal.fire("Error", errorMsg, "error");
    } finally {
        isSaving.value = false;
    }
};

// --- CARGAR DATOS ---
onMounted(async () => {
    try {
        // Cargar Categorías
        const catRes = await HttpClient.get('categories');
        categories.value = catRes.data.data || catRes.data || [];

        // Cargar Noticia si hay ID
        const identifier = route.params.id || route.params.slug;
        if (identifier && identifier !== 'new') {
            const res = await HttpClient.get(`posts/${identifier}`);
            const postData = res.data.post || res.data.data || res.data;

            if (postData) {
                // Parsear el body JSON
                let blocks = postData.content_blocks || postData.body;
                if (typeof blocks === 'string') {
                    try { blocks = JSON.parse(blocks); } catch (e) { blocks = {}; }
                }
                blocks = blocks || {};

                Object.assign(localData, {
                    id: postData.id,
                    title: postData.title || '',
                    subtitle: postData.excerpt || '',
                    imageUrl: postData.featured_image_path || '',
                    date: postData.start_date ? postData.start_date.split('T')[0] : localData.date,
                    category: postData.category?.id || postData.category_id || '',
                    content: blocks.html || '',
                    layout_type: blocks.layout || 'classic',
                    author: blocks.author?.name || '',
                    authorRole: blocks.author?.role || '',
                    authorAvatar: blocks.author?.avatar || '',
                    readTime: blocks.extra?.read_time || '5 min',
                    tags: blocks.extra?.tags || []
                });
            }
        }
    } catch (e) {
        console.error("Error en onMounted:", e);
    }
});
</script>

<style scoped>
/* FIX PARA QUILL EN SIDEBAR */
.quill-wrapper :deep(.ql-toolbar) {
    position: sticky;
    top: 0;
    z-index: 10;
    background: #f8f9fa;
    border-radius: 8px 8px 0 0;
    border: 1px solid #dee2e6;
}
.quill-wrapper :deep(.ql-container) {
    border-radius: 0 0 8px 8px;
    border: 1px solid #dee2e6;
    border-top: none;
    min-height: 300px;
    font-family: inherit;
}
.quill-wrapper :deep(.ql-editor) {
    min-height: 300px;
}

/* Scrollbars */
.custom-scrollbar::-webkit-scrollbar { width: 4px; }
.custom-scrollbar::-webkit-scrollbar-track { background: transparent; }
.custom-scrollbar::-webkit-scrollbar-thumb { background: #cbd5e0; border-radius: 10px; }

/* Estética de Ajustes */
.x-small { font-size: 0.65rem; letter-spacing: 0.8px; }
.layout-option:hover { background: #f8f9fa; }
.cursor-pointer { cursor: pointer; }
.btn-xs { padding: 0.1rem 0.4rem; font-size: 0.7rem; }

/* Transiciones */
.panel-left-enter-active, .panel-left-leave-active,
.panel-right-enter-active, .panel-right-leave-active { transition: all 0.3s ease; }
.panel-left-enter-from, .panel-left-leave-to { transform: translateX(-100%); opacity: 0; }
.panel-right-enter-from, .panel-right-leave-to { transform: translateX(100%); opacity: 0; }
</style>