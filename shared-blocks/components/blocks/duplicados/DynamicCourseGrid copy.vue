
<template>
  <section class="py-5 bg-white">
    <div class="container">
      
      <div class="d-flex justify-content-between align-items-center mb-4 border-bottom pb-2">
        <h2 style="color: #e31140;" class="text-uppercase fw-bold mb-0 ps-3 border-start border-4 border-danger display-6">
          {{ data.title }}
        </h2>
        <!--<h2 class="fw-bold text-dark mb-0">{{ data.title || 'Nuestros Cursos' }}</h2>-->
        <router-link to="/cursos" class="btn btn-sm btn-outline-primary fw-bold rounded-pill px-4">
            Ver Todos <i class="las la-arrow-right"></i>
        </router-link>
      </div>

      <div v-if="loading" class="text-center py-5">
        <div class="spinner-border text-primary"></div>
      </div>

      <div v-else class="row g-4">
        <div v-for="course in courses" :key="course.id" class="col-md-6 col-lg-3">
          <ProductCard :data="course" />
        </div>
        
        <div v-if="courses.length === 0" class="col-12 text-center text-muted py-5">
            <i class="las la-box-open fs-1 mb-2"></i>
            <p>No hay cursos publicados aún.</p>
        </div>
      </div>

    </div>
  </section>
</template>
<script setup lang="ts">
import { ref, onMounted, defineAsyncComponent } from 'vue';
import HttpClient from "@/helpers/http-client";
import { formatImageUrl } from '@/helpers/url'; // Tu helper de imágenes

const ProductCard = defineAsyncComponent(() => import('@/components/ui/ProductCard2.vue'));

interface Course {
    id: number;
    title: string;
    link: string;
    image: string;
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

const props = defineProps<{
  data: {
    title: string;
    limit?: number;
  }
}>();

const courses = ref<Course[]>([]); 
const loading = ref(true);

onMounted(async () => {
  try {
    const limit = props.data.limit || 8;
    const response = await HttpClient.get(`courses-list2?limit=${limit}`); 
    const rawData = response.data.data || response.data;

    // AQUI ESTÁ LA LÓGICA CORREGIDA PARA TU JSON
    courses.value = rawData.map((item: any) => {
        
        // 1. Buscamos el bloque "CourseDetailBlock" dentro del array de bloques
        // (Puede que tengas otros bloques, así que buscamos el correcto por type)
        const detailBlock = item.content_blocks?.find((b: any) => b.type === 'CourseDetailBlock');
        
        // 2. Extraemos el contenido (si existe)
        const content = detailBlock ? detailBlock.content : {};

        // 3. Sacamos al primer profesor del array (si existe)
        const mainTeacher = (content.teachers && content.teachers.length > 0) 
                            ? content.teachers[0] 
                            : null;

        return {
            id: item.id,
            
            // Título: Preferimos el del JSON, si no, el de la tabla principal
            title: content.title || item.title,
            
            // Link: Usamos el slug de la tabla principal
            link: `/cursos/${item.slug}`,
            
            // Imagen: La principal suele estar en la tabla (image_path), 
            // pero si quieres una del JSON podrías buscarla ahí.
            image: formatImageUrl(item.image_url || item.image_path),
            
            // Categoría: Ahora la sacamos del JSON ("Salud")
            categoryName: content.category || 'General',
            categoryColor: '#e31140', // Puedes poner un color default o mapearlo
            
            // Fecha: La sacamos del JSON ("2005-12-12")
            startDate: content.startDate || item.start_date,
            
            duration: content.duration || 'Por definir',
            
            status_label: item.status === 'published' ? 'EN VENTA' : 'BORRADOR',

            // Profesor: Mapeamos el primero que encontramos en el JSON
            teacher: mainTeacher ? {
                name: mainTeacher.name,
                // ¡Importante! Usamos tu helper también aquí por si la URL viene sucia
                image: formatImageUrl(mainTeacher.image) 
            } : undefined
        };
    });

  } catch (e) {
    console.error("Error cargando cursos:", e);
  } finally {
    loading.value = false;
  }
});
</script>