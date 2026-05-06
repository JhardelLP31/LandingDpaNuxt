<script setup lang="ts">
import { computed, ref, onMounted, nextTick, watch } from 'vue';
import { useRoute } from 'vue-router';
import HttpClient from '../../../helpers/http-client';
import { formatImageUrl } from '../../../helpers/url';

const route = useRoute();

// --- ESTADO ---
const manuals = ref<any[]>([]);
const categories = ref<any[]>([]); 
const activeCategoryId = ref<number | null>(null);
const loading = ref(true);
const highlightedManualId = ref<number | null>(null);

// --- LÓGICA PRINCIPAL: Detección por Hash (#) ---
const checkHashAndNavigate = () => {
    // 1. Obtenemos el slug eliminando el michi (#)
    const hash = route.hash;
    if (!hash) {
        // Si no hay hash, y no hay categoría seleccionada, seleccionar la primera por defecto
        if (categories.value.length > 0 && !activeCategoryId.value) {
            activeCategoryId.value = categories.value[0].id;
        }
        return;
    }

    const targetSlug = hash.replace('#', '');
    
    // 2. Buscamos el manual que coincida con ese slug
    const targetManual = manuals.value.find(m => m.slug === targetSlug);

    if (targetManual) {
        // 3. Activamos la categoría de ese manual para que se muestre en la lista
        activeCategoryId.value = targetManual.category_id;
        
        // 4. Marcamos el ID para el efecto visual CSS
        highlightedManualId.value = targetManual.id;
        
        // 5. Esperamos a que Vue renderice el DOM y hacemos Scroll
        nextTick(() => {
            setTimeout(() => {
                const el = document.getElementById(`manual-${targetManual.id}`);
                if (el) {
                    // Calculamos offset por si tienes un header fijo
                    const headerOffset = 100; 
                    const elementPosition = el.getBoundingClientRect().top;
                    const offsetPosition = elementPosition + window.pageYOffset - headerOffset;
    
                    window.scrollTo({
                        top: offsetPosition,
                        behavior: "smooth"
                    });
                }
            }, 500); // Pequeño delay para asegurar que la transición de categoría terminó
        });
    }
};

// --- CARGA DE DATOS ---
const loadData = async () => {
    loading.value = true;
    try {
        const [resManuals, resCats] = await Promise.all([
            //HttpClient.get("manuals-list"),
            HttpClient.get("categories-list?type=manual")
        ]);

        manuals.value = resManuals.data.data || resManuals.data || [];
        categories.value = resCats.data.data || resCats.data || [];

        // Ejecutamos la lógica una vez cargados los datos
        checkHashAndNavigate();

    } catch (error) {
        console.error("Error cargando manuales:", error);
    } finally {
        loading.value = false;
    }
};

/*onMounted(
    loadData
);*/

// Observamos cambios en el Hash por si el usuario busca otra cosa estando ya aquí
watch(() => route.hash, () => {
    checkHashAndNavigate();
});


// --- LÓGICA DE FILTRADO RECURSIVO (Categorías) ---
const getCategoryFamilyIds = (catId: number | null): number[] => {
    if (!catId) return [];
    const ids: number[] = [catId];
    
    const findChildren = (list: any[]) => {
        for (const cat of list) {
            if (cat.id === catId) {
                if (cat.children && Array.isArray(cat.children)) {
                    cat.children.forEach((child: any) => ids.push(child.id));
                }
                return;
            }
            if (cat.children) findChildren(cat.children);
        }
    };
    
    findChildren(categories.value);
    return ids;
};

const filteredCards = computed(() => {
    const targetIds = getCategoryFamilyIds(activeCategoryId.value);
    return manuals.value.filter(m => targetIds.includes(m.category_id));
});

const currentCategoryTitle = computed(() => {
    const findDeep = (list: any[]): string | null => {
        for (const c of list) {
            if (c.id === activeCategoryId.value) return c.name;
            if (c.children) {
                const res = findDeep(c.children);
                if (res) return res;
            }
        }
        return null;
    };
    return findDeep(categories.value) || 'Todos los recursos';
});

const countManuals = (catId: number) => {
    // Cuenta recursiva simple (ajustar si necesitas contar hijos también)
    return manuals.value.filter(m => m.category_id === catId).length;
};

// --- ACCIONES DE UI ---
const selectCategory = (id: number, event: Event) => {
    event.preventDefault();
    activeCategoryId.value = id;
    highlightedManualId.value = null; // Limpiamos el highlight si el usuario cambia de categoría manualmente
};

const getLinks = (links: any) => {
    try {
        if (!links) return [];
        return typeof links === 'string' ? JSON.parse(links) : links;
    } catch (e) { return []; }
};
</script>

<template>
  <section class="resource-section py-5 bg-white font-arial-wrapper min-vh-100">
    <div class="container">
      
      <div v-if="loading" class="text-center py-5">
          <div class="spinner-border text-danger" role="status"></div>
          <p class="mt-2 text-muted">Cargando biblioteca...</p>
      </div>

      <div v-else class="row">
        
        <div class="col-lg-3 col-md-4 mb-4">
            <div class="sidebar-wrapper p-3 bg-light rounded border shadow-sm">
                <h5 class="sidebar-heading mb-3 text-uppercase">Categorías</h5>
                
                <ul class="list-unstyled sidebar-nav m-0">
                    <li v-for="cat in categories" :key="cat.id" class="mb-2">
                        <a href="#" 
                           class="nav-link-main d-flex justify-content-between align-items-center"
                           :class="{ 'active': activeCategoryId === cat.id }"
                           @click="selectCategory(cat.id, $event)">
                            <span class="text-truncate me-2">{{ cat.name }}</span>
                            <span class="badge rounded-pill bg-white text-dark border small">
                                {{ countManuals(cat.id) }}
                            </span>
                        </a>

                        <ul v-if="cat.children && cat.children.length > 0" class="list-unstyled ps-3 mt-1 border-start ms-2">
                            <li v-for="child in cat.children" :key="child.id">
                                <a href="#" 
                                   class="nav-link-sub d-flex justify-content-between align-items-center py-1 ps-2"
                                   :class="{ 'text-danger fw-bold': activeCategoryId === child.id }"
                                   @click="selectCategory(child.id, $event)">
                                    <span class="tiny-text">{{ child.name }}</span>
                                    <span class="text-muted tiny-count">{{ countManuals(child.id) }}</span>
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>

        <div class="col-lg-9 col-md-8 ps-lg-4">
            <div class="article-header mb-4 border-bottom pb-3">
                <h1 class="display-6 fw-bold text-dark mb-2">Manuales y Guías</h1>
                <div class="d-flex align-items-center text-muted small">
                    <span class="badge bg-danger text-white me-2 px-3">
                        <i class="las la-folder-open me-1"></i> {{ currentCategoryTitle }}
                    </span>
                    <span v-if="filteredCards.length">{{ filteredCards.length }} documentos encontrados</span>
                </div>
            </div>

            <transition name="fade" mode="out-in">
                <div :key="activeCategoryId || 'none'" class="row g-4">
                    
                    <div v-for="manual in filteredCards" 
                         :key="manual.id" 
                         :id="`manual-${manual.id}`" 
                         class="col-xl-4 col-md-6">
                        
                        <div class="resource-card h-100 bg-white shadow-sm rounded border d-flex flex-column"
                             :class="{ 'highlight-pulse': highlightedManualId === manual.id }">
                            
                            <div class="card-top-accent"></div>
                            
                            <div class="p-4 text-center d-flex flex-column flex-grow-1">
                                <div class="mb-3 icon-circle mx-auto">
                                    <i class="las la-file-pdf"></i> </div>
                                
                                <h6 class="resource-title mb-3 flex-grow-1" :title="manual.title">
                                    {{ manual.title }}
                                </h6>
                                
                                <div class="d-grid gap-2 mt-auto">
                                    <a v-for="(link, i) in getLinks(manual.download_links)" 
                                       :key="i" 
                                       :href="formatImageUrl(link.url)" 
                                       target="_blank" 
                                       class="btn btn-outline-danger btn-sm rounded-pill fw-bold btn-download">
                                         {{ link.label || 'Ver Documento' }} <i class="las la-external-link-alt ms-1"></i>
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div v-if="filteredCards.length === 0" class="col-12 text-center py-5">
                        <div class="mb-3 text-muted opacity-50">
                            <i class="las la-folder-open" style="font-size: 4rem;"></i>
                        </div>
                        <h5 class="text-muted">No hay manuales en esta categoría</h5>
                        <p class="small text-muted">Intenta seleccionar otra categoría del menú lateral.</p>
                    </div>
                </div>
            </transition>
        </div>

      </div>
    </div>
  </section>
</template>

<style scoped>
.font-arial-wrapper { font-family: Arial, Helvetica, sans-serif !important; }

/* Transiciones de Vue */
.fade-enter-active, .fade-leave-active { transition: opacity 0.2s ease; }
.fade-enter-from, .fade-leave-to { opacity: 0; }

/* Estilos de la Tarjeta */
.resource-card { 
    transition: all 0.3s cubic-bezier(.25,.8,.25,1); 
    border: 1px solid #e9ecef;
    position: relative;
    overflow: hidden;
}
.resource-card:hover { 
    transform: translateY(-5px); 
    box-shadow: 0 10px 20px rgba(0,0,0,0.08) !important; 
    border-color: #dc3545 !important; 
}
.card-top-accent { height: 4px; background: #dc3545; width: 100%; opacity: 0.8; }

/* === EFECTO DE RESALTADO (HIGHLIGHT) === */
.highlight-pulse {
    border: 2px solid #dc3545 !important;
    animation: pulse-attention 2.5s infinite;
}

@keyframes pulse-attention {
    0% { box-shadow: 0 0 0 0px rgba(220, 53, 69, 0.4); }
    50% { box-shadow: 0 0 0 10px rgba(220, 53, 69, 0); }
    100% { box-shadow: 0 0 0 0px rgba(220, 53, 69, 0); }
}

/* Iconos y Textos */
.icon-circle { width: 50px; height: 50px; background: #fff0f0; color: #dc3545; border-radius: 50%; display: grid; place-items: center; font-size: 1.5rem; }
.resource-title { font-size: 0.95rem; font-weight: 700; color: #343a40; line-height: 1.4; display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }

/* Sidebar */
.sidebar-wrapper { position: sticky; top: 100px; /* Ajustar según tu header */ }
.sidebar-heading { font-weight: 800; font-size: 0.75rem; letter-spacing: 1px; color: #adb5bd; border-bottom: 2px solid #f8f9fa; }

.nav-link-main { color: #495057; font-weight: 600; padding: 10px 15px; border-radius: 8px; text-decoration: none; transition: 0.2s; font-size: 0.9rem; }
.nav-link-main:hover { background: #fff5f5; color: #dc3545; }
.nav-link-main.active { background: #dc3545; color: white !important; box-shadow: 0 4px 6px rgba(220, 53, 69, 0.2); }
.nav-link-main.active .badge { color: #dc3545 !important; }

.nav-link-sub { text-decoration: none; color: #6c757d; font-size: 0.85rem; transition: 0.2s; }
.nav-link-sub:hover { color: #dc3545; transform: translateX(3px); }
.tiny-count { font-size: 0.7rem; background: #f8f9fa; padding: 2px 6px; border-radius: 4px; }
.tiny-text { font-size: 0.85rem; }

.btn-download { font-size: 0.75rem; transition: 0.2s; text-transform: uppercase; letter-spacing: 0.5px; }
.btn-download:hover { background-color: #dc3545; color: white; transform: translateY(-1px); }
</style>