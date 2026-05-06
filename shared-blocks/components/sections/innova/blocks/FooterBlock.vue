<script setup lang="ts">
import { computed } from 'vue';

interface Link {
  text: string;
  url: string;
}

interface FooterData {
  logoUrl?: string;
  respaldoLogoUrl?: string;
  linkedinUrl?: string;
  instagramUrl?: string;
  siteMapLinks?: Link[];
  masEsanLinks?: Link[];
  address?: string;
  phone?: string;
  email?: string;
  reclamacionesUrl?: string;
  reclamacionesLogoUrl?: string;
  copyrightText?: string;
  backgroundColor?: string;
  textColor?: string;
}

const props = defineProps<{ data: FooterData }>();

const safeData = computed(() => {
  const d = props.data || {};
  return {
    logoUrl: d.logoUrl || 'https://via.placeholder.com/200x60?text=Logo+Innova',
    respaldoLogoUrl: d.respaldoLogoUrl || 'https://via.placeholder.com/150x50?text=Logo+ESAN',
    linkedinUrl: d.linkedinUrl || 'https://www.linkedin.com/',
    instagramUrl: d.instagramUrl || 'https://www.instagram.com/',
    siteMapLinks: d.siteMapLinks || [
      { text: 'Home', url: '#' },
      { text: '¿Quienes somos?', url: '#' },
      { text: 'Nuestros Programas', url: '#' },
      { text: 'Portafolio', url: '#' },
      { text: 'Comunidad', url: '#' }
    ],
    masEsanLinks: d.masEsanLinks || [
      { text: 'Posgrado', url: '#' },
      { text: 'Pregrado', url: '#' },
      { text: 'Escuela de Gobierno', url: '#' },
      { text: 'E2B', url: '#' }
    ],
    address: d.address || 'Alonso de Molina 1652, Monterrico, Surco 2do Piso del Sport & Convention Center',
    phone: d.phone || '317-7200',
    email: d.email || 'innovaesan@esan.edu.pe',
    reclamacionesLogoUrl: d.reclamacionesLogoUrl || '',
    reclamacionesUrl: d.reclamacionesUrl || '',

    copyrightText: d.copyrightText || '© Copyright 2025 INNOVA ESAN - Universidad ESAN | Todos los derechos reservados.',
    backgroundColor: d.backgroundColor || '#1a1a1a', // Fondo oscuro por defecto
    textColor: d.textColor || '#ffffff'
  };
});
</script>

<template>
  <footer class="footer" :style="{ backgroundColor: safeData.backgroundColor, color: safeData.textColor }">      
    <section class="footer__content espacio">
      
      <article class="footer__logo">
        <div><img :src="safeData.logoUrl" alt="Logo Principal"></div>
        <div>
          <h4 :style="{ color: safeData.textColor }">Respaldado por:</h4>
          <img :src="safeData.respaldoLogoUrl" alt="Logo Respaldo">
        </div>
        <div>
          <h4 :style="{ color: safeData.textColor }">Redes Sociales</h4>
          <ul>
            <li>
              <a :href="safeData.linkedinUrl" target="_blank" :style="{ color: safeData.textColor }">
                <i class="fa-brands fa-linkedin-in"></i>
              </a>
            </li>
            <li>
              <a :href="safeData.instagramUrl" target="_blank" :style="{ color: safeData.textColor }">
                <i class="fa-brands fa-instagram"></i>
              </a>
            </li>
          </ul>
        </div>
      </article>

      <article class="footer__navegacion">
        
        <div class="col-nav">
          <h4 :style="{ color: safeData.textColor }">Mapa de Sitio</h4>
          <ul>
            <li v-for="(link, index) in safeData.siteMapLinks" :key="'sitemap-'+index">
              <a :href="link.url" :style="{ color: safeData.textColor }">{{ link.text }}</a>
            </li>
          </ul>
        </div>
        
        <div class="col-nav">
          <h4 :style="{ color: safeData.textColor }">Más de ESAN</h4>
          <ul>
            <li v-for="(link, index) in safeData.masEsanLinks" :key="'masesan-'+index">
              <a :href="link.url" :style="{ color: safeData.textColor }">{{ link.text }}</a>
            </li>
          </ul>
        </div>
        
        <div class="col-contacto">
          <h4 :style="{ color: safeData.textColor }">Contáctanos</h4>
          
          <h5 :style="{ color: safeData.textColor }">Dirección</h5>
          <p>{{ safeData.address }}</p>
          
          <h5 :style="{ color: safeData.textColor }">Teléfono</h5>
          <p>{{ safeData.phone }}</p>
          
          <h5 :style="{ color: safeData.textColor }">Correo</h5>
          <p>{{ safeData.email }}</p>
        </div>
        
        <div class="col-reclamaciones">
          <a :href="safeData.reclamacionesUrl" target="_blank" rel="noopener noreferrer">
            <img :src="safeData.reclamacionesLogoUrl || 'https://via.placeholder.com/150x50?text=Libro+Reclamaciones'" alt="Libro de Reclamaciones">          
          </a>
        </div>
        
      </article>

    </section>

    <section class="footer__firma" :style="{ borderTopColor: 'rgba(255,255,255,0.1)' }">
      {{ safeData.copyrightText }}
    </section>
  </footer>
</template>

<style scoped>
/* ESTILOS BASE */
.footer {
  width: 100%;
  font-family: inherit;
  
  /* --- EL BLINDAJE PARA EL BUILDER --- */
  display: block;
  position: relative !important; /* Forza a que respete el orden de los bloques */
  z-index: 10; 
  clear: both; /* Limpia cualquier elemento flotante del bloque anterior */
  margin-top: 0 !important; 
}

.espacio {
  max-width: 1200px;
  margin: 0 auto;
  padding: 60px 20px;
}

.footer__content {
  display: flex;
  flex-direction: column;
  gap: 40px;
}

/* Tipografía general */
h4 {
  font-size: 1.2rem;
  font-weight: 700;
  margin-bottom: 15px;
  text-transform: uppercase;
}

h5 {
  font-size: 1rem;
  font-weight: 700;
  margin-top: 15px;
  margin-bottom: 5px;
}

p {
  font-size: 0.9rem;
  margin: 0 0 10px 0;
  opacity: 0.8;
}

ul {
  list-style: none;
  padding: 0;
  margin: 0;
}

li {
  margin-bottom: 10px;
}

a {
  text-decoration: none;
  opacity: 0.8;
  transition: opacity 0.3s;
}

a:hover {
  opacity: 1;
}

.fa-brands {
  font-size: 1.5rem;
}

/* SECCIÓN LOGOS */
.footer__logo {
  display: flex;
  flex-direction: column;
  gap: 30px;
  text-align: center;
}

.footer__logo img {
  max-width: 100%;
  height: auto;
}

.footer__logo ul {
  display: flex;
  justify-content: center;
  gap: 20px;
}

/* SECCIÓN NAVEGACIÓN Y CONTACTO */
.footer__navegacion {
  display: grid;
  grid-template-columns: 1fr;
  gap: 40px;
  text-align: center;
}

.col-reclamaciones img {
  max-width: 150px;
  height: auto;
}

/* FIRMA */
.footer__firma {
  text-align: center;
  padding: 20px;
  font-size: 0.85rem;
  border-top: 1px solid;
  opacity: 0.7;
}

/* MEDIA QUERIES (Ajustado fielmente a tu CSS original) */

@media (max-width: 575px) {
  .footer__logo {
    order: 2;
  }
  .footer__navegacion {
    order: 1;
  }
}

@media (min-width: 768px) {
  .footer__content {
    flex-direction: row; 
    justify-content: space-between;
  }

  .footer__logo {
    width: 25%; /* Ajustado para dar más espacio a los enlaces */
    text-align: left;
    order: 1; 
  }

  .footer__logo ul {
    justify-content: flex-start;
  }

  .footer__navegacion {
    width: 70%;
    /* Dividimos el espacio: 1fr para sitemap, 1fr para mas esan, 1.5fr para contacto, auto para la imagen */
    grid-template-columns: 1fr 1fr 1.5fr auto; 
    text-align: left;
    gap: 30px;
    order: 2;
  }

  h4 {
    text-align: left;
  }
}
</style>