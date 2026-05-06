<template>
  <div class="course-detail-block col-lg-8 mx-auto ">
    
    <div class="mb-4">
      <span class="badge-category p-1 px-2 rounded-1">
        {{ data.category || 'Categoría' }}
      </span>
      
      <div class="mt-3">
        <h5 class="text-muted text-uppercase small mb-1">{{ data.subtitle || 'Curso de Especialización en' }}</h5>
        <h2 style="color: #e31140;" class="fw-bold display-6">{{ data.title }}</h2>
      </div>
    </div>

    <div class="card card-detail-v2 border-0 shadow-sm mb-5">
      <div class="card-body">
        <div class="row text-center text-md-start">
          
          <div class="col-6 col-md-3 mb-3 mb-md-0 border-end-md">
            <div class="text-muted small mb-1"><i class="fa fa-calendar-o text-info me-1"></i> Inicio</div>
            <div class="fw-bold">{{ data.startDate }}</div>
          </div>

          <div class="col-6 col-md-3 mb-3 mb-md-0 border-end-md">
            <div class="text-muted small mb-1"><i class="fa fa-clock-o text-info me-1"></i> Duración</div>
            <div class="fw-bold">{{ data.duration }}</div>
          </div>

          <div class="col-6 col-md-3 border-end-md">
            <div class="text-muted small mb-1"><i class="fa fa-calendar-check-o text-info me-1"></i> Horario</div>
            <div class="fw-bold lh-sm text-pre-wrap">{{ data.schedule }}</div>
          </div>

          <div class="col-6 col-md-3">
            <div class="text-muted small mb-1"><i class="fa fa-whatsapp text-success me-1"></i> Contacto</div>
               <strong>Contáctanos</strong><br>

            <a :href="`https://wa.me/${data.whatsappNumber}?text=Hola, deseo info sobre: ${data.title}`" 
               target="_blank" 
               class="fw-bold text-success text-decoration-none hover-underline">
               {{ data.whatsappNumber }}
            </a>
            <div class="small">{{ data.whatsappDisplay }}</div>
          </div>

        </div>
      </div>
    </div>

    <ul class="nav nav-tabs course-details__tab-navs border-bottom-0 mb-4">
      <li class="nav-item" v-for="tab in tabs" :key="tab.id">
        <button 
          class="nav-link border-0 fw-bold px-4 py-2" 
          :class="{ 'active border-bottom border-3 border-info text-info': activeTab === tab.id, 'text-muted': activeTab !== tab.id }"
          @click="activeTab = tab.id"
        >
          {{ tab.label }}
        </button>
      </li>
    </ul>

    <div class="tab-content course-details__tab-content p-3 bg-white rounded shadow-sm border">
      
      <div v-if="activeTab === 'overview'" class="animate__animated animate__fadeIn">
        <div v-html="data.presentation" class="mb-4 text-justify"></div>
        
        <h5 class="fw-bold text-black mb-3">Objetivos</h5>
        <ul class="custom-list mb-4">
          <li v-for="(obj, i) in data.objectives" :key="i">{{ obj }}</li>
        </ul>

        <h5 class="fw-bold text-black mb-3">Perfil del Participante</h5>
        <ul class="custom-list mb-4">
          <li v-for="(profile, i) in data.profile" :key="i">{{ profile }}</li>
        </ul>

        <h5 class="fw-bold text-black mb-3">Certificación</h5>
        <p class="text-justify">{{ data.certification }}</p>
      </div>

      <div v-if="activeTab === 'curriculum'" class="animate__animated animate__fadeIn">
        <div class="accordion" id="accordionTopic">
          <div class="card border mb-2">
            <div class="card-header bg-white border-0" id="headingOne">
              <h2 class="mb-0">
                <button class="btn btn-link btn-block text-black text-left font-weight-bold text-decoration-none" type="button">
                  Temario Detallado:
                </button>
              </h2>
            </div>
            <div class="collapse show">
              <div class="card-body">
                <ul class="custom-list">
                  <li v-for="(topic, i) in data.curriculum" :key="i">{{ topic }}</li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div v-if="activeTab === 'review'" class="animate__animated animate__fadeIn">
        <ul class="list-group list-group-flush">
          <li v-for="(teacher, index) in data.teachers" :key="index" class="list-group-item border-0 px-0">
            <div class="d-flex mt-3 align-items-start">
              <div class="me-3">
                <img :src="teacher.image || 'https://ui-avatars.com/api/?name='+teacher.name" class="teacher-photo rounded-circle shadow-sm" width="80" height="80">
              </div>
              <div class="flex-grow-1">
                <h5 class="fw-bold mb-1">{{ teacher.name }}</h5>
                <div class="mb-2">
                  <span class="flag-icon" :class="'flag-icon-' + (teacher.countryCode || 'pe')"></span>
                  <span class="ms-2 small text-muted">{{ teacher.countryName || 'Perú' }}</span>
                </div>
                <div class="fw-bold text-primary small mb-2">{{ teacher.role }}</div>
                <p class="text-muted small text-justify m-0">{{ teacher.bio }}</p>
              </div>
            </div>
          </li>
        </ul>
      </div>

      <div v-if="activeTab === 'beneficios'" class="animate__animated animate__fadeIn">
        <div v-if="data.benefits && data.benefits.length > 0">
             <ul class="custom-list">
                <li v-for="(ben, i) in data.benefits" :key="i">{{ ben }}</li>
             </ul>
        </div>
        <div v-else class="text-muted text-center py-4">
            Información de beneficios no disponible.
        </div>
      </div>

    </div>

    <div class="mt-5 p-4 bg-light rounded border-start border-4 border-warning">
      <h5 class="fw-bold mb-3"><i class="fa fa-info-circle text-warning me-2"></i> Importante</h5>
      <ul class="small text-muted mb-0 ps-3">
        <li v-for="(note, i) in data.importantNotes" :key="i" class="mb-1">{{ note }}</li>
      </ul>
    </div>

  </div>
</template>

<script setup lang="ts">
import { ref } from 'vue';

// Definición de Tipos para TypeScript (Seguridad)
interface Teacher {
  name: string;
  image?: string;
  countryCode?: string; // 'pe', 'co', etc.
  countryName?: string;
  role: string;
  bio: string;
}

interface CourseData {
  category: string;
  subtitle?: string;
  title: string;
  startDate: string;
  duration: string;
  schedule: string;
  whatsappNumber: string;
  whatsappDisplay: string;
  presentation: string; // HTML string
  objectives: string[];
  profile: string[];
  certification: string;
  curriculum: string[];
  teachers: Teacher[];
  benefits?: string[];
  importantNotes: string[];
}

// Props
defineProps<{
  data: CourseData;
}>();

// Lógica de Tabs (Sin jQuery)
const activeTab = ref('overview');

const tabs = [
  { id: 'overview', label: 'Presentación' },
  { id: 'curriculum', label: 'Plan de estudios' },
  { id: 'review', label: 'Docentes' },
  { id: 'beneficios', label: 'Beneficios' }
];
</script>

<style scoped lang="scss">
/* Estilos extraídos y limpiados */
.badge-category {
  background-color: #01828f;
  text-transform: uppercase;
  font-size: 0.85rem;
  font-weight: 600;
  color: white;
  display: inline-block;
}

.text-pre-wrap {
  white-space: pre-wrap; /* Permite saltos de línea en el horario */
}

.text-justify {
  text-align: justify;
}

/* Tabs personalizadas */
.nav-link {
  color: #6c757d;
  background: transparent;
  transition: all 0.3s;
  cursor: pointer;
  
  &:hover {
    color: #01828f;
  }
  
  &.active {
    background: transparent;
    color: #01828f !important;
    border-bottom: 3px solid #01828f !important;
  }
}

/* Listas personalizadas */
.custom-list {
  list-style: none;
  padding-left: 0;
  
  li {
    position: relative;
    padding-left: 1.5rem;
    margin-bottom: 0.5rem;
    text-align: justify;
    
    &::before {
      content: "•";
      color: #01828f;
      font-weight: bold;
      position: absolute;
      left: 0;
      top: 0;
    }
  }
}

.teacher-photo {
  object-fit: cover;
  border: 2px solid #fff;
}

/* Media Queries para responsividad */
@media (min-width: 768px) {
  .border-end-md {
    border-right: 1px solid #dee2e6;
  }
}

.hover-underline:hover {
    text-decoration: underline !important;
}
</style>