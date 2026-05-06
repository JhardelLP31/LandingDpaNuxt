<template>
  <div class="card">
    <div class="card-header">
      <h5 class="card-title mb-0">Intensidad de Leads (Día vs Hora)</h5>
    </div>
    <div class="card-body">
      <apexchart type="heatmap" height="350" :options="chartOptions" :series="series"></apexchart>
    </div>
  </div>
</template>

<script setup>
import { defineProps } from 'vue';

const props = defineProps(['series']);

const chartOptions = {
  chart: { toolbar: { show: false } },
  dataLabels: { enabled: false },
  colors: ["#008FFB"],
  xaxis: { type: 'category' }, // Horas
  plotOptions: {
    heatmap: {
      shadeIntensity: 0.5,
      colorScale: {
        ranges: [
            { from: 0, to: 0, color: '#F3F3F3', name: 'Sin actividad' }, // Gris si es 0
            { from: 1, to: 10, color: '#00A100', name: 'Baja' },   // Verde
            { from: 11, to: 50, color: '#FFB200', name: 'Media' }, // Naranja
            { from: 51, to: 100, color: '#FF0000', name: 'Alta' }  // Rojo
        ]
      }
    }
  }
};
</script>