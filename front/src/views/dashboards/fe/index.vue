<template>
    
        <b-row v-if="useAuth.isPermitedRoute('dashboard')">
            
            <b-col md="12" class="mb-4">
                <b-row>
                    <b-col md="3">
                        <div class="card bg-primary text-white h-100">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <h3 class="fw-bold mb-1">{{ kpiData.total_leads }}</h3>
                                    <p class="mb-0 small text-white-50">Total Histórico</p>
                                </div>
                                <div class="ms-3 opacity-50"><i class="las la-layer-group" style="font-size: 3rem;"></i></div>
                            </div>
                        </div>
                    </b-col>

                    <b-col md="3">
                        <div class="card bg-info text-white h-100">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <h3 class="fw-bold mb-1">{{ kpiData.leads_this_month }}</h3>
                                    <p class="mb-0 small text-white-50">Leads este Mes</p>
                                </div>
                                <div class="ms-3 opacity-50"><i class="las la-calendar-check" style="font-size: 3rem;"></i></div>
                            </div>
                        </div>
                    </b-col>

                    <b-col md="3">
                        <div class="card text-white h-100" :class="kpiData.pending > 0 ? 'bg-danger' : 'bg-success'">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <h3 class="fw-bold mb-1">{{ kpiData.pending }}</h3>
                                    <p class="mb-0 small text-white-50">Pendientes Revisión</p>
                                </div>
                                <div class="ms-3 opacity-50">
                                    <i :class="kpiData.pending > 0 ? 'las la-exclamation-circle' : 'las la-check-circle'" style="font-size: 3rem;"></i>
                                </div>
                            </div>
                        </div>
                    </b-col>

                    <b-col md="3">
                        <div class="card bg-secondary text-white h-100">
                            <div class="card-body d-flex justify-content-between align-items-center">
                                <div>
                                    <h3 class="fw-bold mb-1">{{ kpiData.spam_count }}</h3>
                                    <p class="mb-0 small text-white-50">Detectado como Spam</p>
                                </div>
                                <div class="ms-3 opacity-50"><i class="las la-user-shield" style="font-size: 3rem;"></i></div>
                            </div>
                        </div>
                    </b-col>
                </b-row>
            </b-col>

            <b-col md="12" class="mb-4">
                <b-row>
                    <b-col md="6" lg="5">
                         <div class="card h-100 shadow-sm">
                            <div class="card-header bg-white font-weight-bold">
                                Tipo de Formación
                            </div>
                            <div class="card-body">
                                <SimplePieChart v-if="formationSeries.length" :series="formationSeries" />
                                <div v-else class="text-center text-muted py-5">Sin datos suficientes</div>
                            </div>
                         </div>
                    </b-col>

                    <b-col md="6" lg="7">
                        <div class="card h-100 shadow-sm">
                            <div class="card-header bg-white font-weight-bold">
                                Top 5 Cursos Solicitados
                            </div>
                            <div class="card-body">
                                <SimpleBarChart v-if="courseSeries.length" :series="courseSeries" />
                                <div v-else class="text-center text-muted py-5">Sin datos suficientes</div>
                            </div>
                        </div>
                    </b-col>
                </b-row>
            </b-col>

            <b-col md="12" lg="8">
                <div class="card shadow-sm mb-4">
                    <div class="card-header bg-white">Horarios de Mayor Actividad</div>
                    <div class="card-body">
                        <TimeHeatmap v-if="heatmapSeries.length" :series="heatmapSeries" />
                    </div>
                </div>
            </b-col>
            
            <b-col md="12" lg="4">
                 <div class="card shadow-sm mb-4">
                    <div class="card-header bg-white">Fuentes de Tráfico</div>
                    <div class="card-body">
                        <UrlTreemap v-if="treemapSeries.length" :series="treemapSeries" />
                    </div>
                </div>
            </b-col>

        </b-row>
    
</template>

<script setup lang="ts">
import DefaultLayout from "@/layouts/DefaultLayout.vue";
import UrlTreemap from "@/views/dashboards/fe/components/UrlTreemap.vue";
import TimeHeatmap from "@/views/dashboards/fe/components/TimeHeatmap.vue";
// 🔥 IMPORTANTE: Necesitarás crear estos componentes o usar librerías de gráficos genéricas
import SimplePieChart from "@/views/dashboards/fe/components/SimplePieChart.vue"; 
import SimpleBarChart from "@/views/dashboards/fe/components/SimpleBarChart.vue";

import { onMounted, ref } from "vue";
import HttpClient from "@/helpers/http-client";
import { useAuthStore } from "@/stores/auth";

const useAuth = useAuthStore();
const kpiData = ref({ total_leads: 0, leads_this_month: 0, pending: 0, spam_count: 0 });

// Variables reactivas para las gráficas
const heatmapSeries = ref([]);
const treemapSeries = ref([]);
const formationSeries = ref([]); // Nueva
const courseSeries = ref([]);    // Nueva

const loadDashboard = async () => {
    try {
        const res = await HttpClient.get("cms/dashboard-kpi");
        
        // 1. Asignamos KPIs
        kpiData.value = res.data.kpis;

        // 2. Asignamos Gráficas (CORREGIDO SEGÚN EL JSON DEL BACKEND)
        // El backend devuelve: { charts: { by_url: [], by_time: [], by_formation: [], by_course: [] } }
        const charts = res.data.charts;

        treemapSeries.value   = charts.by_url;       // Antes url_treemap
        heatmapSeries.value   = charts.by_time;      // Antes time_heatmap
        formationSeries.value = charts.by_formation; // Nuevo
        courseSeries.value    = charts.by_course;    // Nuevo

    } catch (e) {
        console.error("Error cargando dashboard", e);
    }
};

onMounted(() => {
    loadDashboard();
})
</script>