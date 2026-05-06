<template>
  <div class="news-mega-editor">
    
    <div class="p-3 mb-3 bg-white border rounded shadow-sm">
      <h6 class="mb-3 small fw-bold text-muted text-uppercase">
        <i class="las la-cog"></i> Configuración General
      </h6>
      <div>
        <label class="small fw-bold mb-1">Título de la Sección</label>
        <input 
          type="text" 
          v-model="localContent.sectionTitle" 
          class="form-control form-control-sm" 
          placeholder="Ej: Noticias Destacadas"
        >
      </div>
    </div>

    <div class="accordion" id="accordion-news">
      <div v-for="(article, i) in localContent.articles" :key="i" class="accordion-item border-bottom">
        
        <h2 class="accordion-header">
          <button 
            class="accordion-button py-2" 
            type="button" 
            :class="{ 'collapsed': activeArticle !== i }"
            @click="toggleArticle(Number(i))"
          >
            <div class="d-flex align-items-center gap-2 w-100">
              <span class="badge" :class="i === 0 ? 'bg-danger' : 'bg-dark'">
                {{ i === 0 ? 'PRINCIPAL' : 'SIDE ' + i }}
              </span>
              
              <img v-if="article.imageUrl" 
                   :src="formatImageUrl(article.imageUrl)" 
                   class="rounded object-fit-cover border" 
                   width="35" height="25">
              
              <span class="small fw-bold text-truncate" style="max-width: 140px;">
                {{ article.title || 'Sin título' }}
              </span>
            </div>
          </button>
        </h2>

        <div class="accordion-collapse collapse" :class="{ 'show': activeArticle === i }">
          <div class="accordion-body bg-light p-3 border-top">
            
            <div class="mb-3">
              <label class="small fw-bold mb-1">Imagen de Portada</label>
              <div class="d-flex align-items-center gap-2 p-2 border rounded bg-white">
                <img :src="formatImageUrl(article.imageUrl)" class="rounded border" style="width: 50px; height: 50px; object-fit: cover;">
                <button type="button" @click="$emit('select-image', { item: article, field: 'imageUrl' })" 
                        class="btn btn-sm btn-outline-primary w-100">
                   Cambiar Imagen
                </button>
              </div>
            </div>

            <div class="row g-2 mb-3">
              <div class="col-6">
                <label class="small fw-bold mb-1">Categoría</label>
                <input v-model="article.category" class="form-control form-control-sm" placeholder="TECH">
              </div>
              <div class="col-6">
                <label class="small fw-bold mb-1">Fecha</label>
                <input v-model="article.date" class="form-control form-control-sm" placeholder="24 May, 2024">
              </div>
            </div>

            <div class="mb-3">
              <label class="small fw-bold mb-1">Título del Artículo</label>
              <textarea v-model="article.title" class="form-control form-control-sm" rows="2"></textarea>
            </div>

            <div class="mb-3" v-if="i === 0">
              <label class="small fw-bold mb-1">Extracto / Resumen</label>
              <textarea v-model="article.excerpt" class="form-control form-control-sm" rows="3"></textarea>
            </div>

            <div class="row g-2 mb-3 bg-white p-2 border rounded mx-0">
              <div class="col-7">
                <label class="small fw-bold mb-1" style="font-size: 0.65rem;">AUTOR</label>
                <input v-model="article.author" class="form-control form-control-sm border-0 bg-light">
              </div>
              <div class="col-5">
                <label class="small fw-bold mb-1" style="font-size: 0.65rem;">LECTURA</label>
                <input v-model="article.readTime" class="form-control form-control-sm border-0 bg-light" placeholder="5 min">
              </div>
            </div>

            <div class="mb-3">
              <label class="small fw-bold mb-1">URL del Artículo</label>
              <input v-model="article.link" class="form-control form-control-sm" placeholder="/blog/nombre-noticia">
            </div>

            <div v-if="localContent.articles.length > 1" class="text-end border-top pt-2">
              <button @click="removeArticle(Number(i))" class="btn btn-xs btn-link text-danger p-0">
                <i class="las la-trash"></i> Eliminar Noticia
              </button>
            </div>

          </div>
        </div>
      </div>
    </div>

    <button v-if="localContent.articles.length < 3" 
            @click="addArticle" 
            class="btn btn-sm btn-outline-primary w-100 mt-3 border-dashed">
      <i class="las la-plus-circle"></i> Agregar Noticia al Grid
    </button>
    <div v-else class="alert alert-secondary mt-3 p-2 small text-center">
      Máximo de noticias alcanzado (3) para este diseño.
    </div>

  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { formatImageUrl } from '@/helpers/url';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue', 'select-image']);

const localContent = computed({
  get: () => props.modelValue,
  set: (val) => emit('update:modelValue', val)
});

const activeArticle = ref<number | null>(0);

const toggleArticle = (index: number) => {
  activeArticle.value = activeArticle.value === index ? null : index;
};

const addArticle = () => {
  if (!localContent.value.articles) localContent.value.articles = [];
  localContent.value.articles.push({
    category: 'NUEVO',
    title: 'Título de la noticia',
    excerpt: 'Extracto breve para la noticia principal...',
    author: 'Admin',
    date: 'Hoy',
    readTime: '3 min',
    imageUrl: '',
    link: '#'
  });
  activeArticle.value = localContent.value.articles.length - 1;
};

const removeArticle = (index: number) => {
  localContent.value.articles.splice(index, 1);
};


</script>

<style scoped>
.border-dashed { border-style: dashed !important; }
.btn-xs { padding: 0.1rem 0.4rem; font-size: 0.75rem; }
.accordion-button:not(.collapsed) {
  background-color: #f8f9fa;
  color: inherit;
  box-shadow: none;
}
.accordion-button::after {
  transform: scale(0.7);
}
</style>