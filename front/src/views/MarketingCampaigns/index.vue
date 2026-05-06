<template>
    <b-row class="justify-content-center">
        <b-col cols="12">
            <b-card no-body class="shadow-sm">
                <b-card-header class=" py-3">
                    <b-row class="align-items-center">
                        <b-col md="6">
                            <h5 class="mb-0 fw-bold">🎯 Gestión de Campañas</h5>
                            <small class="text-muted">Administra los periodos de captación</small>
                        </b-col>
                        <b-col md="6" class="text-end">
                            <b-button :variant="themeColor" @click="openModal()">
                                <i class="fas fa-plus me-2"></i> Nueva Campaña
                            </b-button>
                        </b-col>
                    </b-row>
                </b-card-header>

                <b-card-body class="p-0">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle mb-0">
                            <thead class="table-light">
                                <tr>
                                    <th class="ps-3">ID</th>
                                    <th>Campaña / Slug</th>
                                    <th>Periodo</th>
                                    <th>Fechas</th>
                                    <th class="text-center">Estado</th>
                                    <th class="text-end pe-3">Acciones</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="item in campaigns" :key="(item.id)">
                                    <td class="ps-3">#{{ item.id }}</td>
                                    <td>
                                        <div class="fw-bold text-dark">{{ item.name }}</div>
                                        <code class="small text-primary">{{ item.slug }}</code>
                                    </td>
                                    <td>
                                        <b-badge variant="light" class="border text-dark">{{ item.academic_period }}</b-badge>
                                    </td>
                                    <td>
                                      <div class="small">
                                          <span style="font-weight: 700;" class="text-success d-block">
                                              Inicio: {{ item.start_date.split('T')[0] }}
                                          </span>
                                          <span style="font-weight: 700;" class="text-danger d-block">
                                              Fin: {{ item.end_date.split('T')[0] }}
                                          </span>
                                      </div>
                                  </td>
                                    <td class="text-center">
                                        <b-badge :variant="item.is_active ? 'success' : 'secondary'" pill>
                                            {{ item.is_active ? 'Activa' : 'Inactiva' }}
                                        </b-badge>
                                    </td>
                                    <td class="text-end pe-3">
                                        <b-button size="sm" variant="light" class="border me-1" @click="editItem(item)">
                                            <i class="las la-pen text-info"></i>
                                        </b-button>
                                        <b-button size="sm" variant="light" class="border" @click="deleteItem(item)">
                                            <i class="las la-trash text-danger"></i>
                                        </b-button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                        
                        <div v-if="loading" class="text-center p-5">
                            <b-spinner :variant="themeColor"></b-spinner>
                        </div>
                    </div>
                </b-card-body>
            </b-card>
        </b-col>
    </b-row>

    <b-modal v-model="showModal" 
             :title="form.id ? 'Editar Campaña' : 'Nueva Campaña'" 
             size="lg" 
             hide-footer 
             centered>
        <b-row>
            <b-col lg="8" class="mb-3">
                <label class="fw-bold mb-1">Nombre de la Campaña:</label>
                <b-form-input v-model="form.name" placeholder="Ej: Admisión Verano 2026" @input="generateSlug" />
            </b-col>

            <b-col lg="4" class="mb-3">
                <label class="fw-bold mb-1">Periodo Académico:</label>
                <b-form-input v-model="form.academic_period" placeholder="Ej: 2026-I" />
            </b-col>
            
            <b-col cols="12" class="mb-3">
                <label class="fw-bold small text-muted">Slug identificador:</label>
                <b-form-input v-model="form.slug" readonly class="bg-light font-monospace" />
            </b-col>

            <b-col lg="6" class="mb-3">
                <label class="fw-bold text-success mb-1">Fecha Inicio:</label>
                <b-form-input v-model="form.start_date" type="date" />
            </b-col>

            <b-col lg="6" class="mb-3">
                <label class="fw-bold text-danger mb-1">Fecha Fin:</label>
                <b-form-input v-model="form.end_date" type="date" />
            </b-col>

            <b-col cols="12" class="mb-3">
                <div class="p-3 border rounded bg-light">
                    <div class="d-flex justify-content-between mb-3 align-items-center">
                        <span class="fw-bold" :class="`text-${themeColor}`">Configuración de Formulario</span>
                        <b-button size="sm" :variant="themeColor" @click="addField()">
                            <i class="las la-plus"></i> Agregar Campo
                        </b-button>
                    </div>
                    
                    <div v-for="(field, index) in form.form_config.fields" :key="index" class="row g-2 mb-2">
                        <b-col md="6">
                            <b-form-input v-model="field.name" size="sm" placeholder="Nombre del campo (ej: cargo)" />
                        </b-col>
                        <b-col md="4">
                            <b-form-select v-model="field.type" size="sm" :options="['text', 'number', 'tel', 'email', 'date']" />
                        </b-col>
                        <b-col md="2" class="text-end">
                            <b-button size="sm" variant="outline-danger" @click="removeField(index)">
                                <i class="las la-times"></i>
                            </b-button>
                        </b-col>
                    </div>
                    <div v-if="form.form_config.fields.length === 0" class="text-center text-muted small py-2">
                        No hay campos adicionales configurados.
                    </div>
                </div>
            </b-col>

            <b-col cols="12" class="mb-4">
                <b-form-checkbox v-model="form.is_active" switch size="lg">
                    <span :class="form.is_active ? 'text-success fw-bold' : 'text-muted'">
                        {{ form.is_active ? 'Campaña Activa' : 'Campaña Inactiva' }}
                    </span>
                </b-form-checkbox>
            </b-col>

            <b-col cols="12" class="text-end border-top pt-3">
                <b-button variant="light" class="me-2" @click="showModal = false">Cancelar</b-button>
                <b-button :variant="themeColor" @click="save" :disabled="loading">
                    <b-spinner small v-if="loading" class="me-1"></b-spinner>
                    {{ form.id ? 'Actualizar Campaña' : 'Guardar Campaña' }}
                </b-button>
            </b-col>
        </b-row>
    </b-modal>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted } from "vue";
import HttpClient from "@/helpers/http-client"; 
import Swal from "sweetalert2";
import { useAuthStore } from "@/stores/auth"; 

import { handleApiError } from "@/helpers/errorHandler";

const themeColor = ref<any>("danger");

// 1. Interfaces
interface FormField {
    name: string;
    type: string;
}

interface Campaign {
    id: number | null;
    academic_unit_id: number | null;
    name: string;
    slug: string;
    academic_period: string;
    start_date: string;
    end_date: string;
    form_config: { fields: FormField[] };
    is_active: boolean | number;
    study_program_id?: number | null;
    content_id?: number | null;
    utm_source_default?: string;
}

// 2. Estado
const authStore = useAuthStore(); // Obtenemos el store global
const campaigns = ref<Campaign[]>([]);
const loading = ref(false);
const showModal = ref(false);

const form = reactive<Campaign>({
    id: null,
    academic_unit_id: null,
    name: '',
    slug: '',
    academic_period: '',
    start_date: '',
    end_date: '',
    form_config: { fields: [] as FormField[] },
    is_active: true
});

// 3. Lógica
const loadData = async () => {
    loading.value = true;
    try {
        const response = await HttpClient.get('marketing/campaigns', {
            params: {
                academic_unit_id: authStore.academicUnitId 
            }
        });
        campaigns.value = response.data.data || response.data;
    } catch (e: any) {
        handleApiError(e, "Error al cargar campañas");
    } finally {
        loading.value = false;
    }
};

const generateSlug = () => {
    form.slug = form.name.toLowerCase().trim()
        .normalize("NFD").replace(/[\u0300-\u036f]/g, "")
        .replace(/[^a-z0-9 -]/g, '').replace(/\s+/g, '-').replace(/-+/g, '-');
};

const openModal = () => {
    resetForm();
    showModal.value = true;
};

const editItem = (item: any) => {
    resetForm();
    
    // Clonamos la data base
    const clonedItem = JSON.parse(JSON.stringify(item));

    // Limpiamos las fechas para el input HTML (solo YYYY-MM-DD)
    if (clonedItem.start_date) {
        clonedItem.start_date = clonedItem.start_date.substring(0, 10);
    }
    if (clonedItem.end_date) {
        clonedItem.end_date = clonedItem.end_date.substring(0, 10);
    }

    // Asignamos al formulario reactivo
    Object.assign(form, clonedItem);
    form.is_active = !!item.is_active;
    
    // Manejo del JSON form_config
    if (typeof item.form_config === 'string') {
        try { 
            form.form_config = JSON.parse(item.form_config); 
        } catch (e) { 
            form.form_config = { fields: [] }; 
        }
    }
    
    showModal.value = true;
};

const save = async () => {
    if (!form.name || !form.academic_period) {
        return Swal.fire("Atención", "Nombre y Periodo son obligatorios", "warning");
    }

    loading.value = true;
    try {
        const payload = { 
            name: form.name,
            slug: form.slug,
            academic_period: form.academic_period,
            start_date: form.start_date,
            end_date: form.end_date,
            form_config: form.form_config, 
            is_active: !!form.is_active,
            academic_unit_id: authStore.academicUnitId 
        };

        if (form.id) {
            await HttpClient.put(`marketing/campaigns/${form.id}`, payload);
            Swal.fire("Éxito", "Campaña actualizada con éxito", "success");
        } else {
            await HttpClient.post('marketing/campaigns', payload);
            Swal.fire("Éxito", "Campaña creada con éxito", "success");
        }

        await loadData();
        showModal.value = false;

    } catch (e: any) {
        // 🔥 3. Aplicado al guardar. Limpio y elegante.
        handleApiError(e, "Error al guardar la campaña");
    } finally {
        loading.value = false;
    }
};

const deleteItem = (item: Campaign) => {
    Swal.fire({
        title: "¿Estás seguro?",
        text: `Se eliminará la campaña: ${item.name}`,
        icon: "warning",
        showCancelButton: true,
        confirmButtonText: "Sí, eliminar",
        cancelButtonText: "Cancelar"
    }).then(async (result) => {
        if (result.isConfirmed) {
            try {
                await HttpClient.delete(`marketing/campaigns/${item.id}`);
                loadData();
                Swal.fire("Eliminado", "La campaña ha sido borrada", "success");
            } catch (e: any) {
                // 🔥 4. Aplicado al eliminar
                handleApiError(e, "Error al eliminar");
            }
        }
    });
};

const addField = () => {
    form.form_config.fields.push({ name: '', type: 'text' });
};

const removeField = (index: number) => {
    form.form_config.fields.splice(index, 1);
};

const resetForm = () => {
    form.id = null;
    form.academic_unit_id = null;
    form.name = '';
    form.slug = '';
    form.academic_period = '';
    form.start_date = '';
    form.end_date = '';
    form.form_config = { fields: [] as FormField[] };
    form.is_active = true;
};

onMounted(() => {
    loadData();
});
</script>