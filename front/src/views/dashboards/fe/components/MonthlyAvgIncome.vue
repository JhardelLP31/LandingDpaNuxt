<template>
  <b-col md="12" lg="8">
    <b-card no-body>
      <b-card-header>
        <b-row class="align-items-center">
          <div class="col-8">
            <b-card-title>Monthly Avg. Income</b-card-title>
          </div>
          <div class="col-4">
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
        <ApexChart
          v-if="!loading"
          :chart="monthlyIncomeChart"
          class="apex-charts"
          id="monthly_income"
        />
        <b-row>
          <b-col
            md="6"
            lg="3"
            v-for="(item, idx) in monthlyIncomeData"
            :key="idx"
          >
            <MonthlyIncomeCard :item="item" />
          </b-col>
        </b-row>
      </b-card-body>
    </b-card>
  </b-col>
</template>
<script setup lang="ts">
import ApexChart from "@/components/ui/ApexChart.vue";
// import {
//   monthlyIncomeData,
// } from "@/views/dashboards/ecommerce/components/data";
import MonthlyIncomeCard from "@/views/dashboards/ecommerce/components/MonthlyIncomeCard.vue";

import { onMounted, ref, watch } from "vue";
import HttpClient from "@/helpers/http-client";
import type { AxiosResponse } from "axios";
import type { ApexChartType } from "@/types";
const error = ref("");

const year = ref<number>(new Date().getFullYear());
const month  = ref<string>(new Date().getMonth() > 9 ? "0"+(new Date().getMonth()+1) : "0"+(new Date().getMonth()+1));
const loading = ref<boolean>(false);
const monthlyIncomeData = ref<any>([]);

const sales_x_day_of_month = async () => {
  loading.value = true;
  try {
    const res: AxiosResponse<any> = await HttpClient.post("kpi/sales_x_day_of_month",
      {
        year: year.value,
        month: month.value
      }
    );
    console.log(res);
    loading.value = false;
    let data_sales: number[] = [];
    let data_day_name: string[] = [];
    res.data.sales_for_day_month.forEach((sale_day:any) => {
      data_sales.push(sale_day.total_sales);
      data_day_name.push(sale_day.day_created_format);
    });
    monthlyIncomeChart.value.series.push({
      name: "Ventas Diarias",
      data:data_sales,
    });
    if(monthlyIncomeChart.value.options.xaxis){
      console.log(data_day_name);
      monthlyIncomeChart.value.options.xaxis.categories  = data_day_name;
    }
    monthlyIncomeData.value = [
      {
        title: "Total de Ventas",
        stat: `S/. ${res.data.total_sales_current}`,
      },
      {
        title: "Variación %",
        stat: `${res.data.percentageV}%`,
      },
      {
        title: "Total Facturado",
        stat: `S/. ${res.data.total_factur_month_current}`,
      },
      {
        title: "Avg. Total",
        stat: `S/. ${res.data.total_igv_month_current}`,
      },
    ];
    // monthlyIncomeChart(data_sales,data_day_name);
    } catch (e: any) {
        console.log(e);
        if (e.response?.data?.error) {
        if (error.value.length == 0) error.value = e.response?.data?.error;
        }
    }
};

const monthlyIncomeChart = ref<ApexChartType>({
  height: 270,
  type: "bar",
  series: [
    {
      name: "Ventas Diarias",
      data: [],//[2.3, 3.1, 4.0, 10.1, 4.0, 3.6, 3.2, 2.3, 1.4, 0.8, 0.5, 0.2],
    },
  ],
  options: {
    chart: {
      height: 270,
      type: "bar",

      toolbar: {
        show: false,
      },
      dropShadow: {
        enabled: true,
        top: 0,
        left: 5,
        // bottom: 5,
        // right: 0,
        blur: 5,
        color: "#45404a2e",
        opacity: 0.35,
      },
    },
    colors: [
      "#95a0c5",
      "#95a0c5",
      "#95a0c5",
      "#22c55e",
      "#95a0c5",
      "#95a0c5",
      "#95a0c5",
      "#95a0c5",
      "#95a0c5",
      "#95a0c5",
      "#95a0c5",
      "#95a0c5",
    ],
    plotOptions: {
      bar: {
        borderRadius: 6,
        dataLabels: {
          position: "top", // top, center, bottom
        },
        columnWidth: "20",
        distributed: true,
      },
    },
    dataLabels: {
      enabled: true,
      // formatter: function (val) {
      //   return val + "%";
      // },
      offsetY: -20,
      style: {
        fontSize: "12px",
        colors: ["#8997bd"],
      },
    },
    xaxis: {
      categories: [],
      // [
      //   "Jan",
      //   "Feb",
      //   "Mar",
      //   "Apr",
      //   "May",
      //   "Jun",
      //   "Jul",
      //   "Aug",
      //   "Sep",
      //   "Oct",
      //   "Nov",
      //   "Dec",
      // ],
      position: "top",
      axisBorder: {
        show: false,
      },
      axisTicks: {
        show: false,
      },
      crosshairs: {
        fill: {
          type: "gradient",
          gradient: {
            colorFrom: "#D8E3F0",
            colorTo: "#BED1E6",
            stops: [0, 100],
            opacityFrom: 0.4,
            opacityTo: 0.5,
          },
        },
      },
      tooltip: {
        enabled: true,
      },
    },
    yaxis: {
      axisBorder: {
        show: false,
      },
      axisTicks: {
        show: false,
      },
      labels: {
        show: true,
        formatter: function (val) {
          return val + " PEN";//"$" + 
        },
      },
    },
    grid: {
      row: {
        colors: ["transparent", "transparent"], // takes an array which will be repeated on columns
        opacity: 0.2,
      },
      strokeDashArray: 2.5,
    },
    legend: {
      show: false,
    },
  },
});
watch(year, (val) => {
  sales_x_day_of_month();
})
watch(month, (val) => {
  sales_x_day_of_month();
})
onMounted(() => {
  sales_x_day_of_month();
})

</script>
