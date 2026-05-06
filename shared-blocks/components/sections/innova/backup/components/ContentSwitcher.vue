<script setup lang="ts">
import { ref } from 'vue';

interface Props {
  title: string;
  items?: any[];      // Para el Timeline
  freeHtml?: string;  // Para HTML Libre
  features?: string[]; // Para lista de checks
  type: 'timeline' | 'html' | 'features';
  accentColor: string;
  titleColor: string;
}

const props = defineProps<Props>();
const activeIndex = ref(0);
</script>

<template>
  <div class="text-wrapper">
    <h2 class="tituloPrincipal" :style="{ color: titleColor }">
      {{ title }}
    </h2>

    <div v-if="type === 'timeline'" class="timeline-list">
      <div v-for="(item, index) in items" :key="index" 
           class="node-container" @click="activeIndex = index">
        <h3 :class="['titulo__time', { 'titulo__time--activo': activeIndex === index }]"
            :style="activeIndex === index ? { '--accent-color': accentColor } : {}">
          <span>&nbsp;</span>
          {{ item.label }}
          <transition name="expand">
            <div v-show="activeIndex === index" class="content-detail">
              <div class="html-renderer" v-html="item.content"></div>
            </div>
          </transition>
        </h3>
      </div>
    </div>

    <div v-else-if="type === 'html'" class="free-html-content">
      <div class="html-renderer" v-html="freeHtml"></div>
    </div>

    <div v-else-if="type === 'features'" class="features-list">
      <ul class="clean-list">
        <li v-for="(feat, i) in features" :key="i" class="feature-item">
          <i class="las la-check-circle" :style="{ color: accentColor }"></i>
          {{ feat }}
        </li>
      </ul>
    </div>
  </div>
</template>

<style scoped lang="scss">
// Heredamos tus estilos base para mantener la meta final
.tituloPrincipal {
  text-transform: uppercase;
  font-weight: 800;
  font-size: 2.5rem;
  margin-bottom: 50px;
  position: relative;
  &::after {
    content: ''; display: block; width: 70px; height: 4px; 
    background: currentColor; margin-top: 10px;
  }
}

/* --- ESTILOS TIMELINE --- */
.timeline-list {
  position: relative;
  .titulo__time {
    padding: 0 0 25px 30px; margin-bottom: 0; cursor: pointer; position: relative;
    font-size: 1.1rem; font-weight: 800; color: #333;
    &::before { content: ''; position: absolute; left: 0; top: 0; height: 100%; width: 2px; background: #000; }
    span::before { content: ''; position: absolute; left: -6px; top: 5px; width: 14px; height: 14px; background: #000; border-radius: 50%; z-index: 2; }
    span::after { content: ''; position: absolute; left: -3px; top: 8px; width: 8px; height: 8px; background: #fff; border-radius: 50%; z-index: 3; }
    
    &--activo {
      color: var(--accent-color) !important;
      span::before { width: 18px; height: 18px; background: var(--accent-color); left: -8px; top: 3px; }
      span::after { display: none; }
    }
  }
}

/* --- ESTILOS HTML LIBRE --- */
.free-html-content {
  font-size: 1.05rem;
  line-height: 1.7;
  color: #444;
}

/* --- ESTILOS FEATURES --- */
.features-list {
  .clean-list { list-style: none; padding: 0; }
  .feature-item {
    display: flex; align-items: center; gap: 12px;
    margin-bottom: 15px; font-size: 1.1rem; font-weight: 500;
    i { font-size: 1.4rem; }
  }
}

/* Animaciones */
.expand-enter-active, .expand-leave-active { transition: all 0.4s ease; overflow: hidden; }
.expand-enter-from, .expand-leave-to { opacity: 0; max-height: 0; }
.expand-enter-to, .expand-leave-from { opacity: 1; max-height: 500px; }

:deep(.html-renderer) {
  ul { list-style: none; padding: 0; li { position: relative; padding-left: 20px; margin-bottom: 8px;
  &::before { content: ''; position: absolute; left: 0; top: 8px; width: 5px; height: 5px; background: #58595B; border-radius: 50%; } } }
}
</style>