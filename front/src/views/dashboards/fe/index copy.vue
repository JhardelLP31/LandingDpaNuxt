<template>
    <DefaultLayout>
        <b-row v-if="useAuth.isPermitedRoute('dashboard')">
            <b-col md="12" lg="4">
                <b-row>
                    <template v-for="(item, idx) in statData" :key="idx">
                        <b-col md="12" lg="6">
                            <ReportGeneralWidgest :item="item" />
                        </b-col>
                    </template>
                </b-row>
            </b-col>
            <MonthlyAvgIncome />
        </b-row>
        <b-row class="justify-content-center" v-if="useAuth.isPermitedRoute('dashboard')">
            <AudienceOverview />
            <CategoriesMostSale />
        </b-row>
        <b-row v-if="useAuth.isPermitedRoute('dashboard')">
            <ProductsMostSale />
            <ClientMostSale />
        </b-row>
    </DefaultLayout>
</template>
<script setup lang="ts">
import DefaultLayout from "@/layouts/DefaultLayout.vue";
// import { statData } from "@/views/dashboards/ecommerce/components/data";

import ReportGeneralWidgest from "@/views/dashboards/fe/components/ReportGeneralWidgest.vue";
import MonthlyAvgIncome from "@/views/dashboards/fe/components/MonthlyAvgIncome.vue";
import CategoriesMostSale from "@/views/dashboards/fe/components/CategoriesMostSale.vue";
import AudienceOverview from "@/views/dashboards/fe/components/AudienceOverview.vue";
import ProductsMostSale from "@/views/dashboards/fe/components/ProductsMostSale.vue";
import ClientMostSale from "@/views/dashboards/fe/components/ClientMostSale.vue";

import { onMounted, ref, watch } from "vue";
import HttpClient from "@/helpers/http-client";
import type { AxiosResponse } from "axios";
const error = ref("");
const statData = ref<any>([]);

import { useAuthStore } from "@/stores/auth";
const useAuth = useAuthStore();

const report_general = async () => {
  try {
    const res: AxiosResponse<any> = await HttpClient.post("kpi/report_general",{});
    console.log(res);
    statData.value.push({
        title: "Total Cotización",
        icon: "fas fa-file-alt",
        stat: `S/. ${res.data.total_cotiz_month_current}`,
        change: res.data.variation_percentage_total_cotiz,
        subTitle: "",
        buttonVariant: res.data.variation_percentage_total_cotiz > 0 ? "primary" : "danger",
    });
    statData.value.push({
        title: "Total Venta",
        icon: "icofont-money-bag",
        stat: `S/. ${res.data.total_sales_month_current}`,
        change: res.data.variation_percentage_total_sales,
        subTitle: "",
        buttonVariant: res.data.variation_percentage_total_sales > 0 ? "primary" : "danger",
    });
    statData.value.push({
        title: "Total V. Facturado",
        icon: "fas fa-money-bill-alt",
        stat: `S/. ${res.data.total_factur_month_current}`,
        change: res.data.variation_percentage_total_factur,
        subTitle: "",
        buttonVariant: res.data.variation_percentage_total_factur > 0 ? "primary" : "danger",
    });
    statData.value.push({
        title: "N° de Guia Remisión",
        icon: "fas fa-bus",
        stat: `${res.data.total_guia_de_remision}`,
        change: res.data.variation_percentage_guia_de_remision_before,
        subTitle: "",
        buttonVariant: res.data.variation_percentage_guia_de_remision_before > 0 ? "primary" : "danger",
    });
    } catch (e: any) {
        console.log(e);
        if (e.response?.data?.error) {
        if (error.value.length == 0) error.value = e.response?.data?.error;
        }
    }
};

onMounted(() => {
    report_general();
})
</script>