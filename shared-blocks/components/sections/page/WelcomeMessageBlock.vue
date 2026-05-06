<script setup lang="ts">
import { computed } from 'vue';
import { formatImageUrl } from '@/helpers/url';

// --- INTERFACES ---
interface WelcomeData {
  mainImage?: string;
  content?: string;
  signatureImage?: string;
  signatureTitle?: string;
  config?: {
    textAlign?: 'left' | 'justify';
    bgSplitTop?: string;    
    bgSplitBottom?: string;
    cardBgColor?: string; 
  };
}

const props = defineProps<{
  data: WelcomeData;
  isEditor?: boolean;
}>();

// 1. Estilo del FONDO (Full Width real - Truco del Breakout)
const sectionBackgroundStyle = computed(() => {
  const top = props.data.config?.bgSplitTop || '#f8f9fa';
  const bottom = props.data.config?.bgSplitBottom || '#1a1a2e';
  
  return {
    background: `linear-gradient(180deg, ${top} 50%, ${bottom} 50%)`,
    width: '100vw',           // Fuerza ancho de ventana completo
    marginLeft: '50%',        // Mueve al centro
    transform: 'translateX(-50%)' // Re-centra
  };
});

// 2. Estilo de la TARJETA
const cardStyle = computed(() => ({
  backgroundColor: props.data.config?.cardBgColor || '#ffffff',
  borderRadius: '8px', 
  boxShadow: '0 15px 35px rgba(0,0,0,0.1)',
  // Máximo ancho controlado (aprox 1100px) para que se vea compacto en el centro
  maxWidth: '1300px', 
  margin: '0 auto' 
}));

const textStyle = computed(() => ({
  textAlign: props.data.config?.textAlign || 'justify'
}));
</script>

<template>
  <section class="welcome-section py-5" :style="sectionBackgroundStyle">
    <div class="container">
      
      <div class="welcome-card p-4 p-lg-5" :style="cardStyle">
        <div class="row align-items-center">
          
          <div class="col-md-5 mb-4 mb-md-0">
            <div class="position-relative px-2">
              <img 
                v-if="data.mainImage"
                :src="formatImageUrl(data.mainImage)" 
                class="img-fluid w-100 shadow-sm" 
                style="border-radius: 4px;"
                alt="Bienvenida"
              >
            </div>
          </div>

          <div class="col-md-7">
            <div class="ps-md-3">
              
              <div class="welcome-text mb-4" :style="textStyle">
                  <div v-html="data.content" class="quill-content"></div>
              </div>

              <div class="signature-block d-flex flex-column align-items-end mt-4">
                <div class="mb-2" style="min-height: 50px;">
                  <img 
                    v-if="data.signatureImage"
                    :src="formatImageUrl(data.signatureImage)" 
                    class="img-fluid" 
                    style="max-height: 65px; width: auto;"
                    alt="Firma"
                  >
                </div>
                <div v-if="data.signatureTitle" class="signature-title text-end">
                  {{ data.signatureTitle }}
                </div>
              </div>

            </div>
          </div>
          
        </div>
      </div> 
    </div>
  </section>
</template>

<style scoped lang="scss">
$esan-red: #bd1033;

.welcome-section {
  position: relative;
  transition: background 0.3s ease;
  overflow-x: hidden; 
}

// --- TIPOGRAFÍA (16px) ---
.quill-content {
  font-size: 16px; 
  line-height: 1.8; /* Buen interlineado para lectura cómoda */
  color: #555;
  
  :deep(p) { margin-bottom: 1rem; }
  :deep(strong) { color: #222; font-weight: 700; }
}

.signature-title {
  color: $esan-red !important;
  font-weight: 700;
  font-size: 14px;
  letter-spacing: 0.5px;
  text-transform: uppercase;
  margin-top: 5px;
  border-top: 1px solid #eee;
  padding-top: 10px;
}

@media (max-width: 768px) {
  .welcome-text { text-align: left !important; }
  .signature-block { align-items: center !important; }
  .signature-title { text-align: center !important; }
}
</style>