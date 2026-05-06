<template>
  <section class="py-5 bg-white">
    <div class="container">
      <div class="section-header mb-5">
        <h2 style="color: #e31140;" class="text-uppercase fw-bold mb-0 ps-3 border-start border-4 border-danger display-6">
          {{ data.title }}
        </h2>
      </div>

      <div class="row g-4">
        <div v-for="(item, index) in data.items" :key="index" class="col-md-6 col-lg-3">
          
          <ProgramCard 
            :title="item.title"
            :description="item.description"
            :image="item.image"
            :link="item.link || '#'" 
          />x 

        </div>
      </div>
    </div>
  </section>
</template>

<script setup lang="ts">
import ProgramCard from '@/components/ui/ProgramCard.vue';

defineProps<{
  data: {
    title: string;
    items: {
      title: string;
      description: string;
      image: string;
      link?: string; // <--- Definimos que puede venir un link
    }[];
  }
}>()
</script>