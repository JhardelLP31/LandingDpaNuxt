<template>
    <DefaultLayout>
        <b-row class="justify-content-center">
            <b-col cols="12">
                <b-card no-body>
                    <b-card-header>
                        <b-row class="align-items-center justify-content-between">
                            <b-col lg="6">
                                <b-card-title>📂 Gestión de Categorías</b-card-title>
                            </b-col>
                            <b-col lg="3" class="text-end">
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
                                        <th style="width: 50px;">Img</th>
                                        <th>Nombre</th>
                                        <th>Slug</th>
                                        <th>Estado</th>
                                        <th class="text-end">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <template v-for="item in category_tree" :key="item.id">
                                        <tr class="bg-light">
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
                                                      :style="`width: 12px; height: 12px; background-color: ${item.color}`"></span>
                                                {{ item.name }}
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
                                            <td></td> <td class="ps-5 position-relative">
                                                <i class="las la-level-up-alt fa-rotate-90 text-muted me-2"></i>
                                                <span class="d-inline-block rounded-circle me-1 border" 
                                                      :style="`width: 10px; height: 10px; background-color: ${child.color}`"></span>
                                                {{ child.name }}
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
                            
                            <div v-if="category_tree.length === 0 && !loading" class="text-center p-4 text-muted">
                                No hay categorías registradas.
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
                        <b-col cols="12" class="mb-3">
                            <label class="fw-bold">Nombre:</label>
                            <b-form-input v-model="form.name" placeholder="Ej: Tecnología" />
                        </b-col>
                        
                        <b-col cols="12" class="mb-3">
                            <label class="fw-bold">Slug (URL):</label>
                            <b-form-input v-model="form.slug" placeholder="Generado automáticamente si se deja vacío" />
                        </b-col>

                        <b-col lg="6" class="mb-3">
                             <label class="fw-bold">Categoría Padre:</label>
                             <b-form-select v-model="form.parent_id">
                                <option :value="null">-- Categoría Raíz --</option>
                                <option v-for="parent in root_items" :key="parent.id" :value="parent.id">
                                    📂 {{ parent.name }}
                                </option>
                             </b-form-select>
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
                            <div v-if="preview_image" class="mb-2">
                                <img :src="preview_image" class="img-fluid rounded" style="max-height: 150px;">
                            </div>
                            <div v-else class="text-muted py-4">
                                <i class="las la-image fa-3x"></i>
                                <p class="small m-0">Sin imagen</p>
                            </div>
                            <b-form-file v-model="image_file" plain accept="image/*" @change="onFileChange" size="sm"></b-form-file>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="fw-bold d-block">Visibilidad:</label>
                        <b-form-checkbox v-model="form.is_active" switch size="lg">
                            {{ form.is_active ? 'Visible en web' : 'Oculto (Borrador)' }}
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

    </DefaultLayout>
</template>

<script setup lang="ts">
import DefaultLayout from "@/layouts/DefaultLayout.vue";
import { ref, reactive, onMounted, computed } from "vue";
import HttpClient from "@/helpers/http-client";
import Swal from "sweetalert2";
import { formatImageUrl } from "@/helpers/url";
import MediaModal from "@/components/MediaManager.vue";
// --- INTERFACES ---
interface Category {
    id: number;
    name: string;
    slug: string;
    description?: string;
    parent_id?: number | null;
    image_path?: string;
    image_url?: string; // URL completa generada por backend (Accessor)
    color: string;
    is_active: boolean | number;
    children?: Category[];
}

// --- ESTADO ---
const category_tree = ref<Category[]>([]);
const showModal = ref(false);
const loading = ref(false);

// Manejo de Archivos
const image_file = ref<File | null>(null);
const preview_image = ref<string | null>(null);

// Formulario
const form = reactive({
    id: null as number | null,
    name: '',
    slug: '',
    parent_id: null as number | null,
    description: '',
    color: '#6c757d',
    is_active: true
});

// --- COMPUTEDS ---
// Filtramos del árbol los posibles padres (evitar que sea padre de sí mismo)
const root_items = computed(() => {
    return category_tree.value.filter(item => item.id !== form.id);
});

// --- CARGA DE DATOS ---
const loadData = async () => {
    loading.value = true;
    try {
        const timestamp = new Date().getTime();
        // Asumiendo que tu endpoint devuelve el árbol recursivo
        const response = await HttpClient.get(`categories?t=${timestamp}`);
        category_tree.value = response.data.data || response.data;
    } catch (e) {
        console.error(e);
        Swal.fire("Error", "Error al cargar categorías", "error");
    } finally {
        loading.value = false;
    }
};

// --- IMAGEN ---
const onFileChange = (e: Event) => {
    const input = e.target as HTMLInputElement;
    if (input.files && input.files[0]) {
        const file = input.files[0];
        image_file.value = file;
        preview_image.value = URL.createObjectURL(file);
    }
};

// --- CRUD ACCIONES ---
const openModal = () => {
    resetForm();
    showModal.value = true;
};

const addChild = (parent: Category) => {
    resetForm();
    form.parent_id = parent.id;
    showModal.value = true;
};

const editItem = (item: Category, parentId: number | null = null) => {
    resetForm();
    
    form.id = item.id;
    form.name = item.name;
    form.slug = item.slug;
    form.parent_id = parentId ?? item.parent_id ?? null;
    form.description = item.description || '';
    form.color = item.color || '#6c757d';
    // Convertir 1/0 a true/false si viene de MySQL directo sin casting
    form.is_active = Boolean(item.is_active); 

    // Visualizar imagen existente
    if (item.image_url) {
        preview_image.value = formatImageUrl(item.image_path);    
    }

    showModal.value = true;
};

const save = async () => {
    if (!form.name) return Swal.fire("Atención", "El nombre es obligatorio", "warning");

    loading.value = true;
    try {
        // USO DE FORMDATA (Obligatorio para enviar archivos)
        const formData = new FormData();
        formData.append('name', form.name);
        formData.append('slug', form.slug || ''); // Si es vacío, el backend lo genera
        if(form.parent_id) formData.append('parent_id', String(form.parent_id));
        if(form.description) formData.append('description', form.description);
        formData.append('color', form.color);
        formData.append('is_active', form.is_active ? '1' : '0');

        // Si hay nueva imagen
        if (image_file.value) {
            formData.append('image', image_file.value);
        }

        // TRUCO LARAVEL PARA PUT CON FILES:
        // Laravel no procesa bien multipart/form-data con PUT/PATCH nativo.
        // Se envía como POST y se agrega _method: PUT
        if (form.id) {
            formData.append('_method', 'PUT');
            await HttpClient.post(`categories/${form.id}`, formData);
        } else {
            await HttpClient.post('categories', formData);
        }
        
        await loadData();
        showModal.value = false;
        Swal.fire({ icon: 'success', title: 'Guardado', showConfirmButton: false, timer: 1500 });

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
        text: "Se enviará a la papelera.",
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: '#d33',
        confirmButtonText: "Sí, borrar"
    }).then(async (r) => {
        if (r.isConfirmed) {
            loading.value = true;
            try {
                await HttpClient.delete(`categories/${item.id}`);
                await loadData();
                Swal.fire("Eliminado", "", "success");
            } catch (e) {
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
    form.parent_id = null;
    form.description = '';
    form.color = '#000000';
    form.is_active = true;
    
    image_file.value = null;
    preview_image.value = null;
};

// Lifecycle
onMounted(() => {
    loadData();
});
</script>   