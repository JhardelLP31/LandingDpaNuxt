<script setup lang="ts">
import { formatImageUrl } from '@/helpers/url';

// --- IMPORTAMOS SWIPER ---
import { Swiper, SwiperSlide } from 'swiper/vue';
// 1. QUITAMOS 'Pagination' de aquí
import { Navigation, Autoplay } from 'swiper/modules';

// Estilos de Swiper obligatorios
import 'swiper/css';
// 2. QUITAMOS el css de pagination
import 'swiper/css/navigation';

// Interfaces
interface TeamMember {
  image?: string;
  name?: string;
  position?: string;
  linkedin?: string;
  hover_text?: string;
}

interface TeamSectionData {
  title?: string;
  description?: string;
  items?: TeamMember[];
}

interface Props {
  data?: TeamSectionData;
}

withDefaults(defineProps<Props>(), {
  data: () => ({
    title: '',
    description: '',
    items: [],
  }),
});

// 3. QUITAMOS Pagination de la lista de módulos
const modules = [Navigation, Autoplay];

// Configuración Responsive del Carrusel
const breakpoints = {
  320: {
    slidesPerView: 1,
    spaceBetween: 20
  },
  768: {
    slidesPerView: 2,
    spaceBetween: 30
  },
  1024: {
    slidesPerView: 3,
    spaceBetween: 30
  },
  1200: {
    slidesPerView: 4, // Ajustado a 4 para aprovechar pantallas grandes
    spaceBetween: 30
  }
};
</script>

<template>
  <section v-if="data" class="our-team section-spacing">
    <div class="container">
      <div class="theme-title-one">
        <!--<h2 v-if="data?.title">{{ data.title }}</h2>-->
        <h2 style="color: #e31140;" class="section-title text-uppercase fw-bold display-6">
          {{ data.title }}
        </h2>
        <p v-if="data?.description">{{ data.description }}</p>
      </div>

      <div class="wrapper">
        <swiper
          :modules="modules"
          :slides-per-view="1"
          :space-between="30"
          :breakpoints="breakpoints"
          :center-insufficient-slides="true" 
          :loop="(data?.items?.length ?? 0) > 4"
          class="team-swiper"
        >
        
          <swiper-slide 
            v-for="(member, index) in (data?.items || [])" 
            :key="index"
          >
            <div class="team-member">
              <div class="image-box">
                <img 
                  v-if="member?.image"
                  :src="formatImageUrl(member.image)" 
                  :alt="member?.name"
                >
                <div v-else class="placeholder-img"></div>
                
                <div class="overlay">
                  <div class="hover-content">
                    <ul>
                      <li v-if="member?.linkedin">
                        <a :href="member.linkedin" target="_blank">
                          <i class="fab fa-linkedin-in"></i>
                        </a>
                      </li>
                    </ul>
                    <p v-if="member?.hover_text">{{ member.hover_text }}</p>
                  </div>
                </div>
              </div>
              
              <div class="text">
                <h6 v-if="member?.name">{{ member.name }}</h6>
                <span v-if="member?.position">{{ member.position }}</span>
              </div>
            </div>
          </swiper-slide>
        </swiper>
      </div>
      </div>
  </section>
</template>

<style scoped lang="scss">
$esan-red: #e31140;
$esan-black: #000000;
$esan-dark-gray: #333333;
$esan-light-gray: #E6E7E8;
$esan-white: #FFFFFF;

.our-team {
  padding: 80px 0;
  /*background-color: $esan-white;*/

  .theme-title-one {
    text-align: center;
    margin-bottom: 50px;
    h2 {
      font-size: 36px;
      font-weight: 700;
      margin-bottom: 20px;
      color: $esan-black;
      position: relative;
      display: inline-block;
      &::after {
        content: '';
        display: block;
        width: 60px;
        height: 3px;
        background: $esan-red;
        margin: 10px auto 0;
      }
    }
    p {
      margin-top: 15px;
      font-size: 16px;
      text-align: justify;
      color: $esan-dark-gray;
      max-width: 800px;
      margin: 0 auto;
    }
  }

  .wrapper {
    // Estilos específicos para Swiper
    .team-swiper {
      // 4. ELIMINAMOS el padding-bottom que era para los puntos
      padding-bottom: 0; 
    }

    .team-member {
      background: $esan-white;
      transition: all 0.3s ease-in-out;
      margin: 0 auto; 
      
      .image-box {
        position: relative;
        overflow: hidden;
        margin-bottom: 20px;
        height: 380px; 
        background-color: $esan-light-gray;
        
        img {
          width: 100%;
          height: 100%;
          object-fit: cover;
          object-position: top center;
          transition: transform 0.5s ease;
        }

        .placeholder-img {
            width: 100%; height: 100%; background: $esan-light-gray;
        }

        .overlay {
          position: absolute;
          top: 0; left: 0; width: 100%; height: 100%;
          background: rgba($esan-red, 0.9);
          opacity: 0; visibility: hidden;
          transition: all 0.3s ease-in-out;
          display: flex; align-items: center; justify-content: center;
          text-align: center;

          .hover-content {
            padding: 0 20px;
            transform: translateY(20px);
            transition: all 0.3s ease-in-out;
            ul {
                padding: 0; margin-bottom: 15px;
                li { list-style: none; display: inline-block; }
                a {
                    width: 35px; height: 35px; line-height: 35px;
                    background: $esan-white; color: $esan-red;
                    border-radius: 50%; display: block;
                    &:hover { background: $esan-black; color: $esan-white; }
                }
            }
            p { color: $esan-white; font-size: 14px; margin: 0; }
          }
        }
      }

      .text {
        text-align: center;
        h6 { font-size: 18px; font-weight: 600; color: $esan-black; margin-bottom: 5px; }
        span { font-size: 14px; color: #777; }
      }

      &:hover {
        .image-box img { transform: scale(1.1); }
        .image-box .overlay { opacity: 1; visibility: visible; }
        .image-box .hover-content { transform: translateY(0); }
        .text h6 { color: $esan-red; }
      }
    }
  }
}
</style>