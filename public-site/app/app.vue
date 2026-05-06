<template>
  <div>
    <div v-if="isLoading" id="splash-screen"></div>

    <NuxtLayout>
      <NuxtPage />
    </NuxtLayout>
  </div>
</template>

<script setup lang="ts">
const isLoading = ref(true);

onMounted(() => {
  // Desactivar splash cuando los componentes dinámicos del builder estén listos
  isLoading.value = false;
});
</script>

<style>
#splash-screen {
  position: fixed;
  top: 0; left: 0;
  width: 100%; height: 100%;
  background: white;
  z-index: 9999;
}
</style>