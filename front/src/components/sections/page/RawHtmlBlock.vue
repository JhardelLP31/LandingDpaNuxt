<script setup lang="ts">
import { computed, type CSSProperties } from 'vue'; // Importamos CSSProperties
import { formatImageUrl } from '@/helpers/url';

interface HtmlData {
  htmlCode?: string;
  config?: {
    container?: 'container' | 'container-fluid' | 'none';
    paddingY?: string;
    fullWidth?: boolean;
  };
}

const props = defineProps<{
  data: HtmlData;
}>();

// --- PROCESADOR DE RUTAS ---
const processedHtml = computed(() => {
  let code = props.data.htmlCode || '';
  if (!code) return '';

  code = code.replace(/src=["'](\/[^"']+)["']/g, (match, path) => {
    return `src="${formatImageUrl(path)}"`;
  });

  code = code.replace(/url\(\s*['"]?(\/[^'"]+)['"]?\)/g, (match, path) => {
    return `url('${formatImageUrl(path)}')`;
  });

  return code;
});

// Calculamos las clases de contenedor y padding (eliminamos el paddingY si no lo deseas)
const containerClass = computed(() => props.data.config?.container || 'container');

// Aquí eliminamos el padding vertical
const paddingClass = computed(() => 'py-0'); // Establecemos padding a 0 para eliminar el espacio vertical

// SOLUCIÓN: Definimos el tipo de retorno como CSSProperties
const sectionStyle = computed((): CSSProperties => {
  if (props.data.config?.fullWidth) {
    return {
      width: '100%',  // Ajustamos a 100% en lugar de 100vw para evitar márgenes negativos
      position: 'relative',
    };
  }
  return {};
});
</script>

<template>
  <div class="raw-html-wrapper">
    <section 
      :class="[paddingClass, 'raw-html-section']" 
      :style="sectionStyle"
    >
      <div v-if="containerClass !== 'none'" :class="containerClass">
         <div v-html="processedHtml" class="content-render"></div>
      </div>
      <div v-else v-html="processedHtml" class="content-render"></div>
    </section>
  </div>
</template>

<style scoped lang="scss">
.raw-html-wrapper {
  width: 100%;
  overflow-x: hidden; // Vital para que la técnica del margen negativo no rompa el responsive
}

.raw-html-section {
  position: relative;
  box-sizing: border-box;
  
  :deep(.content-render) {
    img { max-width: 100%; height: auto; }
    box-sizing: border-box;
    
    // Si el HTML trae sus propios contenedores, aseguramos que se vean bien
    overflow-wrap: break-word;
    word-wrap: break-word;
  }
}
</style>
