<template>
        <b-row class="justify-content-center">
            <b-col cols="12">
                <b-card no-body>
                    <b-card-header>
                        <b-row class="align-items-center">
                            <b-col md="5">
                                <b-card-title>📂 Gestión de Categorías</b-card-title>
                            </b-col>

                            <b-col md="4">
                                <b-input-group size="sm">
                                    <b-input-group-text><i class="las la-filter"></i> Ver:</b-input-group-text>
                                    <b-form-select v-model="filterType" :disabled="loading">
                                        <option value="">Todas</option>
                                        <option value="academic">Académico</option>
                                        <option value="news">Noticias / Blog</option>
                                        <option value="course">Cursos</option>
                                        <option value="page">Páginas</option>
                                        <option value="manual">Manual</option>
                                        <option value="event">Eventos</option>
                                        <option value="product">Productos</option>
                                    </b-form-select>
                                </b-input-group>
                            </b-col>

                            <b-col md="3" class="text-end">
                                <b-button variant="primary" @click="openModal()">
                                    <i class="fas fa-plus me-2"></i> Nueva Categoría
                                </b-button>
                            </b-col>
                        </b-row>
                    </b-card-header>

                    <b-card-body>
                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead class="table-light">
                                    <tr>
                                        <th>Id</th>
                                        <th style="width: 50px;">Img</th>
                                        <th>Nombre</th>
                                        <th>Tipo</th>
                                        <th>Slug</th>
                                        <th>Estado</th>
                                        <th class="text-end">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <template v-for="item in category_tree" :key="item.id">
                                        <tr>
                                            <th>{{ item.id }}</th>
                                            <td>
                                                <div v-if="item.image_path" class="ratio ratio-1x1 rounded overflow-hidden" style="width: 40px;">
                                                    <img :src="formatImageUrl(item.image_path)" class="object-fit-cover" alt="img">
                                                </div>
                                                <div v-else class="rounded bg-secondary text-white d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                                                    <i class="las la-image"></i>
                                                </div>
                                            </td>
                                            <td class="fw-bold text-dark">
                                                <span class="d-inline-block rounded-circle me-2 border" 
                                                      :style="`width: 12px; height: 12px; background-color: ${item.color || '#6c757d'}`"></span>
                                                {{ item.name }}
                                            </td>
                                            <td>
                                                <b-badge :variant="getBadgeVariant(item.type)" class="text-uppercase">
                                                    {{ item.type }}
                                                </b-badge>
                                            </td>
                                            <td class="text-muted small">{{ item.slug }}</td>
                                            <td>
                                                <b-badge :variant="item.is_active ? 'success' : 'secondary'">
                                                    {{ item.is_active ? 'Activo' : 'Inactivo' }}
                                                </b-badge>
                                            </td>
                                            <td class="text-end">
                                                <b-button size="sm" variant="outline-secondary" class="me-1" @click="editItem(item)">
                                                    <i class="las la-pen"></i>
                                                </b-button>
                                                <b-button size="sm" variant="outline-danger" class="me-1" @click="deleteItem(item)">
                                                    <i class="las la-trash"></i>
                                                </b-button>
                                                <b-button size="sm" variant="outline-success" @click="addChild(item)" title="Agregar Subcategoría">
                                                    <i class="las la-level-down-alt"></i>
                                                </b-button>
                                            </td>
                                        </tr>

                                        <tr v-for="child in (item.children || [])" :key="child.id">
                                            <td>{{ child.id }}</td> 
                                            <td class="ps-5 position-relative" colspan="2">
                                                <i class="las la-level-up-alt fa-rotate-90 text-muted me-2"></i>
                                                <span class="d-inline-block rounded-circle me-1 border" 
                                                      :style="`width: 10px; height: 10px; background-color: ${child.color || '#6c757d'}`"></span>
                                                {{ child.name }}
                                            </td>
                                            <td>
                                                <b-badge variant="light" class="text-uppercase border">{{ child.type }}</b-badge>
                                            </td>
                                            <td class="text-muted small">{{ child.slug }}</td>
                                            <td>
                                                <b-badge :variant="child.is_active ? 'success' : 'secondary'">
                                                    {{ child.is_active ? 'Activo' : 'Inactivo' }}
                                                </b-badge>
                                            </td>
                                            <td class="text-end">
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
                            
                            <div v-if="loading" class="text-center p-5">
                                <b-spinner variant="primary"></b-spinner>
                            </div>

                            <div v-if="category_tree.length === 0 && !loading" class="text-center p-4 text-muted">
                                No hay categorías de tipo <strong>{{ filterType || 'Todas' }}</strong>.
                            </div>
                        </div>
                    </b-card-body>
                </b-card>
            </b-col>
        </b-row>

        <b-modal v-model="showModal" 
                 :title="form.id ? 'Editar Categoría' : 'Nueva Categoría'" 
                 size="lg" 
                 hide-footer
                 centered>
            
            <b-row>
                <b-col lg="8">
                    <b-row>
                        <b-col lg="6" class="mb-3">
                            <label class="fw-bold">Tipo de Contenido:</label>
                            <b-form-select v-model="form.type">
                                <option value="academic">Académico</option>
                                <option value="news">Noticias / Blog</option>
                                <option value="course">Cursos</option>
                                <option value="page">Páginas</option>
                                <option value="manual">Manual</option>
                                <option value="event">Eventos</option>
                                <option value="product">Productos</option>
                            </b-form-select>
                        </b-col>

                        <b-col lg="6" class="mb-3">
                            <label class="fw-bold">Categoría Padre:</label>
                            <b-form-select v-model="form.parent_id" :options="parentOptions">
                                <template #first>
                                    <option :value="null">-- Categoría Raíz --</option>
                                </template>
                            </b-form-select>
                        </b-col>

                        <b-col cols="12" class="mb-3">
                            <label class="fw-bold">Nombre:</label>
                            <b-form-input v-model="form.name" placeholder="Ej: Facultad de Ingeniería" />
                        </b-col>
                        
                        <b-col cols="12" class="mb-3">
                            <label class="fw-bold">Slug (URL):</label>
                            <b-form-input v-model="form.slug" placeholder="Generado automáticamente" />
                        </b-col>

                        <b-col lg="6" class="mb-3">
                            <label class="fw-bold">Color Distintivo:</label>
                            <div class="d-flex align-items-center">
                                <b-form-input type="color" v-model="form.color" class="form-control form-control-color me-2" title="Elige un color" />
                                <span class="text-muted small">{{ form.color }}</span>
                            </div>
                        </b-col>

                        <b-col cols="12" class="mb-3">
                            <label class="fw-bold">Descripción:</label>
                            <b-form-textarea v-model="form.description" rows="3" placeholder="Descripción breve para SEO..." />
                        </b-col>
                    </b-row>
                </b-col>

                <b-col lg="4">
                    <div class="mb-3">
                        <label class="fw-bold d-block mb-2">Imagen Destacada:</label>
                        <div class="border rounded p-2 text-center bg-light">
                            <div v-if="form.image_path" class="mb-2">
                                <img :src="formatImageUrl(form.image_path)" class="img-fluid rounded" style="max-height: 150px;">
                                <div class="mt-1">
                                    <b-button size="sm" variant="link" class="text-danger p-0" @click="form.image_path = ''">
                                        <small>Quitar imagen</small>
                                    </b-button>
                                </div>
                            </div>
                            <div v-else class="text-muted py-4">
                                <i class="las la-image fa-3x"></i>
                                <p class="small m-0">Sin imagen</p>
                            </div>
                            
                            <b-button variant="secondary" size="sm" class="w-100" @click="showMediaModal = true">
                                <i class="las la-images me-1"></i> Seleccionar de Galería
                            </b-button>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="fw-bold d-block">Visibilidad:</label>
                        <b-form-checkbox v-model="form.is_active" switch size="lg">
                            {{ form.is_active ? 'Visible' : 'Oculto' }}
                        </b-form-checkbox>
                    </div>
                </b-col>

                <b-col cols="12" class="text-end mt-3 border-top pt-3">
                    <b-button variant="secondary" class="me-2" @click="showModal = false">Cancelar</b-button>
                    <b-button variant="primary" @click="save" :disabled="loading">
                        <span v-if="loading" class="spinner-border spinner-border-sm me-1"></span>
                        Guardar
                    </b-button>
                </b-col>
            </b-row>
        </b-modal>

        <MediaSelector 
            :collection="''"
            v-if="showMediaModal" 
            @close="showMediaModal = false" 
            @select="handleMediaSelect" 
        />
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, computed, watch } from "vue";
import HttpClient from "@/helpers/http-client"; 
import Swal from "sweetalert2";
import { formatImageUrl } from "@/helpers/url"; 
import MediaSelector from "@/components/modals/MediaSelector.vue"; 

interface Category {
    id: number;
    name: string;
    slug: string;
    type: string;
    description?: string;
    parent_id?: number | null;
    image_path?: string;
    color?: string; 
    is_active: boolean | number;
    children?: Category[];
}

// --- ESTADO ---
const category_tree = ref<Category[]>([]);
const filterType = ref(''); 
const showModal = ref(false);
const showMediaModal = ref(false);
const loading = ref(false);

const form = reactive({
    id: null as number | null,
    name: '',
    slug: '',
    type: 'academic', 
    parent_id: null as number | null,
    description: '',
    color: '#6c757d',
    is_active: true,
    image_path: '' as string
});

// --- COMPUTEDS ---

// Transforma el árbol en una lista plana para el selector (Evita que la categoría se elija a sí misma como padre)
const parentOptions = computed(() => {
    const flatList: any[] = [];
    const flattenCategories = (categories: Category[], level = 0) => {
        categories.forEach(c => {
            if (c.id !== form.id) { // No puedo ser mi propio padre
                flatList.push({ 
                    value: c.id, 
                    text: `${'— '.repeat(level)}📂 ${c.name}` 
                });
                if (c.children && c.children.length > 0) {
                    flattenCategories(c.children, level + 1);
                }
            }
        });
    };
    flattenCategories(category_tree.value);
    return flatList;
});

// --- UTILS DE UI ---
const getBadgeVariant = (type: string) => {
    switch(type) {
        case 'academic': return 'primary';
        case 'news': return 'info';
        case 'course': return 'warning';
        case 'event': return 'success';
        case 'product': return 'dark';
        default: return 'secondary';
    }
}

// --- LOGICA DE CARGA ---
watch(filterType, () => {
    loadData();
});

const loadData = async () => {
    loading.value = true;
    try {
        const timestamp = new Date().getTime();
        const response = await HttpClient.get(`categories?type=${filterType.value}&t=${timestamp}`);
        category_tree.value = response.data.data || response.data;
    } catch (e) {
        console.error(e);
        Swal.fire("Error", "Error al cargar categorías", "error");
    } finally {
        loading.value = false;
    }
};

const handleMediaSelect = (path: string) => {
    form.image_path = path; 
    showMediaModal.value = false;
};

// --- CRUD ACCIONES ---
const openModal = () => {
    resetForm();
    form.type = filterType.value || 'academic';    
    showModal.value = true;
};

const addChild = (parent: Category) => {
    resetForm();
    form.parent_id = parent.id;
    form.type = parent.type; 
    showModal.value = true;
};

const editItem = (item: Category, parentId: number | null = null) => {
    resetForm();
    form.id = item.id;
    form.name = item.name;
    form.slug = item.slug;
    form.type = item.type;
    form.parent_id = parentId ?? item.parent_id ?? null;
    form.description = item.description || '';
    form.color = item.color || '#6c757d';
    form.is_active = Boolean(item.is_active); 
    form.image_path = item.image_path || '';
    showModal.value = true;
};

const save = async () => {
    if (!form.name || !form.type) return Swal.fire("Atención", "El nombre y el tipo son obligatorios", "warning");

    loading.value = true;
    try {
        // CONSTRUIMOS EL PAYLOAD EXACTO QUE NECESITA LARAVEL 
        // Solo mandamos los campos que tienen datos para evitar errores de validación.
        const payload: any = {
            name: form.name,
            type: form.type,
            slug: form.slug,
            is_active: form.is_active ? 1 : 0
        };

        // Agregamos opcionales solo si existen
        if (form.parent_id !== null) payload.parent_id = form.parent_id;
        if (form.description) payload.description = form.description;
        if (form.color && form.color !== '#6c757d') payload.color = form.color;
        if (form.image_path) payload.image_path = form.image_path;

        if (form.id) {
            await HttpClient.put(`categories/${form.id}`, payload);
        } else {
            await HttpClient.post('categories', payload);
        }
        
        if (form.type !== filterType.value && filterType.value !== '') {
            filterType.value = form.type; 
        } else {
            await loadData();
        }

        showModal.value = false;
        Swal.fire({ icon: 'success', title: 'Guardado correctamente', showConfirmButton: false, timer: 1500 });
    } catch (e: any) {
        const msg = e.response?.data?.message || "Error al guardar";
        Swal.fire("Error", msg, "error");
    } finally {
        loading.value = false;
    }
};

const deleteItem = (item: Category) => {
    Swal.fire({
        title: "¿Eliminar?",
        text: `Se eliminará: ${item.name}`,
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: '#d33',
        confirmButtonText: "Sí, borrar",
        cancelButtonText: 'Cancelar'
    }).then(async (r) => {
        if (r.isConfirmed) {
            loading.value = true;
            try {
                const response = await HttpClient.delete(`categories/${item.id}`);
                if (response.data.success === false) {
                    Swal.fire({ title: "Atención", text: response.data.message, icon: "warning" });
                    return; 
                }
                await loadData();
                Swal.fire("Eliminado", response.data.message || "Se borró con éxito", "success");
            } catch (e) {
                console.error(e);
                Swal.fire("Error", "No se pudo eliminar", "error");
            } finally {
                loading.value = false;
            }
        }
    });
};

const resetForm = () => {
    form.id = null;
    form.name = '';
    form.slug = '';
    form.type = 'academic'; 
    form.parent_id = null;
    form.description = '';
    form.color = '#6c757d'; 
    form.is_active = true;
    form.image_path = '';
};

// Generador de slug mejorado (Mantiene las letras con tilde convirtiéndolas a su versión sin tilde)
watch(() => form.name, (newVal) => {
    if(!form.id || form.slug === '') {
        form.slug = newVal
            .toLowerCase()
            .trim()
            .normalize("NFD").replace(/[\u0300-\u036f]/g, "") 
            .replace(/[^a-z0-9 -]/g, '') 
            .replace(/\s+/g, '-') 
            .replace(/-+/g, '-'); 
    }
});

// Si el usuario cambia el tipo, le reseteamos la categoría padre para que no haya inconsistencias
watch(() => form.type, () => {
    if (!form.id) form.parent_id = null;
});

onMounted(() => {
    loadData();
});
</script>