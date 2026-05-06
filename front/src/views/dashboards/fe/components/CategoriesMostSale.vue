<template>
  <b-col md="6" lg="4">
    <b-card no-body>
      <b-card-header>
        <b-row class="align-items-center">
          <div class="col">
            <b-card-title>Categorias</b-card-title>
          </div>
          <div class="col-auto">
            <div class="d-flex">
              <div class="">
                <select
                    class="form-control form-select-solid fw-bolder"
                    name="year_2"
                    placeholder="Filtrar por Año"
                    v-model="year"
                  >
                    <option value="2025">2025</option>
                    <option value="2026">2026</option>
                    <option value="2027">2027</option>
                    <option value="2028">2028</option>
                </select>
                <small class="form-text text-muted"><b>Filtrar</b> por Año</small >
              </div>
              <div class="mx-3">
                <select
                  class="form-control form-select-solid fw-bolder"
                  name="month_2"
                  placeholder="Filtrar por Mes"
                  v-model="month"
                >
                      <option value="01">Enero</option>
                      <option value="02">Febrero</option>
                      <option value="03">Marzo</option>
                      <option value="04">Abril</option>
                      <option value="05">Mayo</option>
                      <option value="06">Junio</option>
                      <option value="07">Julio</option>
                      <option value="08">Agosto</option>
                      <option value="09">Septiembre</option>
                      <option value="10">Octubre</option>
                      <option value="11">Noviembre</option>
                      <option value="12">Diciembre</option>
                </select>
                <small class="form-text text-muted"><b>Filtrar</b> por Mes</small>
              </div>
            </div>
          </div>
        </b-row>
      </b-card-header>
      <b-card-body class="pt-0">
        <ApexChart v-if="!loading" :chart="customersChart" class="apex-charts" id="customers" />
      </b-card-body>
    </b-card>
  </b-col>
</template>
<script setup lang="ts">
import ApexChart from "@/components/ui/ApexChart.vue";
// import { customersChart } from "@/views/dashboards/ecommerce/components/data";

import { onMounted, ref, watch } from "vue";
import HttpClient from "@/helpers/http-client";
import type { AxiosResponse } from "axios";
import type { ApexChartType } from "@/types";
const error = ref("");

const year = ref<number>(new Date().getFullYear());
const month  = ref<string>(new Date().getMonth() > 9 ? "0"+(new Date().getMonth()+1) : "0"+(new Date().getMonth()+1));
const loading = ref<boolean>(false);

const categories_most_sales = async () => {
  loading.value = true;
  try {
    const res: AxiosResponse<any> = await HttpClient.post("kpi/categories_most_sales",
      {
        year: year.value,
        month: month.value
      }
    );
    console.log(res);
    loading.value = false;
    let data_sales: number[] = [];
    let data_categorie_name: string[] = [];
    res.data.categories_most_sales.forEach((sale_day:any) => {
      data_sales.push(sale_day.total_sales);
      data_categorie_name.push(sale_day.categorie_name);
    });
    customersChart.value.series = data_sales;
    if(customersChart.value.options.labels){
      customersChart.value.options.labels  = data_categorie_name;
    }
    // monthlyIncomeChart(data_sales,data_categorie_name);
    } catch (e: any) {
        console.log(e);
        if (e.response?.data?.error) {
        if (error.value.length == 0) error.value = e.response?.data?.error;
        }
    }
};

const customersChart = ref<ApexChartType>({
  height: 280,
  type: "donut",
  series: [],//[50, 25, 25],
  options: {
    chart: {
      height: 280,
      type: "donut",
    },
    plotOptions: {
      pie: {
        donut: {
          size: "80%",
        },
      },
    },
    dataLabels: {
      enabled: false,
    },

    stroke: {
      show: true,
      width: 2,
      colors: ["transparent"],
    },
    legend: {
      show: true,
      position: "bottom",
      horizontalAlign: "center",
      // verticalAlign: 'middle',
      floating: false,
      fontSize: "13px",
      fontFamily: "Be Vietnam Pro, sans-serif",
      offsetX: 0,
      offsetY: 0,
    },
    labels: [],//["Currenet", "New", "Retargeted"],
    colors: ["#22c55e", "#08b0e7", "#ffc728"],

    responsive: [
      {
        breakpoint: 600,
        options: {
          plotOptions: {
            donut: {
              customScale: 0.2,
            },
          },
          chart: {
            height: 240,
          },
          legend: {
            show: false,
          },
        },
      },
    ],
    tooltip: {
      y: {
        formatter: function (val) {
          return val + " PEN";
        },
      },
    },
  },
});


watch(year, (val) => {
  categories_most_sales();
})
watch(month, (val) => {
  categories_most_sales();
})
onMounted(() => {
  categories_most_sales();
})


</script>
