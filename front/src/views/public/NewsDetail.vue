<script setup lang="ts">
import { useRoute } from 'vue-router';
import PageLayout from '@/components/layout/PageLayout.vue';
// Importas el componente que creamos arriba
import CategoryNewsGrid from '@/components/sections/page/CategoryNewsGrid.vue';

const route = useRoute();
</script>

<template>
    <div class="container py-5">
      <CategoryNewsGrid 
        :data="{ categoryId: route.params.slug as string }" 
      />
    </div>
</template>