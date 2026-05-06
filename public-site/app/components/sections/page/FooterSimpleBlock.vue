<script setup lang="ts">
import { computed } from 'vue';

// --- INTERFACES ---
interface SocialLink {
  platform: string; // Nombre para identificar (Facebook, Youtube...)
  url: string;
  iconClass: string; // "fab fa-facebook", etc.
}

interface FooterData {
  copyrightText?: string; // "© Copyright {year} ESANDATA..."
  socials?: SocialLink[];
  config?: {
    bgColor?: string;
    textColor?: string;
    iconColor?: string;
  };
}

const props = defineProps<{
  data: FooterData;
  isEditor?: boolean;
}>();

// Estilos dinámicos
const footerStyle = computed(() => ({
  backgroundColor: props.data.config?.bgColor || '#1a1a1a', // Negro suave por defecto
  color: props.data.config?.textColor || '#ffffff',
}));

// Helper para reemplazar {year} por el año actual
const formattedCopyright = computed(() => {
  const text = props.data.copyrightText || '';
  const currentYear = new Date().getFullYear();
  return text.replace('{year}', currentYear.toString());
});
</script>

<template>
  <footer class="simple-footer py-4" :style="footerStyle">
    <div class="container text-center">
      <div class="row justify-content-center">
        <div class="col-md-12">
          
          <div v-if="data.socials && data.socials.length > 0" class="social-icons mb-3">
            <a 
              v-for="(link, index) in data.socials" 
              :key="index"
              :href="link.url" 
              target="_blank" 
              rel="noopener noreferrer"
              class="social-btn mx-2"
              :style="{ color: data.config?.iconColor || '#ffffff' }"
              :aria-label="link.platform"
            >
              <i :class="link.iconClass"></i>
            </a>
          </div>

          <div class="copyright-text small opacity-75">
            <span v-html="formattedCopyright"></span>
          </div>

        </div>
      </div>
    </div>
  </footer>
</template>

<style scoped lang="scss">
.simple-footer {
  // Transición suave si cambias de color
  transition: background-color 0.3s ease;
}

.social-btn {
  font-size: 1.5rem; // Tamaño de iconos
  text-decoration: none;
  transition: transform 0.2s ease, opacity 0.2s ease;
  display: inline-block;

  &:hover {
    opacity: 0.8;
    transform: translateY(-3px); // Pequeño salto al pasar mouse
  }
}

.copyright-text {
  font-size: 0.9rem;
  letter-spacing: 0.5px;
  
  // Para que los enlaces dentro del copyright (si hubiera) hereden el color
  :deep(a) {
    color: inherit;
    text-decoration: underline;
  }
}
</style>