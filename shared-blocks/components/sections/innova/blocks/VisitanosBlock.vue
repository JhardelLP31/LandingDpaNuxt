<script setup lang="ts">
import { computed } from 'vue';

interface VisitanosData {
  title?: string;
  address?: string;
  mapUrl?: string;
  backgroundColor?: string;
  textColor?: string;
  invertLayout?: boolean; // <-- Nueva propiedad para invertir el orden
}

const props = defineProps<{ data: VisitanosData }>();

const safeData = computed(() => {
  const d = props.data || {};
  return {
    title: d.title || 'campus esan',
    address: d.address || 'Jr. Alonso de Molina 1652, Santiago de Surco 15023',
    mapUrl: d.mapUrl || 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3900.957582531005!2d-76.96347352504892!3d-12.11504954316168!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9105c70ce045a555%3A0xc07ce678248c187!2sUniversidad%20ESAN!5e0!3m2!1ses-419!2spe',
    backgroundColor: d.backgroundColor || '#ffffff',
    textColor: d.textColor || '#1a1a1a',
    invertLayout: d.invertLayout || false // Por defecto, texto a la izquierda
  };
});
</script>

<template>
  <section 
    class="informativo" 
    id="visitanos" 
    :style="{ backgroundColor: safeData.backgroundColor, color: safeData.textColor }"
  >
    <div class="espacio">
      <section class="informativo__cont" :class="{ 'informativo__cont--invertido': safeData.invertLayout }">
        
        <article class="informativo__texto">
          <h2 class="tituloPrincipal" :style="{ color: safeData.textColor }">
            {{ safeData.title }}
          </h2>      
          <div class="linea-titulo" :style="{ backgroundColor: safeData.textColor }"></div>

          <p>{{ safeData.address }}</p>  
          <div class="linea-direccion"></div>       
        </article>
        
        <div class="grid__modelo--tmp">               
          <iframe 
            :src="safeData.mapUrl" 
            width="100%" 
            height="400px" 
            style="border:0; border-radius: 8px;" 
            allowfullscreen="true" 
            loading="lazy" 
            referrerpolicy="no-referrer-when-downgrade"
          ></iframe>                           
        </div>            
        
      </section>
    </div>
  </section>
</template>

<style scoped>
/* Contenedor principal */
.informativo {
  width: 100%;
  display: block;
  font-family: inherit;
  transition: background-color 0.3s ease;
}

.espacio {
  max-width: 1200px;
  margin: 0 auto;
  padding: 60px 20px;
}

/* Grilla principal: 2 columnas en PC */
.informativo__cont {
  display: grid;
  grid-template-columns: 1fr 1fr;
  align-items: center;
  gap: 60px; /* Aumenté un poco el gap para que respire más como en tu imagen */
}

/* CLASE PARA INVERTIR EL ORDEN */
.informativo__cont--invertido .informativo__texto {
  order: 2;
}
.informativo__cont--invertido .grid__modelo--tmp {
  order: 1;
}

/* Textos */
.informativo__texto {
  display: flex;
  flex-flow: column;
  justify-content: center;
  align-items: flex-start; /* Asegura que el contenido se alinee a la izquierda */
}

.tituloPrincipal {
  font-size: 2.2rem;
  font-weight: 700;
  text-transform: uppercase;
  margin: 0 0 10px 0; /* Ajuste de margen para la línea */
  display: flex;
  align-items: center;
}

/* Nuevas Líneas */
.linea-titulo {
  width: 80px; /* Largo de la línea gruesa */
  height: 3px;
  margin-bottom: 25px; /* Espacio antes de la dirección */
}

.linea-direccion {
  width: 100%;
  max-width: 350px; /* Para que no se estire infinitamente */
  height: 1px;
  background-color: #d1d1d1; /* Gris claro */
  margin-top: 25px;
}

.informativo__texto p {
  font-size: 1.1rem;
  line-height: 1.5;
  margin: 0;
  color: #555; /* Un gris un poco más suave para la dirección, opcional */
}

/* Contenedor del Iframe */
.grid__modelo--tmp {
  width: 100%;
  overflow: hidden;
  box-shadow: 0 10px 30px rgba(0,0,0,0.1);
  border-radius: 8px; 
}

/* Responsivo para celulares y tablets (1 columna) */
@media (max-width: 768px) {
  .informativo__cont {
    grid-template-columns: 1fr;
    gap: 40px;
  }
  
  /* En móviles forzamos a que el texto siempre vaya primero o segundo, como prefieras */
  .informativo__cont--invertido .informativo__texto,
  .informativo__texto {
    order: 1; 
  }
  .informativo__cont--invertido .grid__modelo--tmp,
  .grid__modelo--tmp {
    order: 2;
  }
  
  .tituloPrincipal {
    font-size: 1.8rem;
  }
}
</style>