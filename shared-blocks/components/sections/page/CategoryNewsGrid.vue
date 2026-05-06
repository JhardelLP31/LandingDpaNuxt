<script setup lang="ts">
import { ref, onMounted, watch, computed } from 'vue';
import HttpClient from "@/helpers/http-client";
import { formatImageUrl } from '@/helpers/url';

// 1. PROPS: Recibimos la configuración DEL EDITOR
// data.categoryId es el ID de la categoría de noticias que quieres mostrar
const props = defineProps<{
    data: { 
        categoryId?: number | string;
        titleOverride?: string;
    }
}>();

// --- STATE ---
const newsItems = ref<any[]>([]);
const actualCategoryName = ref('');
const loading = ref(false);

// Título final a mostrar
const displayTitle = computed(() => {
    return props.data.titleOverride || actualCategoryName.value || 'Noticias Recientes';
});

// --- MAPPER DE NOTICIAS ---
const mapNewsData = (rawData: any[], categoryName: string) => {
    return rawData.map((item: any) => {
        const img = item.image_path || item.featured_image_path || 'https://via.placeholder.com/400x250?text=Noticia';
        
        return {
            id: item.id,
            title: item.title,
            slug: item.slug,
            // Asumimos que la noticia tiene 'summary', 'intro' o 'body'
            description: item.summary || item.intro || item.description || 'Lee la nota completa para más detalles.',
            image_path: img,
            published_at: item.published_at || item.created_at, // Fecha
            category: { name: categoryName },
            // Link para ir a leer la noticia completa
            link: `/noticias/view-detail/${item.slug}` 
        };
    });
};

// --- LOGICA PRINCIPAL ---
const fetchNewsByCategory = async () => {
    // Si no hay ID seleccionado en el editor, no hacemos nada
    if (!props.data?.categoryId) {
        newsItems.value = [];
        actualCategoryName.value = '';
        return;
    }

    loading.value = true;
    
    try {
        const targetId = props.data.categoryId;
        
        // CAMBIO PRINCIPAL: Endpoint de noticias
        // Ajusta 'news' si tu endpoint se llama 'posts' o 'blog'
        const response = await HttpClient.get(`news/category/${targetId}`);
        const backendResponse = response.data; 
        // 1. Datos de Categoría
        if (backendResponse.category) {
            actualCategoryName.value = backendResponse.category.name;
        }

        // 2. Datos de Noticias (Soporta paginación .data o array directo)
        const newsData = backendResponse.news?.data || backendResponse.news || backendResponse.data || [];
        newsItems.value = mapNewsData(newsData, actualCategoryName.value);

    } catch (e) {
        console.error("Error cargando noticias:", e);
        newsItems.value = [];
        actualCategoryName.value = "Error de Conexión";
    } finally {
        loading.value = false;
    }
};

// --- LIFECYCLE & WATCH ---
onMounted(() => {
    fetchNewsByCategory();
});

// Si cambias la categoría en el editor, recargar
watch(() => props.data, () => {
    fetchNewsByCategory();
}, { deep: true });
</script>

<template>
    <section class="clean-section py-5">
        
        <div class="container mb-5" v-if="!loading && newsItems.length > 0">
            <div class="text-center">
                <h2 class="section-title text-uppercase fw-bold mb-3">
                    {{ displayTitle }}
                </h2>
                <div class="section-line"></div>
            </div>
        </div>
        
        <div class="container">
            <div v-if="loading" class="text-center py-5">
                <div class="spinner-border text-primary" role="status">
                    <span class="visually-hidden">Cargando...</span>
                </div>
                <p class="mt-3 text-muted">Cargando noticias...</p>
            </div>

            <div v-else-if="!props.data.categoryId" class="alert alert-warning text-center">
                <i class="fas fa-cog fa-2x mb-2"></i><br>
                Selecciona una categoría de noticias en el editor.
            </div>

            <div v-else-if="newsItems.length > 0" class="row g-4">
                 <div 
                    v-for="item in newsItems" 
                    :key="item.id" 
                    class="col-md-6 col-lg-4"
                >
                    <div class="news-card h-100">
                        
                        <div class="card-image-wrapper">
                            <RouterLink :to="item.link" class="d-block h-100">
                                <img :src="formatImageUrl(item.image_path)" :alt="item.title" loading="lazy" />
                                <span class="category-badge">{{ item.category.name }}</span>
                            </RouterLink>
                        </div>

                        <div class="card-content">
                            <div class="news-date mb-2" v-if="item.published_at">
                                <i class="far fa-calendar-alt me-1"></i>
                                {{ new Date(item.published_at).toLocaleDateString() }}
                            </div>

                            <h3 class="card-title">
                                <RouterLink :to="item.link" class="text-decoration-none text-dark">
                                    {{ item.title }}
                                </RouterLink>
                            </h3>
                            
                            <p class="card-desc">{{ item.description }}</p>
                            
                            <RouterLink :to="item.link" class="btn-read-more">
                                Leer más <i class="fas fa-arrow-right ms-1"></i>
                            </RouterLink>
                        </div>
                    </div>
                </div>
            </div>
            
            <div v-else class="text-center py-5 text-muted">
                <i class="far fa-folder-open fa-3x mb-3"></i>
                <p>No se encontraron noticias en: <strong>{{ actualCategoryName }}</strong></p>
            </div>

        </div>
    </section>
</template> 

<style scoped lang="scss">
// --- VARIABLES ---
$primary: #144c74; 
$accent: #bd1033; // Rojo corporativo
$text: #333;
$text-light: #666;
$bg-card: #ffffff;
$radius: 8px;

.section-title {
    color: $primary;
    font-size: 2rem;
}

.section-line {
    width: 60px;
    height: 4px;
    background: $accent;
    margin: 0 auto;
    border-radius: 2px;
}

// --- TARJETA ---
.news-card {
    background: $bg-card;
    border-radius: $radius;
    overflow: hidden;
    box-shadow: 0 5px 15px rgba(0,0,0,0.05);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    border: 1px solid #eee;
    display: flex;
    flex-direction: column;

    &:hover {
        transform: translateY(-5px);
        box-shadow: 0 15px 30px rgba(0,0,0,0.1);
        
        .card-image-wrapper img {
            transform: scale(1.05);
        }
        .card-title {
            color: $accent;
        }
    }
}

// 1. Imagen
.card-image-wrapper {
    position: relative;
    height: 220px;
    overflow: hidden;
    
    img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: transform 0.5s ease;
    }
}

.category-badge {
    position: absolute;
    top: 15px;
    right: 15px;
    background: $accent;
    color: white;
    padding: 4px 10px;
    border-radius: 4px;
    font-size: 0.75rem;
    font-weight: 700;
    text-transform: uppercase;
}

// 2. Contenido
.card-content {
    padding: 25px;
    display: flex;
    flex-direction: column;
    flex-grow: 1;
}

.news-date {
    font-size: 0.85rem;
    color: #999;
    font-weight: 500;
}

.card-title {
    font-size: 1.25rem;
    font-weight: 700;
    color: $primary;
    margin-bottom: 12px;
    line-height: 1.4;
    transition: color 0.3s;
}

.card-desc {
    font-size: 0.95rem;
    color: $text-light;
    line-height: 1.6;
    margin-bottom: 20px;
    
    // Truncar a 3 líneas
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    overflow: hidden;
}

// 3. Botón
.btn-read-more {
    margin-top: auto;
    font-weight: 700;
    color: $primary;
    text-decoration: none;
    font-size: 0.9rem;
    display: inline-flex;
    align-items: center;
    transition: all 0.2s;

    &:hover {
        color: $accent;
        transform: translateX(5px);
    }
}
</style>