<template>
  <div class="page-content" :style="cssVars">
    
  <header v-if="headerInfo" class="institutional-header">
    <ClientOnly>
      <component 
        :is="resolveBrandingComponent(headerInfo.type)" 
        :config="{ ...headerInfo.content, logoLink: `/${unitSlug}/` }" :menu="menuTree"
        :linkComponent="NuxtLink" 
      />
    </ClientOnly>
  </header>

    <slot />

    <footer v-if="footerInfo">
      <ClientOnly>
        <component 
          :is="resolveBrandingComponent(footerInfo.type)" 
          :config="footerInfo.content"
          :menu="menuTree"
          :linkComponent="NuxtLink"
        />
      </ClientOnly>
    </footer>
    
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { useRoute } from 'vue-router';
// 👇 MAGIA: Importamos el componente de enlace real de Nuxt
import { NuxtLink } from '#components'; 
import { resolveBrandingComponent } from '@shared/core/BrandingRegistry';

const route = useRoute();
const unitSlug = (route.params.unit as string) || 'general';

// Solo pedimos el branding en el Layout
const { data: brandingResponse } = await useAsyncData(`branding-${unitSlug}`, 
  () => useApi().getUnitBrandingBySlug(unitSlug)
);

const brandingData = computed(() => brandingResponse.value?.data || brandingResponse.value);

// Pasamos la data al composable
const { headerInfo, footerInfo, menuTree, cssVars } = useUnitBranding(brandingData.value, unitSlug);
</script>