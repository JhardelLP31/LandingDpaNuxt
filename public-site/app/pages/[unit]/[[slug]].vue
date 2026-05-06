<script setup lang="ts">
import { ref, onMounted, computed, watchEffect, resolveComponent } from 'vue';
import { useRoute } from 'vue-router';
import { resolveBlock } from '@shared/core/BlockRegistry';
import { resolveBrandingComponent } from '@shared/core/BrandingRegistry';
import { useApi } from '~/composables/useApi';

// 1. Layout fijo de la unidad
definePageMeta({ layout: 'unit' });

// --- INTERFACES ---
interface MenuItem {
  id: number;
  title: string;
  content_id: number | null;
  url: string | null;
  target: string;
  content?: { slug: string };
  children?: MenuItem[];
  [key: string]: any;
}

const route = useRoute();
const unitSlug = route.params.unit as string;
const pageSlug = (route.params.slug as string) || 'inicio';

// 2. FETCH DE DATOS EN PARALELO (Página + Branding)
const [{ data: pageResponse, pending: pagePending, error: pageError }, { data: brandingResponse }] = await Promise.all([
  useAsyncData(
    `page-data`,
    () => useApi().getPage(route.params.unit as string, (route.params.slug as string) || 'inicio'),
    {
      watch: [() => route.params.unit, () => route.params.slug] 
    }
  ),
  useAsyncData(
    `branding-data`, // Llave genérica para el branding
    () => useApi().getUnitBrandingBySlug(route.params.unit as string).catch(() => null),
    {
      watch: [() => route.params.unit] 
    }
  )
]);

const pageData = computed(() => pageResponse.value?.data || pageResponse.value);
const brandingData = computed(() => brandingResponse.value?.data || brandingResponse.value);

// 3. VALIDACIÓN DE ERROR SÍNCRONA (Magia del 404)
if (pageError.value || !pageData.value) {
  showError({ 
    statusCode: 404, 
    statusMessage: 'Página no encontrada', 
    fatal: true 
  });
}

// 4. LÓGICA DEL MENÚ DINÁMICO
const menuTree = computed(() => {
  const menuObj = brandingData.value?.menu;
  if (!menuObj) return [];
  
  const rawItems = menuObj.items || [];
  
  const buildUrl = (item: MenuItem) => {
    // Si es página interna
    if (item.content_id && item.content?.slug) {
      const slug = item.content.slug;
      if (slug === 'inicio') return `/${unitSlug}`;
      return `/${unitSlug}/${slug}`;
    }
    // Si es enlace externo o ancla
    if (item.url) {
      if (item.url.startsWith('http') || item.url.startsWith('#')) return item.url;
      return `/${unitSlug}/${item.url.replace(/^\//, '')}`;
    }
    return `/${unitSlug}`; // Fallback
  };

  const mapItems = (items: any[]): any[] => {
    return items.map(item => {
      const finalPath = buildUrl(item);
      return {
        ...item,
        url: finalPath,
        link: finalPath,
        to: finalPath,
        path: finalPath,
        children: item.children ? mapItems(item.children) : []
      };
    });
  };

  return mapItems(rawItems);
});

// 5. CONFIGURACIÓN DEL HEADER
const headerInfo = computed(() => {
  if (!brandingData.value?.custom_css) return null;
  try {
    const parsed = typeof brandingData.value.custom_css === 'string' 
      ? JSON.parse(brandingData.value.custom_css) : brandingData.value.custom_css;
    const blocks = Array.isArray(parsed) ? parsed : [parsed];
    const headerBlock = blocks.find((b: any) => b.type?.includes('Header')) || blocks[0];
    
    return {
      type: headerBlock.type || 'DefaultHeader',
      content: {
        ...(headerBlock.content || headerBlock),
        logoUrl: brandingData.value.logo_primary?.url || headerBlock.content?.logoUrl,
      }
    };
  } catch (e) { return null; }
});

// 6. PROCESAMIENTO DE BLOQUES DE LA PÁGINA
const blocks = computed(() => {
  const raw = pageData.value?.content_blocks;
  if (!raw) return [];
  try {
    const parsed = typeof raw === 'string' ? JSON.parse(raw) : raw;
    return Array.isArray(parsed) ? parsed : [];
  } catch (e) { return []; }
});

// 7. VARIABLES CSS DINÁMICAS (Color + Tipografía Opcional)
const cssVars = computed(() => {
  const b = brandingData.value;
  // Extraemos la fuente del branding (ajusta 'typography' al nombre de la columna en tu BD)
  const fontFamily = b?.typography || b?.settings?.fontFamily || 'inherit';
  
  return {
    '--global-primary': b?.primary_color || '#e3000f', // fallback a un rojo
    '--global-accent': b?.accent_color || '#000000',
    '--global-font': fontFamily
  };
});

// 8. CONFIGURACIÓN SEO
watchEffect(() => {
  if (!pageData.value) return;
  
  let seoTitle = pageData.value.title;
  let seoDesc = 'Página oficial de la institución.';

  if (pageData.value?.seo_config) {
    try {
      const parsedSeo = typeof pageData.value.seo_config === 'string' 
        ? JSON.parse(pageData.value.seo_config) : pageData.value.seo_config;
      if (parsedSeo.title) seoTitle = parsedSeo.title;
      if (parsedSeo.description) seoDesc = parsedSeo.description;
    } catch (e) {}
  }

  useSeoMeta({
    title: seoTitle,
    ogTitle: seoTitle,
    description: seoDesc,
    ogDescription: seoDesc,
  });
});

// Auxiliar para pasar NuxtLink dinámicamente
const defineNuxtLink = () => resolveComponent('NuxtLink');

const isMounted = ref(false);
onMounted(() => { isMounted.value = true; });
</script>

<template>
  <div class="page-content" :style="cssVars">
    
    <header v-if="headerInfo" class="institutional-header">
      <ClientOnly>
        <component 
          :is="resolveBrandingComponent(headerInfo.type)" 
          :config="headerInfo.content"
          :menu="menuTree"
          :linkComponent="defineNuxtLink()" 
        />
      </ClientOnly>
    </header>

    <div v-if="pagePending" class="loading-container text-center py-5">
      <div class="spinner-border text-danger" role="status"></div>
    </div>
    
    <main v-else class="page-blocks-container">
      <div v-if="!isMounted" class="loading-container text-center py-5">
        <div class="spinner-grow text-danger mb-3" role="status" style="width: 3rem; height: 3rem;"></div>
        <p class="text-muted small">Estructurando la página...</p>
      </div>

      <div v-else class="blocks-wrapper">
        <Suspense v-for="(block, index) in blocks" :key="block.id || index">
          <component 
            :is="resolveBlock(block.type)" 
            v-if="resolveBlock(block.type)"
            :data="block.content || {}" 
          />
          <template #fallback>
            <div class="py-5 text-center text-muted small">
              <div class="spinner-grow spinner-grow-sm me-2" role="status"></div>
              Cargando sección...
            </div>
          </template>
        </Suspense>
      </div>
    </main>
  </div>
</template>

<style>
/* --- ESTILOS GLOBALES DE LA PÁGINA --- */
.page-content {
  width: 100%;
  min-height: 100vh;
  overflow: hidden;
  /* Aplicamos la tipografía aquí. Si no hay variable, usa la del body (inherit) */
  font-family: var(--global-font, inherit) !important;
}

/* Forzamos a que los hijos hereden la fuente del contenedor .page-content */
.page-content * {
  font-family: inherit !important;
}

/* Header sticky */
.institutional-header {
  position: sticky;
  top: 0;
  z-index: 1050;
  width: 100%;
}
</style>

<style scoped>
.loading-container {
  min-height: 50vh;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}
</style>