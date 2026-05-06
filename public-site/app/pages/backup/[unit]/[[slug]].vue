<script setup lang="ts">
import { computed } from 'vue';
import { useRoute } from 'vue-router';
import { resolveBlock } from '@shared/core/BlockRegistry';
import { resolveBrandingComponent } from '@shared/core/BrandingRegistry'; // Añadido para el header
import { useApi } from '~/composables/useApi';

const route = useRoute();
const unitSlug = computed(() => (route.params.unit as string) || 'general'); 
const pageSlug = computed(() => {
  const slugParam = route.params.slug;
  if (Array.isArray(slugParam)) return slugParam[0] || 'inicio';
  return (slugParam as string) || 'inicio';
});

// 👉 AGREGA ESTO PARA DEPURAR:
console.log("🔍 NUXT ESTÁ PIDIENDO A LARAVEL -> Unidad:", unitSlug.value, "| Página:", pageSlug.value);

// 1. FETCH DE PÁGINA (Tu código original, intacto y seguro)
const { data: response, pending, error } = await useAsyncData<any>(
  `page-${unitSlug.value}-${pageSlug.value}`, 
  () => useApi().getPage(unitSlug.value, pageSlug.value) 
);

const pageData = computed(() => response.value?.data || response.value);

// 2. FETCH DE BRANDING (Nuevo, pero si falla no rompe la página)
const { data: brandingResponse } = await useAsyncData<any>(
  `branding-${unitSlug.value}`,
  () => useApi().getUnitBrandingBySlug(unitSlug.value).catch(() => null) // <-- El .catch() evita explosiones
);

const brandingData = computed(() => brandingResponse.value?.data || brandingResponse.value);

// --- LÓGICA DEL BRANDING (HEADER Y MENÚ) ---
const headerInfo = computed(() => {
  if (!brandingData.value?.custom_css) return null;
  try {
    const parsed = typeof brandingData.value.custom_css === 'string' 
      ? JSON.parse(brandingData.value.custom_css) 
      : brandingData.value.custom_css;
    return Array.isArray(parsed) ? parsed[0] : null;
  } catch (e) { return null; }
});

const menuTree = computed(() => brandingData.value?.menu?.items || []);

// --- LÓGICA DE BLOQUES ORIGINAL ---
const blocks = computed(() => {
  const rawBlocks = pageData.value?.content_blocks;
  if (!rawBlocks) return [];
  try {
    const parsed = typeof rawBlocks === 'string' ? JSON.parse(rawBlocks) : rawBlocks;
    return Array.isArray(parsed) ? parsed : [];
  } catch (e) {
    console.error("❌ Error parseando bloques:", e);
    return [];
  }
});

// --- VARIABLES CSS INTEGRADAS ---
const cssVars = computed(() => {
  const vars: Record<string, string> = {};
  const p = pageData.value;
  const b = brandingData.value;

  // Prioridad: Branding > Página
  if (b?.primary_color || p?.primary_color) {
    vars['--global-primary'] = b?.primary_color || p?.primary_color;
  }
  if (b?.accent_color) {
    vars['--global-accent'] = b.accent_color;
  }
  if (p?.font_family) {
    vars['--global-font'] = p.font_family;
  }
  return vars;
});

// --- SEO Y FUENTES ORIGINAL ---
const googleFontUrl = computed(() => {
  const font = pageData.value?.font_family;
  if (!font || font.includes('system-ui')) return null;
  const fontName = font.split(',')[0].replace(/['"]/g, '').trim().replace(/\s+/g, '+');
  return `https://fonts.googleapis.com/css2?family=${fontName}:wght@400;700&display=swap`;
});

useHead(() => ({
  title: pageData.value?.title || 'Cargando...',
  meta: [
    { name: 'description', content: pageData.value?.seo_config?.description || '' }
  ],
  link: googleFontUrl.value ? [
    { rel: 'preconnect', href: 'https://fonts.googleapis.com' },
    { rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: 'anonymous' },
    { rel: 'stylesheet', href: googleFontUrl.value }
  ] : []
}));
</script>

<template>
  <div class="page-content" :style="cssVars">
    
    <header v-if="headerInfo" class="institutional-header">
      <ClientOnly>
        <component 
          :is="resolveBrandingComponent(headerInfo.type)" 
          :config="headerInfo.content"
          :menu="menuTree"
        />
      </ClientOnly>
    </header>

    <div v-if="pending" class="loading-container">
      <div class="spinner-border text-danger" role="status"></div>
    </div>
    
    <div v-else-if="error || !pageData" class="alert alert-danger m-4">
      <h3 class="h5">Hubo un problema</h3>
      <p>{{ (error as any)?.data?.message || 'No se encontró la página.' }}</p>
    </div>

    <div v-else>
      <ClientOnly>
        <template v-for="(block, index) in blocks" :key="block.id || `block-${index}`">
          <div :id="'sec-' + block.id"> 
            <component 
              :is="resolveBlock(block.type)" 
              v-if="resolveBlock(block.type)"
              :data="block.content || {}" 
            />
          </div>
        </template>
      </ClientOnly>
    </div>
    
  </div>
</template>

<style>
/* --- ESTILOS GLOBALES DE LA PÁGINA (Los tuyos intactos) --- */
.page-content {
  width: 100%;
  min-height: 100vh;
  overflow: hidden;
  font-family: var(--global-font, inherit) !important;
}

.page-content * {
  font-family: inherit !important;
}

.page-content h1, 
.page-content h2, 
.page-content h3, 
.page-content h4 {
  color: var(--global-primary);
}

.page-content a:hover {
  color: var(--global-primary);
}

/* Nuevo estilo para que el header se quede arriba */
.institutional-header {
  position: sticky;
  top: 0;
  z-index: 1050;
  width: 100%;
}
</style>

<style scoped>
.loading-container {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 5rem;
  min-height: 50vh;
}
</style>