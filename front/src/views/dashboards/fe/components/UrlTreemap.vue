<template>
  <div class="card">
    <div class="card-header">
      <h5 class="card-title mb-0">Origen del Tráfico (Top URLs)</h5>
    </div>
    <div class="card-body">
      <apexchart type="treemap" height="350" :options="chartOptions" :series="series"></apexchart>
    </div>
  </div>
</template>

<script setup>
import { defineProps, computed } from 'vue';

const props = defineProps(['series']);

const chartOptions = {
  legend: { show: true },
  chart: { toolbar: { show: false } },
  title: { text: 'Volumen por Sitio Web', align: 'center' },
  colors: ['#3B93A5', '#F7B844', '#ADD8C7', '#EC3C65', '#CDD7B6'],
  plotOptions: {
    treemap: {
      distributed: true,
      enableShades: false
    }
  }
};
</script>