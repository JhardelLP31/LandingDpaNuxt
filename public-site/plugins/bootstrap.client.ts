// @ts-ignore
import bootstrap from 'bootstrap/dist/js/bootstrap.bundle.min.js';

export default defineNuxtPlugin((nuxtApp) => {
  // Esto permite usar tooltips o modales de Bootstrap por código
  return {
    provide: {
      bootstrap: bootstrap
    }
  }
});