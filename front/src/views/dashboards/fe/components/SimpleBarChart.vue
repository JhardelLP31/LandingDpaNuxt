<template>
  <div v-if="series && series.length > 0">
    <apexchart
      type="bar"
      height="300"
      :options="chartOptions"
      :series="chartSeries"
    ></apexchart>
  </div>
</template>

<script setup lang="ts">
import { computed } from "vue";

const props = defineProps({
  series: {
    type: Array as () => Array<{ name: string; value: number }>,
    default: () => [],
  },
});

// 1. ApexCharts espera un array de objetos para barras
const chartSeries = computed(() => {
  return [
    {
      name: "Interesados",
      data: props.series.map((item) => item.value), // Solo números
    },
  ];
});

// 2. Ponemos los nombres de los cursos en el Eje X (Categorías)
const chartOptions = computed(() => {
  return {
    chart: {
      toolbar: { show: false },
    },
    plotOptions: {
      bar: {
        borderRadius: 4,
        horizontal: true, // IMPORTANTE: Barras horizontales para leer mejor
        barHeight: "50%",
      },
    },
    dataLabels: {
      enabled: true,
      textAnchor: "start",
      style: {
        colors: ["#fff"],
      },
      formatter: function (val: any, opt: any) {
        return val + " leads";
      },
      offsetX: 0,
    },
    xaxis: {
      categories: props.series.map((item) => item.name), // Nombres de cursos
    },
    colors: ["#696cff"], // Color principal
    grid: {
      borderColor: "#f1f1f1",
      xaxis: {
        lines: { show: false },
      },
    },
  };
});
</script>