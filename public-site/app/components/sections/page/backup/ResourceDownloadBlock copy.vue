<script setup lang="ts">
import { computed, ref, onMounted } from 'vue';

// --- TIPOS ---
interface DownloadLink { url: string; label?: string; }
interface ResourceCard { 
  categoryId: string; // CLAVE: Vincula la tarjeta con el menú
  title: string; 
  links: DownloadLink[]; 
}
interface SidebarItem {
  id: string;      // ID único para filtrar (ej: 'alumnos', 'profesores')
  label: string;
  children?: { id: string; label: string; }[];
}

const props = defineProps<{
  data: {
    title?: string;
    sidebarTitle?: string;
    items?: SidebarItem[];
    cards?: ResourceCard[];
  }
}>();

// Estado reactivo para saber qué categoría se está viendo
const activeCategoryId = ref('');

// Datos procesados
const blockData = computed(() => ({
  title: props.data.title || 'Recursos Virtuales',
  sidebarTitle: props.data.sidebarTitle || 'MANUALES',
  sidebarItems: props.data.items || [
      { id: 'cat1', label: 'Esan Virtual', children: [
          { id: 'profesores', label: 'Profesores' },
          { id: 'alumnos', label: 'Alumnos' }
      ]},
      { id: 'laboratorios', label: 'Laboratorios' }
  ],
  allCards: props.data.cards || []
}));

// Inicializar con la primera categoría que tenga contenido o exista
onMounted(() => {
    if (blockData.value.sidebarItems.length > 0) {
        // Buscamos el primer hijo del primer item, o el item mismo
        const firstItem = blockData.value.sidebarItems[0];
        activeCategoryId.value = firstItem.children?.[0]?.id || firstItem.id;
    }
});

// Computed: Filtrar tarjetas según la categoría activa
const filteredCards = computed(() => {
    return blockData.value.allCards.filter(c => c.categoryId === activeCategoryId.value);
});

// Computed: Obtener el título de la categoría activa para mostrarlo arriba
const currentCategoryTitle = computed(() => {
    // Buscar en padres
    const parent = blockData.value.sidebarItems.find(i => i.id === activeCategoryId.value);
    if (parent) return parent.label;
    
    // Buscar en hijos
    for (const item of blockData.value.sidebarItems) {
        const child = item.children?.find(c => c.id === activeCategoryId.value);
        if (child) return `${item.label} / ${child.label}`;
    }
    return 'Recursos';
});

// Acción de click
const selectCategory = (id: string, event: Event) => {
    event.preventDefault(); // Evitar recarga
    activeCategoryId.value = id;
};
</script>

<template>
  <section class="resource-section py-5 bg-white">
    <div class="container">
      <div class="row">
        
        <div class="col-lg-9 col-md-12 pe-lg-5 order-2 order-md-1">
            
            <div class="article-header mb-4 border-bottom pb-3">
                <h1 class="display-6 fw-bold text-dark mb-2">{{ blockData.title }}</h1>
                <div class="d-flex align-items-center text-muted small">
                    <span class="badge bg-danger text-white me-2">
                        <i class="las la-folder-open me-1"></i> {{ currentCategoryTitle }}
                    </span>
                    <span class="text-secondary" v-if="filteredCards.length > 0">{{ filteredCards.length }} documentos disponibles</span>
                    <span class="text-danger" v-else>No hay documentos en esta sección</span>
                </div>
            </div>

            <transition name="fade" mode="out-in">
                <div :key="activeCategoryId" class="row g-4">
                    <div v-for="(card, index) in filteredCards" :key="index" class="col-md-4 col-sm-6 d-flex align-items-stretch">
                        <div class="resource-card w-100 position-relative bg-white shadow-sm rounded">
                            <div class="card-top-accent"></div>
                            <div class="p-4 text-center d-flex flex-column h-100">
                                <div class="mb-3 icon-circle mx-auto"><i class="las la-file-pdf"></i></div>
                                <h5 class="resource-title mb-3 flex-grow-1">{{ card.title }}</h5>
                                <div class="d-grid gap-2 mt-auto">
                                    <a v-for="(link, i) in card.links.slice(0, 2)" :key="i" :href="link.url" target="_blank" class="btn btn-custom btn-sm rounded-pill">
                                        {{ link.label || 'Descargar' }} <i class="las la-download ms-1"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </transition>
        </div>

        <div class="col-lg-3 col-md-12 mt-4 mt-lg-0 order-1 order-md-2">
            <div class="sidebar-wrapper p-3 bg-light rounded border">
                <h5 class="sidebar-heading mb-3 text-uppercase">{{ blockData.sidebarTitle }}</h5>
                
                <ul class="list-unstyled sidebar-nav m-0">
                    <li v-for="(item, idx) in blockData.sidebarItems" :key="idx" class="nav-item mb-1">
                        <a 
                            href="#" 
                            class="nav-link-main d-flex justify-content-between align-items-center"
                            :class="{ 'active': activeCategoryId === item.id && (!item.children || item.children.length === 0) }"
                            @click="(!item.children || item.children.length === 0) ? selectCategory(item.id, $event) : $event.preventDefault()"
                        >
                            {{ item.label }}
                            <i v-if="item.children && item.children.length" class="las la-angle-down small opacity-50"></i>
                        </a>
                        
                        <ul v-if="item.children && item.children.length" class="list-unstyled submenu ms-3 mt-1 ps-2 border-start border-3 border-danger">
                            <li v-for="(child, cIdx) in item.children" :key="cIdx" class="mb-1">
                                <a 
                                    href="#" 
                                    class="nav-link-sub" 
                                    :class="{ 'active-sub': activeCategoryId === child.id }"
                                    @click="selectCategory(child.id, $event)"
                                >
                                    {{ child.label }}
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>

      </div>
    </div>
  </section>
</template>

<style scoped>
*{
    font-family: 'Arial';
}
/* Transición Fade */
.fade-enter-active, .fade-leave-active { transition: opacity 0.3s ease; }
.fade-enter-from, .fade-leave-to { opacity: 0; }

/* Estilos previos (simplificados) */
.resource-card { transition: transform 0.2s; border: 1px solid #eee; }
.resource-card:hover { transform: translateY(-3px); box-shadow: 0 10px 20px rgba(0,0,0,0.05); }
.card-top-accent { height: 3px; background: #dc3545; }
.icon-circle { width: 45px; height: 45px; background: #fff0f0; color: #dc3545; border-radius: 50%; display: grid; place-items: center; font-size: 1.4rem; }
.resource-title { font-size: 0.85rem; font-weight: 700; color: #333; }
.btn-custom { border: 1px solid #dc3545; color: #dc3545; font-size: 0.75rem; font-weight: 600; }
.btn-custom:hover { background: #dc3545; color: white; }

/* Sidebar */
.sidebar-heading { font-weight: 800; font-size: 1rem; border-bottom: 2px solid #ddd; padding-bottom: 8px; }
.nav-link-main { color: #444; font-weight: 700; padding: 8px 10px; border-radius: 4px; text-decoration: none; transition: all 0.2s; }
.nav-link-main:hover, .nav-link-main.active { background: white; color: #dc3545; box-shadow: 0 2px 5px rgba(0,0,0,0.05); }
.nav-link-sub { display: block; padding: 4px 8px; color: #666; font-size: 0.9rem; text-decoration: none; border-radius: 4px; }
.nav-link-sub:hover, .nav-link-sub.active-sub { color: #dc3545; background: rgba(220, 53, 69, 0.05); font-weight: 600; }
</style>