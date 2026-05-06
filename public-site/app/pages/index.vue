<template>
  <div class="portal-container">
    <h1>Bienvenido a la Institución</h1>
    <p>Por favor, selecciona el área que deseas visitar:</p>
    
    <div class="links">
      <NuxtLink to="/pregrado/inicio">🎓 Pregrado</NuxtLink>
      <NuxtLink to="/posgrado/inicio">💼 Posgrado</NuxtLink>
    </div>
  </div>
</template>

<script setup>
// Aquí no hacemos redirecciones automáticas.
// Dejamos que el usuario elija su unidad.
</script>