<template>
  <header class="header-section">
    <TopBar />
    <DecorationLine />
    <MainMenu />
  </header>
</template>

<script setup lang="ts">
// Importamos los componentes hijos
// Asegúrate de que la ruta sea correcta según donde creaste los archivos
import TopBar from './header/TopBar.vue';
import DecorationLine from './header/DecorationLine.vue';
import MainMenu from './header/MainMenu.vue';

</script>

<style scoped>
.header-section {
  width: 100%;
  position: fixed;
  top: 0;
  z-index: 1000;
  
  /* Transparencia con desenfoque */
  background-color: rgba(255, 255, 255, 0.7); /* Blanco al 70% */
  backdrop-filter: blur(10px); /* El truco mágico del desenfoque */
  -webkit-backdrop-filter: blur(10px); /* Soporte para Safari */
  
  border-bottom: 1px solid rgba(255, 255, 255, 0.3); /* Línea sutil */
  box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
}
</style>