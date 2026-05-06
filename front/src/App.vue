<template>
  <component :is="layout">
    <RouterView />
  </component>
</template>

<script setup lang="ts">
import { computed, onMounted, h } from "vue";
import { useRoute } from "vue-router";
import { useLayoutStore } from "@/stores/layout";

import PageLayout from '@/components/layout/PageLayout.vue'; 

import DefaultLayout from '@/layouts/DefaultLayout.vue'; 

import AuthLayout from '@/layouts/AuthLayout.vue';
const BlankLayout = (props: any, { slots }: any) => slots.default?.(); 
const route = useRoute();

const layouts: any = {
  'public': PageLayout,    
  'admin': DefaultLayout,  
  'auth': AuthLayout,
  'editor': BlankLayout, // Ahora sí es seguro
};

const layout = computed(() => {
  const layoutName = (route.meta.layout as string) || 'public';
  return layouts[layoutName] || BlankLayout;
});

onMounted(() => {
  useLayoutStore().init();
});
</script>

<style>
/* TUS ESTILOS GLOBALES SE QUEDAN IGUAL */
.border-sale { border: 1px solid #22c55e; }
.selectr-option.selected { color: white; }
.selectr-options li { color: black; }
</style>