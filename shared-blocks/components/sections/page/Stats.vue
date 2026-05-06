<script setup lang="ts">
defineProps<{ data: any }>();
</script>

<template>
  <section class="bento-section py-5">
    <div class="container">
      <div class="text-center mb-5">
        <span class="text-accent fw-bold text-uppercase small">{{ data.subtitle }}</span>
        <h2 class="fw-bold text-primary display-5">{{ data.title }}</h2>
      </div>

      <div class="bento-grid">
        <div v-for="item in data.items" :key="item.id" 
             :class="['bento-item', `size-${item.size}`]"
             :style="{ backgroundColor: item.bgColor, color: item.textColor }">
          
          <div class="bento-content">
            <i :class="[item.icon, 'bento-icon']"></i>
            <h4 class="fw-bold mt-3">{{ item.title ||"xd"}}</h4>
            <p class="mb-0 opacity-75 small">{{ item.desc }}</p>
          </div>
          
          <div class="bento-shape"></div>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.bento-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  grid-auto-rows: 180px;
  gap: 1.5rem;
}

.bento-item {
  position: relative;
  padding: 2rem;
  border-radius: 24px;
  overflow: hidden;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
  border: 1px solid rgba(0,0,0,0.05);
  display: flex;
  align-items: flex-end;
}

.bento-item:hover {
  transform: scale(1.02);
  box-shadow: 0 20px 40px rgba(0,0,0,0.1);
}

.size-large { grid-column: span 2; }
.size-medium { grid-row: span 2; grid-column: span 1; align-items: center; }
.size-small { grid-column: span 1; }

.bento-icon {
  font-size: 2.5rem;
  margin-bottom: 1rem;
  display: block;
}

.text-accent { color: var(--color-accent); }
.text-primary { color: var(--color-primary); }

/* Responsive */
@media (max-width: 991px) {
  .bento-grid {
    grid-template-columns: repeat(2, 1fr);
    grid-auto-rows: 200px;
  }
}
</style>