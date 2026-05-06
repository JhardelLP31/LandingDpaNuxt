<script setup lang="ts">
import { formatImageUrl } from '@/helpers/url';

interface AboutData {
  title?: string;
  subtitle?: string;
  content?: string;
  image?: string;
  yearsExperience?: string;
  features?: string[];
}

defineProps<{
  data: AboutData;
}>();
</script>

<template>
  <div v-if="data" class="about-company section-spacing py-5 position-relative overflow-hidden">
    
    <div class="container position-relative">
      <div class="row align-items-center gy-5">
        
        <div class="col-lg-6 col-12">
            <div class="image-wrapper pe-lg-5">
                <div class="image-box position-relative">
                    
                    <img 
                      v-if="data.image"
                      :src="formatImageUrl(data.image)" 
                      alt="Nuestra Historia"
                      class="img-fluid rounded-4 shadow-lg w-100 main-image"
                    >
                    
                    <div v-else class="placeholder-image bg-light d-flex align-items-center justify-content-center text-muted rounded-4 shadow-sm border">
                       <div class="text-center">
                           <i class="las la-image display-1 opacity-25 mb-2"></i>
                       </div>
                    </div>

                    <div v-if="data.yearsExperience" class="experience-badge shadow">
                        <span class="year fw-bold">{{ data.yearsExperience }}</span>
                        <span class="text text-uppercase">Años de<br>Experiencia</span>
                    </div>

                </div>
                <div class="shape-dotted"></div>
            </div>
        </div>

        <div class="col-lg-6 col-12">
          <div class="text-content ps-lg-2">
            
            <div class="theme-title-one">
                <span v-if="data.subtitle" class="sub-title text-uppercase mb-2 d-block fw-bold">
                    {{ data.subtitle }}
                </span>

                <h2 v-if="data.title" class="section-title mb-4 text-uppercase fw-bold display-6">
                  {{ data.title }}
                </h2>
            </div>
              
            <div
              v-if="data.content"
              class="content-body text-muted mb-4"
              v-html="data.content"
            ></div>

            <div v-if="data.features && data.features.length > 0" class="features-grid row mt-4">
                <div v-for="(item, index) in data.features" :key="index" class="col-md-6 mb-3">
                    <div class="d-flex align-items-center feature-item">
                        <div class="icon-check me-3 flex-shrink-0">
                            <i class="las la-check"></i>
                        </div>
                        <span class="fw-semibold text-dark">{{ item }}</span>
                    </div>
                </div>
            </div>

          </div> 
        </div>

      </div> 
    </div> 
  </div>
</template>

<style scoped>
/* VARIABLES */
:root {
    --brand-color: #e31140; 
}

/* --- TÍTULOS --- */
.sub-title {
    color: #e31140;
    letter-spacing: 1px;
    font-size: 0.9rem;
}

.section-title {
    color: #e31140;
    position: relative;
    text-align: left; 
}

.section-title::after {
    content: '';
    display: block;
    width: 60px;
    height: 4px;
    background-color: #e31140;
    margin: 15px 0 0 0;
    border-radius: 2px;
}

/* --- IMAGEN --- */
.image-wrapper {
    position: relative;
    z-index: 1;
}

.main-image {
    object-fit: cover;
    min-height: 400px; 
    transition: transform 0.3s ease;
}

/* Estilo del recuadro gris cuando no hay foto */
.placeholder-image {
    height: 400px;
    width: 100%;
    border: 1px dashed #ced4da !important; 
    background-color: #f8f9fa;
}

.image-wrapper:hover .main-image {
    transform: translateY(-5px);
}

/* Badge Flotante */
.experience-badge {
    position: absolute;
    bottom: 40px;
    left: -30px; 
    background: #e31140;
    color: #fff;
    padding: 20px 30px;
    border-radius: 12px;
    display: flex;
    align-items: center;
    gap: 15px;
    z-index: 2;
}

.experience-badge .year {
    font-size: 3rem; 
    line-height: 1;
}

.experience-badge .text {
    font-size: 0.85rem;
    line-height: 1.2;
    letter-spacing: 0.5px;
    font-weight: 500;
}

.shape-dotted {
    position: absolute;
    top: -30px;
    right: 20px;
    width: 180px;
    height: 180px;
    background-image: radial-gradient(#e31140 2px, transparent 2px);
    background-size: 24px 24px;
    opacity: 0.2;
    z-index: -1;
}

/* --- TEXTO Y FEATURES --- */
.content-body {
    text-align: left; 
    font-size: 1.05rem;
    line-height: 1.8;
}

.icon-check {
    width: 32px;
    height: 32px;
    background-color: rgba(227, 17, 64, 0.1);
    color: #e31140;
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 1.1rem;
}

/* RESPONSIVE */
@media (max-width: 991px) {
    .experience-badge {
        left: 20px;
        bottom: -20px;
        padding: 15px 20px;
    }
    .experience-badge .year { font-size: 2rem; }
    
    .image-wrapper {
        padding-right: 0;
        margin-bottom: 50px; 
    }
    
    .section-title { font-size: 2rem; }
}
</style>