<script setup lang="ts">
import { ref } from 'vue';

interface Props {
  type: 'timeline' | 'html' | 'list' | 'accordion'; // Añadimos 'accordion'
  title: string;
  items?: any[];
  freeHtml?: string;  
  features?: string[];
  accentColor: string;
  titleColor: string;
  
}

const props = defineProps<Props>();
const activeIndex = ref(0);

// Cambiamos el índice activo o cerramos si se hace click en el mismo
const toggleIndex = (index: number) => {
  activeIndex.value = activeIndex.value === index ? -1 : index;
};
</script>

<template>
  <div class="text-wrapper">
    <h2 class="tituloPrincipal" :style="{ color: titleColor }">{{ title }}</h2>

    <div class="dynamic-content-area">
      
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

      <div v-else-if="type === 'html'" class="free-html-area">
        <div class="html-renderer" v-html="freeHtml"></div>
      </div>

      <div v-else-if="type === 'list'" class="features-list">
        <div v-for="(feat, i) in features" :key="i" class="feature-item">
          <i class="las la-check-circle" :style="{ color: accentColor }"></i>
          <span v-html="feat"></span>
        </div>
      </div>

      <div v-else-if="type === 'accordion'" class="accordion-clean">
        <div v-for="(item, index) in items" :key="index" class="acc-node mb-3">
          <h3 
            class="titulo__plus" 
            :class="{ 'titulo__plus--activo': activeIndex === index }"
            @click="toggleIndex(index)"
            :style="activeIndex === index ? { color: accentColor } : {}"
          >
            <i :class="['fa-solid me-2', activeIndex === index ? 'fa-minus' : 'fa-plus']"></i>
            {{ item.label }}
          </h3>
          
          <transition name="expand">
            <article v-show="activeIndex === index" class="titulo__plus--cont">
              <div class="html-renderer" v-html="item.content"></div>
            </article>
          </transition>
          <hr class="acc-divider">
        </div>
      </div>

    </div>
  </div>
</template>

<style scoped lang="scss">
/* --- ESTILOS BASE --- */
.tituloPrincipal {
  text-transform: uppercase;
  font-weight: 600;
  font-size: 2.2rem;
  margin-bottom: 40px;
  position: relative;
  &::after {
    content: ''; display: block; width: 60px; height: 4px; 
    background: currentColor; margin-top: 10px;
  }
}
.content-detail{
  font-size: 14px;
  color: #000;
  font-weight: 400;
}
/* --- MODO TIMELINE --- */
.timeline-list {
  position: relative;
  .titulo__time {
    padding: 0 0 25px 30px; cursor: pointer; position: relative;
    font-size: 1.1rem; font-weight: 800; transition: color 0.3s;
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

/* --- MODO ACORDEÓN (Nuevo) --- */
.accordion-clean {
  .titulo__plus {
    font-size: 1.25rem;
    font-weight: 700;
    cursor: pointer;
    display: flex;
    align-items: center;
    transition: all 0.3s ease;
    margin-bottom: 0;
    padding: 10px 0;

    i {
      font-size: 0.9rem;
      width: 25px;
      transition: transform 0.3s ease;
    }

    &:hover { opacity: 0.8; }
  }

  .titulo__plus--cont {
    padding: 10px 0 20px 30px;
    color: #555;
    font-size: 0.95rem;
    line-height: 1.6;
  }

  .acc-divider {
    margin: 0;
    border-color: #eee;
    opacity: 1;
  }
}

/* --- ESTILOS DE LISTA --- */
.feature-item {
  display: flex; align-items: center; gap: 10px; margin-bottom: 12px;
  font-size: 1.1rem; i { font-size: 1.5rem; }
}

/* --- ANIMACIONES --- */
.expand-enter-active, .expand-leave-active { transition: all 0.4s cubic-bezier(0.4, 0, 0.2, 1); overflow: hidden; }
.expand-enter-from, .expand-leave-to { opacity: 0; max-height: 0; }
.expand-enter-to, .expand-leave-from { opacity: 1; max-height: 800px; }

/* Reset para renderizado HTML de Quill */
:deep(.html-renderer) {
  ul { 
    list-style: none; padding: 0; margin: 0;
    li { 
      position: relative; padding-left: 20px; margin-bottom: 10px;
      &::before { content: ''; position: absolute; left: 0; top: 8px; width: 6px; height: 6px; background: #666; border-radius: 50%; }
    }
  }
  strong { color: #333; }
}
</style>