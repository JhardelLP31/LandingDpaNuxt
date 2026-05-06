<script setup lang="ts">
import { computed } from 'vue';

const props = defineProps<{
  data: {
    title?: string;
    description?: string; // HTML Rico (Quill)
    buttonText?: string;
    buttonUrl?: string;
    videoUrl?: string;
  }
}>();

const content = computed(() => ({
  title: props.data.title || 'MESA DE AYUDA',
  // Si no hay descripción, ponemos un placeholder seguro
  description: props.data.description || '<p>Descripción del servicio...</p>',
  btnText: props.data.buttonText || 'Ver más',
  btnUrl: props.data.buttonUrl || '#',
  video: props.data.videoUrl || ''
}));

// Helper para Youtube
const embedUrl = computed(() => {
  let url = content.value.video;
  if (!url) return '';
  if (url.includes('/embed/')) return url;
  const id = url.includes('v=') ? url.split('v=')[1]?.split('&')[0] 
           : url.includes('youtu.be/') ? url.split('youtu.be/')[1] : '';
  return id ? `https://www.youtube.com/embed/${id}` : url;
});
</script>

<template>
  <section class="service-desk-block bg-white">
    <div class="container">
      <div class="row align-items-center">
        
        <div class="col-lg-6 mb-4 mb-lg-0">
          <div class="content-wrapper">
            
            <h2 class="sppb-addon-title">{{ content.title }}</h2>
            
            <div class="sppb-addon-content mb-4">
                <div class="rich-text-content" v-html="content.description"></div>
            </div>

            <div v-if="content.btnText">
              <a :href="content.btnUrl" target="_blank" class="sppb-btn sppb-btn-primary sppb-btn-rounded">
                {{ content.btnText }} <i class="fas fa-arrow-right ms-2"></i>
              </a>
            </div>

          </div>
        </div>

        <div class="col-lg-6">
          <div class="ratio ratio-16x9 shadow rounded overflow-hidden" v-if="embedUrl">
            <iframe :src="embedUrl" allowfullscreen title="Video Service Desk"></iframe>
          </div>
        </div>

      </div>
    </div>
  </section>
</template>

<style scoped>
/* Estilos originales replicados */

.sppb-addon-title {
  font-size: 24px;
  font-weight: 350;
  margin-bottom: 20px;
  color: #333;
  text-transform: uppercase;
  line-height: 1;
}

/* Estilos para el contenido que viene del Quill */
:deep(.rich-text-content) {
  text-align: justify;
  font-size: 15px;
  color: #444;
  line-height: 1.6;
}

:deep(.nota) {
  margin-top: 15px;
  font-size: 0.95em;
}

:deep(a) {
  color: #0d6efd;
  text-decoration: none;
}
:deep(a:hover) { text-decoration: underline; }

/* Botón estilo ESAN */
.sppb-btn {
  display: inline-block;
  font-weight: 600;
  padding: 12px 35px;
  font-size: 14px;
  border-radius: 50px;
  text-transform: uppercase;
  text-decoration: none;
  transition: all 0.3s;
}

.sppb-btn-primary {
  background-color: #cb1d1d;
  color: #fff;
  border: 1px solid #cb1d1d;
}

.sppb-btn-primary:hover {
  background-color: #a01515;
  border-color: #a01515;
}
</style>