<script setup lang="ts">
import { ref, onMounted, computed, watch } from 'vue';
import { useRoute } from 'vue-router';
import HttpClient from "@/helpers/http-client";
import Swal from "sweetalert2";
import draggable from 'vuedraggable';
import MediaSelector from '@/components/modals/MediaSelector.vue';
import { useAuthStore } from "@/stores/auth"; 

import { 
    resolveBlock, 
    resolveEditor, 
    BlockLabels, 
    getInitialData, 
    blockGroups, 
    blockIcons 
} from '@shared/core/BlockRegistry';

// --- 1. ESTADO DEL EDITOR ---
const blocks = ref<any[]>([]);
const post = ref<any>({ 
    title: '', 
    font_family: 'system-ui, sans-serif', 
    primary_color: '#ff8121', 
    content_blocks: [] 
});

const activeBlockId = ref<string | null>(null);
const saving = ref(false);
const isDarkMode = ref(false);
const route = useRoute();
const authStore = useAuthStore();

// --- 2. ESTADO DE LA INTERFAZ (SIDEBARS) ---
const showLeftSidebar = ref(true);
const showRightSidebar = ref(true);

// Variables para manejar la lógica de la fuente personalizada
const selectedFontMode = ref('system-ui, sans-serif');
const customFontValue = ref('');

// --- 3. COMPUTED PROPERTIES ---
const activeBlock = computed(() => blocks.value.find(b => b.id === activeBlockId.value) || null);

// --- 4. GESTIÓN DE BLOQUES ---
const selectBlock = (id: string) => { 
    activeBlockId.value = id; 
    showRightSidebar.value = true; // Abrir automáticamente al seleccionar
};

const cloneBlock = (blockKey: string) => ({
    id: crypto.randomUUID(),
    type: blockKey,
    content: getInitialData(blockKey)
});

const addBlock = (type: string) => {
    const newBlock = { 
        id: crypto.randomUUID(), 
        type, 
        content: getInitialData(type) 
    };
    blocks.value.push(newBlock);
    activeBlockId.value = newBlock.id;
    showRightSidebar.value = true;
    
    setTimeout(() => { 
        const container = document.querySelector('.canvas-container');
        if (container) container.scrollTo({ top: container.scrollHeight, behavior: 'smooth' }); 
    }, 150);
};

const removeBlock = (i: number) => { 
    Swal.fire({ 
        title: '¿Eliminar este bloque?', 
        text: "Se borrará el contenido de esta sección.",
        icon: 'warning', 
        showCancelButton: true, 
        confirmButtonText: 'Sí, eliminar',
        cancelButtonText: 'Cancelar', 
        confirmButtonColor: '#dc3545' 
    }).then((r) => { 
        if(r.isConfirmed) {
            if (blocks.value[i].id === activeBlockId.value) activeBlockId.value = null;
            blocks.value.splice(i, 1);
        }
    });
};

// --- 5. LÓGICA DE FUENTES Y ESTILOS GLOBALES ---

watch([selectedFontMode, customFontValue], ([mode, custom]) => {
    if (mode === 'custom') {
        post.value.font_family = custom || 'system-ui, sans-serif';
    } else {
        post.value.font_family = mode;
    }
});

const loadGoogleFont = (fontFamily: string) => {
    if (!fontFamily || fontFamily.includes('system-ui')) return;
    const parts = fontFamily.split(',');
    if (parts.length === 0) return;
    let fontName = parts[0].replace(/['"]/g, '').trim();
    if (!fontName) return;
    const linkId = `gfont-${fontName.replace(/\s+/g, '-').toLowerCase()}`;
    if (!document.getElementById(linkId)) {
        const link = document.createElement('link');
        link.id = linkId; link.rel = 'stylesheet';
        try {
            link.href = `https://fonts.googleapis.com/css2?family=${fontName.replace(/\s+/g, '+')}:wght@400;700&display=swap`;
            document.head.appendChild(link);
        } catch(e) { }
    }
};

watch(() => post.value.font_family, (newFont) => {
    loadGoogleFont(newFont);
}, { immediate: true });

// --- 6. SINCRONIZACIÓN AUTOMÁTICA DEL MENÚ ---
watch(blocks, (newBlocks) => {
    const headerBlock = newBlocks.find(b => 
        ['HeaderBlock', 'HeaderInnova', 'HeaderInnovaBlock'].includes(b.type)
    );
    if (!headerBlock) return;
    const newSections = newBlocks
        .filter(b => b.id !== headerBlock.id && b.type !== 'FooterBlock')
        .map(b => ({
            id: b.id,
            label: b.content.title || b.content.heroTitle || b.content.heading || BlockLabels[b.type] || 'Sección',
            url: `#sec-${b.id}`
        }));
    const currentNavLinksStr = JSON.stringify(headerBlock.content.navLinks);
    const newSectionsStr = JSON.stringify(newSections);
    if (currentNavLinksStr !== newSectionsStr) {
        headerBlock.content.navLinks = newSections;
    }
}, { deep: true });

// --- 7. GESTIÓN DE IMÁGENES ---
const isMediaModalOpen = ref(false);
const activeSelectionTarget = ref<{obj: any, key: string} | null>(null);

const handleImageSelection = (contentBlock: any, payload: any) => {
    if (payload && typeof payload === 'object' && payload.item) {
        activeSelectionTarget.value = { obj: payload.item, key: payload.field };
    } else {
        activeSelectionTarget.value = { obj: contentBlock, key: payload };
    }
    isMediaModalOpen.value = true;
};

const handleMediaSelected = (p: { url: string }) => {
    if (activeSelectionTarget.value) {
        activeSelectionTarget.value.obj[activeSelectionTarget.value.key] = p.url;
    }
    isMediaModalOpen.value = false;
};

// --- 8. PERSISTENCIA ---
onMounted(async () => {
    try {
        const { data } = await HttpClient.get(`pages/${route.params.id}`, {
            params: { academic_unit_id: authStore.academicUnitId }
        });
        const loaded = data.post || data.data; 
        post.value = {
            ...loaded,
            font_family: loaded.font_family || 'system-ui, sans-serif',
            primary_color: loaded.primary_color 
        };
        const predefinedFonts = ["system-ui, sans-serif", "'Montserrat', sans-serif", "'Poppins', sans-serif", "'Roboto', sans-serif", "'Playfair Display', serif", "'Oswald', sans-serif"];
        if (predefinedFonts.includes(post.value.font_family)) {
            selectedFontMode.value = post.value.font_family;
        } else {
            selectedFontMode.value = 'custom';
            customFontValue.value = post.value.font_family;
        }
        if (loaded.content_blocks) {
            const raw = typeof loaded.content_blocks === 'string' ? JSON.parse(loaded.content_blocks) : loaded.content_blocks;
            blocks.value = raw.map((b: any) => ({ ...b, id: b.id || crypto.randomUUID() }));
        }
    } catch (e) { console.error("Error cargando página:", e); }
});

const savePage = async () => {
    saving.value = true;
    try {
        const payload = { ...post.value, content_blocks: blocks.value, academic_unit_id: authStore.academicUnitId, _method: 'PUT' };
        await HttpClient.post(`pages/${route.params.id}`, payload);
        Swal.fire({ toast: true, position: 'top-end', icon: 'success', title: 'Cambios guardados', showConfirmButton: false, timer: 2000 });
    } catch (e) { Swal.fire("Error", "No se pudo guardar", "error"); } finally { saving.value = false; }
};

const getBlockLabel = (type: string) => BlockLabels[type] || type;
// --- NUEVO: Computado para extraer solo secciones linkeables ---
const currentSections = computed(() => {
    return blocks.value
        .filter(b => !['HeaderBlock', 'HeaderInnova', 'HeaderInnovaBlock', 'FooterBlock'].includes(b.type))
        .map(b => ({
            id: b.id,
            title: b.content.title || b.content.heroTitle || b.content.heading || BlockLabels[b.type] || 'Sección sin nombre'
        }));
});

</script>
<template>
    <div class="page-editor-container vh-100 d-flex flex-column overflow-hidden"
        :class="isDarkMode ? 'bg-dark text-white' : 'bg-light text-dark'" 
        :data-bs-theme="isDarkMode ? 'dark' : 'light'">

        <header class="border-bottom px-4 py-2 d-flex justify-content-between align-items-center shadow-sm flex-shrink-0"
            :class="isDarkMode ? 'bg-dark border-secondary' : 'bg-white'" style="z-index: 1020;">
            <div class="d-flex align-items-center">
                <button class="btn btn-sm btn-outline-secondary me-3" @click="$router.go(-1)">
                    <i class="las la-arrow-left"></i>
                </button>
                
                <div class="btn-group me-3 shadow-sm">
                    <button class="btn btn-sm btn-light border" @click="showLeftSidebar = !showLeftSidebar" :class="{'active': showLeftSidebar}" title="Panel de Bloques">
                        <i class="las la-columns"></i>
                    </button>
                    <button v-if="activeBlockId" class="btn btn-sm btn-light border" @click="showRightSidebar = !showRightSidebar" :class="{'active': showRightSidebar}" title="Panel de Edición">
                        <i class="las la-indent"></i>
                    </button>
                </div>

                <h6 class="m-0 fw-bold">
                    <i class="las la-edit text-primary"></i> {{ post.title || 'Sin Título' }}
                </h6>
            </div>
            
            <div class="d-flex gap-2 text-dark">
                <button @click="savePage" :disabled="saving" class="btn btn-success btn-sm fw-bold px-4 shadow-sm">
                    <span v-if="saving" class="spinner-border spinner-border-sm me-2"></span>
                    {{ saving ? 'GUARDANDO...' : '💾 GUARDAR CAMBIOS' }}
                </button>
            </div>
        </header>

        <div class="d-flex flex-grow-1 overflow-hidden">

            <aside class="sidebar border-end d-flex flex-column h-100 shadow-sm transition-sidebar"
                :class="[
                    isDarkMode ? 'bg-dark border-secondary' : 'bg-white',
                    { 'sidebar-hidden': !showLeftSidebar }
                ]">
                
                <div class="p-3 border-bottom bg-primary bg-opacity-10">
                    <h6 class="text-uppercase fw-bold mb-3 small text-primary"><i class="las la-palette me-1"></i> Estilo Global</h6>
                    
                    <div class="mb-3">
                        <label class="x-small fw-bold text-muted d-block mb-1">Tipografía</label>
                        <select v-model="selectedFontMode" class="form-select form-select-sm shadow-sm border-0 mb-2">
                            <option value="system-ui, sans-serif">Sistema (Defecto)</option>
                            <option value="'Montserrat', sans-serif">Montserrat</option>
                            <option value="'Poppins', sans-serif">Poppins</option>
                            <option value="'Roboto', sans-serif">Roboto</option>
                            <option value="'Playfair Display', serif">Elegante (Playfair)</option>
                            <option value="'Oswald', sans-serif">Oswald</option>
                            <option value="custom">Otra (Escribir nombre)...</option>
                        </select>

                        <div v-if="selectedFontMode === 'custom'" class="mt-2">
                            <input 
                                type="text" 
                                class="form-control form-control-sm border-0 shadow-sm" 
                                placeholder="Ej: 'Bebas Neue', sans-serif"
                                v-model="customFontValue"
                            >
                            <small class="text-muted d-block mt-1" style="font-size: 0.65rem; line-height: 1.1;">
                                Escribe el nombre exacto de Google Fonts, seguido de la familia de fallback.
                            </small>
                        </div>
                    </div>
                </div>

                <div class="p-2 border-bottom bg-light text-center">
                    <h6 class="text-uppercase fw-bold m-0 x-small text-secondary">Bloques Disponibles</h6>
                </div>
                
                <div class="p-3 overflow-y-auto flex-grow-1 custom-scrollbar">
                    <div v-for="(group, gIdx) in blockGroups" :key="gIdx" class="mb-4">
                        <span class="small fw-bold text-uppercase text-muted mb-2 d-block" style="font-size: 0.65rem;">{{ group.name }}</span>
                        <draggable 
                            :list="group.keys" 
                            :group="{ name: 'blocks', pull: 'clone', put: false }" 
                            :sort="false"
                            :clone="cloneBlock"
                            item-key="id"
                        >
                            <template #item="{ element: blockKey }">
                                <div class="block-card p-2 mb-2 rounded border bg-white text-dark shadow-sm d-flex align-items-center"
                                    @click="addBlock(blockKey)">
                                    <div class="icon-box me-2 bg-light rounded text-primary">
                                        <i :class="blockIcons[blockKey] || group.icon"></i>
                                    </div>
                                    <span class="small fw-medium">{{ BlockLabels[blockKey] || blockKey }}</span>
                                </div>
                            </template>
                        </draggable>
                    </div>
                </div>
            </aside>

            <main class="canvas-container flex-grow-1 overflow-auto position-relative p-4 transition-all" 
                :class="isDarkMode ? 'bg-black' : 'bg-secondary bg-opacity-10'">
                
                <div class="canvas-content mx-auto shadow-sm min-vh-100" 
                     :class="isDarkMode ? 'bg-dark' : 'bg-white'"
                     :style="{ 
                        '--global-font': post.font_family || 'system-ui, sans-serif',
                        'font-family': 'var(--global-font)'
                     }">
                    
                    <draggable 
                        v-model="blocks" 
                        group="blocks" 
                        item-key="id"
                        handle=".drag-handle"
                        ghost-class="ghost-card"
                        drag-class="dragging-card"
                        animation="200"
                    >
                        <template #item="{ element: block, index }">
                            <div class="block-editable-wrapper position-relative group"
                                :class="{ 'is-active': activeBlockId === block.id }"
                                @click.stop="selectBlock(block.id)">
                                
                                <div class="block-overlay-tools position-absolute shadow-lg rounded-pill border bg-white p-1 d-flex gap-1" style="z-index: 100;">
                                    <button class="btn btn-sm btn-primary rounded-pill px-3 drag-handle">
                                        <i class="las la-arrows-alt me-1"></i> <small class="fw-bold text-white">MOVER</small>
                                    </button>
                                    <button class="btn btn-sm btn-dark rounded-pill px-3" @click.stop="selectBlock(block.id)">
                                        <i class="las la-cog me-1"></i> <small class="fw-bold">EDITAR</small>
                                    </button>
                                    <button class="btn btn-sm btn-outline-danger rounded-pill px-3" @click.stop="removeBlock(index)">
                                        <i class="las la-trash me-1"></i> <small class="fw-bold">ELIMINAR</small>
                                    </button>
                                </div>

                                <div class="visual-preview-area" :id="'sec-' + block.id">
                                    <component :is="resolveBlock(block.type)" :data="block.content" />
                                </div>
                            </div>
                        </template>
                    </draggable>

                    <div v-if="blocks.length === 0" class="text-center py-5 opacity-50">
                        <i class="las la-plus-circle fs-1 text-primary"></i>
                        <p class="fw-bold mt-2">Arrastra bloques para construir tu página</p>
                    </div>
                </div>
            </main>

            <transition name="panel">
                <aside v-if="activeBlock && showRightSidebar" class="inspector-panel border-start d-flex flex-column h-100 shadow-lg bg-white text-dark transition-sidebar" 
                    :class="{ 'sidebar-hidden': !showRightSidebar }"> 
                    
                    <div class="p-3 border-bottom bg-primary text-white d-flex justify-content-between align-items-center shadow-sm">
                        <div class="d-flex align-items-center">
                            <div class="bg-white text-primary rounded-circle p-2 me-3 d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                <i :class="blockIcons[activeBlock.type]" class="fs-4"></i>
                            </div>
                            <div>
                                <h6 class="m-0 fw-bold small text-uppercase text-white">Configurar Bloque</h6>
                                <small class="opacity-75 text-white">{{ getBlockLabel(activeBlock.type) }}</small>
                            </div>
                        </div>
                        <button class="btn-close btn-close-white" @click="showRightSidebar = false"></button>
                    </div>

                    <div class="p-4 overflow-y-auto flex-grow-1 custom-scrollbar bg-light">
                        <component 
                            v-if="resolveEditor(activeBlock.type)"
                            :is="resolveEditor(activeBlock.type)" 
                            v-model="activeBlock.content" 
                            :availableSections="currentSections" 
                            @select-image="(payload) => handleImageSelection(activeBlock.content, payload)"
                        />
                    </div>

                    <div class="p-3 border-top bg-white">
                        <button class="btn btn-primary w-100 shadow fw-bold py-2" @click="showRightSidebar = false">
                            <i class="las la-check-circle me-2"></i> CERRAR EDITOR
                        </button>
                    </div>
                </aside>
            </transition>

        </div>

        <MediaSelector 
            collection="pages"
            v-if="isMediaModalOpen" 
            @select="handleMediaSelected" 
            @close="isMediaModalOpen = false" 
        />
    </div>
</template>



<style scoped>
/* TRANSICIÓN PARA LOS SIDEBARS */
.transition-sidebar {
    transition: all 0.35s cubic-bezier(0.4, 0, 0.2, 1);
    overflow: hidden;
}

/* SIDEBAR IZQUIERDO */
.sidebar {
    width: 280px;
    min-width: 280px;
}
.sidebar.sidebar-hidden {
    width: 0 !important;
    min-width: 0 !important;
    opacity: 0;
    border: none !important;
}

/* INSPECTOR DERECHO */
.inspector-panel {
    width: 410px;
    min-width: 410px;
}
.inspector-panel.sidebar-hidden {
    width: 0 !important;
    min-width: 0 !important;
    opacity: 0;
}

/* CANVAS ANIMATION */
.canvas-container {
    transition: all 0.35s ease;
}

.block-editable-wrapper {
    position: relative;
    border: 2px solid transparent;
    transition: 0.2s;
    /* 1. ELIMINAMOS el transform: translateZ(0) porque "atrapa" los z-index y no deja que las herramientas resalten */
}   

/* 2. EL SECRETO: Cuando pasas el mouse o está activo, el contenedor salta al frente (z-index alto) */
.block-editable-wrapper:hover,
.block-editable-wrapper.is-active {
    z-index: 999; /* Por encima del Header y de cualquier otro bloque */
    border-color: #0d6efd;
    box-shadow: 0 0 0 1px #0d6efd;
}

.block-overlay-tools {
    /* 3. Lo movemos un poquito hacia adentro para que nunca se corte si está muy arriba */
    top: 10px; 
    right: 10px;
    opacity: 0;
    transition: 0.2s;
    transform: translateY(-5px);
    z-index: 1000 !important; /* Herramientas intocables, siempre por encima de todo */
}

/* 4. Mantenemos las herramientas visibles si el bloque está activo o en hover */
.block-editable-wrapper:hover .block-overlay-tools,
.block-editable-wrapper.is-active .block-overlay-tools {
    opacity: 1;
    transform: translateY(0);
}

.x-small { font-size: 0.65rem; }
.block-card { cursor: grab; transition: 0.2s; }
.block-card:hover { transform: translateY(-2px); }

.icon-box {
    width: 32px;
    height: 32px;
    display: flex;
    align-items: center;
    justify-content: center;
}

.custom-scrollbar::-webkit-scrollbar { width: 5px; }
.custom-scrollbar::-webkit-scrollbar-thumb { background: #cbd5e0; border-radius: 10px; }

/* TRANSICIÓN DE VUE PARA EL PANEL */
.panel-enter-active, .panel-leave-active { transition: all 0.35s ease; }
.panel-enter-from, .panel-leave-to { transform: translateX(100%); opacity: 0; }
</style>