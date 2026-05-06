<script setup lang="ts">
import { computed, ref } from 'vue';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue']);

// Estados locales para UI del editor
const activeEditorTab = ref('structure'); // 'structure' | 'content'
const selectedCatForEditing = ref(''); // ID de la categoría que estamos editando actualmente

const localData = computed({
  get: () => props.modelValue || { title: 'Recursos', items: [], cards: [] },
  set: (val) => emit('update:modelValue', val)
});

// === UTILIDADES ===
const generateId = () => Math.random().toString(36).substr(2, 9);
const updateData = (key: string, val: any) => emit('update:modelValue', { ...localData.value, [key]: val });

// === LOGICA ESTRUCTURA (MENU) ===
const addItem = () => {
    const items = [...(localData.value.items || [])];
    items.push({ id: generateId(), label: 'Nueva Sección', children: [] });
    updateData('items', items);
};
const addSubItem = (parentIdx: number) => {
    const items = JSON.parse(JSON.stringify(localData.value.items));
    items[parentIdx].children.push({ id: generateId(), label: 'Sub-categoría' });
    updateData('items', items);
};
// (Update/Remove similares a la versión anterior, simplificados aquí)

// === LOGICA CONTENIDO (CARDS) ===
// Filtramos las cards que pertenecen a la categoría seleccionada
const currentCards = computed(() => {
    return (localData.value.cards || []).filter((c: any) => c.categoryId === selectedCatForEditing.value);
});

const addCardToCurrentCategory = () => {
    if (!selectedCatForEditing.value) return;
    const cards = [...(localData.value.cards || [])];
    cards.push({
        categoryId: selectedCatForEditing.value,
        title: 'Nuevo Documento',
        links: [{ url: '', label: 'Descargar' }]
    });
    updateData('cards', cards);
};

const updateCard = (cardIndexInGlobal: number, field: string, val: any) => {
    const cards = [...localData.value.cards];
    cards[cardIndexInGlobal][field] = val;
    updateData('cards', cards);
};

// Encuentra el índice real en el array global para poder editar
const getGlobalIndex = (card: any) => localData.value.cards.indexOf(card);

// Helper para obtener lista plana de categorías para el selector
const availableCategories = computed(() => {
    const cats = [];
    localData.value.items?.forEach((p: any) => {
        cats.push({ id: p.id, label: p.label, isParent: true });
        p.children?.forEach((c: any) => cats.push({ id: c.id, label: `${p.label} > ${c.label}`, isParent: false }));
    });
    return cats;
});
</script>

<template>
  <div class="resource-editor-compact">
      
      <div class="btn-group w-100 mb-3">
          <button 
            class="btn btn-sm" 
            :class="activeEditorTab === 'structure' ? 'btn-dark' : 'btn-outline-secondary border-0'"
            @click="activeEditorTab = 'structure'"
          >
            1. Estructura del Menú
          </button>
          <button 
            class="btn btn-sm"
            :class="activeEditorTab === 'content' ? 'btn-dark' : 'btn-outline-secondary border-0'"
            @click="activeEditorTab = 'content'"
          >
            2. Contenido de Tarjetas
          </button>
      </div>

      <div v-if="activeEditorTab === 'structure'" class="p-2">
          <div class="alert alert-light border small py-2 mb-3">
              <i class="las la-info-circle text-primary"></i> Define aquí las secciones del menú lateral.
          </div>
          
          <div v-for="(item, idx) in localData.items" :key="idx" class="mb-3 bg-white border rounded shadow-sm">
              <div class="d-flex align-items-center p-2 border-bottom bg-light">
                  <i class="las la-folder me-2 text-warning"></i>
                  <input type="text" class="form-control form-control-sm border-0 bg-transparent fw-bold" v-model="item.label" placeholder="Nombre Sección">
                  <button class="btn btn-xs text-danger" @click="localData.items.splice(idx, 1); updateData('items', localData.items)"><i class="las la-trash"></i></button>
              </div>
              
              <div class="p-2 ps-4 bg-light-subtle">
                  <div v-for="(child, cIdx) in item.children" :key="cIdx" class="d-flex align-items-center mb-1">
                      <i class="las la-level-up-alt la-rotate-90 me-2 text-muted small"></i>
                      <input type="text" class="form-control form-control-sm py-0" v-model="child.label">
                      <button class="btn btn-xs text-danger ms-1" @click="item.children.splice(cIdx, 1); updateData('items', localData.items)"><i class="las la-times"></i></button>
                  </div>
                  <button @click="addSubItem(idx)" class="btn btn-link btn-sm p-0 mt-1 text-decoration-none small">
                      <i class="las la-plus"></i> Añadir Sub-categoría
                  </button>
              </div>
          </div>
          <button @click="addItem" class="btn btn-primary btn-sm w-100"><i class="las la-plus"></i> Nueva Sección Principal</button>
      </div>

      <div v-if="activeEditorTab === 'content'" class="p-2">
          
          <div class="mb-3">
              <label class="small fw-bold text-muted">¿Qué sección quieres editar?</label>
              <select v-model="selectedCatForEditing" class="form-select form-select-sm border-primary">
                  <option value="" disabled>-- Selecciona una categoría --</option>
                  <option v-for="cat in availableCategories" :key="cat.id" :value="cat.id">
                      {{ cat.label }}
                  </option>
              </select>
          </div>

          <div v-if="selectedCatForEditing">
              
              <div class="d-flex justify-content-between align-items-center mb-2">
                  <small class="fw-bold text-secondary">{{ currentCards.length }} Documentos en esta sección</small>
                  <button @click="addCardToCurrentCategory" class="btn btn-success btn-sm py-0 shadow-sm">
                      <i class="las la-plus"></i> Añadir
                  </button>
              </div>

              <div v-if="currentCards.length === 0" class="text-center p-4 text-muted border border-dashed rounded bg-light">
                  <i class="las la-file-pdf fs-3 opacity-50"></i>
                  <p class="small m-0">No hay documentos aquí aún.</p>
              </div>

              <div class="cards-list-container">
                  <div v-for="card in currentCards" :key="getGlobalIndex(card)" class="card mb-2 border-start-0 border-end-0 border-top-0 border-bottom shadow-none rounded-0">
                      <div class="card-body p-2">
                          
                          <div class="d-flex gap-2 align-items-start">
                              <div class="flex-grow-1">
                                  <input 
                                    type="text" 
                                    class="form-control form-control-sm fw-bold mb-1" 
                                    :value="card.title" 
                                    @input="(e:any) => updateCard(getGlobalIndex(card), 'title', e.target.value)"
                                    placeholder="Título del Documento"
                                  >
                                  
                                  <div class="bg-light p-1 rounded">
                                      <div v-for="(link, lIdx) in card.links" :key="lIdx" class="d-flex gap-1 mb-1">
                                           <input type="text" class="form-control form-control-xs" v-model="link.url" placeholder="URL">
                                           <input type="text" class="form-control form-control-xs w-50" v-model="link.label" placeholder="Texto Btn">
                                      </div>
                                  </div>
                              </div>
                              
                              <button @click="localData.cards.splice(getGlobalIndex(card), 1); updateData('cards', localData.cards)" class="btn btn-xs text-danger border">
                                  <i class="las la-trash"></i>
                              </button>
                          </div>

                      </div>
                  </div>
              </div>

          </div>
          <div v-else class="text-center py-5 text-muted opacity-50">
              <i class="las la-arrow-up fs-1"></i>
              <p>Selecciona una categoría arriba para empezar.</p>
          </div>

      </div>

  </div>
</template>

<style scoped>
.form-control-xs { padding: 0.1rem 0.4rem; font-size: 0.75rem; }
.bg-light-subtle { background-color: #f8f9fa; }
.border-dashed { border-style: dashed !important; }
.w-50 { width: 50% !important; }
</style>