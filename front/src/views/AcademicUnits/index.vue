<template>
    <b-row class="justify-content-center">
        <b-col cols="12">
            <b-card no-body>
                <b-card-header>
                    <b-row class="align-items-center">
                        <b-col md="6">
                            <b-card-title>🏛️ Gestión de Unidades Académicas</b-card-title>
                        </b-col>
                        <b-col md="6" class="text-end">
                            <b-button variant="primary" @click="openModal()">
                                <i class="fas fa-plus me-2"></i> Nueva Unidad
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
                                    <th>Código</th>
                                    <th>Nombre</th>
                                    <th>Slug</th>
                                    <th>Dominio</th> <th>Estado</th>
                                    <th class="text-end">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="item in academic_units" :key="item.id">
                                    <th>{{ item.id }}</th>
                                    <td>
                                        <b-badge variant="dark" class="text-uppercase">{{ item.code }}</b-badge>
                                    </td>
                                    <td class="fw-bold text-dark">{{ item.name }}</td>
                                    <td class="text-muted small">{{ item.slug }}</td>
                                    <td class="small">
                                        <span v-if="item.domain" class="text-primary font-monospace">{{ item.domain }}</span>
                                        <span v-else class="text-muted fst-italic">No asignado</span>
                                    </td>
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

                        <div v-if="academic_units.length === 0 && !loading" class="text-center p-4 text-muted">
                            No hay unidades académicas registradas.
                        </div>
                    </div>
                </b-card-body>
            </b-card>
        </b-col>
    </b-row>

    <b-modal v-model="showModal" 
             :title="form.id ? 'Editar Unidad Académica' : 'Nueva Unidad Académica'" 
             size="md" 
             hide-footer
             centered>
        
        <b-row>
            <b-col cols="12" class="mb-3">
                <label class="fw-bold">Nombre de la Unidad:</label>
                <b-form-input v-model="form.name" placeholder="Ej: Pregrado" />
            </b-col>

            <b-col cols="12" class="mb-3">
                <label class="fw-bold">Código Institucional:</label>
                <b-form-input v-model="form.code" placeholder="Ej: PRE-01" class="text-uppercase" />
            </b-col>
            
            <b-col cols="12" class="mb-3">
                <label class="fw-bold">Slug (URL Interna):</label>
                <b-form-input v-model="form.slug" placeholder="Generado automáticamente" readonly />
                <small class="text-muted d-block mt-1">Usado para pruebas locales o rutas internas.</small>
            </b-col>

            <b-col cols="12" class="mb-3">
                <label class="fw-bold">Dominio Principal (Opcional):</label>
                <b-form-input v-model="form.domain" placeholder="Ej: pregrado.dominio.com o pregrado.test" />
                <small class="text-muted d-block mt-1">Sin http:// ni /. Déjalo en blanco si no usa subdominio propio.</small>
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

interface AcademicUnit {
    id: number;
    name: string;
    slug: string;
    code: string;
    domain: string | null; // <-- Añadido al tipado
    is_active: boolean | number;
}

// --- ESTADO ---
const academic_units = ref<AcademicUnit[]>([]);
const showModal = ref(false);
const loading = ref(false);

const form = reactive({
    id: null as number | null,
    name: '',
    slug: '',
    code: '',
    domain: '', // <-- Añadido al state del formulario
    is_active: true
});

// --- LOGICA DE CARGA ---
const loadData = async () => {
    loading.value = true;
    try {
        const response = await HttpClient.get('academic-units');
        academic_units.value = response.data.data || response.data;
    } catch (e) {
        console.error(e);
        Swal.fire("Error", "Error al cargar las unidades", "error");
    } finally {
        loading.value = false;
    }
};

// --- CRUD ACCIONES ---
const openModal = () => {
    resetForm();
    showModal.value = true;
};

const editItem = (item: AcademicUnit) => {
    resetForm();
    form.id = item.id;
    form.name = item.name;
    form.slug = item.slug;
    form.code = item.code;
    form.domain = item.domain || ''; // <-- Recuperamos el dominio al editar
    form.is_active = Boolean(item.is_active);
    showModal.value = true;
};

const save = async () => {
    if (!form.name || !form.code) return Swal.fire("Atención", "El nombre y el código son obligatorios", "warning");

    loading.value = true;
    try {
        const payload = {
            name: form.name,
            slug: form.slug,
            code: form.code.toUpperCase(),
            domain: form.domain ? form.domain.trim().toLowerCase() : null, // <-- Limpiamos y enviamos
            is_active: form.is_active ? 1 : 0
        };

        if (form.id) {
            await HttpClient.put(`academic-units/${form.id}`, payload);
        } else {
            await HttpClient.post('academic-units', payload);
        }
        
        await loadData();
        showModal.value = false;
        Swal.fire({ icon: 'success', title: 'Guardado correctamente', showConfirmButton: false, timer: 1500 });
    } catch (e: any) {
        // Mejor manejo de error si el dominio está duplicado (Regla UNIQUE en la BD)
        const msg = e.response?.data?.message || "Error al guardar";
        if(msg.includes('domain') || msg.includes('Duplicate entry')) {
            Swal.fire("Error", "Este dominio ya está en uso por otra unidad.", "error");
        } else {
            Swal.fire("Error", msg, "error");
        }
    } finally {
        loading.value = false;
    }
};

const deleteItem = (item: AcademicUnit) => {
    Swal.fire({
        title: "¿Eliminar?",
        text: `Se eliminará la unidad: ${item.name}`,
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: '#d33',
        confirmButtonText: "Sí, borrar",
        cancelButtonText: 'Cancelar'
    }).then(async (r) => {
        if (r.isConfirmed) {
            loading.value = true;
            try {
                await HttpClient.delete(`academic-units/${item.id}`);
                await loadData();
                Swal.fire("Eliminado", "La unidad se movió a la papelera", "success");
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
    form.code = '';
    form.domain = ''; // <-- Reseteamos el dominio
    form.is_active = true;
};

// Generador automático de slug
watch(() => form.name, (newVal) => {
    // Si estamos editando y ya tiene un slug, no lo sobreescribimos a menos que queramos
    // (Opcional: puedes quitar este if si quieres que el slug cambie siempre que cambie el nombre)
    if(!form.id) {
        if (newVal) {
            form.slug = newVal
                .toLowerCase()
                .trim()
                .normalize("NFD").replace(/[\u0300-\u036f]/g, "") 
                .replace(/[^a-z0-9 -]/g, '') 
                .replace(/\s+/g, '-') 
                .replace(/-+/g, '-'); 
        } else {
            form.slug = '';
        }
    }
});

onMounted(() => {
    loadData();
});
</script>