<template>
  <div v-if="series && series.length > 0">
    <apexchart
      type="donut"
      height="300"
      :options="chartOptions"
      :series="chartSeries"
    ></apexchart>
  </div>
</template>

<script setup lang="ts">
import { computed } from "vue";

// Recibimos la data con formato: [{ name: 'Diplomado', value: 10 }, ...]
const props = defineProps({
  series: {
    type: Array as () => Array<{ name: string; value: number }>,
    default: () => [],
  },
});

// 1. Extraemos solo los números para la serie del gráfico
const chartSeries = computed(() => {
  return props.series.map((item) => item.value);
});

// 2. Configuramos las opciones (Etiquetas y colores)
const chartOptions = computed(() => {
  return {
    labels: props.series.map((item) => item.name), // Extraemos los nombres
    colors: ["#696cff", "#03c3ec", "#71dd37", "#ff3e1d", "#8592a3"], // Colores de tu tema
    dataLabels: {
      enabled: true,
    },
    legend: {
      position: "bottom",
    },
    plotOptions: {
      pie: {
        donut: {
          labels: {
            show: true,
            total: {
              show: true,
              label: "Total",
              formatter: function (w: any) {
                // Suma total al centro del dona
                return w.globals.seriesTotals.reduce((a: any, b: any) => a + b, 0);
              },
            },
          },
        },
      },
    },
  };
});
</script>