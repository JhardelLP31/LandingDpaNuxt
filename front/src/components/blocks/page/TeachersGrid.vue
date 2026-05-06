<template>
  <section v-if="data.items && data.items.length > 0" class="teachers-section py-5 bg-white">
    <div class="container">
      
      <div class="text-start mb-5">
        <!--<h2 class="fw-bold display-6">{{ data.title || 'Nuestros Docentes' }}</h2>-->
         <h2 style="color: #e31140;" class="text-uppercase fw-bold mb-0 ps-3 border-start border-4 border-danger display-6">
          {{ data.title || 'Nuestros Docentes' }}
        </h2>
        <!--<div class="bg-danger mx-auto mt-3 rounded" style="width: 60px; height: 4px;"></div>-->
      </div>

      <div class="row g-4 justify-content-center">
        <div v-for="(teacher, index) in data.items" :key="index" class="col-sm-6 col-lg-3">
          
          <div class="teacher-card text-center p-4 border-0 shadow-sm rounded-3 h-100 bg-white position-relative hover-top">
            
            <div class="avatar-wrapper mx-auto mb-3 p-1 border border-2 border-light rounded-circle" style="width: 120px; height: 120px;">
              <!---<img 
                :src="teacher.image || 'https://ui-avatars.com/api/?background=random&name=' + teacher.name" 
                :alt="teacher.name"
                class="w-100 h-100 rounded-circle object-fit-cover"
                loading="lazy"
              >-->
              <img 
                :src="teacher.image ? formatImageUrl(teacher.image) : 'https://ui-avatars.com/api/?background=random&name=' + teacher.name"
                :alt="teacher.name"
                class="w-100 h-100 rounded-circle object-fit-cover"
                loading="lazy">
            </div>
            
            <h5 class="fw-bold mb-1 text-danger">{{ teacher.name }}</h5>
            <p class="text-danger small fw-bold text-uppercase mb-3">{{ teacher.role }}</p>
            
            <p v-if="teacher.bio" class="text-muted small fst-italic line-clamp-3">
                {{ teacher.bio }}
            </p>

          </div>

        </div>
      </div>

    </div>
  </section>
</template>

<script setup lang="ts">

import { formatImageUrl } from '@/helpers/url';
//IMPORTAR EN TODOS ESAN LINEAS
/*
import { formatImageUrl } from '@/helpers/url';

<img 
    :src="teacher.image ? formatImageUrl(teacher.image) : 'https://ui-avatars.com/api/?background=random&name=' + teacher.name"
    :alt="teacher.name"
    class="w-100 h-100 rounded-circle object-fit-cover"
    loading="lazy"
>
*/

defineProps<{
  data: {
    title: string;
    items: {
      name: string;
      role?: string;
      image?: string;
      bio?: string;
    }[];
  }
}>();
</script>

<style scoped>
.hover-top {
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.hover-top:hover {
    transform: translateY(-5px);
    box-shadow: 0 1rem 3rem rgba(0,0,0,.15)!important;
}
.object-fit-cover {
    object-fit: cover;
}
.line-clamp-3 {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>