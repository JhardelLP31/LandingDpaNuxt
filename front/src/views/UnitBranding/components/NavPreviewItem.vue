<template>
  <li 
    class="nav-item-container" 
    @mouseenter="isHovered = true" 
    @mouseleave="isHovered = false"
  >
    <a 
      href="javascript:void(0)" 
      class="nav-link-custom" 
      :style="linkStyle"
    >
      {{ item.title }}
      <i v-if="hasChildren" class="las la-angle-down ms-1 small-icon"></i>
      <span class="underline-indicator" :style="{ backgroundColor: accentColor }" :class="{ active: isHovered }"></span>
    </a>

    <transition name="dropdown">
      <ul v-if="hasChildren && isHovered" class="nav-dropdown shadow-lg">
        <NavPreviewItem 
          v-for="child in item.children" 
          :key="child.id" 
          :item="child" 
          :accent-color="accentColor"
          text-color="#334155" 
        />
      </ul>
    </transition>
  </li>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';

const props = defineProps<{
  item: any;
  accentColor: string;
  textColor: string;
}>();

const isHovered = ref(false);
const hasChildren = computed(() => props.item.children && props.item.children.length > 0);

const linkStyle = computed(() => ({
  color: props.textColor,
  '--hover-accent': props.accentColor
}));
</script>

<style scoped>
.nav-item-container { position: relative; list-style: none; }

.nav-link-custom {
  display: block;
  padding: 1.5rem 0.75rem;
  font-size: 0.75rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.5px;
  text-decoration: none;
  transition: opacity 0.2s;
  position: relative;
}

.underline-indicator {
  position: absolute;
  bottom: 15px;
  left: 10px;
  right: 10px;
  height: 2px;
  transform: scaleX(0);
  transition: transform 0.3s ease;
}
.underline-indicator.active { transform: scaleX(1); }

.nav-dropdown {
  position: absolute;
  top: 100%;
  left: 0;
  min-width: 200px;
  background: white;
  border-radius: 8px;
  padding: 0.5rem 0;
  z-index: 100;
  list-style: none;
  margin-top: -5px;
}

/* Estilos para los hijos dentro del dropdown */
:deep(.nav-link-custom) {
  color: #1e293b !important;
  padding: 0.75rem 1.25rem !important;
  text-transform: none;
  font-weight: 500;
}

:deep(.nav-link-custom:hover) {
  background: #f8fafc;
  color: var(--hover-accent) !important;
}

.dropdown-enter-active, .dropdown-leave-active { transition: all 0.2s ease; }
.dropdown-enter-from, .dropdown-leave-to { opacity: 0; transform: translateY(10px); }
</style>