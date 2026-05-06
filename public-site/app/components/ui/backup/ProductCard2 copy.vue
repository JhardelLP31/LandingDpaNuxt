<template>
  <div class="col-lg-12">
    <div class="item card-product col-product h-100" :id="`itemProduct${data.id}`">
      <div class="course-one__single color-1 h-100 d-flex flex-column">


        <div v-if="data.status_label" class="ecommerce-ribbon-product">
          <div class="ribbon" :class="getRibbonClass(data.status_label)">
            <span>{{ data.status_label }}</span>
          </div>
        </div>
        <div class="course-one__content p-3 flex-grow-1 d-flex flex-column">

          

          <div class="course-one__title mb-3">
            <router-link :to="data.link" class="course-title-link fw-bold text-decoration-none"
              :style="{ color: data.categoryColor || '#01828f' }">
              {{ data.title }}
            </router-link>
          </div>
          <div class="mb-2">
            <span class="badge" :style="`background-color: ${data.categoryColor || '#01828f'}`">
              {{ data.categoryName || 'General' }}
            </span>
          </div>
          <div class="course-one__admin d-flex align-items-center mb-3">
            <img :src="data.teacher?.image || 'https://ui-avatars.com/api/?name=P'" alt="Instructor"
              class="course-teacher-avatar rounded-circle border" style="width: 35px; height: 35px; object-fit: cover;">
            <span class="ms-2 text-muted small">
              {{ data.teacher?.name || 'Instructor' }}
            </span>
          </div>

          <div class="mt-auto border-top pt-2">
            <div class="d-flex justify-content-between text-muted small">
              <div class="text-center text-black">
                <i class="las la-calendar-alt"></i> INICIO
                <span class="d-block">{{ data.startDate || 'Pronto' }}</span>
              </div>
              <div class="text-center text-black">
                <i class="las la-clock"></i> DURACIÓN
                <span class="d-block">{{ data.duration || 'N/A' }}</span>
              </div>
            </div>
          </div>

        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
const props = defineProps<{
  data: {
    id: number;
    title: string;
    // Permitimos string (URL manual) u Object (Nombre de ruta Vue)
    link: string | object;
    image: string;
    status_label?: string;
    startDate?: string;
    duration?: string;
    categoryName?: string;
    categoryColor?: string;
    teacher?: {
      name: string;
      image: string;
    };
  }
}>();

const getRibbonClass = (status?: string) => {
  if (!status) return 'ribbon-gray';
  const s = status.toUpperCase();

  if (['OPEN', 'DISPONIBLE', 'INSCRIPCIONES ABIERTAS', 'EN VENTA'].includes(s)) return 'ribbon-green';
  if (['RESERVADO', 'PREVENTA EXCLUSIVA'].includes(s)) return 'ribbon-yellow';
  if (['AGOTADO', 'CERRADO', 'CLOSED'].includes(s)) return 'ribbon-gray';
  if (['PRÓXIMAMENTE', 'COMING SOON', 'BORRADOR'].includes(s)) return 'ribbon-blue';

  return 'ribbon-red';
};
</script>

<style scoped>
/* Mismos estilos, no toqué nada aquí */
.course-one__single {
  background-color: white;
  box-shadow: 0 4px 15px rgba(0, 0, 0, 0.05);
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  border: 1px solid #f0f0f0;
  position: relative;
  /* Necesario para el ribbon */

}

.course-one__single:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
}

.ecommerce-ribbon-product {
  position: absolute;
  top: -5px;
  left: -5px;
  z-index: 10;
  overflow: hidden;
  width: 100px;
  height: 100px;
}

.ribbon {
  font: bold 10px Sans-Serif;
  color: #fff;
  text-align: center;
  transform: rotate(-45deg);
  position: relative;
  padding: 5px 0;
  top: 15px;
  left: -30px;
  width: 120px;
  box-shadow: 0px 0px 3px rgba(0, 0, 0, 0.3);
  text-transform: uppercase;
}

.ribbon-green {
  background: #198754;
}

.ribbon-yellow {
  background: #ffc107;
  color: #000;
}

.ribbon-blue {
  background: #0dcaf0;
}

.ribbon-gray {
  background: #6c757d;
}

.ribbon-red {
  background: #dc3545;
}

.course-title-link {
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
  overflow: hidden;
  font-size: 14pt;
  line-height: 1.3;
  color: #01828f;
  /* Aseguré el color que tenías antes */
}

.course-title-link:hover {
  color: #016f73;
}
</style>