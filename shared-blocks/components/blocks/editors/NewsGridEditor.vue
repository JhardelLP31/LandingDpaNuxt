<script setup lang="ts">
import { ref, computed } from 'vue';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue', 'select-image']);

const localData = computed({
  get: () => props.modelValue,
  set: (val) => emit('update:modelValue', val)
});

const activeIndex = ref<number | null>(0);

// Lógica para etiquetas (Tags)
const newTag = ref("");
const addTag = (item: any) => {
  if (!newTag.value) return;
  if (!item.tags) item.tags = [];
  item.tags.push(newTag.value);
  newTag.value = "";
};

const removeTag = (item: any, tagIndex: number) => {
  item.tags.splice(tagIndex, 1);
};

const addItem = () => {
  localData.value.items.push({
    tags: ['Nuevo'],
    title: 'Nueva Noticia',
    excerpt: 'Descripción breve...',
    image: '',
    date: 'Hoy'
  });
  activeIndex.value = localData.value.items.length - 1;
};
</script>

<template>
  <div class="news-grid-editor">
    <div class="mb-3 bg-white p-2 border rounded">
      <label class="small fw-bold">Título de Sección</label>
      <input v-model="localData.title" class="form-control form-control-sm">
    </div>

    <div class="accordion" id="newsAcc">
      <div v-for="(item, i) in localData.items" :key="i" class="accordion-item">
        <h2 class="accordion-header">
          <button class="accordion-button py-2 shadow-none" :class="{collapsed: activeIndex !== i}" @click="activeIndex = Number(i)">
            <span class="small fw-bold">#{{Number(i) + 1}} - {{ item.title }}</span>
          </button>
        </h2>
        
        <div class="accordion-collapse collapse" :class="{show: activeIndex === i}">
          <div class="accordion-body bg-light">
            
            <div class="mb-3">
              <label class="small fw-bold">Etiquetas (Tags)</label>
              <div class="d-flex flex-wrap gap-1 mb-2">
                <span v-for="(tag, ti) in item.tags" :key="ti" class="badge bg-primary d-flex align-items-center gap-1">
                  {{ tag }} <i class="las la-times-circle cursor-pointer" @click="removeTag(item, Number(ti))"></i>
                </span>
              </div>
              <div class="input-group input-group-sm">
                <input v-model="newTag" @keyup.enter="addTag(item)" placeholder="Nueva etiqueta..." class="form-control">
                <button @click="addTag(item)" class="btn btn-dark">+</button>
              </div>
            </div>

            <div class="mb-2">
              <label class="small fw-bold">Imagen de fondo</label>
              <button @click="emit('select-image', { item, field: 'image' })" class="btn btn-sm btn-outline-primary w-100">
                {{ item.image ? 'Cambiar Imagen' : 'Subir Imagen' }}
              </button>
              <p class="text-xxs text-muted mt-1">* Si no hay imagen, se mostrará como tarjeta de texto.</p>
            </div>

            <div class="mb-2">
              <label class="small fw-bold">Título</label>
              <input v-model="item.title" class="form-control form-control-sm">
            </div>

            <div class="mb-2">
              <label class="small fw-bold">Extracto</label>
              <textarea v-model="item.excerpt" class="form-control form-control-sm" rows="2"></textarea>
            </div>

            <button @click="localData.items.splice(i, 1)" class="btn btn-xs btn-danger w-100 mt-2">Eliminar</button>
          </div>
        </div>
      </div>
    </div>
    
    <button @click="addItem" class="btn btn-sm btn-primary w-100 mt-3">+ Añadir Noticia</button>
  </div>
</template>

<style scoped>
.text-xxs { font-size: 0.65rem; }
.cursor-pointer { cursor: pointer; }
</style>