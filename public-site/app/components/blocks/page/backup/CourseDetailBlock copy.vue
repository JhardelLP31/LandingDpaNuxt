<script setup lang="ts">
import { ref } from 'vue';
// Mantenemos tu helper de imágenes intacto
import { formatImageUrl } from '@/helpers/url';

// --- TUS INTERFACES Y PROPS ORIGINALES ---
interface Teacher {
  name: string;
  image?: string;
  countryCode?: string;
  countryName?: string;
  role: string;
  bio: string;
}

interface CourseData {
  category: string;
  categoryColor:string;
  subtitle?: string;
  title: string;
  startDate: string;
  duration: string;
  schedule: string;
  whatsappNumber: string;
  whatsappDisplay: string;
  presentation: string;
  objectives: string[];
  profile: string[];
  certification: string;
  curriculum: string[];
  teachers: Teacher[];
  benefits?: string[];
  importantNotes: string[];
  price?: number;
}

defineProps<{
  data: CourseData;
}>();

const activeTab = ref('overview');

const tabs = [
  { id: 'overview', label: 'Presentación' },
  { id: 'curriculum', label: 'Plan de estudios' },
  { id: 'review', label: 'Docentes' },
  { id: 'beneficios', label: 'Beneficios' }
];
</script>

<template>
  <section class="course-section-final">
    <div class="container py-5">
      <div class="row gx-5">

        <div class="col-lg-8">

          <div class="mb-5">
            <span :style="{ backgroundColor: data.categoryColor }" class="category-badge mb-3">
              {{ data.category || 'PROGRAMA' }}
            </span>
            <h1 class="course-title">
              {{ data.title || 'Título del Curso' }}
            </h1>
          </div>

          <div class="info-bar mb-5">
            <div class="row g-0">
              
              <div class="col-6 col-md-3 info-item">
                <div class="icon-circle">
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                </div>
                <div class="info-text">
                  <span class="label">INICIO</span>
                  <span class="value">{{ data.startDate || 'Por definir' }}</span>
                </div>
              </div>

              <div class="col-6 col-md-3 info-item">
                <div class="icon-circle">
                  <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                </div>
                <div class="info-text">
                  <span class="label">DURACIÓN</span>
                  <span class="value">{{ data.duration || '--' }}</span>
                </div>
              </div>

              <div class="col-6 col-md-3 info-item">
                <div class="icon-circle">
                   <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><path d="M16 2v4M8 2v4M3 10h18"></path></svg>
                </div>
                <div class="info-text">
                  <span class="label">HORARIO</span>
                  <span class="value truncate">{{ data.schedule || 'Ver detalle' }}</span>
                </div>
              </div>

               <div class="col-6 col-md-3 info-item">
                <div class="icon-circle contact">
                   <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>
                </div>
                <div class="info-text">
                  <span class="label">CONTACTO</span>
                  <a :href="`https://wa.me/${data.whatsappNumber}`" target="_blank" class="value link-contact">
                    {{ data.whatsappNumber || 'Consultar' }}
                  </a>
                </div>
              </div>

            </div>
          </div>

          <div class="tabs-wrapper mb-4">
             <div class="d-flex gap-2 flex-wrap">
                <button 
                  v-for="tab in tabs" 
                  :key="tab.id"
                  class="btn-tab"
                  :class="{ active: activeTab === tab.id }"
                  @click="activeTab = tab.id"
                >
                  {{ tab.label }}
                </button>
             </div>
          </div>

          <div class="tab-body">
             <transition name="fade" mode="out-in">
                
                <div v-if="activeTab === 'overview'" key="overview">
                   <div class="text-content mb-5" v-html="data.presentation"></div>
                   
                   <h5 class="section-heading">Objetivos</h5>
                   <ul class="styled-list mb-5">
                      <li v-for="(obj, i) in data.objectives" :key="i">{{ obj }}</li>
                   </ul>

                   <h5 class="section-heading">Perfil del participante</h5>
                   <ul class="styled-list mb-5">
                      <li v-for="(prof, i) in data.profile" :key="i">{{ prof }}</li>
                   </ul>

                   <div class="cert-box">
                      <h6 class="fw-bold mb-2">Certificación</h6>
                      <p class="mb-0 text-muted small">{{ data.certification }}</p>
                   </div>
                </div>

                <div v-else-if="activeTab === 'curriculum'" key="curriculum">
                   <div class="timeline">
                      <div class="timeline-item" v-for="(topic, i) in data.curriculum" :key="i">
                         <span class="timeline-num">{{ i + 1 }}</span>
                         <p class="timeline-text">{{ topic }}</p>
                      </div>
                   </div>
                </div>

                <div v-else-if="activeTab === 'review'" key="review">
                   <div class="d-flex flex-column gap-4">
                      <div class="teacher-card" v-for="(teacher, i) in data.teachers" :key="i">
                         <img :src="formatImageUrl(teacher.image)" class="teacher-avatar" alt="Docente">
                         <div class="teacher-info">
                            <h5 class="teacher-name">{{ teacher.name }}</h5>
                            <span class="teacher-role">{{ teacher.role }}</span>
                            <p class="teacher-bio">{{ teacher.bio }}</p>
                         </div>
                      </div>
                   </div>
                </div>

                <div v-else-if="activeTab === 'beneficios'" key="beneficios">
                   <div class="row g-3">
                      <div class="col-md-6" v-for="(ben, i) in data.benefits" :key="i">
                         <div class="benefit-item">
                            <span class="check-icon">✓</span> {{ ben }}
                         </div>
                      </div>
                   </div>
                </div>

             </transition>
          </div>
           <div class="important-box mt-4" v-if="data.importantNotes && data.importantNotes.length > 0">
                <div class="warning-icon-wrapper">
                  <span class="warning-symbol">⚠</span>
                </div>
                <div class="warning-content">
                  <ul class="warning-list">
                     <li v-for="(note, i) in data.importantNotes" :key="i">{{ note }}</li>
                  </ul>
                </div>
             </div>
        </div>
        
        <div class="col-lg-4">
          <div class="sticky-wrapper">
             
             <div class="sidebar-card shadow-clean">
                <div class="card-top-accent"></div>
                
                <div class="card-content text-center">
                   <span class="label-investment">INVERSIÓN TOTAL</span>
                   
                   <h2 class="price-big" v-if="data.price">
                      <span class="currency">S/</span>{{ data.price }}<span class="decimals"></span>
                   </h2>
                   <h2 class="price-big" v-else>Consultar</h2>

                   <div class="divider-line"></div>

                   <p class="promo-text">
                      Matricúlate ahora y accede a beneficios exclusivos para estudiantes.
                   </p>

                   <a :href="`https://wa.me/${data.whatsappNumber}`" target="_blank" class="btn-whatsapp-solid">
                      <svg width="24" height="24" viewBox="0 0 24 24" fill="currentColor" class="me-2"><path d="M20 2H4c-1.1 0-2 .9-2 2v18l4-4h14c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2z"></path></svg>
                      <div>
                        <span class="d-block lh-1 small">SOLICITAR</span>
                        <span class="d-block lh-1 fw-bold">INFORMACIÓN</span>
                      </div>
                   </a>
                   
                   <div class="status-indicator">
                      <span class="dot"></span> Respuesta inmediata
                   </div>
                </div>
             </div>

              <!--<div class="important-box mt-4" v-if="data.importantNotes && data.importantNotes.length > 0">
                <div class="warning-icon-wrapper">
                  <span class="warning-symbol">⚠</span>
                </div>
                <div class="warning-content">
                  <ul class="warning-list">
                     <li v-for="(note, i) in data.importantNotes" :key="i">{{ note }}</li>
                  </ul>
                </div>
             </div>-->

          </div>
        </div>

      </div>
    </div>
  </section>
</template>

<style scoped>
/* FUENTE Y VARIABLES */
@import url('https://fonts.googleapis.com/css2?family=Inter:wght@400;600;800&display=swap');

.course-section-final {
  background-color: #ffffff;
  font-family: 'Inter', sans-serif;
  color: #1f2937;
  --primary-teal: #008b99; /* El color exacto de tu imagen */
  --primary-dark: #006b75;
  --text-dark: #0f172a;
  --text-gray: #64748b;
  --bg-soft: #f8fafc;
}

/* --- HEADER --- */
.category-badge {
  color: white;
  padding: 4px 10px;
  text-transform: uppercase;
  font-weight: 700;
  font-size: 0.75rem;
  border-radius: 4px;
  display: inline-block;
}

.course-title {
  font-weight: 800;
  font-size: 2.5rem;
  color: var(--text-dark);
  line-height: 1.1;
  /* Efecto sutil de sombra en texto para despegarlo del fondo blanco */
  text-shadow: 2px 2px 0px rgba(0,0,0,0.05); 
}

/* --- INFO BAR --- */
.info-bar {
  background: white;
  border-radius: 12px;
  box-shadow: 0 10px 40px -10px rgba(0,0,0,0.08); /* Sombra difusa "Apple" */
  padding: 20px;
  border: 1px solid #f1f5f9;
}

.info-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  position: relative;
}

/* Líneas separadoras en desktop */
@media (min-width: 768px) {
  .info-item:not(:last-child)::after {
    content: ''; position: absolute; right: 0; top: 10%; height: 80%; width: 1px; background: #e2e8f0;
  }
}

.icon-circle {
  color: var(--primary-teal);
  margin-bottom: 8px;
  width: 24px; height: 24px;
}
.icon-circle.contact { color: var(--primary-teal); }

.info-text .label {
  display: block; font-size: 0.7rem; font-weight: 700; color: #94a3b8; letter-spacing: 0.5px; margin-bottom: 2px;
}
.info-text .value {
  font-weight: 700; color: var(--text-dark); font-size: 0.9rem;
}
/* Estilo para el enlace del teléfono */
.link-contact {
  text-decoration: none; border-bottom: 1px dashed var(--primary-teal); transition: all 0.2s;
}
.link-contact:hover {
  background-color: #ecfdf5; color: #059669; border-bottom-style: solid;
}
.truncate { white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 100%; display: block; }

/* --- TABS --- */
.btn-tab {
  background: #f1f5f9;
  border: none;
  padding: 10px 24px;
  border-radius: 50px;
  font-weight: 600;
  color: var(--text-gray);
  transition: all 0.2s;
}
.btn-tab:hover { background: #e2e8f0; color: var(--text-dark); }
.btn-tab.active {
  background: var(--primary-teal); color: white; box-shadow: 0 4px 10px rgba(0, 139, 153, 0.3);
}

/* --- CONTENIDO TABS --- */
.text-content { line-height: 1.7; color: #334155; }
.section-heading { font-weight: 800; color: var(--text-dark); margin-bottom: 1rem; position: relative; display: inline-block; }
.section-heading::after {
  content: ''; display: block; width: 40px; height: 4px; background: var(--primary-teal); margin-top: 5px; border-radius: 2px;
}

.styled-list { list-style: none; padding: 0; }
.styled-list li {
  position: relative; padding-left: 25px; margin-bottom: 10px; color: #475569;
}
.styled-list li::before {
  content: '•'; color: var(--primary-teal); font-size: 1.5rem; position: absolute; left: 5px; top: -5px;
}

/* Certificacion */
.cert-box {
  background: #f0f9ff; border-left: 4px solid var(--primary-teal); padding: 20px; border-radius: 0 8px 8px 0;
}

/* Timeline Curriculum */
.timeline-item { display: flex; gap: 15px; margin-bottom: 15px; }
.timeline-num {
  background: var(--primary-teal); color: white; width: 28px; height: 28px; border-radius: 50%;
  display: flex; align-items: center; justify-content: center; font-weight: bold; font-size: 0.8rem; flex-shrink: 0;
}
.timeline-text { margin: 0; font-weight: 500; }

/* Docentes */
.teacher-card { display: flex; align-items: flex-start; gap: 20px; padding: 20px; background: #fff; border: 1px solid #e2e8f0; border-radius: 12px; }
.teacher-avatar { width: 70px; height: 70px; border-radius: 50%; object-fit: cover; }
.teacher-name { font-weight: 700; margin-bottom: 2px; }
.teacher-role { font-size: 0.8rem; text-transform: uppercase; color: var(--primary-teal); font-weight: 700; display: block; margin-bottom: 8px; }
.teacher-bio { font-size: 0.9rem; color: var(--text-gray); margin: 0; line-height: 1.5; }

/* Beneficios */
.benefit-item {
  background: white; border: 1px solid #e2e8f0; padding: 15px; border-radius: 8px; font-weight: 500; height: 100%;
}
.check-icon { color: #22c55e; font-weight: bold; margin-right: 8px; }

/* --- SIDEBAR (EL CAMBIO IMPORTANTE) --- */
.sticky-wrapper { position: sticky; top: 20px; }

.sidebar-card {
  background: white;
  border-radius: 20px; /* Bordes muy redondeados como la imagen */
  box-shadow: 0 20px 40px rgba(0,0,0,0.08); /* Sombra suave y profunda */
  overflow: hidden;
  position: relative;
  border: 1px solid #f1f5f9;
}

.card-top-accent {
  height: 6px;
  background: var(--primary-teal); /* La linea superior verde */
  width: 100%;
}

.card-content { padding: 40px 30px; }

.label-investment {
  display: block; font-size: 0.8rem; font-weight: 800; color: #94a3b8; text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 5px;
}

.price-big {
  color: #0f172a; font-weight: 800; font-size: 3.5rem; margin: 0; line-height: 1; letter-spacing: -1px;
}
.currency { font-size: 1.5rem; color: #64748b; vertical-align: top; margin-right: 5px; position: relative; top: 10px; }
.decimals { font-size: 2rem; color: #0f172a; }

.divider-line { height: 1px; background: #e2e8f0; margin: 25px auto; width: 60%; }

.promo-text { font-size: 0.9rem; color: #64748b; margin-bottom: 25px; line-height: 1.4; padding: 0 10px; }

/* Botón WhatsApp Estilo Imagen */
.btn-whatsapp-solid {
  background-color: var(--primary-teal);
  color: white;
  display: flex; align-items: center; justify-content: center;
  padding: 16px;
  border-radius: 12px;
  text-decoration: none;
  transition: transform 0.2s, background 0.2s;
  box-shadow: 0 10px 20px -5px rgba(0, 139, 153, 0.4);
}
.btn-whatsapp-solid:hover {
  background-color: var(--primary-dark);
  transform: translateY(-2px);
  color: white;
}

.status-indicator { margin-top: 20px; font-size: 0.85rem; color: #64748b; display: flex; align-items: center; justify-content: center; gap: 8px; }
.dot { width: 10px; height: 10px; background: #22c55e; border-radius: 50%; box-shadow: 0 0 0 3px #dcfce7; }

/* --- IMPORTANTE BOX (Debajo del sidebar) --- */
.important-box {
  background: #f8fafc; /* Fondo gris/azul muy suave */
  border: 1px solid #f97316; /* Borde naranja igual a la imagen */
  border-radius: 8px;
  padding: 20px;
  display: flex;
  align-items: flex-start;
  gap: 15px;
}

.warning-symbol {
  color: #f97316; font-size: 1.2rem;
}

.warning-list {
  list-style: none; padding: 0; margin: 0; font-size: 0.85rem; color: #64748b;
}
.warning-list li { margin-bottom: 8px; line-height: 1.4; }

/* Transiciones */
.fade-enter-active, .fade-leave-active { transition: opacity 0.2s ease; }
.fade-enter-from, .fade-leave-to { opacity: 0; }
</style>