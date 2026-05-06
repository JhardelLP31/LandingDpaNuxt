<script setup lang="ts">
import { ref, onMounted } from 'vue';
import { formatImageUrl } from '@/helpers/url';

// --- INTERFACES ---
interface CounterItem {
  id: number | string;
  value: number;
  suffix: string;
  description: string;
}

interface AchievementData {
  subtitle: string;
  title: string;
  buttonText: string;
  buttonLink: string;
  image: string; 
  counters: CounterItem[];
}

// --- PROPS ---
const props = withDefaults(defineProps<{
  data?: AchievementData;
}>(), {
  data: () => ({
    subtitle: '',
    title: '',
    buttonText: '',
    buttonLink: '',
    image: '',
    counters: []
  })
});
// --- STATE ---
const sectionRef = ref<HTMLElement | null>(null);
const animatedNumbers = ref<Record<string | number, number>>({});

// --- ANIMATION LOGIC ---
const animate = (item: CounterItem) => {
  let start = 0;
  const duration = 2000;
  let startTimestamp: number | null = null;

  const step = (timestamp: number) => {
    if (!startTimestamp) startTimestamp = timestamp;
    const progress = Math.min((timestamp - startTimestamp) / duration, 1);
    animatedNumbers.value[item.id] = Math.floor(progress * item.value);
    if (progress < 1) window.requestAnimationFrame(step);
  };
  window.requestAnimationFrame(step);
};

onMounted(() => {
  // SEGURIDAD: Solo ejecutar si data y counters existen
  if (!props.data || !props.data.counters) return;

  const observer = new IntersectionObserver((entries) => {
    if (entries[0].isIntersecting) {
      props.data.counters.forEach(animate);
      observer.disconnect();
    }
  }, { threshold: 0.2 });

  if (sectionRef.value) observer.observe(sectionRef.value);
});
</script>

<template>
  <section 
    v-if="data"
    ref="sectionRef"
    class="theme-counter" 
    :style="{ 
      backgroundImage: data.image ? `url(${formatImageUrl(data.image)})` : 'none' 
    }"
  >
    <div class="overlay">
      <div class="container">
        <div class="content-wrapper">
          <h6 class="subtitle">{{ data?.subtitle }}</h6>
          <h2 class="main-title">{{ data?.title }}</h2>

          <div class="counter-container">
            <div class="row justify-content-center">
              <div 
                v-for="item in (data?.counters || [])" 
                :key="item.id" 
                class="col-lg-4 col-md-6"
              >
                <div class="single-counter-box">
                  <div class="number-wrapper">
                    <span class="number">{{ animatedNumbers[item.id] || 0 }}</span>
                    <span class="suffix">{{ item.suffix }}</span>
                  </div>
                  <div class="red-divider"></div>
                  <p class="description">{{ item.description }}</p>
                </div>
              </div>
            </div>
          </div>

          <a v-if="data?.buttonText" :href="data?.buttonLink" class="theme-button-one">
            {{ data.buttonText }}
          </a>
        </div>
      </div>
    </div>
  </section>
</template>

<style lang="scss" scoped>
// Tus estilos SCSS se mantienen igual...
$esan-red: #e31140;
$esan-white: #FFFFFF;
$esan-light-gray: #E6E7E8;

.theme-counter {
  position: relative;
  background-size: cover;
  background-position: center;
  background-attachment: fixed;
  min-height: 550px;
  display: flex;
  align-items: center;
  background-color: #000; // Backup color
}

.overlay {
  background: linear-gradient(135deg, rgba(0, 0, 0, 0.85) 0%, rgba(0, 0, 0, 0.7) 100%);
  width: 100%;
  padding: 100px 0;
}

.content-wrapper {
  text-align: center;
  color: $esan-white;
}

.subtitle {
  color: $esan-red;
  font-weight: 700;
  letter-spacing: 3px;
  margin-bottom: 10px;
  text-transform: uppercase;
}

.main-title {
  font-size: 2.8rem;
  font-weight: 800;
  margin-bottom: 60px;
  max-width: 900px;
  margin-left: auto;
  margin-right: auto;
}

.number-wrapper {
  font-size: 4.5rem;
  font-weight: 900;
  line-height: 1;
  color: $esan-white;
  margin-bottom: 15px;
}

.red-divider {
  width: 50px;
  height: 4px;
  background-color: $esan-red;
  margin: 0 auto 20px;
}

.description {
  font-size: 1.1rem;
  font-weight: 300;
  color: $esan-light-gray;
  max-width: 280px;
  margin: 0 auto 40px;
  line-height: 1.5;
}

.theme-button-one {
  display: inline-block;
  background-color: $esan-red;
  color: $esan-white;
  padding: 16px 45px;
  border-radius: 4px;
  font-weight: 700;
  text-decoration: none;
  text-transform: uppercase;
  letter-spacing: 1px;
  transition: all 0.3s ease;
  border: 2px solid $esan-red;

  &:hover {
    background-color: transparent;
    color: $esan-red;
    transform: translateY(-5px);
  }
}

@media (max-width: 768px) {
  .main-title { font-size: 2rem; }
  .number-wrapper { font-size: 3.5rem; }
}
</style>