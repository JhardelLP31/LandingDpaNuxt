<script setup lang="ts">
// Pasamos la prop como un array simple para evitar el bug de "hasOwnProperty" de Vue/Nuxt
const props = defineProps(['error']);

const handleError = () => clearError({ redirect: '/' });
</script>

<template>
  <div class="error-container">
    <div class="error-content">
      <h1 class="error-code">ERROR {{ props.error?.statusCode || 404 }}</h1>
      <h2 class="error-title">¡Ups! Te perdiste.</h2>
      <p class="error-message">
        {{ props.error?.message || 'La página que estás buscando no existe o fue movida.' }}
      </p>
      <button @click="handleError" class="btn-home">
        Volver al Inicio
      </button>
    </div>
  </div>
</template>

<style scoped>
.error-container {
  height: 100vh;
  width: 100vw;
  display: flex;
  justify-content: center;
  align-items: center;
  background-color: #111; /* Fondo oscuro elegante */
  color: white;
  text-align: center;
  font-family: sans-serif;
  position: fixed; /* Fixed asegura que cubra toda la pantalla sin importar dónde estés */
  top: 0;
  left: 0;
  z-index: 9999;
}

.error-code {
  font-size: 6rem;
  font-weight: 900;
  color: #ff4757; /* Rojo intenso */
  margin: 0;
  text-shadow: 2px 2px 10px rgba(255, 71, 87, 0.5);
}

.error-title {
  font-size: 2rem;
  margin-top: 10px;
}

.error-message {
  font-size: 1.2rem;
  color: #ccc;
  margin-bottom: 30px;
}

.btn-home {
  padding: 12px 24px;
  font-size: 1.1rem;
  background-color: #ff4757;
  color: white;
  border: none;
  border-radius: 8px;
  cursor: pointer;
  transition: background 0.3s;
}

.btn-home:hover {
  background-color: #ff6b81;
}
</style>