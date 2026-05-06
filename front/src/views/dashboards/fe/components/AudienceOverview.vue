<template>
  <b-col md="6" lg="8">
    <b-card no-body>
      <b-card-header>
        <b-row class="align-items-center">
          <div class="col">
            <b-card-title>Audience Overview</b-card-title>
          </div>
          <div class="col-auto">
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
        </b-row>
      </b-card-header>
      <b-card-body class="pt-0">
        <ApexChart
          v-if="!loading"
          :chart="audienceOverviewChart"
          class="apex-charts"
          id="audience_overview"
        />
      </b-card-body>
    </b-card>
  </b-col>
</template>
<script setup lang="ts">
import ApexChart from "@/components/ui/ApexChart.vue";
// import { audienceOverviewChart } from "@/views/dashboards/analytics/components/data";

import { onMounted, ref, watch } from "vue";
import HttpClient from "@/helpers/http-client";
import type { AxiosResponse } from "axios";
import type { ApexChartType } from "@/types";
const error = ref("");

const year = ref<number>(new Date().getFullYear());
const loading = ref<boolean>(false);

const sales_x_month_of_year = async () => {
  loading.value = true;
  try {
    const res: AxiosResponse<any> = await HttpClient.post("kpi/sales_x_month_of_year",
      {
        year: year.value,
      }
    );
    console.log(res);
    loading.value = false;
    let data_sales: number[] = [];
    let data_sale_before: number[] = [];
    res.data.sales_x_month_of_year_current.forEach((sale_day:any) => {
      data_sales.push(sale_day.total_sales);
    });
    res.data.sales_x_month_of_year_before.forEach((sale_day:any) => {
      data_sale_before.push(sale_day.total_sales);
    });
    audienceOverviewChart.value.series.push({
      name: "Ventas Por Mes - "+(year.value),
      data:data_sales,
    });
    audienceOverviewChart.value.series.push({
      name: "Ventas Por Mes - "+(year.value - 1),
      data:data_sale_before,
    });
    if(audienceOverviewChart.value.options.labels){
      audienceOverviewChart.value.options.labels  = res.data.months_name;
    }
    // monthlyIncomeChart(data_sales,data_day_name);
    } catch (e: any) {
        console.log(e);
        if (e.response?.data?.error) {
        if (error.value.length == 0) error.value = e.response?.data?.error;
        }
    }
};

const audienceOverviewChart = ref<ApexChartType>({
  height: 280,
  type: "area",
  series: [],
  // [
  //   {
  //     name: "Income",
  //     data: [31, 40, 28, 51, 31, 40, 28, 51, 31, 40, 28, 51],
  //   },
  //   {
  //     name: "Expenses",
  //     data: [0, 30, 10, 40, 30, 60, 50, 80, 70, 100, 90, 130],
  //   },
  // ],
  options: {
    chart: {
      height: 280,
      type: "area",
      toolbar: {
        show: false,
      },
      dropShadow: {
        enabled: true,
        top: 12,
        left: 0,
        // bottom: 0,
        // right: 0,
        blur: 2,
        color: "rgba(132, 145, 183, 0.3)",
        opacity: 0.35,
      },
    },
    // annotations: {
    //   xaxis: [
    //     {
    //       x: 312,
    //       strokeDashArray: 4,
    //       borderWidth: 1,
    //       borderColor: "var(--bs-secondary)",
    //     },
    //   ],
    //   points: [
    //     {
    //       x: 312,
    //       y: 52,
    //       marker: {
    //         size: 6,
    //         fillColor: "var(--bs-primary)",
    //         strokeColor: "var(--bs-card-bg)",
    //         strokeWidth: 4,
    //         radius: 5,
    //       },
    //       label: {
    //         borderWidth: 1,
    //         offsetY: -110,
    //         text: "50k",
    //         style: {
    //           background: "var(--bs-primary)",
    //           fontSize: "14px",
    //           fontWeight: "600",
    //         },
    //       },
    //     },
    //   ],
    // },
    colors: ["#22c55e", "rgba(106, 155, 155, 0.3)"],
    dataLabels: {
      enabled: false,
    },
    stroke: {
      show: true,
      curve: "smooth",
      width: [3, 3],
      dashArray: [0, 0],
      lineCap: "round",
    },
    labels: [],
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

    yaxis: {
      labels: {
        offsetX: -12,
        offsetY: 0,
        formatter: function (value) {
          return "S/. " + value;
        },
      },
    },
    grid: {
      strokeDashArray: 3,
      xaxis: {
        lines: {
          show: true,
        },
      },
      yaxis: {
        lines: {
          show: false,
        },
      },
    },
    legend: {
      show: false,
    },

    fill: {
      type: "gradient",
      gradient: {
        type: "vertical",
        shadeIntensity: 1,
        inverseColors: !1,
        opacityFrom: 0.05,
        opacityTo: 0.05,
        stops: [45, 100],
      },
    },
  },
});

watch(year, (val) => {
  sales_x_month_of_year();
})
onMounted(() => {
  sales_x_month_of_year();
})
</script>
