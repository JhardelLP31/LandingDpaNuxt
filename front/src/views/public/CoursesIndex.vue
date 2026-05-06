<template>
    <div class="bg-primary py-5 text-white text-center">
      <h1 class="fw-bold display-5">Nuestros Programas</h1>
      <p class="lead opacity-75">Especialízate con los mejores profesionales</p>
    </div>

    <div class="container py-5">
      <div v-if="loading" class="text-center py-5">
        <div class="spinner-border text-primary"></div>
      </div>

      <div v-else class="row g-4">
        <div v-for="(course, index) in courses" :key="index" class="col-md-6 col-lg-4">
          <CourseMiniCard :data="course" />
        </div>
      </div>

      <div v-if="!loading && courses.length === 0" class="text-center py-5 text-muted">
        <h4>No hay programas publicados aún.</h4>
      </div>
    </div>
</template>

<script setup lang="ts">
import { ref, onMounted } from 'vue';
import HttpClient from "@/helpers/http-client";
import PublicLayout from "@/layouts/PublicLayout.vue";
import CourseMiniCard from '@/components/ui/CourseMiniCard.vue';

const courses = ref([]);
const loading = ref(true);

onMounted(async () => {
  try {
    // Llamamos al endpoint ligero que creamos
    const { data } = await HttpClient.get('courses-list');
    courses.value = data;
  } catch (e) {
    console.error(e);
  } finally {
    loading.value = false;
  }
});
</script>