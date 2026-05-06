<script setup lang="ts">
import { computed } from 'vue';

interface SpacerData {
  height: number;      // Altura en píxeles
  showLine: boolean;   // ¿Mostrar línea?
  config?: {
    lineColor?: string;
    lineStyle?: 'solid' | 'dashed' | 'dotted';
    lineWidth?: string; // '100%', '50%', etc.
    lineThickness?: number; // Grosor en px
  };
}

const props = defineProps<{
  data: SpacerData;
}>();

// Estilo del contenedor (el alto)
const containerStyle = computed(() => ({
  height: `${props.data.height}px`,
  display: 'flex',
  alignItems: 'center',
  justifyContent: 'center',
  width: '100%'
}));

// Estilo de la línea (si está activa)
const lineStyle = computed(() => ({
  width: props.data.config?.lineWidth || '100%',
  borderTopWidth: `${props.data.config?.lineThickness || 1}px`,
  borderTopStyle: props.data.config?.lineStyle || 'solid',
  borderTopColor: props.data.config?.lineColor || '#e0e0e0',
  margin: 0,
  opacity: 1 // Bootstrap a veces baja la opacidad de los HR
}));
</script>

<template>
  <div class="spacer-block" :style="containerStyle">
    <hr v-if="data.showLine" :style="lineStyle" />
  </div>
</template>

<style scoped>
.spacer-block {
  transition: height 0.3s ease;
}
</style>