<template>
    <b-row class="justify-content-center">
        <b-col cols="12">
            <b-card no-body>
                <b-card-header>
                    <b-row class="align-items-center justify-content-between">
                        <b-col lg="3">
                            <b-card-title>🚀 Gestión de Leads</b-card-title>
                        </b-col>
                        <b-col lg="6" class="text-end d-flex justify-content-end align-items-center gap-2">
                            <div class="d-flex align-items-center gap-1" style="max-width: 300px;">
                                <b-form-input 
                                    type="date" 
                                    size="sm" 
                                    v-model="excelFilters.start_date" 
                                    title="Fecha Inicio"
                                ></b-form-input>
                                <span class="text-muted">-</span>
                                <b-form-input 
                                    type="date" 
                                    size="sm" 
                                    v-model="excelFilters.end_date"
                                    title="Fecha Fin"
                                ></b-form-input>
                            </div>

                            <b-button variant="success" @click="downloadExcel" :disabled="isDownloading" size="sm">
                                <i class="las la-file-excel"></i> 
                                <span v-if="!isDownloading">Exportar</span>
                                <b-spinner small v-else></b-spinner>
                            </b-button>

                            <b-button variant="primary" @click="openModal()" size="sm">
                                <i class="las la-plus"></i> Nuevo
                            </b-button>
                        </b-col>
                    </b-row>
                </b-card-header>

                <b-card-body class="pt-0">
                    <div v-if="isLoading" class="text-center py-5">
                        <b-spinner label="Cargando..."></b-spinner>
                    </div>

                    <div v-else class="table-responsive m-0">
                        <table class="table table-hover">
                            <thead class="table-light">
                                <tr>
                                    <th>ID</th>
                                    <th>Nombre Completo</th>
                                    <th>Contacto</th>
                                    <th>Origen</th>
                                    <th>Interés</th>
                                    <th>Estado</th>
                                    <th>Mensaje</th>
                                    <th>Fecha</th>
                                    <th>Acción</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr v-for="lead in leadsList" :key="lead.id">
                                    <td>#{{ lead.id }}</td>
                                    <td>
                                        <div class="fw-bold">{{ lead.first_name }} {{ lead.last_name }}</div>
                                    </td>
                                    <td>
                                        <div><i class="las la-envelope"></i> {{ lead.email }}</div>
                                        <div v-if="lead.phone" class="small text-muted"><i class="las la-phone"></i> {{ lead.phone }}</div>
                                    </td>
                                    <td>
                                        <a v-if="parseJsonSafely(lead.marketing_metadata)?.origin_url" :href="parseJsonSafely(lead.marketing_metadata).origin_url" target="_blank" class="text-truncate d-inline-block" style="max-width: 150px;">
                                            {{ parseJsonSafely(lead.marketing_metadata).origin_url }}
                                        </a>
                                        <span v-else class="text-muted small">-</span>
                                    </td>
                                    <td>
                                        <div v-if="parseJsonSafely(lead.payload)">
                                            <b-badge variant="primary" v-if="parseJsonSafely(lead.payload).formation_type" class="mb-1">
                                                {{ parseJsonSafely(lead.payload).formation_type }}
                                            </b-badge>
                                            
                                            <div v-if="parseJsonSafely(lead.payload).course_interest" class="small fw-bold text-dark">
                                                {{ parseJsonSafely(lead.payload).course_interest }}
                                            </div>
                                        </div>
                                        <span v-else class="text-muted small">-</span>
                                    </td>
                                    <td>
                                        <b-badge :variant="getStatusVariant(lead.status)">
                                            {{ getStatusLabel(lead.status) }}
                                        </b-badge>
                                    </td>
                                    <td>
                                        <span class="d-inline-block text-truncate" style="max-width: 150px;" :title="parseJsonSafely(lead.payload)?.message">
                                            {{ parseJsonSafely(lead.payload)?.message || '-' }}
                                        </span>
                                    </td>
                                    <td>{{ formatDate(lead.created_at) }}</td>
                                    <td>
                                        <b-button size="sm" variant="ghost-primary" @click="openModal(lead)">
                                            <i class="las la-pen fs-18"></i>
                                        </b-button>
                                        <b-button size="sm" variant="ghost-danger" @click="deleteLead(lead)">
                                            <i class="las la-trash-alt fs-18"></i>
                                        </b-button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    
                    <b-pagination
                        v-if="pagination.total > 0"
                        v-model="pagination.current"
                        :total-rows="pagination.total"
                        :per-page="pagination.perPage"
                        class="mt-3 justify-content-end"
                    />
                </b-card-body>
            </b-card>
        </b-col>
    </b-row>

    <b-modal
        v-model="showModal"
        :title="`${form.id ? 'Editar' : 'Registrar'} Lead`"
        title-class="m-0"
        centered
        size="lg"
        hide-footer
    >
        <form @submit.prevent="submitLead">
            <b-row>
                <b-col lg="6" class="mb-3">
                    <label class="form-label">Nombre <span class="text-danger">*</span></label>
                    <b-form-input v-model="form.first_name" placeholder="Ej: Carlos" />
                </b-col>

                <b-col lg="6" class="mb-3">
                    <label class="form-label">Apellido <span class="text-danger">*</span></label>
                    <b-form-input v-model="form.last_name" placeholder="Ej: Pérez" />
                </b-col>

                <b-col lg="6" class="mb-3">
                    <label class="form-label">Email <span class="text-danger">*</span></label>
                    <b-form-input v-model="form.email" type="email" placeholder="cliente@empresa.com" />
                </b-col>

                <b-col lg="6" class="mb-3">
                    <label class="form-label">Teléfono</label>
                    <b-form-input v-model="form.phone" type="tel" placeholder="+51 999..." />
                </b-col>

                <b-col lg="12" class="mb-3">
                    <label class="form-label">URL de Origen</label>
                    <b-form-input v-model="form.marketing_metadata.origin_url" placeholder="https://landing-page.com/campana-x" />
                </b-col>

                <b-col lg="12" class="mb-3">
                    <label class="form-label">Estado</label>
                    <select class="form-select" v-model="form.status">
                        <option value="new">Nuevo</option>
                        <option value="pending">Pendiente</option>
                        <option value="contacted">Contactado</option>
                        <option value="spam">Descartado / Spam</option>
                    </select>
                </b-col>

                <b-col lg="12" class="mb-3">
                    <label class="form-label">Mensaje del Lead</label>
                    <b-form-textarea v-model="form.payload.message" rows="3" placeholder="Mensaje dejado por el cliente..."></b-form-textarea>
                </b-col>
                
                <b-col lg="6" class="mb-3">
                    <label class="form-label">Tipo de Formación</label>
                    <b-form-input v-model="form.payload.formation_type" placeholder="Ej: Diplomado"></b-form-input>
                </b-col>

                <b-col lg="6" class="mb-3">
                    <label class="form-label">Interés / Programa</label>
                    <b-form-input v-model="form.payload.course_interest" placeholder="Ej: Gestión Pública"></b-form-input>
                </b-col>

                <b-col lg="12">
                    <details class="mb-3">
                        <summary class="text-muted small cursor-pointer">Ver JSON completo (Técnico)</summary>
                        <b-form-textarea :model-value="JSON.stringify({ payload: form.payload, marketing_metadata: form.marketing_metadata })" readonly rows="3" class="bg-light mt-2 font-monospace" style="font-size: 0.8rem;"></b-form-textarea>
                    </details>
                </b-col>

                <b-col lg="12" class="d-flex justify-content-end gap-2 mt-2">
                    <b-button variant="light" @click="closeModalFn">Cancelar</b-button>
                    <b-button type="submit" variant="primary" :disabled="isSubmitting">
                        <b-spinner small v-if="isSubmitting"></b-spinner>
                        {{ form.id ? 'Actualizar' : 'Guardar' }}
                    </b-button>
                </b-col>
            </b-row>
        </form>
    </b-modal>
</template>

<script setup lang="ts">
import { ref, reactive, onMounted, watch } from "vue";
import HttpClient from "@/helpers/http-client";
import Swal from "sweetalert2";
import type { Lead } from "@/types/leads";

// --- STATE ---
const leadsList = ref<Lead[]>([]);
const isLoading = ref(false);
const isSubmitting = ref(false);
const showModal = ref(false);

const pagination = reactive({
    current: 1,
    total: 0,
    perPage: 10
});

// Estado inicial ajustado a la BD
const initialFormState = {
    id: undefined as number | undefined,
    first_name: "",
    last_name: "",
    email: "",
    phone: "",
    status: "new",
    payload: {
        message: "",
        formation_type: "",
        course_interest: ""
    },
    marketing_metadata: {
        origin_url: ""
    }
};

// Clonamos profundo para evitar referencias cruzadas
const form = reactive(JSON.parse(JSON.stringify(initialFormState)));

// --- API ACTIONS ---

const fetchLeads = async () => {
    isLoading.value = true;
    try {
        // Quitamos la desestructuración { data } por un momento para ver TODO
        const response = await HttpClient.get(`leads?page=${pagination.current}`);
        
        // 🚨 AQUÍ ESTÁ EL RADAR 🚨
        console.log("1. Respuesta completa de Axios:", response);
        console.log("2. Lo que mandó Laravel (response.data):", response.data);

        // Guardamos lo que mandó Laravel en una variable más clara
        const backendData = response.data;

        // Laravel por defecto manda los items paginados en la propiedad "data"
        // Intentamos leer de varias formas comunes
        leadsList.value = backendData.data || backendData.leads?.data || []; 
        pagination.total = backendData.total || backendData.leads?.total || 0;
        pagination.perPage = backendData.per_page || backendData.leads?.per_page || 10;

    } catch (error) {
        console.error("Error en la petición:", error);
        toast("Error al cargar leads", "error");
    } finally {
        isLoading.value = false;
    }
};
const excelFilters = reactive({
    start_date: "",
    end_date: ""
});

const isDownloading = ref(false);

const downloadExcel = async () => {
    if ((excelFilters.start_date && !excelFilters.end_date) || (!excelFilters.start_date && excelFilters.end_date)) {
        toast("Selecciona ambas fechas para filtrar o ninguna para todo", "warning");
        return;
    }

    isDownloading.value = true;
    try {
        const response = await HttpClient.get('leads-excel', { 
            responseType: 'blob',
            params: {
                start_date: excelFilters.start_date,
                end_date: excelFilters.end_date
            }
        });
        
        const url = window.URL.createObjectURL(new Blob([response.data]));
        const link = document.createElement('a');
        link.href = url;
        
        const suffix = excelFilters.start_date ? `_${excelFilters.start_date}_al_${excelFilters.end_date}` : '_Todos';
        link.setAttribute('download', `Leads${suffix}.xlsx`);
        
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        
        toast("Reporte generado con éxito", "success");
    } catch (error) {
        toast("Error al generar excel", "error");
    } finally {
        isDownloading.value = false;
    }
};

const submitLead = async () => {
    if (!validate()) return;
    
    isSubmitting.value = true;
    try {
        const payload = { ...form }; 
        
        let response;
        if (form.id) {
            response = await HttpClient.put(`leads/${form.id}`, payload);
        } else {
            response = await HttpClient.post(`leads`, payload);
        }

        if (response.data.error) throw new Error(response.data.message);

        const savedLead = response.data.lead || response.data;
        
        if (form.id) {
            const index = leadsList.value.findIndex(l => l.id === form.id);
            if (index !== -1) leadsList.value[index] = savedLead;
        } else {
            leadsList.value.unshift(savedLead);
        }

        toast("Lead guardado correctamente", "success");
        closeModalFn();

    } catch (error: any) {
        toast(error.response?.data?.message || "Error al guardar", "error");
    } finally {
        isSubmitting.value = false;
    }
};

const deleteLead = async (lead: Lead) => {
    const result = await Swal.fire({
        title: "¿Estás seguro?",
        text: `Se eliminará el lead de ${lead.first_name}`,
        icon: "warning",
        showCancelButton: true,
        confirmButtonColor: "#d33",
        confirmButtonText: "Sí, eliminar"
    });

    if (result.isConfirmed) {
        try {
            await HttpClient.delete(`leads/${lead.id}`);
            leadsList.value = leadsList.value.filter(l => l.id !== lead.id);
            toast("Lead eliminado", "success");
        } catch (error) {
            toast("No se pudo eliminar", "error");
        }
    }
};

// --- HELPERS ---

// Función de seguridad para evitar errores al parsear JSONs desde Laravel
const parseJsonSafely = (data: any) => {
    if (!data) return {};
    if (typeof data === 'object') return data;
    try {
        return JSON.parse(data);
    } catch (e) {
        return {};
    }
};

const openModal = (lead?: any) => {
    resetForm();
    if (lead) {
        const payloadObj = parseJsonSafely(lead.payload);
        const marketingObj = parseJsonSafely(lead.marketing_metadata);

        Object.assign(form, {
            id: lead.id,
            first_name: lead.first_name,
            last_name: lead.last_name,
            email: lead.email,
            phone: lead.phone,
            status: lead.status || 'new',
            payload: {
                message: payloadObj.message || "",
                formation_type: payloadObj.formation_type || "",
                course_interest: payloadObj.course_interest || ""
            },
            marketing_metadata: {
                origin_url: marketingObj.origin_url || ""
            }
        });
    }
    showModal.value = true;
};

const closeModalFn = () => {
    showModal.value = false;
    resetForm();
};

const resetForm = () => {
    Object.assign(form, JSON.parse(JSON.stringify(initialFormState)));
};

const validate = () => {
    if (!form.first_name || !form.last_name || !form.email) {
        toast("Nombre, Apellido y Email son obligatorios", "warning");
        return false;
    }
    return true;
};

const toast = (title: string, icon: 'success' | 'error' | 'warning' | 'info') => {
    Swal.fire({
        toast: true,
        position: 'top-end',
        showConfirmButton: false,
        timer: 3000,
        icon: icon,
        title: title
    });
};

// Utilidades visuales ajustadas a STRINGS
const getStatusLabel = (status: string) => {
    const map: Record<string, string> = { 
        'new': 'Nuevo', 
        'pending': 'Pendiente', 
        'contacted': 'Contactado', 
        'spam': 'Descartado' 
    };
    return map[status] || 'Desconocido';
};

const getStatusVariant = (status: string) => {
    const map: Record<string, string> = { 
        'new': 'info', 
        'pending': 'warning', 
        'contacted': 'success', 
        'spam': 'danger' 
    };
    return map[status] || 'secondary';
};

const formatDate = (date: string) => {
    if(!date) return '-';
    return new Date(date).toLocaleDateString('es-PE', { year: 'numeric', month: 'short', day: 'numeric' });
};

// --- LIFECYCLE ---
watch(() => pagination.current, fetchLeads);

onMounted(() => {
    fetchLeads();
});
</script>