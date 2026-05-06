<script setup lang="ts">
    import { ref, reactive, onMounted } from 'vue';
    import { useRoute } from 'vue-router';
    import HttpClient from "@/helpers/http-client";
    import Swal from "sweetalert2";
    import { QuillEditor } from '@vueup/vue-quill';
    import '@vueup/vue-quill/dist/vue-quill.snow.css';
    import MediaSelector from '@/components/modals/MediaSelector.vue';
    import { formatImageUrl } from '@/helpers/url';
    import ArticleDetail from '@/components/blocks/page/ArticleDetail.vue'; 

    // 1. INTERFACES
    interface ArticleData {
        id?: number | string;
        category: string | number;
        title: string;
        subtitle?: string;
        content: string;
        imageUrl: string;
        date: string;
        author: string;
        authorAvatar?: string;
        authorRole?: string;
        readTime: string;
        tags?: string[];
    }

    const route = useRoute();

    // 2. ESTADO
    const categories = ref<any[]>([]);
    const tagInput = ref('');
    const isMediaModalOpen = ref(false);
    const currentMediaTarget = ref<'cover' | 'avatar'>('cover');
    const isSaving = ref(false);

    const sections = reactive({ header: true, media: true, content: true, meta: true });

    const localData = reactive<ArticleData>({
        category: '', title: '', subtitle: '', content: '', imageUrl: '',
        date: new Date().toISOString().split('T')[0],
        author: '', authorAvatar: '', authorRole: '',
        readTime: '5 min', tags: []
    });

    // 3. MÉTODOS
    const toggleSection = (key: keyof typeof sections) => sections[key] = !sections[key];

    // Lógica de Imagen (Portada vs Avatar)
    const openMediaSelector = (target: 'cover' | 'avatar') => {
        currentMediaTarget.value = target;
        isMediaModalOpen.value = true;
    };

    const handleMediaSelected = (payload: { id: number; url: string }) => {
        if (currentMediaTarget.value === 'cover') {
            localData.imageUrl = payload.url;
        } else {
            localData.authorAvatar = payload.url;
        }
        isMediaModalOpen.value = false;
    };

    // Lógica de Tags
    const addTag = () => { if (tagInput.value && !localData.tags?.includes(tagInput.value)) localData.tags?.push(tagInput.value); tagInput.value = ''; };
    const removeTag = (i: number) => localData.tags?.splice(i, 1);
    const isCodeMode = ref(false);

    const allToolbarOptions = [
        ['bold', 'italic', 'underline', 'strike'],
        ['blockquote', 'code-block'],
        [{ 'header': 1 }, { 'header': 2 }, { 'header': [3, 4, 5, 6, false] }],
        [{ 'list': 'ordered' }, { 'list': 'bullet' }],
        [{ 'script': 'sub' }, { 'script': 'super' }],
        [{ 'indent': '-1' }, { 'indent': '+1' }],
        [{ 'direction': 'rtl' }],
        [{ 'size': ['small', false, 'large', 'huge'] }],
        [{ 'color': [] }, { 'background': [] }],
        [{ 'font': [] }],
        [{ 'align': [] }],
        ['link', 'image', 'video'],
        ['clean']
    ];

    const getCategoryName = (id: string | number) => categories.value.find(c => c.id == id)?.name || '';
    
    const getImageSrc = (path: string) => {
        if (!path) return 'https://placehold.co/600x400?text=Sin+Imagen';

        const baseUrl = (import.meta.env.VITE_API_URL || 'http://127.0.0.1:8000').replace(/\/$/, "");
        let cleanPath = path;

        if (path.startsWith('http')) {
            const storageMatch = path.match(/(\/storage\/.*)/);
            if (storageMatch) {
                cleanPath = storageMatch[1];
            }
        }

        cleanPath = cleanPath.replace(/^\//, "");

        if (!cleanPath.startsWith('storage/')) {
            cleanPath = `storage/${cleanPath}`;
        }

        return `${baseUrl}/${cleanPath}`;
    };

    // ==========================================
    // 4. GUARDAR (MAPEO EXACTO A TU DB)
    // ==========================================

    const saveToStore = async () => {
        if (!localData.title) {
            Swal.fire("Falta el título", "El título es obligatorio", "warning");
            return;
        }

        isSaving.value = true;

        try {
            // 1. JSON para el contenido dinámico/visual
            const dynamicContent = {
                html: localData.content,
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

            // 2. Payload con los campos reales de tu DB
            const dataToSend = {
                title: localData.title,
                slug: localData.title.toLowerCase().replace(/ /g, '-').replace(/[^\w-]+/g, ''),
                excerpt: localData.subtitle || '',
                featured_image_path: localData.imageUrl,
                start_date: localData.date, 
                status: 'published',
                type: 'news', 
                
                // Relaciones
                category_id: localData.category,
                academic_unit_id: localStorage.getItem('academic_unit_id'),

                // 🔥 AQUÍ ESTÁ LA MAGIA: Tu DB lo llama 'body', no 'content_blocks'
                // Lo mandamos como string (texto) para que Laravel no se queje si la columna es TEXT
                body: JSON.stringify(dynamicContent) 
            };

            console.log("📤 Enviando Payload Corregido:", dataToSend);

            let response;
            const currentId = localData.id || route.params.id;

            if (currentId) {
                // UPDATE
                response = await HttpClient.put(`posts/${currentId}`, dataToSend);
            } else {
                // CREATE
                response = await HttpClient.post('posts', dataToSend);

                if (response.data && (response.data.id || response.data.post?.id)) {
                    localData.id = response.data.id || response.data.post.id;
                }
            }

            Swal.fire({
                icon: 'success',
                title: '¡Guardado!',
                timer: 2000,
                showConfirmButton: false
            });

        } catch (error: any) {
            console.error("❌ Error:", error);
            let msg = "Error al guardar";
            if (error.response?.status === 422) {
                const errors = error.response.data.errors;
                msg = Object.values(errors).flat().join('<br>');
            }
            Swal.fire("Error", msg, "error");
        } finally {
            isSaving.value = false;
        }
    };

    // ==========================================
    // 5. CARGAR DATOS (EXTRACCIÓN EXACTA)
    // ==========================================
    onMounted(async () => {
        try {
            // A. Categorías
            try {
                const catRes = await HttpClient.get('categories');
                categories.value = catRes.data.data || catRes.data || [];
            } catch (e) { console.warn("Error cargando categorías:", e); }

            // B. Cargar la Noticia
            const identifier = route.params.id || route.params.slug;
            if (identifier) {
                const response = await HttpClient.get(`posts/${identifier}`);
                const postData = response.data.post || response.data.data || response.data;
                
                console.log("🔍 RADIOGRAFÍA DEL POST:", postData); 

                if (postData) {
                    // 1. Extraer los bloques dinámicos
                    let blocks = postData.content_blocks || postData.body;
                    if (typeof blocks === 'string') {
                        try { blocks = JSON.parse(blocks); } catch (e) { blocks = {}; }
                    }
                    blocks = blocks || {};

                    // 2. Limpiar la fecha para el input type="date"
                    let cleanDate = new Date().toISOString().split('T')[0];
                    if (postData.start_date) {
                        cleanDate = postData.start_date.split('T')[0];
                    }

                    // 3. Mapear todo al estado local
                    Object.assign(localData, {
                        id: postData.id,
                        title: postData.title || '',
                        subtitle: postData.excerpt || '',
                        imageUrl: postData.featured_image_path || '',
                        date: cleanDate,
                        
                        // Extraemos la categoría directamente del objeto anidado o del ID
                        category: postData.category?.id || postData.category_id || '',

                        // Datos del JSON / Blocks
                        content: blocks.html || '',
                        author: blocks.author?.name || '',
                        authorRole: blocks.author?.role || '',
                        authorAvatar: blocks.author?.avatar || '',
                        readTime: blocks.extra?.read_time || '5 min',
                        tags: blocks.extra?.tags || []
                    });
                }
            }
        } catch (e) {
            console.error(e);
            Swal.fire("Error", "No se pudo cargar la noticia.", "error");
        }
    });
</script>
<template>
    <div class="news-editor-layout d-flex bg-light" style="height: 100vh; width: 100vw; overflow: hidden;">

        <aside class="editor-sidebar bg-white border-end d-flex flex-column shadow-sm"
            style="width: 420px; min-width: 420px; height: 100%;">

            <div class="sidebar-header p-3 border-bottom bg-white">
                <div class="d-flex align-items-center justify-content-between mb-2">
                    <button class="btn btn-sm btn-outline-secondary border-0" @click="$router.go(-1)">
                        <i class="las la-arrow-left"></i> Volver
                    </button>
                    <span class="badge bg-dark text-uppercase ls-1">Editor Blog</span>
                </div>
                <h6 class="m-0 text-truncate fw-bold text-dark">{{ localData.title || 'Nueva Noticia' }}</h6>
                <small class="text-muted" v-if="localData.date">Publicación: {{ localData.date }}</small>
            </div>

            <div class="sidebar-body flex-grow-1 overflow-y-auto p-3 custom-scrollbar">

                <div class="card mb-3 border shadow-sm">
                    <div class="card-header bg-white p-2 d-flex justify-content-between align-items-center cursor-pointer user-select-none"
                        @click="toggleSection('header')">
                        <span class="small fw-bold text-uppercase"><i class="las la-heading"></i> Cabecera & SEO</span>
                        <i class="las" :class="sections.header ? 'la-angle-up' : 'la-angle-down'"></i>
                    </div>
                    <div v-show="sections.header" class="card-body bg-light bg-opacity-10 p-3">
                        <div class="mb-3">
                            <label class="form-label-xs">Título Principal (H1)</label>
                            <textarea v-model="localData.title" class="form-control form-control-sm fw-bold"
                                rows="2"></textarea>
                        </div>
                        <div class="mb-3">
                            <label class="form-label-xs">Subtítulo / Bajada</label>
                            <textarea v-model="localData.subtitle" class="form-control form-control-sm"
                                rows="2"></textarea>
                        </div>
                        <div class="row g-2">
                            <div class="col-6">
                                <label class="form-label-xs">Categoría</label>
                                <select v-model="localData.category" class="form-select form-select-sm">
                                    <option value="" disabled>-- Seleccionar --</option>
                                    <option v-for="cat in categories" :key="cat.id" :value="cat.id">{{ cat.name }}
                                    </option>
                                </select>
                            </div>
                            <div class="col-6">
                                <label class="form-label-xs">Tiempo Lectura</label>
                                <input v-model="localData.readTime" class="form-control form-control-sm"
                                    placeholder="Ej: 5 min">
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card mb-3 border shadow-sm">
                    <div class="card-header bg-white p-2 d-flex justify-content-between align-items-center cursor-pointer user-select-none"
                        @click="toggleSection('media')">
                        <span class="small fw-bold text-uppercase"><i class="las la-image"></i> Portada</span>
                        <i class="las" :class="sections.media ? 'la-angle-up' : 'la-angle-down'"></i>
                    </div>
                    <div v-show="sections.media" class="card-body p-3 text-center">
                        <div class="ratio ratio-16x9 bg-light rounded border mb-2 position-relative overflow-hidden group-hover cursor-pointer"
                            @click="openMediaSelector('cover')">
                            <img v-if="localData.imageUrl" :src="formatImageUrl(localData.imageUrl)"
                                class="object-fit-cover w-100 h-100">
                            <div v-else class="d-flex align-items-center justify-content-center text-muted w-100 h-100">
                                <div class="small"><i class="las la-cloud-upload-alt fs-3"></i><br>Subir Imagen</div>
                            </div>
                            <div
                                class="position-absolute inset-0 bg-dark bg-opacity-50 d-flex align-items-center justify-content-center opacity-0 hover-opacity-100 transition">
                                <span class="text-white small fw-bold"><i class="las la-sync"></i> Cambiar</span>
                            </div>
                        </div>
                        <small class="text-muted d-block text-start" style="font-size: 0.7rem;">Clic en la imagen para
                            cambiarla.</small>
                    </div>
                </div>

                <div class="card mb-3 border shadow-sm">
                    <div class="card-header bg-white p-2 d-flex justify-content-between align-items-center cursor-pointer user-select-none"
                        @click="toggleSection('content')">
                        <span class="small fw-bold text-uppercase"><i class="las la-pen-nib"></i> Cuerpo de la
                            Noticia</span>
                        <span class="badge bg-info text-dark" style="font-size: 0.6rem;">HTML</span>
                    </div>
                    <div v-show="sections.content" class="card-body p-0">
                        <div class="editor-wrapper">
                            <div
                                class="editor-controls d-flex justify-content-between align-items-center p-2 bg-light border-bottom">
                                <small class="text-muted fw-bold ms-2">
                                    MODO: {{ isCodeMode ? 'CÓDIGO HTML' : 'EDITOR VISUAL' }}
                                </small>
                                <button type="button" class="btn btn-sm"
                                    :class="isCodeMode ? 'btn-success' : 'btn-outline-dark'"
                                    @click="isCodeMode = !isCodeMode">
                                    <i :class="isCodeMode ? 'bi bi-eye' : 'bi bi-code-slash'"></i>
                                    {{ isCodeMode ? ' Ver Resultado' : ' Editar HTML' }}
                                </button>
                            </div>

                            <div class="editor-container">
                                <QuillEditor v-if="!isCodeMode" v-model:content="localData.content" contentType="html"
                                    theme="snow" :toolbar="allToolbarOptions"
                                    style="min-height: 400px; border: none;" />

                                <textarea v-else v-model="localData.content" class="html-raw-editor"
                                    placeholder="Escribe o pega tu código HTML aquí..."
                                    style="min-height: 400px; width: 100%;"></textarea>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card mb-3 border shadow-sm">
                    <div class="card-header bg-white p-2 d-flex justify-content-between align-items-center cursor-pointer user-select-none"
                        @click="toggleSection('meta')">
                        <span class="small fw-bold text-uppercase"><i class="las la-user-tag"></i> Autor & Tags</span>
                        <i class="las" :class="sections.meta ? 'la-angle-up' : 'la-angle-down'"></i>
                    </div>

                    <div v-show="sections.meta" class="card-body p-3">

                        <label class="form-label-xs mb-2">Perfil del Autor</label>
                        <div class="d-flex gap-2 align-items-start mb-3">
                            <div class="avatar-uploader rounded-circle bg-light border position-relative overflow-hidden cursor-pointer group-hover flex-shrink-0"
                                style="width: 50px; height: 50px;" @click="openMediaSelector('avatar')">
                                <img v-if="localData.authorAvatar" :src="formatImageUrl(localData.authorAvatar)"
                                    class="w-100 h-100 object-fit-cover">
                                <div v-else
                                    class="w-100 h-100 d-flex align-items-center justify-content-center text-muted">
                                    <i class="las la-user"></i>
                                </div>
                                <div
                                    class="position-absolute inset-0 bg-dark bg-opacity-50 d-flex align-items-center justify-content-center opacity-0 hover-opacity-100 transition">
                                    <i class="las la-camera text-white small"></i>
                                </div>
                            </div>

                            <div class="flex-grow-1">
                                <input v-model="localData.author" class="form-control form-control-sm mb-1"
                                    placeholder="Nombre completo">
                                <input v-model="localData.authorRole" class="form-control form-control-sm text-muted"
                                    placeholder="Cargo (Ej: Editor)">
                            </div>
                        </div>

                        <hr class="border-secondary opacity-10 my-3">

                        <div>
                            <label class="form-label-xs">Etiquetas</label>
                            <div class="border rounded p-2 bg-white">
                                <div class="d-flex flex-wrap gap-1 mb-2">
                                    <span v-for="(tag, i) in localData.tags" :key="i"
                                        class="badge bg-light text-dark border d-flex align-items-center">
                                        #{{ tag }} <i class="las la-times ms-1 cursor-pointer text-danger"
                                            @click="removeTag(i)"></i>
                                    </span>
                                </div>
                                <input v-model="tagInput" @keydown.enter.prevent="addTag"
                                    class="form-control form-control-sm border-0 shadow-none p-0"
                                    placeholder="Escribe tag...">
                            </div>
                        </div>
                    </div>
                </div>

            </div>

            <div class="sidebar-footer p-3 border-top bg-white">
                <button
                    class="btn btn-dark w-100 fw-bold shadow-sm d-flex align-items-center justify-content-center gap-2"
                    @click="saveToStore" :disabled="isSaving">
                    <i v-if="isSaving" class="las la-spinner la-spin"></i>
                    <i v-else class="las la-save"></i>
                    {{ isSaving ? 'GUARDANDO...' : 'GUARDAR CAMBIOS' }}
                </button>
            </div>
        </aside>

        <main class="editor-canvas flex-grow-1 bg-secondary bg-opacity-10 position-relative h-100 overflow-hidden">
            <div class="h-100 overflow-auto custom-scrollbar p-0 p-lg-5">

                <ArticleDetail :post="localData" :category-name="getCategoryName(localData.category)" />

                <div style="height: 100px;"></div>
            </div>
        </main>

        <MediaSelector v-if="isMediaModalOpen" @close="isMediaModalOpen = false" @select="handleMediaSelected" />
    </div>
</template>



<style scoped lang="scss">
.form-label-xs {
    font-size: 0.75rem;
    font-weight: 700;
    color: #6c757d;
    text-transform: uppercase;
    margin-bottom: 0.25rem;
    display: block;
}

.custom-scrollbar::-webkit-scrollbar {
    width: 6px;
}

.custom-scrollbar::-webkit-scrollbar-thumb {
    background: #ccc;
    border-radius: 4px;
}

.cursor-pointer {
    cursor: pointer;
}

.user-select-none {
    user-select: none;
}

.hover-opacity-100:hover {
    opacity: 1 !important;
}

.transition {
    transition: all 0.2s ease;
}

.preview-header {
    height: 500px;

    .header-bg {
        position: absolute;
        inset: 0;
        background-size: cover;
        background-position: center;
        opacity: 0.6;
        transition: background-image 0.3s ease;
    }

    .header-overlay {
        position: absolute;
        inset: 0;
        background: linear-gradient(0deg, rgba(0, 0, 0, 0.8) 0%, transparent 100%);
    }
}

.badge-category {
    background: #e63946;
    color: white;
    padding: 4px 12px;
    font-size: 0.75rem;
    font-weight: 700;
    border-radius: 4px;
}

.article-body-content :deep(p) {
    margin-bottom: 1.2rem;
    line-height: 1.7;
    font-size: 1.1rem;
    color: #333;
}

.article-body-content :deep(h2) {
    margin-top: 2rem;
    font-weight: 800;
    color: #111;
}

.article-body-content :deep(img) {
    max-width: 100%;
    border-radius: 8px;
    margin: 1rem 0;
}

.article-body-content :deep(blockquote) {
    border-left: 4px solid #e63946;
    padding-left: 1rem;
    font-style: italic;
    background: #f9f9f9;
    padding: 1rem;
}
</style>