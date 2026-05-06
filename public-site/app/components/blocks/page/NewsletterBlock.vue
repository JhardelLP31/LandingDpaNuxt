<script setup lang="ts">
interface NewsletterData {
  title: string;
  subtitle: string;
  buttonText: string;
}

defineProps<{
  data: NewsletterData;
}>();
</script>

<template>
  <div v-if="data" class="newsletter-section">
    <div class="container">
      <div class="row align-items-center justify-content-center">
        
        <div class="col-lg-7 text-center text-lg-start mb-4 mb-lg-0">
          <h2 class="text-white fw-bold text-uppercase mb-2">
            <i class="las la-paper-plane me-2 opacity-50"></i>
            {{ data.title || 'Mantente Informado' }}
          </h2>
          <p class="text-white opacity-75 mb-0 fs-5">
            {{ data.subtitle || 'Suscríbete para recibir nuestras últimas noticias.' }}
          </p>
        </div>

        <div class="col-lg-5">
          <form class="newsletter-form" @submit.prevent>
            <div class="input-group p-1 bg-white rounded-pill shadow-lg">
              <input 
                type="email" 
                class="form-control border-0 bg-transparent ps-4" 
                placeholder="Tu correo electrónico..."
                aria-label="Email"
              >
              <button class="btn btn-dark rounded-pill px-4 fw-bold text-uppercase" type="button">
                {{ data.buttonText || 'Suscribirse' }}
              </button>
            </div>
          </form>
        </div>

      </div>
    </div>
    
    <div class="circle-decoration one"></div>
    <div class="circle-decoration two"></div>
  </div>
</template>

<style scoped>
.newsletter-section {
  /* Truco Full Width */
  width: 100vw;
  position: relative;
  left: 50%;
  right: 50%;
  margin-left: -50vw;
  margin-right: -50vw;
  
  /* Estilo Visual */
  background: linear-gradient(135deg, #e31140 0%, #b30930 100%); /* Tu rojo con degradado a oscuro */
  padding: 80px 0;
  overflow: hidden; /* Para que la decoración no rompa el scroll */
}

.form-control:focus {
  box-shadow: none; /* Eliminar brillo azul default de bootstrap */
}

/* DECORACIÓN DE FONDO (Círculos flotantes) */
.circle-decoration {
  position: absolute;
  border-radius: 50%;
  background: rgba(255, 255, 255, 0.1);
  pointer-events: none;
}

.one {
  width: 300px;
  height: 300px;
  top: -100px;
  left: -50px;
}

.two {
  width: 200px;
  height: 200px;
  bottom: -50px;
  right: 10%;
}

/* Responsive */
@media (max-width: 991px) {
  .newsletter-section {
    padding: 60px 0;
    text-align: center;
  }
}
</style>