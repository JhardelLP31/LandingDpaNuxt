<template>
    <b-row class="justify-content-center">
        <b-col cols="12">
            <b-card no-body>
                <b-card-header>
                    <b-row class="align-items-center">
                        <b-col md="6">
                            <b-card-title>🎓 Gestión de Programas de Estudio</b-card-title>
                        </b-col>
                        <b-col md="6" class="text-end">
                            <b-button variant="primary" @click="openModal()">
                                <i class="fas fa-plus me-2"></i> Nuevo Programa
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
                                    <th>Color</th>
                                    <th>Programa</th>
                                    <th>Modalidad</th>
                                    <th>Duración</th>
                                    <th>Estado</th>
                                    <th class="text-end">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="item in programs" :key="item.id">
                                    <th>{{ item.id }}</th>
                                    <td>
                                        <span class="d-inline-block rounded-circle border" 
                                              :style="`width: 15px; height: 15px; background-color: ${item.branding_color || '#000000'}`">
                                        </span>
                                    </td>
                                    <td>
                                        <div class="fw-bold text-dark">{{ item.name }}</div>
                                        <div class="text-muted small">{{ item.slug }}</div>
                                    </td>
                                    <td>
                                        <b-badge variant="info" class="text-uppercase">{{ item.modality }}</b-badge>
                                    </td>
                                    <td>{{ item.duration }}</td>
                                    <td>
                                        <b-badge :variant="item.is_active ? 'success' : 'secondary'">
                                            {{ item.is_active ? 'Activo' : 'Inactivo' }}
                                        </b-badge>
                                    </td>
                                    <td class="text-end">
                                        <b-button size="sm" variant="outline-secondary" class="me-1" @click="editItem(item)">
                                            <i class="las la-pen"></i>
                                        </b-button>
                                        <b-button size="sm" variant="outline-danger" @click="deleteItem(item)">
                                            <i class="las la-trash"></i>
                                        </b-button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        
                        <div v-if="loading" class="text-center p-5">
                            <b-spinner variant="primary"></b-spinner>
                        </div>

                        <div v-if="programs.length === 0 && !loading" class="text-center p-4 text-muted">
                            No hay programas registrados.
                        </div>
                    </div>
                </b-card-body>
            </b-card>
        </b-col>
    </b-row>
    <b-modal v-model="showModal" 
             :title="form.id ? 'Editar Programa' : 'Nuevo Programa'" 
             size="lg" 
             hide-footer
             centered>
        
        <b-row>
            <b-col lg="6" class="mb-3" v-if="!authStore.academicUnitId">
                <label class="fw-bold text-danger">Unidad Académica *:</label>
                <b-form-select v-model="form.academic_unit_id" :options="academicUnitsOptions">
                    <template #first>
                        <option :value="null" disabled>-- Selecciona una Unidad --</option>
                    </template>
                </b-form-select>
            </b-col>

            <b-col :lg="authStore.academicUnitId ? '12' : '6'" class="mb-3">
                <label class="fw-bold text-danger">Categoría *:</label>
                <b-form-select v-model="form.category_id" :options="categoriesOptions">
                    <template #first>
                        <option :value="null" disabled>-- Selecciona una Categoría --</option>
                    </template>
                </b-form-select>
            </b-col>

            <b-col cols="12" class="mb-3">
                <label class="fw-bold">Nombre del Programa:</label>
                <b-form-input 
                    v-model="form.name" 
                    placeholder="Ej: Ingeniería de Sistemas" 
                    @input="generateSlug" 
                />
            </b-col>
            
            <b-col cols="12" class="mb-3">
                <label class="fw-bold">Slug (URL):</label>
                <b-form-input v-model="form.slug" placeholder="Generado automáticamente" readonly />
            </b-col>

            <b-col lg="4" class="mb-3">
                <label class="fw-bold">Modalidad:</label>
                <b-form-select v-model="form.modality">
                    <option value="presencial">Presencial</option>
                    <option value="semipresencial">Semipresencial</option>
                    <option value="a distancia">A distancia</option>
                </b-form-select>
            </b-col>

            <b-col lg="4" class="mb-3">
                <label class="fw-bold">Duración:</label>
                <b-form-input v-model="form.duration" placeholder="Ej: 10 ciclos" />
            </b-col>

            <b-col lg="4" class="mb-3">
                <label class="fw-bold">Color de Marca:</label>
                <div class="d-flex align-items-center">
                    <b-form-input type="color" v-model="form.branding_color" class="form-control form-control-color me-2" />
                    <span class="text-muted small">{{ form.branding_color }}</span>
                </div>
            </b-col>

            <b-col cols="12" class="mb-3">
                <label class="fw-bold">Descripción:</label>
                <b-form-textarea v-model="form.description" rows="3" placeholder="Resumen del programa..." />
            </b-col>

            <b-col cols="12" class="mb-3">
                <b-form-checkbox v-model="form.is_active" switch size="lg">
                    <span class="fw-bold">Estado:</span> {{ form.is_active ? 'Activo (Visible)' : 'Inactivo (Oculto)' }}
                </b-form-checkbox>
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
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, watch } from "vue";
import HttpClient from "@/helpers/http-client"; 
import Swal from "sweetalert2";
import { useAuthStore } from "@/stores/auth"; 

import { handleApiError } from "@/helpers/errorHandler";

const authStore = useAuthStore();

interface Program {
    id: number;
    academic_unit_id: number;
    category_id: number;
    name: string;
    slug: string;
    modality: string;
    duration: string;
    description: string;
    branding_color: string;
    is_active: boolean | number;
}

// Generador de slug accionado SOLO cuando el usuario teclea
const generateSlug = () => {
    if (form.name) {
        form.slug = form.name
            .toLowerCase()
            .trim()
            .normalize("NFD").replace(/[\u0300-\u036f]/g, "") 
            .replace(/[^a-z0-9 -]/g, '') 
            .replace(/\s+/g, '-') 
            .replace(/-+/g, '-'); 
    } else {
        form.slug = '';
    }
};

// --- ESTADO ---
const programs = ref<Program[]>([]);
const academicUnitsOptions = ref<any[]>([]);
const categoriesOptions = ref<any[]>([]);
const showModal = ref(false);
const loading = ref(false);

const form = reactive({
    id: null as number | null,
    academic_unit_id: null as number | null,
    category_id: null as number | null,
    name: '',
    slug: '',
    modality: 'presencial',
    duration: '',
    description: '',
    branding_color: '#000000',
    is_active: true
});

// --- LOGICA DE CARGA ---
const loadData = async () => {
    loading.value = true;
    try {
        const response = await HttpClient.get('study-programs');
        programs.value = response.data.data || response.data;
    } catch (e: any) {
        // 🔥 2. Aplicado en la carga principal
        handleApiError(e, "Error al cargar los programas");
    } finally {
        loading.value = false;
    }
};

const loadDependencies = async () => {
    try {
        // Cargar Unidades Académicas para el Select
        const unitsRes = await HttpClient.get('academic-units');
        const units = unitsRes.data.data || unitsRes.data;
        academicUnitsOptions.value = units.map((u: any) => ({ value: u.id, text: `${u.code} - ${u.name}` }));

        // Cargar Categorías (puedes filtrar por type=academic en el backend o aquí)
        const catRes = await HttpClient.get('categories?type=academic');
        const cats = catRes.data.data || catRes.data;
        
        // Función rápida para aplanar el árbol de categorías si vienen anidadas
        const flatCats: any[] = [];
        const flatten = (arr: any[], level = 0) => {
            arr.forEach(c => {
                flatCats.push({ value: c.id, text: `${'— '.repeat(level)}${c.name}` });
                if (c.children && c.children.length > 0) flatten(c.children, level + 1);
            });
        };
        flatten(cats);
        categoriesOptions.value = flatCats;

    } catch (e: any) {
        // 🔥 3. Aplicado en las dependencias (por si falla la carga de selects por permisos o red)
        handleApiError(e, "Error al cargar las dependencias (Unidades/Categorías)");
    }
};

// --- CRUD ACCIONES ---
const openModal = () => {
    resetForm();
    showModal.value = true;
};

const editItem = (item: Program) => {
    resetForm();
    form.id = item.id;
    form.academic_unit_id = authStore.academicUnitId || item.academic_unit_id;    
    form.category_id = item.category_id;
    form.name = item.name;
    form.slug = item.slug;
    form.modality = item.modality || 'presencial';
    form.duration = item.duration || '';
    form.description = item.description || '';
    form.branding_color = item.branding_color || '#000000';
    form.is_active = Boolean(item.is_active);
    showModal.value = true;
};

const save = async () => {
    if (!form.name || !form.academic_unit_id || !form.category_id) {
        return Swal.fire("Atención", "Nombre, Unidad Académica y Categoría son obligatorios", "warning");
    }

    loading.value = true;
    try {
        const payload = {
            academic_unit_id: form.academic_unit_id,
            category_id: form.category_id,
            name: form.name,
            slug: form.slug,
            modality: form.modality,
            duration: form.duration,
            description: form.description,
            branding_color: form.branding_color,
            is_active: form.is_active ? 1 : 0
        };

        if (form.id) {
            await HttpClient.put(`study-programs/${form.id}`, payload);
        } else {
            await HttpClient.post('study-programs', payload);
        }
        
        await loadData();
        showModal.value = false;
        Swal.fire({ icon: 'success', title: 'Guardado correctamente', showConfirmButton: false, timer: 1500 });
    } catch (e: any) {
        // 🔥 4. Aplicado al guardar. Atrápara validaciones de slug repetido, campos vacíos y permisos.
        handleApiError(e, "Error al guardar el programa");
    } finally {
        loading.value = false;
    }
};

const deleteItem = (item: Program) => {
    Swal.fire({
        title: "¿Eliminar?",
        text: `Se eliminará el programa: ${item.name}`,
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: '#d33',
        confirmButtonText: "Sí, borrar",
        cancelButtonText: 'Cancelar'
    }).then(async (r) => {
        if (r.isConfirmed) {
            loading.value = true;
            try {
                await HttpClient.delete(`study-programs/${item.id}`);
                await loadData();
                Swal.fire("Eliminado", "Se borró con éxito", "success");
            } catch (e: any) {
                // 🔥 5. Aplicado al eliminar (intercepta 403 Forbidden o 500)
                handleApiError(e, "No se pudo eliminar el programa");
            } finally {
                loading.value = false;
            }
        }
    });
};

const resetForm = () => {
    form.id = null;
    form.academic_unit_id = authStore.academicUnitId || null;
    form.category_id = null;
    form.name = '';
    form.slug = '';
    form.modality = 'presencial';
    form.duration = '';
    form.description = '';
    form.branding_color = '#000000';
    form.is_active = true;
};

// Generador automático de slug
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

onMounted(() => {
    loadDependencies(); // Carga los selectores primero
    loadData(); // Carga la tabla
});
</script>