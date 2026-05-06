<script setup lang="ts">
import { computed, watchEffect } from 'vue';
import { useRoute } from 'vue-router';
import { resolveBlock } from '@shared/core/BlockRegistry';
import { resolveBrandingComponent } from '@shared/core/BrandingRegistry';
import { useApi } from '~/composables/useApi';

// --- INTERFACES SEGÚN TU LÓGICA ---
interface MenuItem {
  id: number;
  title: string;
  content_id: number | null;
  url: string | null;
  target: string;
  page?: { slug: string }; // La relación que traeremos de Laravel
  children?: MenuItem[];
  [key: string]: any;
}

const route = useRoute();
const unitSlug = computed(() => (route.params.unit as string) || 'general'); 

// 1. FETCH DE DATOS
const { data: response, pending, error } = await useAsyncData<any>(
  `page-${unitSlug.value}-${(route.params.slug as string) || 'inicio'}`, 
  () => useApi().getPage(unitSlug.value, (route.params.slug as string) || 'inicio') 
);

const { data: brandingResponse } = await useAsyncData<any>(
  `branding-${unitSlug.value}`,
  () => useApi().getUnitBrandingBySlug(unitSlug.value).catch(() => null)
);

const pageData = computed(() => response.value?.data || response.value);
const brandingData = computed(() => brandingResponse.value?.data || brandingResponse.value);

// --- 2. LÓGICA DEL MENÚ (EL CORAZÓN DEL PROBLEMA) ---
const menuTree = computed(() => {
  const menuObj = brandingData.value?.menu;
  if (!menuObj) return [];
  
  const rawItems = menuObj.items || [];
  const unit = unitSlug.value;

const buildUrl = (item: MenuItem) => {
    // CASO A: Es una Página Interna (Tiene content_id)
    // 👇 Cambia item.page por item.content 👇
    if (item.content_id && item.content?.slug) {
      const slug = item.content.slug; // 👇 Y aquí también 👇
      if (slug === 'inicio') return `/${unit}`;
      return `/${unit}/${slug}`;
    }

    // CASO B: Es un Enlace Externo (Tiene URL manual)
    if (item.url) {
      if (item.url.startsWith('http') || item.url.startsWith('#')) return item.url;
      return `/${unit}/${item.url.replace(/^\//, '')}`;
    }

    return `/${unit}`; // Fallback al inicio de la unidad
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

// --- 3. LÓGICA DE BRANDING Y BLOQUES ---
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

const blocks = computed(() => {
  const raw = pageData.value?.content_blocks;
  if (!raw) return [];
  const parsed = typeof raw === 'string' ? JSON.parse(raw) : raw;
  return Array.isArray(parsed) ? parsed : [];
});

const cssVars = computed(() => {
  const b = brandingData.value;
  return {
    '--global-primary': b?.primary_color || '',
    '--global-accent': b?.accent_color || '',
  };
});
// Agrega esta pequeña función auxiliar dentro de tu <script setup>
const defineNuxtLink = () => resolveComponent('NuxtLink');

useHead(() => ({
  title: pageData.value?.title || 'Cargando...',
  meta: [{ name: 'description', content: pageData.value?.seo_config?.description || '' }]
}));

// --- 4. CONFIGURACIÓN DE SEO TÉCNICO ---
watchEffect(() => {
  if (pending.value || !pageData.value) return;

  let seoTitle = pageData.value.title;
  let seoDescription = 'Página oficial de la institución.'; // Un fallback por si acaso

  // Intentamos parsear el JSON de seo_config si existe
  if (pageData.value.seo_config) {
    try {
      const parsedSeo = typeof pageData.value.seo_config === 'string' 
        ? JSON.parse(pageData.value.seo_config) 
        : pageData.value.seo_config;
      
      if (parsedSeo.title) seoTitle = parsedSeo.title;
      if (parsedSeo.description) seoDescription = parsedSeo.description;
    } catch (e) {
      console.warn('Error parseando seo_config:', e);
    }
  }

  // Inyectamos la magia de Nuxt para el SEO
  useSeoMeta({
    title: seoTitle,
    ogTitle: seoTitle,
    description: seoDescription,
    ogDescription: seoDescription,
    // Aquí omitimos la imagen como pediste
  });
});
// ==========================================
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



    <div v-if="pending" class="loading-container">
      <div class="spinner-border text-danger" role="status"></div>
    </div>
    
    <div v-else-if="error || !pageData" class="alert alert-danger m-4">
      <p>Página no encontrada.</p>
    </div>

    <div v-else>
      <ClientOnly>
        <template v-for="(block, index) in blocks" :key="block.id || index">
          <component 
            :is="resolveBlock(block.type)" 
            v-if="resolveBlock(block.type)"
            :data="block.content || {}" 
          />
        </template>
      </ClientOnly>
    </div>
  </div>
</template>
<style>
/* --- ESTILOS GLOBALES DE LA PÁGINA --- */
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
  /*color: var(--global-primary);*/
}

.page-content a:hover {
  /*color: var(--global-primary);*/
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
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 5rem;
  min-height: 50vh;
}
</style>