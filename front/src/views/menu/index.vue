<template>
    <b-container fluid>
        <b-row class="mb-4">
            <b-col cols="12">
                <b-card no-body class="shadow-sm border-0">
                    <b-card-body class="bg-light rounded d-flex align-items-center justify-content-between">
                        <div class="d-flex align-items-center gap-3 w-50">
                            <i class="las la-compass fs-1 text-primary"></i>
                            <div class="flex-grow-1">
                                <label class="fw-bold mb-1">Selecciona el Menú a editar:</label>
                                <b-form-select v-model="selected_menu_id" @change="loadMenuItems" class="shadow-sm">
                                    <option :value="null">-- Elige un menú --</option>
                                    <option v-for="menu in menus_list" :key="menu.id" :value="menu.id">
                                        {{ menu.name }} (Ubicación: {{ menu.location }})
                                    </option>
                                </b-form-select>
                            </div>
                        </div>
                        
                        <div>
                            <b-button variant="outline-primary" @click="showMenuModal = true">
                                <i class="las la-plus"></i> Crear Nuevo Menú
                            </b-button>
                        </div>
                    </b-card-body>
                </b-card>
            </b-col>
        </b-row>

        <b-row v-if="selected_menu_id" class="justify-content-center">
            <b-col cols="12">
                <b-card no-body class="shadow-sm border-0">
                    <b-card-header class="bg-white border-bottom-0 pt-4 pb-0">
                        <b-row class="align-items-center justify-content-between">
                            <b-col lg="6">
                                <b-card-title class="mb-0">
                                    <i class="las la-list"></i> Enlaces del Menú
                                </b-card-title>
                            </b-col>
                            <b-col lg="6" class="text-end">
                                <b-button variant="primary" @click="openItemModal()">
                                    <i class="fas fa-plus me-2"></i> Agregar Enlace
                                </b-button>
                            </b-col>
                        </b-row>
                    </b-card-header>

                    <b-card-body>
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>Orden</th>
                                        <th>Título del Enlace</th>
                                        <th>Destino / URL</th>
                                        <th>Apertura</th>
                                        <th>Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <template v-for="item in menu_tree" :key="item.id">
                                        <tr class="bg-light">
                                            <td width="80">
                                                <b-badge variant="light" class="text-dark border">#{{ item.order }}</b-badge>
                                            </td>
                                            <td class="fw-bold text-dark">
                                                <i class="las la-link me-1"></i> {{ item.title }}
                                            </td>
                                            <td class="small text-muted">
                                                <span v-if="item.content_id" class="text-primary"><i class="las la-file-alt"></i> Página Interna (ID: {{ item.content_id }})</span>
                                                <span v-else><i class="las la-globe"></i> {{ item.url }}</span>
                                            </td>
                                            <td>
                                                <b-badge :variant="item.target === '_blank' ? 'info' : 'secondary'">
                                                    {{ item.target === '_blank' ? 'Nueva Pestaña' : 'Misma Pestaña' }}
                                                </b-badge>
                                            </td>
                                            <td>
                                                <b-button size="sm" variant="outline-secondary" class="me-1" @click="editItem(item)">
                                                    <i class="las la-pen"></i>
                                                </b-button>
                                                <b-button size="sm" variant="outline-danger" @click="deleteItem(item)">
                                                    <i class="las la-trash"></i>
                                                </b-button>
                                                <b-button size="sm" variant="outline-success" class="ms-1" @click="addChild(item)" title="Agregar Submenú">
                                                    <i class="las la-level-down-alt"></i> Hijo
                                                </b-button>
                                            </td>
                                        </tr>

                                        <tr v-for="child in (item.children || [])" :key="child.id">
                                            <td></td>
                                            <td class="ps-5 position-relative">
                                                <i class="las la-level-up-alt fa-rotate-90 text-muted me-2"></i>
                                                {{ child.title }}
                                            </td>
                                            <td class="text-muted small">
                                                <span v-if="child.content_id" class="text-primary"><i class="las la-file-alt"></i> Página Interna (ID: {{ child.content_id }})</span>
                                                <span v-else><i class="las la-globe"></i> {{ child.url }}</span>
                                            </td>
                                            <td>
                                                <b-badge :variant="child.target === '_blank' ? 'info' : 'secondary'">
                                                    {{ child.target === '_blank' ? 'Nueva Pestaña' : 'Misma Pestaña' }}
                                                </b-badge>
                                            </td>
                                            <td>
                                                <b-button size="sm" variant="outline-secondary" class="me-1" @click="editItem(child, item.id)">
                                                    <i class="las la-pen"></i>
                                                </b-button>
                                                <b-button size="sm" variant="outline-danger" @click="deleteItem(child)">
                                                    <i class="las la-trash"></i>
                                                </b-button>
                                            </td>
                                        </tr>
                                    </template>
                                </tbody>
                            </table>
                            
                            <div v-if="menu_tree.length === 0 && !loading" class="text-center p-5 text-muted bg-light rounded border border-dashed">
                                <i class="las la-anchor fs-1 mb-2"></i>
                                <h5>Este menú está vacío</h5>
                                <p>Haz clic en "Agregar Enlace" para empezar a construir la navegación.</p>
                            </div>
                        </div>
                    </b-card-body>
                </b-card>
            </b-col>
        </b-row>

        <div v-else class="text-center p-5 mt-4 text-muted bg-white rounded shadow-sm border">
            <i class="las la-hand-pointer fs-1 mb-3 text-primary"></i>
            <h4>Selecciona un menú arriba para comenzar</h4>
            <p>O crea uno nuevo si aún no tienes menús registrados en tu unidad académica.</p>
        </div>

        <b-modal v-model="showMenuModal" title="Crear Nuevo Menú Contenedor" hide-footer centered>
            <b-form-group label="Nombre del Menú:" class="mb-3 fw-bold">
                <b-form-input v-model="newMenuForm.name" placeholder="Ej: Menú Principal Header" />
            </b-form-group>
            <b-form-group label="Ubicación (location):" class="mb-4 fw-bold">
                <b-form-select v-model="newMenuForm.location">
                    <option value="header">Header (Cabecera)</option>
                    <option value="footer">Footer (Pie de página)</option>
                    <option value="sidebar_dpa">Sidebar (Barra lateral)</option>
                </b-form-select>
            </b-form-group>
            <div class="text-end">
                <b-button variant="secondary" class="me-2" @click="showMenuModal = false">Cancelar</b-button>
                <b-button variant="primary" @click="saveMenu" :disabled="loading">Guardar Menú</b-button>
            </div>
        </b-modal>

        <b-modal v-model="showItemModal" :title="formItem.id ? 'Editar Enlace' : 'Nuevo Enlace'" size="lg" hide-footer centered>
            <b-row>
                <b-col lg="12" class="mb-3">
                    <label class="fw-bold">Título del Enlace:</label>
                    <b-form-input v-model="formItem.title" placeholder="Ej: Nuestra Historia" />
                </b-col>

                <b-col lg="6" class="mb-3">
                    <label class="fw-bold">Tipo de Destino:</label>
                    <b-form-select v-model="ui_link_type" @change="resetLinkDestination">
                        <option value="internal">Página de la Plataforma (content_id)</option>
                        <option value="external">URL Personalizada (url)</option>
                    </b-form-select>
                </b-col>

                <b-col lg="6" class="mb-3">
                    <label class="fw-bold">Ruta / Destino:</label>
                    
                    <b-form-select v-if="ui_link_type === 'internal'" v-model="formItem.content_id" @change="autoFillTitle">
                        <option :value="null">-- Selecciona una página --</option>
                        <option v-for="p in available_pages" :key="p.id" :value="p.id">📄 {{ p.title }}</option>
                    </b-form-select>

                    <b-form-input v-else v-model="formItem.url" placeholder="Ej: https://google.com o /ruta-manual" />
                </b-col>

                <b-col lg="4" class="mb-3">
                    <label class="fw-bold">Apertura (target):</label>
                    <b-form-select v-model="formItem.target">
                        <option value="_self">Misma pestaña (_self)</option>
                        <option value="_blank">Nueva pestaña (_blank)</option>
                    </b-form-select>
                </b-col>

                <b-col lg="4" class="mb-3">
                    <label class="fw-bold">Submenú de (Padre):</label>
                    <b-form-select v-model="formItem.parent_id">
                        <option :value="null">-- Elemento Principal (Raíz) --</option>
                        <option v-for="parent in root_items" :key="parent.id" :value="parent.id">
                            📂 {{ parent.title }}
                        </option>
                    </b-form-select>
                </b-col>

                <b-col lg="4" class="mb-3">
                    <label class="fw-bold">Orden (Posición):</label>
                    <b-form-input type="number" v-model="formItem.order" />
                </b-col>

                <b-col cols="12" class="text-end mt-3 border-top pt-3">
                    <b-button variant="secondary" class="me-2" @click="showItemModal = false">Cancelar</b-button>
                    <b-button variant="primary" @click="saveItem" :disabled="loading">
                        <span v-if="loading" class="spinner-border spinner-border-sm me-1"></span> Guardar Enlace
                    </b-button>
                </b-col>
            </b-row>
        </b-modal>
    </b-container>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, computed } from "vue";
import HttpClient from "@/helpers/http-client";
import Swal from "sweetalert2";
import { useAuthStore } from "@/stores/auth";

import { handleApiError } from "@/helpers/errorHandler";

// --- 1. INTERFACES (Mapeadas a tu BD) ---
interface Menu {
    id: number;
    academic_unit_id: number;
    name: string;
    location: string;
}

interface MenuItem {
    id: number;
    menu_id: number;
    parent_id: number | null;
    content_id: number | null;
    title: string;
    url: string | null;
    order: number;
    target: '_self' | '_blank';
    children?: MenuItem[];
}

interface PageItem {
    id: number;
    title: string;
}

// --- 2. ESTADO GLOBAL ---
const authStore = useAuthStore();
const loading = ref(false);

// Para la tabla `menus`
const menus_list = ref<Menu[]>([]);
const selected_menu_id = ref<number | null>(null);
const showMenuModal = ref(false);

const newMenuForm = reactive({
    name: '',
    location: 'header',
    academic_unit_id: authStore.academicUnitId
});

// Para la tabla `menu_items`
const menu_tree = ref<MenuItem[]>([]);
const available_pages = ref<PageItem[]>([]);
const showItemModal = ref(false);
const ui_link_type = ref<'internal' | 'external'>('internal');

const formItem = reactive({
    id: null as number | null,
    menu_id: null as number | null,
    parent_id: null as number | null,
    content_id: null as number | null,
    title: '',
    url: null as string | null,
    order: 1,
    target: '_self' as '_self' | '_blank'
});

// --- 3. COMPUTADOS ---
const root_items = computed(() => {
    return menu_tree.value.filter(item => item.id !== formItem.id);
});

// --- 4. CARGA DE DATOS INICIALES ---
const loadInitialData = async () => {
    loading.value = true;
    try {
        const [resMenus, resPages] = await Promise.all([
            HttpClient.get('menus', {
                params: {
                    academic_unit_id: authStore.academicUnitId
                }
            }),
            HttpClient.get('pages/selection')
        ]);

        menus_list.value = resMenus.data.data || resMenus.data;
        available_pages.value = resPages.data.data || resPages.data;
    } catch (e: any) {
        handleApiError(e, "Error cargando la base de menús y páginas");
    } finally {
        loading.value = false;
    }
};

// --- 5. LÓGICA DE MENÚS (Padres) ---
const saveMenu = async () => {
    if (!newMenuForm.name) return Swal.fire("Atención", "El nombre es obligatorio", "warning");
    
    loading.value = true;
    try {
        // Aseguramos que se mande el ID actual por si el usuario cambió de sede
        newMenuForm.academic_unit_id = authStore.academicUnitId;
        
        const response = await HttpClient.post('menus', newMenuForm);
        const savedMenu = response.data.data || response.data;
        
        menus_list.value.push(savedMenu); 
        selected_menu_id.value = savedMenu.id; 
        
        showMenuModal.value = false;
        newMenuForm.name = ''; // Limpiar
        
        await loadMenuItems(); // Cargar la tabla vacía
        Swal.fire({ icon: 'success', title: 'Menú creado', timer: 1500, showConfirmButton: false });
    } catch (e: any) {
        // 🔥 3. Aplicado al crear el menú base
        handleApiError(e, "No se pudo crear el menú");
    } finally {
        loading.value = false;
    }
};

const loadMenuItems = async () => {
    if (!selected_menu_id.value) {
        menu_tree.value = [];
        return;
    }
    
    loading.value = true;
    try {
        // Usamos el endpoint SHOW normal de tu controlador
        const res = await HttpClient.get(`menus/${selected_menu_id.value}`);
        
        // Tu backend devuelve el menú completo, los enlaces están dentro de 'items'
        const menuData = res.data.data || res.data;
        menu_tree.value = menuData.items || []; 
        
    } catch (e: any) {
        // 🔥 4. Aplicado al cargar los ítems del menú seleccionado
        handleApiError(e, "Error cargando los ítems del menú");
    } finally {
        loading.value = false;
    }
};

// --- 6. LÓGICA DE ITEMS (Hijos / Enlaces) ---
const resetLinkDestination = () => {
    if (ui_link_type.value === 'internal') {
        formItem.url = null;
    } else {
        formItem.content_id = null;
    }
};

const autoFillTitle = () => {
    if (!formItem.title && formItem.content_id) {
        const page = available_pages.value.find(p => p.id === formItem.content_id);
        if (page) formItem.title = page.title;
    }
};

const openItemModal = () => {
    resetItemForm();
    // Pre-asignar el siguiente número de orden
    formItem.order = (menu_tree.value.length + 1);
    showItemModal.value = true;
};

const addChild = (parent: MenuItem) => {
    resetItemForm();
    formItem.parent_id = parent.id;
    formItem.order = (parent.children?.length || 0) + 1;
    showItemModal.value = true;
};

const editItem = (item: MenuItem, parentId: number | null = null) => {
    resetItemForm();
    formItem.id = item.id;
    formItem.menu_id = item.menu_id;
    formItem.parent_id = parentId ?? item.parent_id ?? null;
    formItem.content_id = item.content_id;
    formItem.title = item.title;
    formItem.url = item.url;
    formItem.order = item.order;
    formItem.target = item.target;

    ui_link_type.value = item.content_id ? 'internal' : 'external';
    showItemModal.value = true;
};

const saveItem = async () => {
    if (!formItem.title) return Swal.fire("Atención", "El título es obligatorio", "warning");
    if (ui_link_type.value === 'internal' && !formItem.content_id) return Swal.fire("Atención", "Selecciona una página interna", "warning");
    if (ui_link_type.value === 'external' && !formItem.url) return Swal.fire("Atención", "Ingresa una URL válida", "warning");

    loading.value = true;
    try {
        if (formItem.id) {
            await HttpClient.put(`menu-items/${formItem.id}`, formItem);
        } else {
            await HttpClient.post('menu-items', formItem);
        }
        await loadMenuItems();
        showItemModal.value = false;
        Swal.fire({ icon: 'success', title: 'Enlace guardado', timer: 1500, showConfirmButton: false });
    } catch (e: any) {
        // 🔥 5. Aplicado al guardar un nuevo enlace/item
        handleApiError(e, "No se pudo guardar el enlace");
    } finally {
        loading.value = false;
    }
};

const deleteItem = (item: MenuItem) => {
    Swal.fire({
        title: "¿Eliminar Enlace?", 
        text: `Se borrará "${item.title}". Si tiene submenús, también se borrarán.`, 
        icon: "warning",
        showCancelButton: true, confirmButtonText: "Sí, borrar", cancelButtonText: "Cancelar"
    }).then(async (r) => {
        if (r.isConfirmed) {
            loading.value = true;
            try {
                await HttpClient.delete(`menu-items/${item.id}`);
                await loadMenuItems();
                Swal.fire({ icon: 'success', title: 'Eliminado', timer: 1500, showConfirmButton: false });
            } catch (e: any) {
                // 🔥 6. Aplicado al borrar un enlace/item
                handleApiError(e, "No se pudo eliminar el enlace");
            } finally {
                loading.value = false;
            }
        }
    });
};

const resetItemForm = () => {
    formItem.id = null;
    formItem.menu_id = selected_menu_id.value;
    formItem.parent_id = null;
    formItem.content_id = null;
    formItem.title = '';
    formItem.url = null;
    formItem.order = 1;
    formItem.target = '_self';
    ui_link_type.value = 'internal';
};

onMounted(() => {
    loadInitialData();
});
</script>