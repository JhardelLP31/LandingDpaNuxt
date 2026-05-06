<script setup lang="ts">
import { ref, onMounted, watch, defineAsyncComponent, computed } from 'vue';
import HttpClient from "@/helpers/http-client";
// Importamos el nuevo componente
import CourseCard from '@/components/sections/ui/CardSoftware.vue'; 

const CoursePreviewModal = defineAsyncComponent(() => import('@/components/modals/CoursePreviewModal.vue'));

const props = defineProps<{
    data: { 
        categoryId?: number | string;
        titleOverride?: string;
    }
}>();

const courses = ref<any[]>([]);
const actualCategoryName = ref('');
const loading = ref(false);
const showModal = ref(false);
const selectedCourse = ref<any>(null);

const displayTitle = computed(() => {
    return props.data.titleOverride || actualCategoryName.value || 'Sección Destacada';
});

const mapSystemData = (rawData: any[], categoryName: string) => {
    return rawData.map((item: any) => ({
        id: item.id,
        title: item.title,
        slug: item.slug,
        description: item.description || 'Sin descripción disponible.',
        image_path: item.image_path || 'https://via.placeholder.com/400x250?text=No+Image',
        video_url: item.video_url || '#', 
        category: { name: categoryName },
        content_blocks: {
            ventajas: item.content_blocks?.ventajas || "Contenido especializado.",
            aplicacion: item.content_blocks?.aplicacion || "Uso profesional.",
            laboratorios: item.content_blocks?.laboratorios || "Laboratorios Virtuales"
        }
    }));
};

const fetchSystemResources = async () => {
    if (!props.data?.categoryId) {
        courses.value = [];
        actualCategoryName.value = '';
        return;
    }

    loading.value = true;
    try {
        const response = await HttpClient.get(`courses/category/${props.data.categoryId}`);
        const backendResponse = response.data; 

        if (backendResponse.category) {
            actualCategoryName.value = backendResponse.category.name;
        }

        const coursesData = backendResponse.courses.data || backendResponse.courses || [];
        courses.value = mapSystemData(coursesData, actualCategoryName.value);
    } catch (e) {
        console.error("Error cargando cursos:", e);
        courses.value = [];
        actualCategoryName.value = "Error de Conexión";
    } finally {
        loading.value = false;
    }
};

const openModal = (course: any) => {
    selectedCourse.value = course;
    showModal.value = true;
};

onMounted(fetchSystemResources);
watch(() => props.data, fetchSystemResources, { deep: true });
</script>

<template>
    <section class="clean-section">
        <div class="section-header" v-if="!loading && courses.length > 0">
            <h2 class="section-title mb-2 text-uppercase fw-bold display-6">
                {{ displayTitle }}
            </h2>
            <div class="section-line"></div>
        </div>
        
        <div v-if="loading" class="loading-container">
            <div class="spinner"></div>
            <p>Cargando recursos...</p>
        </div>

        <div v-else-if="!props.data.categoryId" class="empty-editor-state">
            <i class="las la-cog"></i>
            <span>Selecciona una categoría en el editor.</span>
        </div>

        <div v-else-if="courses.length > 0" class="cards-grid">
             <CourseCard 
                v-for="course in courses" 
                :key="course.id" 
                :course="course"
                @click-detail="openModal"
            />
        </div>
        
        <div v-else class="empty-state">
            <i class="las la-folder-open"></i>
            <span>No hay cursos en: {{ actualCategoryName }}</span>
        </div>

        <CoursePreviewModal v-model="showModal" :course="selectedCourse" />
    </section>
</template>

<style scoped lang="scss">
$accent: #e31140;
$text-light: #666;

.section-header { margin-bottom: 40px; text-align: center; }
.section-title { color: $accent; text-align: center; }
.section-line { width: 60px; height: 4px; background: $accent; margin: 0 auto; border-radius: 2px; }

.cards-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
    gap: 30px;
}

.loading-container, .empty-state, .empty-editor-state {
    text-align: center; padding: 60px; color: $text-light;
}
.empty-editor-state {
    border: 2px dashed #ccc; border-radius: 12px; background: #f9f9f9; margin: 20px;
    i { font-size: 3rem; color: #ccc; display: block; margin-bottom: 15px; }
}
.spinner {
    width: 40px; height: 40px; border: 4px solid #eee; border-top: 4px solid $accent;
    border-radius: 50%; margin: 0 auto 15px; animation: spin 1s linear infinite;
}
@keyframes spin { 0% { transform: rotate(0deg); } 100% { transform: rotate(360deg); } }

@media (max-width: 768px) {
    .cards-grid { grid-template-columns: 1fr; }
}
</style>