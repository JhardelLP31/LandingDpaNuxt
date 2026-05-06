<template>
    <div class="builder-container">
        <header class="designer-header shadow-sm position-relative z-3">
            <div class="d-flex align-items-center gap-2">
                <b-button variant="outline-secondary" @click="goBack" size="sm" class="me-2" title="Regresar">
                    <i class="las la-arrow-left"></i>
                </b-button>

                <b-button variant="light" @click="toggleLeftSidebar" size="sm" class="border" title="Ocultar/Mostrar Configuración">
                    <i class="las" :class="isLeftSidebarOpen ? 'la-angle-double-left' : 'la-list'"></i>
                </b-button>

                <div class="brand-icon shadow-sm ms-2"><i class="las la-swatchbook"></i></div>
                <div>
                    <h5 class="mb-0 fw-bold">Identidad Institucional</h5>
                    <span class="badge bg-soft-primary text-primary">Unidad Académica ID: {{ authStore.academicUnitId }}</span>
                </div>
            </div>

            <div class="d-flex gap-3 align-items-center">
                <b-button variant="outline-dark" @click="loadInitialData" size="sm" class="rounded-pill px-3">
                    <i class="las la-sync"></i> Refrescar
                </b-button>
                <b-button variant="success" @click="saveBranding" :disabled="loading" size="sm" class="rounded-pill px-4 shadow">
                    <span v-if="loading" class="spinner-border spinner-border-sm me-2"></span>
                    <i v-else class="las la-save me-1"></i> Publicar Cambios
                </b-button>
                
                <b-button variant="light" @click="toggleRightSidebar" size="sm" class="border ms-2" title="Ocultar/Mostrar Editor">
                    <i class="las" :class="isRightSidebarOpen ? 'la-angle-double-right' : 'la-edit'"></i>
                </b-button>
            </div>
        </header>

        <div class="designer-main">
            <aside class="designer-sidebar-left bg-white shadow-sm position-relative z-2" :class="{ 'collapsed': !isLeftSidebarOpen }">
                <div class="sidebar-content">
                    <div class="accordion-panel border rounded mb-3">
                        <div class="accordion-header p-3 cursor-pointer d-flex justify-content-between align-items-center bg-light" @click="togglePanel('model')">
                            <label class="section-title mb-0 cursor-pointer">Modelo de Cabecera</label>
                            <i class="las" :class="panels.model ? 'la-angle-up' : 'la-angle-down'"></i>
                        </div>
                        <div class="accordion-body p-3 border-top" v-show="panels.model">
                            <div v-for="(data, key) in headerModels" :key="key" 
                                @click="changeModel(key as string, 'header')"
                                class="model-selector-card p-2 mb-2 rounded border cursor-pointer d-flex align-items-center transition-all"
                                :class="form.header_type === key ? 'border-primary bg-primary bg-opacity-10 active-model' : 'bg-white'">
                                <i :class="[data.icon, form.header_type === key ? 'text-primary' : 'text-secondary']" class="fs-4 me-2"></i>
                                <span class="small fw-bold">{{ data.label }}</span>
                            </div>
                        </div>
                    </div>

                    <div class="accordion-panel border rounded mb-3">
                        <div class="accordion-header p-3 cursor-pointer d-flex justify-content-between align-items-center bg-light" @click="togglePanel('footer_model')">
                            <label class="section-title mb-0 cursor-pointer">Modelo de Pie de Página</label>
                            <i class="las" :class="panels.footer_model ? 'la-angle-up' : 'la-angle-down'"></i>
                        </div>
                        <div class="accordion-body p-3 border-top" v-show="panels.footer_model">
                            <div v-for="(data, key) in footerModels" :key="key" 
                                @click="changeModel(key as string, 'footer')"
                                class="model-selector-card p-2 mb-2 rounded border cursor-pointer d-flex align-items-center transition-all"
                                :class="form.footer_type === key ? 'border-primary bg-primary bg-opacity-10 active-model' : 'bg-white'">
                                <i :class="[data.icon, form.footer_type === key ? 'text-primary' : 'text-secondary']" class="fs-4 me-2"></i>
                                <span class="small fw-bold">{{ data.label }}</span>
                            </div>
                        </div>
                    </div>

                    <div class="accordion-panel border rounded mb-3">
                        <div class="accordion-header p-3 cursor-pointer d-flex justify-content-between align-items-center bg-light" @click="togglePanel('nav')">
                            <label class="section-title mb-0 cursor-pointer">Estructura de Navegación</label>
                            <i class="las" :class="panels.nav ? 'la-angle-up' : 'la-angle-down'"></i>
                        </div>
                        <div class="accordion-body p-3 border-top" v-show="panels.nav">
                            <div class="control-group">
                                <small class="text-muted d-block mb-2">Menú Principal (Backend)</small>
                                <b-form-select v-model="form.selected_menu_id" @change="loadMenuItems" class="modern-input">
                                    <option :value="null">-- Seleccionar Menú --</option>
                                    <option v-for="menu in menus_list" :key="menu.id" :value="menu.id">{{ menu.name }}</option>
                                </b-form-select>
                            </div>
                        </div>
                    </div>

                    <div class="accordion-panel border rounded mb-3">
                        <div class="accordion-header p-3 cursor-pointer d-flex justify-content-between align-items-center bg-light" @click="togglePanel('palette')">
                            <label class="section-title mb-0 cursor-pointer">Paleta Institucional</label>
                            <i class="las" :class="panels.palette ? 'la-angle-up' : 'la-angle-down'"></i>
                        </div>
                        <div class="accordion-body p-3 border-top" v-show="panels.palette">
                            <div class="color-grid">
                                <div class="color-box">
                                    <b-form-input type="color" v-model="form.primary_color" />
                                    <span>Primario</span>
                                </div>
                                <div class="color-box">
                                    <b-form-input type="color" v-model="form.accent_color" />
                                    <span>Acento</span>
                                </div>
                                <div class="color-box">
                                    <b-form-input type="color" v-model="form.secondary_color" />
                                    <span>Texto/Fondo</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </aside>

            <main class="designer-canvas bg-light">
                <div class="preview-window shadow-lg d-flex flex-column h-100 overflow-hidden">
                    <div class="window-bar flex-shrink-0">
                        <div class="window-dots"><span></span><span></span><span></span></div>
                        <div class="window-url">https://{{ authStore.academicUnitId }}.portal.edu.pe</div>
                    </div>

                    <div class="window-content position-relative flex-grow-1 overflow-auto bg-dark">
                        <div class="live-preview-area w-100 position-absolute top-0 start-0 z-3">
                            <component 
                                v-if="form.header_type"
                                :is="resolveBrandingComponent(form.header_type)" 
                                :config="form.header_config"
                                :colors="{ 
                                    primary: form.primary_color, 
                                    accent: form.accent_color, 
                                    text: form.secondary_color 
                                }"
                                :menu="menu_tree"
                            />
                        </div>

                        <div class="preview-hero text-center d-flex flex-column justify-content-center align-items-center position-relative">
                            <div class="position-absolute top-0 start-0 w-100 h-100 bg-dark opacity-75"></div>
                            <div class="position-relative z-1 text-white mt-5 pt-5 px-3">
                                <h1 class="display-3 fw-bold mb-3">Banner Principal</h1>
                                <p class="lead opacity-75">Aquí iría el slider de fotos o video de la universidad.</p>
                                <p class="small text-warning mt-4"><i class="las la-info-circle"></i> Haz scroll en esta ventana para probar el efecto de menú y ver el footer.</p>
                            </div>
                        </div>
                        
                        <div class="bg-white p-5 text-center d-flex align-items-center justify-content-center flex-column" style="min-height: 800px;">
                            <h2 class="text-muted opacity-50 mb-3">Cuerpo de la Página</h2>
                            <p class="text-muted opacity-25">Contenido dinámico de noticias, eventos, etc.</p>
                        </div>

                        <div class="live-preview-area w-100 position-relative z-3">
                            <component 
                                v-if="form.footer_type"
                                :is="resolveBrandingComponent(form.footer_type)" 
                                :config="form.footer_config"
                                :colors="{ 
                                    primary: form.primary_color, 
                                    accent: form.accent_color, 
                                    text: form.secondary_color 
                                }"
                                :menu="menu_tree"
                            />
                        </div>
                    </div>
                </div>
            </main>

            <aside class="designer-sidebar-right bg-white shadow-sm position-relative z-2" :class="{ 'collapsed': !isRightSidebarOpen }">
                <div class="sidebar-content h-100">
                    
                    <div class="accordion-panel border rounded border-primary shadow-sm mb-4">
                        <div class="accordion-header p-3 bg-primary bg-opacity-10 border-bottom d-flex justify-content-between align-items-center cursor-pointer" @click="toggleRightPanel('header')">
                            <label class="section-title mb-0 text-primary cursor-pointer">Contenido de Cabecera</label>
                            <i class="las text-primary" :class="panelsRight.header ? 'la-angle-up' : 'la-angle-down'"></i>
                        </div>
                        <div class="accordion-body p-0" v-show="panelsRight.header">
                            <component 
                                v-if="form.header_type"
                                :is="resolveBrandingEditor(form.header_type)" 
                                v-model="form.header_config" 
                                @select-image="handleImageSelection($event, 'header')"
                            />
                        </div>
                    </div>

                    <div class="accordion-panel border rounded border-success shadow-sm">
                        <div class="accordion-header p-3 bg-success bg-opacity-10 border-bottom d-flex justify-content-between align-items-center cursor-pointer" @click="toggleRightPanel('footer')">
                            <label class="section-title mb-0 text-success cursor-pointer">Contenido de Pie de Página</label>
                            <i class="las text-success" :class="panelsRight.footer ? 'la-angle-up' : 'la-angle-down'"></i>
                        </div>
                        <div class="accordion-body p-0" v-show="panelsRight.footer">
                            <component 
                                v-if="form.footer_type"
                                :is="resolveBrandingEditor(form.footer_type)" 
                                v-model="form.footer_config" 
                                @select-image="handleImageSelection($event, 'footer')"
                            />
                        </div>
                    </div>

                </div>
            </aside>
        </div>

        <MediaSelector 
            collection="branding"
            v-if="isMediaModalOpen" 
            @select="handleMediaSelected" 
            @close="isMediaModalOpen = false" 
        />
    </div>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, computed } from "vue";
import { useRouter } from 'vue-router';
import HttpClient from "@/helpers/http-client";
import Swal from "sweetalert2";
import { useAuthStore } from "@/stores/auth";
import MediaSelector from '@/components/modals/MediaSelector.vue';

import { handleApiError } from "@/helpers/errorHandler";

import { 
    BRANDING_REGISTRY,
    resolveBrandingComponent, 
    resolveBrandingEditor, 
    getInitialBrandingData 
} from '@shared/core/BrandingRegistry';

// --- INICIALIZACIÓN ---
const router = useRouter();
const authStore = useAuthStore();
const loading = ref(false);

// Listas para menús
const menus_list = ref<any[]>([]); 
const menu_tree = ref<any[]>([]);  

// Estados de Interfaz (UI)
const isLeftSidebarOpen = ref(true);
const isRightSidebarOpen = ref(true);
const isMediaModalOpen = ref(false);

// Para saber qué imagen estamos editando y a quién pertenece (header o footer)
const activeSelectionTarget = ref<string | null>(null);
const activeConfigTarget = ref<'header' | 'footer'>('header');

const panels = reactive({ model: true, footer_model: false, nav: false, palette: false });
const panelsRight = reactive({ header: true, footer: false });

// Filtrar modelos del Registry basado en prefijos para no mezclarlos
const headerModels = computed(() => {
    const result: Record<string, any> = {};
    for (const [key, value] of Object.entries(BRANDING_REGISTRY)) {
        if (key.startsWith('Header')) result[key] = value;
    }
    return result;
});

const footerModels = computed(() => {
    const result: Record<string, any> = {};
    for (const [key, value] of Object.entries(BRANDING_REGISTRY)) {
        if (key.startsWith('Footer')) result[key] = value;
    }
    return result;
});

// El Formulario Principal (Payload)
const form = reactive({
    id: null,
    academic_unit_id: authStore.academicUnitId,
    primary_color: '#003366',
    secondary_color: '#ffffff',
    accent_color: '#ffcc00',
    selected_menu_id: null as number | null, 
    
    // Header
    header_type: Object.keys(headerModels.value)[0] || 'HeaderOverlay',
    header_config: {} as Record<string, any>, 
    
    // Footer
    footer_type: Object.keys(footerModels.value)[0] || 'FooterStandard',
    footer_config: {} as Record<string, any>, 

    custom_css: '' 
});

// Inicializar configs por defecto si existen
form.header_config = getInitialBrandingData(form.header_type);
form.footer_config = getInitialBrandingData(form.footer_type);

// --- FUNCIONES DE NAVEGACIÓN Y UI ---
const goBack = () => router.back();
const toggleLeftSidebar = () => { isLeftSidebarOpen.value = !isLeftSidebarOpen.value; };
const toggleRightSidebar = () => { isRightSidebarOpen.value = !isRightSidebarOpen.value; };
const togglePanel = (panelName: keyof typeof panels) => { panels[panelName] = !panels[panelName]; };

const toggleRightPanel = (panelName: 'header' | 'footer') => { 
    panelsRight.header = false;
    panelsRight.footer = false;
    panelsRight[panelName] = true;
};

// --- GESTIÓN DE CONTENIDO Y MODELOS ---
const changeModel = (key: string, target: 'header' | 'footer') => {
    if (target === 'header') {
        if (form.header_type === key) return;
        form.header_type = key;
        form.header_config = getInitialBrandingData(key);
        panelsRight.header = true;
        panelsRight.footer = false;
    } else {
        if (form.footer_type === key) return;
        form.footer_type = key;
        form.footer_config = getInitialBrandingData(key);
        panelsRight.footer = true;
        panelsRight.header = false;
    }
};

const handleImageSelection = (fieldKey: string, target: 'header' | 'footer') => {
    activeSelectionTarget.value = fieldKey;
    activeConfigTarget.value = target;
    isMediaModalOpen.value = true;
};

const handleMediaSelected = (payload: { url: string }) => {
    if (activeSelectionTarget.value && activeConfigTarget.value) {
        if (activeConfigTarget.value === 'header') {
            form.header_config[activeSelectionTarget.value] = payload.url;
        } else {
            form.footer_config[activeSelectionTarget.value] = payload.url;
        }
    }
    isMediaModalOpen.value = false;
};

// --- CARGA DE DATOS (HIDRATACIÓN) ---
const loadMenuItems = async () => {
    if (!form.selected_menu_id) {
        menu_tree.value = [];
        return;
    }
    try {
        const res = await HttpClient.get(`menus/${form.selected_menu_id}`);
        const data = res.data.data || res.data;
        menu_tree.value = data.items || [];
    } catch (e: any) {
        // 🔥 2. Aplicado a la carga de items de menú
        handleApiError(e, "Error al cargar items del menú");
    }
};

const loadInitialData = async () => {
    loading.value = true;
    try {
        const resMenus = await HttpClient.get('menus', { 
            params: { academic_unit_id: authStore.academicUnitId } 
        });
        menus_list.value = resMenus.data.data || resMenus.data;

        // Recuerda que el controlador devuelve status 200 e 'is_new: true' si no existe,
        // por lo que un error aquí es puramente del servidor o permisos (403/500).
        const resBranding = await HttpClient.get(`unit-branding/unit/${authStore.academicUnitId}`);
        const data = resBranding.data.data || resBranding.data;
        
        if (data) {
            form.id = data.id;
            form.primary_color = data.primary_color || form.primary_color;
            form.secondary_color = data.secondary_color || form.secondary_color;
            form.accent_color = data.accent_color || form.accent_color;
            form.selected_menu_id = data.selected_menu_id;
            
            // Preferimos las columnas dedicadas de la DB si existen
            if (data.header_config && typeof data.header_config === 'object' && Object.keys(data.header_config).length > 0) {
                form.header_config = data.header_config;
            }
            if (data.footer_config && typeof data.footer_config === 'object' && Object.keys(data.footer_config).length > 0) {
                form.footer_config = data.footer_config;
            }

            // DESEMPAQUETAR EL JSON DE CUSTOM_CSS (Backup de configuración y tipos)
            if (data.custom_css) {
                try {
                    let parsedBlocks = [];
                    if (typeof data.custom_css === 'string') {
                        parsedBlocks = JSON.parse(data.custom_css);
                    } else if (Array.isArray(data.custom_css)) {
                        parsedBlocks = data.custom_css;
                    }

                    if (Array.isArray(parsedBlocks) && parsedBlocks.length > 0) {
                        // Buscar bloque de Header
                        const savedHeader = parsedBlocks.find(b => b.type && b.type.startsWith('Header')) || parsedBlocks[0];
                        if (savedHeader) {
                            form.header_type = savedHeader.type || form.header_type;
                            // Si la DB no trajo header_config en su columna, lo sacamos del JSON
                            if (!data.header_config || Object.keys(data.header_config).length === 0) {
                                form.header_config = savedHeader.content || getInitialBrandingData(form.header_type);
                            }
                        }

                        // Buscar bloque de Footer
                        const savedFooter = parsedBlocks.find(b => b.type && b.type.startsWith('Footer')) || parsedBlocks[1];
                        if (savedFooter) {
                            form.footer_type = savedFooter.type || form.footer_type;
                            // Si la DB no trajo footer_config en su columna, lo sacamos del JSON
                            if (!data.footer_config || Object.keys(data.footer_config).length === 0) {
                                form.footer_config = savedFooter.content || getInitialBrandingData(form.footer_type);
                            }
                        }
                    }
                } catch (err) {
                    console.error("Error parseando diseño guardado, usando valores por defecto", err);
                }
            }

            // Sincronizar el menu ID si estaba guardado en la config del header
            if (!form.selected_menu_id && form.header_config.menu_id) {
                form.selected_menu_id = form.header_config.menu_id;
            }

            if (form.selected_menu_id) {
                await loadMenuItems();
            }
        }
    } catch (e: any) {
        // 🔥 3. Aplicado en la inicialización
        handleApiError(e, "Error al iniciar la configuración de branding");
    } finally {
        loading.value = false;
    }
};

// --- GUARDADO ---
const saveBranding = async () => {
    loading.value = true;
    try {
        form.header_config.menu_id = form.selected_menu_id;
        
        // Empaquetar bloques de diseño (Ambos Header y Footer)
        const designBlocks = [
            {
                id: form.id || crypto.randomUUID(), 
                type: form.header_type,
                content: form.header_config
            },
            {
                id: crypto.randomUUID(), 
                type: form.footer_type,
                content: form.footer_config
            }
        ];
        
        form.custom_css = JSON.stringify(designBlocks);

        // Enviamos todo a la API.
        const response = await HttpClient.post('unit-branding', form);
        
        if (response.data.data?.id) form.id = response.data.data.id;

        Swal.fire({ 
            toast: true, position: 'top-end', icon: 'success', 
            title: '¡Identidad visual actualizada!', showConfirmButton: false, timer: 2000 
        });
    } catch (e: any) {
        // 🔥 4. Aplicado en el guardado principal
        handleApiError(e, "No se pudo sincronizar la identidad visual");
    } finally {
        loading.value = false;
    }
};

onMounted(loadInitialData);
</script>
<style scoped>
.builder-container { height: 100vh; display: flex; flex-direction: column; }
.designer-header { 
    background: white; 
    padding: 0.75rem 1.5rem; 
    display: flex; 
    justify-content: space-between; 
    align-items: center; 
}
.brand-icon { 
    width: 40px; height: 40px; 
    background: #4e73df; color: white; 
    display: flex; align-items: center; justify-content: center; 
    border-radius: 10px; font-size: 1.5rem;
}

.designer-main { flex: 1; display: flex; overflow: hidden; }

/* NAVEGACIÓN IZQUIERDA Y DERECHA */
.designer-sidebar-left { 
    width: 300px; 
    transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
    border-right: 1px solid #dee2e6;
}
.designer-sidebar-left.collapsed { width: 0; border-right: none; }

.designer-sidebar-right { 
    width: 480px; 
    transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
    border-left: 1px solid #dee2e6;
}
.designer-sidebar-right.collapsed { width: 0; border-left: none; }

.sidebar-content {
    width: 100%;
    height: 100%;
    overflow-y: auto;
    padding: 1.5rem;
    opacity: 1;
    transition: opacity 0.2s ease;
}

.designer-sidebar-left .sidebar-content { min-width: 300px; }
.designer-sidebar-right .sidebar-content { min-width: 480px; }
.collapsed .sidebar-content { opacity: 0; pointer-events: none; padding: 0; }

/* EL LIENZO */
.designer-canvas { 
    flex: 1; 
    padding: 2rem; 
    overflow-y: auto; 
    transition: padding 0.3s ease;
}

.cursor-pointer { cursor: pointer; }
.accordion-header:hover { background-color: #f8f9fa !important; }
.accordion-panel { overflow: hidden; }

.section-title { font-size: 0.75rem; font-weight: 800; color: #6c757d; text-transform: uppercase; letter-spacing: 1px; display: block; }
.model-selector-card { border: 2px solid transparent !important; }
.active-model { border-color: #4e73df !important; }

.color-grid { display: grid; grid-template-columns: repeat(3, 1fr); gap: 10px; }
.color-box { text-align: center; }
.color-box input { height: 35px; border-radius: 6px; border: 1px solid #dee2e6; cursor: pointer; width: 100%; margin-bottom: 5px; }
.color-box span { font-size: 0.6rem; color: #6c757d; font-weight: bold; }

/* VENTANA PREVIEW */
.preview-window { 
    width: 100%; 
    max-width: 1600px;
    background: white; border-radius: 12px; 
    margin: 0 auto; min-height: 80vh; 
}
.window-bar { background: #f1f3f5; padding: 10px 20px; display: flex; align-items: center; gap: 20px; }
.window-dots span { width: 10px; height: 10px; border-radius: 50%; display: inline-block; background: #dee2e6; margin-right: 5px; }
.window-url { background: white; flex: 1; border-radius: 6px; font-size: 0.7rem; color: #adb5bd; padding: 4px 15px; border: 1px solid #e9ecef; }

.window-content {
    position: relative;
    background-color: #212529; 
    overflow-y: auto;
    overflow-x: hidden;
    scroll-behavior: smooth;
}

.preview-hero {
    min-height: 600px;
    background-image: url('https://images.unsplash.com/photo-1541339907198-e08756dedf3f?q=80&w=2070&auto=format&fit=crop'); 
    background-size: cover;
    background-position: center;
}

.transition-all { transition: all 0.3s ease; }
.modern-input { border-radius: 8px; font-size: 0.9rem; }
</style>