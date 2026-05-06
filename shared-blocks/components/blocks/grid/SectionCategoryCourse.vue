<template>
  <section class="py-5 bg-white">
    <div class="container">
      
      <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
        <h2 
          :style="{ 
             color: categoryColor, 
             borderColor: categoryColor + ' !important' 
          }" 
          class="text-uppercase fw-bold mb-0 ps-3 border-start border-4 display-6"
        >
          {{ categoryName || 'Cargando...' }}
        </h2>

        <router-link to="/programas" class="btn btn-sm btn-outline-primary fw-bold rounded-pill px-4">
            Ver Todos <i class="las la-arrow-right"></i>
        </router-link>
      </div>

      <div v-if="loading" class="text-center py-5">
        <div class="spinner-border text-primary"></div>
      </div>

      <div v-else class="row g-4">
        
        <div v-for="course in courses" :key="course.id" class="col-md-6 col-lg-4">
          <ProductCard :data="course" />
        </div>
        
        <div v-if="courses.length === 0" class="col-12 text-center text-muted py-5">
            <i class="las la-box-open fs-1 mb-2"></i>
            <p>No hay programas publicados en la categoría <strong>{{ categoryName }}</strong> aún.</p>
        </div>

      </div>

    </div>
  </section>
</template>

<script setup lang="ts">
import { ref, watch, defineAsyncComponent } from 'vue';
import { useRoute } from 'vue-router'; 
import HttpClient from "@/helpers/http-client";
import { formatImageUrl } from '@/helpers/url'; 


// Importación Asíncrona de la Tarjeta
const ProductCard = defineAsyncComponent(() => import('@/components/ui/ProductCard2.vue'));

// Definición de Tipos
interface Course {
    id: number;
    title: string;
    link: string;
    image_path: string;
    status_label?: string; 
    categoryName?: string;
    categoryColor?: string;
    startDate?: string;
    duration?: string;
    teacher?: {
        name: string;
        image: string;
    };
}

// ESTADO
const route = useRoute();
const courses = ref<Course[]>([]);
const categoryName = ref(''); 
const categoryColor = ref('#e31140'); // Color por defecto (Rojo)
const loading = ref(true);

// LÓGICA PRINCIPAL DE CARGA
const fetchCategoryData = async (slug: string) => {
  window.scrollTo(0, 0); 
  loading.value = true;
  courses.value = []; // Limpiamos la vista anterior
  
  try {
    const response = await HttpClient.get(`courses/category/${slug}`);
    const responseData = response.data;

    if (responseData.category) {
        categoryName.value = responseData.category.name;
        categoryColor.value = responseData.category.color || '#e31140'; 
    }

    const rawData = responseData.courses.data || responseData.courses;

    courses.value = rawData.map((item: any) => {
        
        // Buscamos el bloque de detalle dentro del JSON content_blocks
        const detailBlock = item.content_blocks?.find((b: any) => b.type === 'CourseDetailBlock');
        const content = detailBlock ? detailBlock.content : {};
        
        // Extraemos el primer profesor si existe
        const mainTeacher = (content.teachers && content.teachers.length > 0) 
                            ? content.teachers[0] 
                            : null;

        return {
            id: item.id,
            title: content.title || item.title,
            link: `/programas/${item.slug}`,
            image_path: item.image_path || item.image_url,            
            
            // Usamos el nombre de la categoría que viene en el bloque o el de la API
            categoryName: content.category || categoryName.value, 
            
            // Pasamos el color que obtuvimos de la categoría principal
            categoryColor: categoryColor.value, 
            
            startDate: content.startDate || item.start_date,
            duration: content.duration || 'Por definir',
            status_label: item.status === 'published' ? 'EN VENTA' : 'BORRADOR',
            
            teacher: mainTeacher ? {
                name: mainTeacher.name,
                image: formatImageUrl(mainTeacher.image) 
            } : undefined
        };
    });

  } catch (e) {
    console.error("Error cargando categoría:", e);
    categoryName.value = 'No encontrada';
  } finally {
    loading.value = false;
  }
};

// OBSERVADOR DE URL (WATCH)
watch(
  () => route.params.slug,
  (newSlug) => {
    if (newSlug) {
      // 1. Subir al top inmediatamente al detectar el cambio de slug
      window.scrollTo({
        top: 0,
        behavior: 'smooth' // O 'auto' si quieres que sea instantáneo
      });

      // 2. Cargar los datos
      fetchCategoryData(newSlug as string);
    }
  },
  { immediate: true }
);

</script>