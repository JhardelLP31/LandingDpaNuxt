<script setup lang="ts">
import { ref, onMounted, watch, defineAsyncComponent } from 'vue';
import HttpClient from "@/helpers/http-client";
import { formatImageUrl } from '@/helpers/url';

const ProductCard = defineAsyncComponent(() => import('@/components/ui/ProductCard2.vue'));

interface Course {
    id: number;
    title: string;
    subtitle: string;
    link: string;
    image: string;
    categoryName?: string;
    categoryColor?: string;
    image_url?: string;
    image_path?: string;
    startDate?: string;
    modality?: string;
    duration?: string;
    status_course?: string;
    teacher?: { name: string; image: string; };
}

const props = defineProps<{
    title: string;
    limit?: number;
    categoryName?: string; 
    currentCourseTitle?: string; 
}>();

const courses = ref<Course[]>([]); 
const loading = ref(true);

const loadRelatedCourses = async () => {
    loading.value = true;
    try {
        // Pedimos una lista para filtrar (puedes aumentar el limit si tienes muchas categorías)
        const response = await HttpClient.get(`courses-list2?limit=15`); 
        const rawData = response.data.data || response.data;

        // Mapeamos y Filtramos por categoría en un solo paso
        courses.value = rawData
            .map((item: any) => {
                const detailBlock = item.content_blocks?.find((b: any) => b.type === 'CourseDetailBlock');
                const content = detailBlock ? detailBlock.content : {};
                const mainTeacher = (content.teachers?.length > 0) ? content.teachers[0] : null;

                return {
                    id: item.id,
                    title: `${item.subtitle} en Especialización de ${item.title}`,
                    modality: item.modality,
                    link: `/programas/${item.slug}`,
                    image: item.image_url || item.image_path,
                    image_path:  item.image_path,
                    categoryName: content.category || 'General',
                    categoryColor: item.category?.color || '#e31140', 
                    startDate: content.startDate || item.start_date,
                    duration: content.duration || 'Por definir',
                    status_course: item.status_course || 'EN VENTA',
                    teacher: mainTeacher ? {
                        name: mainTeacher.name,
                        image: formatImageUrl(mainTeacher.image) 
                    } : undefined
                };
            })
            .filter((course: Course) => {
                // REGLA 1: Que coincida la categoría
                const isSameCategory = course.categoryName === props.categoryName;
                
                // REGLA 2: Que el título NO sea igual al que estamos viendo
                // Usamos trim() para evitar errores por espacios en blanco
                const isNotCurrent = course.title?.trim() !== props.currentCourseTitle?.trim();
                
                return isSameCategory && isNotCurrent;
            })
            .slice(0, props.limit || 3);

    } catch (e) {
        console.error("❌ Error en Vertical List:", e);
    } finally {
        loading.value = false;
    }
};

onMounted(loadRelatedCourses);

// Vigila si cambia la categoría para recargar
watch(() => props.categoryName, () => {
    loadRelatedCourses();
});
</script>

<template>
  <div class="vertical-recommendations mt-5">
    
    <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
      <div class="d-flex align-items-center">
        <div class="accent-line"></div>
        <h2 class="section-title-mini">
          {{ title }}
        </h2>
      </div>
      <router-link to="/programas" class="view-all-text">
        VER TODOS
      </router-link>
    </div>

    <div v-if="loading" class="d-flex justify-content-center py-4">
      <div class="spinner-border spinner-border-sm text-danger" role="status"></div>
    </div>

    <div v-else class="vertical-list">
      <div v-for="course in courses" :key="course.id" class="mb-3">
        <ProductCard :data="course" class="sidebar-variant" />
      </div>

      <div v-if="courses.length === 0" class="text-center text-muted py-3">
          <small><i class="las la-info-circle me-1"></i> No se encontraron cursos similares</small>
      </div>
    </div>

  </div>
</template>

<style scoped lang="scss">
.vertical-recommendations {
  background: transparent;
}

.accent-line {
  width: 4px;
  height: 22px;
  background-color: #e31140;
  margin-right: 12px;
  border-radius: 2px;
}

.section-title-mini {
  color: #1a1a1a;
  font-weight: 800;
  font-size: 1rem;
  margin-bottom: 0;
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.view-all-text {
  font-size: 0.7rem;
  font-weight: 700;
  color: #6c757d;
  text-decoration: none;
  transition: color 0.2s;
  
  &:hover {
    color: #e31140;
  }
}

.vertical-list {
  display: flex;
  flex-direction: column;
}

/* ESTILOS DE ADAPTACIÓN PARA EL SIDEBAR 
   Asegura que el ProductCard no se vea gigante 
*/
:deep(.sidebar-variant) {
  .card {
    border: 1px solid #edf2f7;
    box-shadow: 0 2px 4px rgba(0,0,0,0.02) !important;
    transition: transform 0.2s ease, box-shadow 0.2s ease;

    &:hover {
      transform: translateX(5px);
      box-shadow: 0 4px 12px rgba(0,0,0,0.08) !important;
      border-color: #e3114033;
    }
  }

  // Ajuste de proporciones para espacio reducido
  .card-img-top {
    height: 130px; 
  }

  .card-body {
    padding: 1rem;
  }

  .course-title {
    font-size: 0.95rem !important;
    line-height: 1.3;
  }
}
</style>