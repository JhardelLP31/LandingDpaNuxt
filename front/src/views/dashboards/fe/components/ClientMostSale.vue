<template>
  <b-col lg="6">
    <b-card no-body class="card-h-100">
      <b-card-header>
        <b-row class="align-items-center">
          <div class="col-6">
            <b-card-title>Productos/Servicios con mas Ventas</b-card-title>
          </div>
          <div class="col-6">
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
        <b-table-simple responsive class="mb-0">
          <b-thead class="table-light">
            <b-tr>
              <b-th class="border-top-0">Cliente</b-th>
              <b-th class="border-top-0">N° de Venta</b-th>
              <b-th class="border-top-0">Total de Venta</b-th>
              <b-th class="border-top-0">Igv Total</b-th>
            </b-tr>
          </b-thead>
          <b-tbody>
            <b-tr v-for="(item, idx) in client_sales" :key="idx">
              <b-td
                >{{ item.client_most_sale }}</b-td
              >
              <b-td
                >{{ item.count_sales
                }}
              </b-td>
              <b-td
                >S/. {{ item.total_sales
                }}
              </b-td>
              <b-td>
                S/. {{ item.total_igv }}
              </b-td>
            </b-tr>
          </b-tbody>
        </b-table-simple>
        <!-- <p class="m-0 fs-12 fst-italic ps-2 text-muted">
          Last data updated - 13min ago
          <a href="#!" class="link-danger ms-1"
            ><i class="align-middle iconoir-refresh"></i
          ></a>
        </p> -->
      </b-card-body>
    </b-card>
  </b-col>
</template>
<script setup lang="ts">
// import { visitsList } from "@/views/dashboards/analytics/components/data";

import { onMounted, ref, watch } from "vue";
import HttpClient from "@/helpers/http-client";
import type { AxiosResponse } from "axios";
const error = ref("");
const client_sales = ref<any>([]);
const year = ref<number>(new Date().getFullYear());
const month  = ref<string>(new Date().getMonth() > 9 ? "0"+(new Date().getMonth()+1) : "0"+(new Date().getMonth()+1));

const client_most_sales = async () => {
  try {
    const res: AxiosResponse<any> = await HttpClient.post("kpi/client_most_sales",
      {
        year: year.value,
        month: month.value
      }
    );
    console.log(res);
    client_sales.value = res.data.client_most_sale;
    } catch (e: any) {
        console.log(e);
        if (e.response?.data?.error) {
        if (error.value.length == 0) error.value = e.response?.data?.error;
        }
    }
};
watch(year, (val) => {
  client_most_sales();
})
watch(month, (val) => {
  client_most_sales();
})
onMounted(() => {
    client_most_sales();
})
</script>
