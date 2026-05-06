import VueApexCharts from "vue3-apexcharts";

export default defineNuxtPlugin((nuxtApp) => {
  // Esto registra ApexCharts globalmente solo en el cliente
  nuxtApp.vueApp.use(VueApexCharts);
});