<script setup lang="ts">
import { ref, onMounted, defineAsyncComponent } from 'vue';
import HttpClient from "@/helpers/http-client";
import { formatImageUrl } from '@/helpers/url';

// --- COMPONENTES ---
const CoursePreviewModal = defineAsyncComponent(() => import('@/components/modals/CoursePreviewModal.vue'));

// --- PROPS ---
// Dejamos esto opcional para que no te de errores, 
// pero internamente usaremos el ID 7 fijo por ahora.
const props = defineProps<{
    categoryId?: number;
    categorySlug?: string;
}>();

// --- STATE ---
const courses = ref<any[]>([]);
const currentCategoryName = ref('');
const loading = ref(false);
const showModal = ref(false);
const selectedCourse = ref<any>(null);

// --- MAPPER (AJUSTADO A TU JSON REAL) ---
const mapSystemData = (rawData: any[], categoryName: string) => {
    return rawData.map((item: any) => {
        // 1. Imagen: Tu JSON trae "image_path", usamos ese.
        // Si viene null, ponemos una por defecto.
        const img = item.image_path || 'https://via.placeholder.com/400x250?text=No+Image';
        
        // 2. Bloques de contenido: 
        // Tu JSON ya trae "content_blocks" con {ventajas, aplicacion, laboratorios}.
        // Usamos eso directo. Si viene null, usamos un objeto vacío.
        const blocks = item.content_blocks || {};

        return {
            id: item.id,
            title: item.title,
            slug: item.slug,
            description: item.description || 'Sin descripción disponible.',
            image_path: img,
            // Tu JSON trae el link en "video_url", perfecto.
            video_url: item.video_url || '#', 
            category: { name: categoryName },
            
            // Mapeo exacto de tus bloques reales
            content_blocks: {
                ventajas: blocks.ventajas || "Contenido especializado.",
                aplicacion: blocks.aplicacion || "Uso profesional.",
                laboratorios: blocks.laboratorios || "Laboratorios Virtuales"
            }
        };
    });
};

// --- FETCHING ---
const fetchSystemResources = async () => {
    const targetId = 7; // ID FIJO PARA MICRO FINANZAS
    loading.value = true;
    
    try {
        console.log("Iniciando petición para ID:", targetId);
        const response = await HttpClient.get(`courses/category/${targetId}`);
        
        // Tu respuesta es { category: {...}, courses: [...] } o { courses: { data: [] } }
        const backendResponse = response.data; 

        // 1. Categoría
        const categoryData = backendResponse.category;
        currentCategoryName.value = categoryData ? categoryData.name : 'Categoría';

        // 2. Cursos
        // NOTA: Si usas paginate() en Laravel, los cursos están en .courses.data
        // Si usas get() o collection directa, pueden estar en .courses directo.
        // Esta línea maneja ambos casos:
        const coursesData = backendResponse.courses.data || backendResponse.courses || [];
        
        console.log("Cursos encontrados:", coursesData); // Para depurar

        courses.value = mapSystemData(coursesData, currentCategoryName.value);

    } catch (e) {
        console.error("Error cargando cursos:", e);
        courses.value = [];
        currentCategoryName.value = "Error de Conexión";
    } finally {
        loading.value = false;
    }
};

const openModal = (course: any) => {
    selectedCourse.value = course;
    showModal.value = true;
};

// --- LIFECYCLE ---
onMounted(() => {
    fetchSystemResources();
});
</script>
<template>
    <section class="clean-section">
        
        <div class="section-header">
            <h2 class="section-title">
                {{ currentCategoryName }}
            </h2>
            <div class="section-line"></div>
        </div>
        
        <div v-if="loading" class="loading-container">
            <div class="spinner"></div>
            <p>Cargando cursos...</p>
        </div>

        <div v-else-if="courses.length > 0" class="cards-grid">
             <div 
                v-for="course in courses" 
                :key="course.id" 
                class="course-card"
            >
                <div class="card-image-wrapper">
                    <img :src="formatImageUrl(course.image_path)" :alt="course.title" loading="lazy" />
                    <span class="category-badge">{{ course.category.name }}</span>
                </div>

                <div class="card-content">
                    <h3 class="card-title">{{ course.title }}</h3>
                    <p class="card-desc">{{ course.description }}</p>
                    
                    <button class="btn-detail" @click="openModal(course)">
                        Ver Detalle
                        <i class="las la-arrow-right"></i>
                    </button>
                </div>
            </div>
        </div>
        
        <div v-else class="empty-state">
            <i class="las la-folder-open"></i>
            <span>No hay cursos disponibles en esta categoría.</span>
        </div>

        <CoursePreviewModal v-model="showModal" :course="selectedCourse" />
    </section>
</template>

<style scoped lang="scss">
// --- VARIABLES ---
$primary: #144c74; // Azul oscuro
$accent: #e31140;  // Rojo
$text: #333;
$text-light: #666;
$bg-card: #ffffff;
$radius: 12px;

.clean-section {
    padding: 60px 0;
    font-family: 'Inter', system-ui, sans-serif; // Tipografía moderna
    max-width: 1200px;
    margin: 0 auto;
    padding-left: 20px;
    padding-right: 20px;
}

// --- HEADER ---
.section-header {
    margin-bottom: 40px;
    text-align: center;
}
.section-title {
    font-size: 2rem;
    font-weight: 700;
    color: $accent;
    margin-bottom: 10px;
    text-transform: uppercase;
    letter-spacing: -0.5px;
}
.section-line {
    width: 60px;
    height: 4px;
    background: $accent;
    margin: 0 auto;
    border-radius: 2px;
}

// --- GRID ---
.cards-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
    gap: 30px;
}

// --- TARJETA ---
.course-card {
    background: $bg-card;
    border-radius: $radius;
    overflow: hidden;
    box-shadow: 0 4px 20px rgba(0,0,0,0.06);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
    border: 1px solid #f0f0f0;
    display: flex;
    flex-direction: column;

    &:hover {
        transform: translateY(-5px);
        box-shadow: 0 12px 25px rgba(0,0,0,0.1);
        
        .card-image-wrapper img {
            transform: scale(1.05);
        }
    }
}

// 1. Imagen
.card-image-wrapper {
    position: relative;
    height: 200px;
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
    left: 15px;
    background: rgba($primary, 0.9);
    color: white;
    padding: 5px 12px;
    border-radius: 20px;
    font-size: 0.75rem;
    font-weight: 600;
    backdrop-filter: blur(4px);
}

// 2. Contenido
.card-content {
    padding: 25px;
    display: flex;
    flex-direction: column;
    flex-grow: 1;
}

.card-title {
    font-size: 1.15rem;
    font-weight: 700;
    color: $primary;
    margin-bottom: 10px;
    line-height: 1.4;
}

.card-desc {
    font-size: 0.9rem;
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
.btn-detail {
    margin-top: auto; // Empuja el botón al fondo siempre
    width: 100%;
    padding: 12px;
    background: transparent;
    border: 1px solid $primary;
    color: $primary;
    border-radius: 6px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.2s ease;
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 8px;

    &:hover {
        background: $primary;
        color: white;
    }
}

// --- LOADING & EMPTY ---
.loading-container, .empty-state {
    text-align: center;
    padding: 60px;
    color: $text-light;
}
.spinner {
    width: 40px; height: 40px;
    border: 4px solid #eee;
    border-top: 4px solid $accent;
    border-radius: 50%;
    margin: 0 auto 15px;
    animation: spin 1s linear infinite;
}
.empty-state i {
    font-size: 3rem;
    color: #ccc;
    display: block;
    margin-bottom: 10px;
}

@keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }

/* Responsive adjustments */
@media (max-width: 768px) {
    .section-title { font-size: 1.5rem; }
    .cards-grid { grid-template-columns: 1fr; }
}
</style>