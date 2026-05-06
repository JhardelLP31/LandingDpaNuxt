<script setup lang="ts">
import { ref, computed } from 'vue';
import MediaSelector from '@/components/modals/MediaSelector.vue';
import { formatImageUrl } from '@/helpers/url';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue']);

// ESTADO DEL MODAL
const isMediaOpen = ref(false);
const currentImageKey = ref('');

// DATA REACTIVA
const localData = computed({
  get: () => {
    if (!props.modelValue.items) props.modelValue.items = [];
    // Inicializar decoraciones si no existen
    if (!props.modelValue.decorations) {
        props.modelValue.decorations = {
            leftSmall: '', leftLarge: '', 
            rightSmall: '', rightLarge: '', bottomSmall: ''
        };
    }
    return props.modelValue;
  },
  set: (val) => emit('update:modelValue', val)
});

// LOGICA IMAGENES
const openSelector = (key: string) => {
    currentImageKey.value = key;
    isMediaOpen.value = true;
};

const handleImageSelected = (url: string) => {
    // TypeScript puede quejarse si no casteamos, pero en JS puro funciona directo
    localData.value.decorations[currentImageKey.value] = url;
    isMediaOpen.value = false;
};

// LOGICA TESTIMONIOS
const addTestimonial = () => {
  localData.value.items.push({
    name: 'Nombre Cliente', role: 'Cargo', quote: 'Opinión...', linkText: 'Ver Caso', linkUrl: '#'
  });
};

const removeTestimonial = (index: number) => {
  if(confirm('¿Eliminar?')) localData.value.items.splice(index, 1);
};
</script>

<template>
  <div class="bg-white rounded border shadow-sm">
    <div class="p-3 border-bottom bg-light">
      <h6 class="fw-bold m-0 text-dark"><i class="las la-quote-left me-2"></i>Sección Testimonios</h6>
    </div>

    <div class="p-3">
      
      <div class="mb-4">
        <label class="form-label fw-bold small text-uppercase text-muted">Textos Principales</label>
        <input v-model="localData.title" class="form-control mb-2 fw-bold" placeholder="Título">
        <textarea v-model="localData.subtitle" class="form-control" rows="2" placeholder="Subtítulo"></textarea>
      </div>

      <hr class="my-4">

      <label class="form-label fw-bold small text-uppercase text-muted mb-3"><i class="las la-image"></i> Imágenes de Fondo (Avatares)</label>
      
      <div class="bg-light p-3 rounded border mb-4">
          <div class="row text-center g-2">
              <div class="col-4 border-end">
                  <small class="d-block text-muted mb-2 fw-bold">Izquierda</small>
                  <div class="d-flex flex-column gap-2 align-items-center">
                      <div class="img-preview rounded-circle cursor-pointer border bg-white" style="width: 40px; height: 40px;" @click="openSelector('leftSmall')">
                          <img v-if="localData.decorations.leftSmall" :src="formatImageUrl(localData.decorations.leftSmall)" class="w-100 h-100 rounded-circle object-fit-cover">
                          <i v-else class="las la-plus text-muted" style="line-height: 40px;"></i>
                      </div>
                      <div class="img-preview rounded-circle cursor-pointer border bg-white" style="width: 60px; height: 60px;" @click="openSelector('leftLarge')">
                          <img v-if="localData.decorations.leftLarge" :src="formatImageUrl(localData.decorations.leftLarge)" class="w-100 h-100 rounded-circle object-fit-cover">
                          <i v-else class="las la-plus text-muted fs-4" style="line-height: 60px;"></i>
                      </div>
                  </div>
              </div>

              <div class="col-4 border-end d-flex flex-column justify-content-end align-items-center pb-2">
                  <small class="d-block text-muted mb-2 fw-bold">Abajo Centro</small>
                  <div class="img-preview rounded-circle cursor-pointer border bg-white" style="width: 50px; height: 50px;" @click="openSelector('bottomSmall')">
                      <img v-if="localData.decorations.bottomSmall" :src="formatImageUrl(localData.decorations.bottomSmall)" class="w-100 h-100 rounded-circle object-fit-cover">
                      <i v-else class="las la-plus text-muted fs-5" style="line-height: 50px;"></i>
                  </div>
              </div>

              <div class="col-4">
                  <small class="d-block text-muted mb-2 fw-bold">Derecha</small>
                  <div class="d-flex flex-column gap-2 align-items-center">
                      <div class="img-preview rounded-circle cursor-pointer border bg-white" style="width: 45px; height: 45px;" @click="openSelector('rightSmall')">
                          <img v-if="localData.decorations.rightSmall" :src="formatImageUrl(localData.decorations.rightSmall)" class="w-100 h-100 rounded-circle object-fit-cover">
                          <i v-else class="las la-plus text-muted" style="line-height: 45px;"></i>
                      </div>
                      <div class="img-preview rounded-circle cursor-pointer border bg-white" style="width: 70px; height: 70px;" @click="openSelector('rightLarge')">
                          <img v-if="localData.decorations.rightLarge" :src="formatImageUrl(localData.decorations.rightLarge)" class="w-100 h-100 rounded-circle object-fit-cover">
                          <i v-else class="las la-plus text-muted fs-3" style="line-height: 70px;"></i>
                      </div>
                  </div>
              </div>
          </div>
          <small class="d-block text-center text-muted mt-2 fst-italic" style="font-size: 0.75rem;">Clic en los círculos para cambiar los avatares flotantes.</small>
      </div>

      <label class="form-label fw-bold small text-uppercase text-muted mb-2">Testimonios ({{ localData.items.length }})</label>
      <div class="d-flex flex-column gap-2">
        <div v-for="(item, index) in localData.items" :key="index" class="card border-secondary">
          <div class="card-header bg-white py-1 px-2 d-flex justify-content-between align-items-center">
            <span class="small fw-bold text-truncate" style="max-width: 150px;">{{ item.name }}</span>
            <button @click="removeTestimonial(Number(index))" class="btn btn-xs text-danger"><i class="las la-times"></i></button>
          </div>
          <div class="p-2 bg-light">
             <input v-model="item.name" class="form-control form-control-sm mb-1" placeholder="Nombre">
             <input v-model="item.role" class="form-control form-control-sm mb-1" placeholder="Cargo">
             <textarea v-model="item.quote" class="form-control form-control-sm" rows="2" placeholder="Testimonio"></textarea>
          </div>
        </div>
      </div>

      <button @click="addTestimonial" class="btn btn-outline-primary w-100 mt-3 btn-sm border-dashed">
        <i class="las la-plus"></i> Agregar Testimonio
      </button>

    </div>

    <MediaSelector v-if="isMediaOpen" @close="isMediaOpen = false" @select="handleImageSelected" />
  </div>
</template>

<style scoped>
.img-preview:hover { border-color: #0d6efd !important; opacity: 0.8; }
.border-dashed { border-style: dashed; }
.btn-xs { padding: 0 0.3rem; }
</style>