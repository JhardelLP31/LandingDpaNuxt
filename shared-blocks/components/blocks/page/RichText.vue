<template>
  <section class="rich-text-section py-5 bg-white">
    <div class="container">
      <div class="row justify-content-center">
        <div class="col-lg-8">
          
          <h2 v-if="data.heading" class="fw-bold mb-4 text-dark">{{ data.heading }}</h2>
          
          <div class="content-body text-muted" style="line-height: 1.8; font-size: 1.1rem;">
            <div v-html="data.content || '<p>Escribe tu contenido aquí...</p>'"></div>
          </div>

        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
defineProps<{
  data: {
    heading?: string;
    content?: string;
  }
}>();
</script>

<style scoped>
/* Estilos para que el HTML inyectado se vea bien */
.content-body :deep(p) {
    margin-bottom: 1.5rem;
}
.content-body :deep(ul), .content-body :deep(ol) {
    margin-bottom: 1.5rem;
    padding-left: 1.5rem;
}
.content-body :deep(a) {
    color: var(--bs-primary);
    text-decoration: underline;
}
</style>