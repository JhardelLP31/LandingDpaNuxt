<template>
  <component 
    :is="selectedComponent" 
    :settings="settings" 
  />
</template>

<script setup>
import { computed } from 'vue';
// Importamos tu diseño "V1" (que contiene tu TopBar adaptado)
import HeaderV1Default from './HeaderV1Default.vue';
import HeaderV2Centered from './HeaderV2Centered.vue'; // Futuro diseño

const props = defineProps(['settings']);

const selectedComponent = computed(() => {
    const designs = {
        'v1_default': HeaderV1Default, // Tu diseño actual
        'v2_centered': HeaderV2Centered
    };
    return designs[props.settings.header_type] || HeaderV1Default;
});
</script>