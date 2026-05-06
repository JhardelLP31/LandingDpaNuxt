<template>
  <div class="col-lg-12">
    <router-link :to="data.link" class="item card-product-wao" :title="data.title">
      <div class="course-one__single-wao">
        
        <div class="tech-grid"></div>

        <div v-if="data.status_course" class="ecommerce-ribbon-wao">
          <div class="ribbon-wao" :class="getNeonClass(data.status_course)">
            <span>{{ data.status_course }}</span>
          </div>
        </div>

        <div class="course-one__content-wao">
          <div class="title-teacher-container">
            <div class="course-one__title-wao">
              <h3 :style="{ '--accent-color': data.categoryColor || '#0f6eb6' }">
                {{ truncateTitle(data.title) }}
              </h3>
            </div>
            
            <div class="course-one__admin-wao">
              <div class="avatar-glow" :style="{ '--glow-color': data.categoryColor || '#0f6eb6' }">
                <img :src="data.teacher?.image || 'https://ui-avatars.com/api/?name=P'" alt="Docente">
              </div>
              <span class="teacher-name">{{ data.teacher?.name || 'Instructor' }}</span>
            </div>
          </div>

          <div class="course-one__category-wao" :style="{ '--bg-cat': data.categoryColor || '#0f6eb6' }">
            {{ data.categoryName || 'General' }}
          </div>

          <div class="course-one__meta-wao">
            <div class="meta-col">
              <div class="meta-label"><i class="las la-terminal"></i> INICIO</div>
              <div class="meta-val">{{ data.startDate || 'Pronto' }}</div>
            </div>
            <div class="meta-col border-start-wao">
              <div class="meta-label"><i class="las la-history"></i> DURACIÓN</div>
              <div class="meta-val">{{ data.duration || 'N/A' }}</div>
            </div>
          </div>
        </div>

        <div class="liquid-flash"></div> 
        <div class="glow-corner"></div> 
      </div>
    </router-link>
  </div>
</template>

<script setup lang="ts">
const props = defineProps<{
  data: {
    id: number;
    title: string;
    link: string | object;
    status_course?: string;
    startDate?: string;
    duration?: string;
    categoryName?: string;
    categoryColor?: string;
    teacher?: { name: string; image: string; };
  }
}>();

const truncateTitle = (text: string) => {
  return text.length > 40 ? text.substring(0, 37) + '...' : text;
};

const getNeonClass = (status?: string) => {
  const s = status?.toUpperCase() || '';
  if (['EN VENTA', 'OPEN'].includes(s)) return 'neon-green';
  if (['PREVENTA'].includes(s)) return 'neon-yellow';
  return 'neon-red';
};
</script>

<style scoped>
.card-product-wao {
  display: block;
  text-decoration: none !important;
  height: 100%;
  perspective: 1200px;
}

.course-one__single-wao {
  background: #ffffff;
  border: 1px solid rgba(15, 110, 182, 0.1);
  border-radius: 20px;
  position: relative;
  overflow: hidden;
  height: 100%;
  transition: all 0.5s cubic-bezier(0.23, 1, 0.32, 1);
  z-index: 1;
}

.tech-grid {
  position: absolute;
  inset: 0;
  background-image: radial-gradient(rgba(15, 110, 182, 0.05) 1px, transparent 1px);
  background-size: 15px 15px;
  opacity: 0.5;
  z-index: -1;
}

/* RIBBON */
.ecommerce-ribbon-wao {
  position: absolute;
  top: 15px;
  right: -5px;
  z-index: 10;
}
.ribbon-wao {
  padding: 4px 15px;
  font-size: 10px;
  font-weight: 900;
  color: #fff;
  border-radius: 4px 0 0 4px;
}
.neon-green { background: #00d26a; box-shadow: 0 0 15px rgba(0,210,106,0.3); }
.neon-yellow { background: #ffb300; box-shadow: 0 0 15px rgba(255,179,0,0.3); }
.neon-red { background: #ff3e3e; box-shadow: 0 0 15px rgba(255,62,62,0.3); }

/* CONTENIDO */
.course-one__content-wao {
  padding: 25px;
  display: flex;
  flex-direction: column;
}

.title-teacher-container {
  height: 165px;
  display: flex;
  flex-direction: column;
}

.course-one__title-wao h3 {
  font-size: 1.2rem;
  font-weight: 800;
  color: #1a1a1a;
  line-height: 1.3;
  margin-bottom: 20px;
  transition: all 0.3s;
}

.course-one__admin-wao {
  display: flex;
  align-items: center;
  gap: 12px;
}
.avatar-glow {
  width: 42px;
  height: 42px;
  border-radius: 50%;
  padding: 2px;
  border: 2px solid var(--glow-color);
  box-shadow: 0 0 10px var(--glow-color);
  transition: all 0.3s;
}
.avatar-glow img {
  width: 100%;
  height: 100%;
  border-radius: 50%;
  object-fit: cover;
}
.teacher-name {
  font-size: 0.9rem;
  font-weight: 600;
  color: #555;
}

.course-one__category-wao {
  background: var(--bg-cat);
  color: #fff;
  padding: 7px 16px;
  border-radius: 10px;
  font-size: 0.8rem;
  font-weight: 700;
  display: inline-block;
  align-self: flex-start;
  margin-bottom: 20px;
}

.course-one__meta-wao {
  display: grid;
  grid-template-columns: 1fr 1fr;
  background: rgba(240, 245, 255, 0.5);
  border-radius: 12px;
  padding: 12px;
  border: 1px solid rgba(15, 110, 182, 0.05);
}
.meta-label {
  font-size: 9px;
  font-weight: 800;
  color: #94a3b8;
  margin-bottom: 4px;
  display: flex;
  align-items: center;
  gap: 5px;
}
.meta-val {
  font-size: 0.85rem;
  font-weight: 700;
  color: #1e293b;
}
.border-start-wao {
  border-left: 1px solid rgba(0,0,0,0.05);
  padding-left: 15px;
}

/* --- NUEVA ANIMACIÓN: LIQUID FLASH --- */
.liquid-flash {
  position: absolute;
  top: 0;
  left: -100%;
  width: 50%;
  height: 100%;
  background: linear-gradient(
    to right,
    transparent,
    rgba(255, 255, 255, 0.4),
    transparent
  );
  transform: skewX(-25deg);
  transition: none;
  z-index: 5;
}

.card-product-wao:hover .liquid-flash {
  animation: flashSweep 0.8s ease-in-out forwards;
}

@keyframes flashSweep {
  0% { left: -100%; }
  100% { left: 200%; }
}

/* Hover Effects generales */
.card-product-wao:hover .course-one__single-wao {
  transform: rotateX(5deg) translateY(-10px);
  box-shadow: 0 25px 50px rgba(0, 0, 0, 0.15);
  border-color: var(--accent-color, #0f6eb6);
}

.card-product-wao:hover .course-one__title-wao h3 {
  color: var(--accent-color);
}

.card-product-wao:hover .avatar-glow {
  transform: scale(1.1) rotate(5deg);
}
</style>