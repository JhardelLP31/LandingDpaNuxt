<script setup lang="ts">
import { ref, onMounted, watch } from 'vue';

const props = defineProps<{
  src: string;
  alt?: string;
  className?: string;
  tolerance?: number; // Qué tan "blanco" debe ser para borrarse (0-255)
}>();

const processedSrc = ref<string>('');
const isLoading = ref(true);

// Función mágica que borra el blanco
const removeWhiteBackground = (imageSrc: string) => {
  const img = new Image();
  img.crossOrigin = "Anonymous"; // Importante para evitar bloqueos de seguridad
  img.src = imageSrc;

  img.onload = () => {
    const canvas = document.createElement('canvas');
    const ctx = canvas.getContext('2d');
    
    if (!ctx) return;

    canvas.width = img.width;
    canvas.height = img.height;
    
    // 1. Dibujamos la imagen original en el canvas
    ctx.drawImage(img, 0, 0);
    
    // 2. Obtenemos la data de cada píxel
    const imgData = ctx.getImageData(0, 0, canvas.width, canvas.height);
    const data = imgData.data;
    const limit = props.tolerance || 230; // Rango de tolerancia (230 es bueno para JPGs sucios)

    // 3. Recorremos píxel por píxel
    for (let i = 0; i < data.length; i += 4) {
      const r = data[i];     // Rojo
      const g = data[i + 1]; // Verde
      const b = data[i + 2]; // Azul
      
      // Si los tres canales son muy altos (es decir, es blanco o casi blanco)
      if (r > limit && g > limit && b > limit) {
        data[i + 3] = 0; // Alpha a 0 (Totalmente transparente)
      }
    }

    // 4. Ponemos la data modificada de nuevo
    ctx.putImageData(imgData, 0, 0);
    
    // 5. Convertimos a URL
    processedSrc.value = canvas.toDataURL();
    isLoading.value = false;
  };

  img.onerror = () => {
    // Si falla (por CORS o error), mostramos la original aunque tenga fondo
    processedSrc.value = props.src;
    isLoading.value = false;
  }
};

onMounted(() => {
  removeWhiteBackground(props.src);
});

// Por si cambia la URL dinámicamente
watch(() => props.src, (newVal) => {
  isLoading.value = true;
  removeWhiteBackground(newVal);
});
</script>

<template>
  <div class="clean-img-wrapper" :class="className">
    <div v-if="isLoading" class="skeleton-loader"></div>
    
    <img 
      v-else
      :src="processedSrc" 
      :alt="alt"
      class="img-result"
    />
  </div>
</template>

<style scoped>
.clean-img-wrapper {
  display: inline-block;
  position: relative;
  width: 100%;
  height: 100%;
}

.img-result {
  width: 100%;
  height: 100%;
  object-fit: contain;
  display: block;
}

.skeleton-loader {
  width: 100%;
  height: 100%;
  background: rgba(255,255,255,0.05);
  animation: pulse 1.5s infinite;
  border-radius: 8px;
}

@keyframes pulse {
  0% { opacity: 0.3; }
  50% { opacity: 0.7; }
  100% { opacity: 0.3; }
}
</style>