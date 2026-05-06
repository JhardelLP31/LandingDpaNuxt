<script setup lang="ts">
const route = useRoute();
const unit = route.params.unit as string;
const api = useApi();

// Cargamos Branding y Menús de la Unidad Académica
const { data: branding } = await useAsyncData(`branding-${unit}`, async () => {
  const res = await api.get(`/branding/${unit}`);
  return res.data;
});
</script>

<template>
  <div :style="{ '--primary-color': branding?.primary_color || '#01828f' }">
    <header class="main-header shadow-sm">
      <div class="container d-flex justify-content-between align-items-center py-3">
        <img :src="branding?.logo_primary_path" alt="Logo" height="50">
        <nav>
           <ul class="nav">
             <li v-for="item in branding?.menu_header" :key="item.id" class="nav-item">
               <NuxtLink :to="`/${unit}${item.url}`" class="nav-link">{{ item.title }}</NuxtLink>
             </li>
           </ul>
        </nav>
      </div>
    </header>

    <main>
      <slot />
    </main>

    <footer class="py-5 bg-dark text-white text-center">
      <p>{{ branding?.footer_config?.copyright || 'ESAN 2026' }}</p>
    </footer>
  </div>
</template>

<style scoped>
.main-header { border-bottom: 3px solid var(--primary-color); }
</style>