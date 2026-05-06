<script setup lang="ts">
const props = defineProps<{
  data: any
}>();
</script>

<template>
  <section class="study-work-banner" :style="{
    backgroundColor: data.bgColor || '#ffb300',
    fontFamily: data.fontFamily || 'inherit'
  }">
    
    <div class="background-pattern" :style="{
      backgroundImage: data.bgPattern ? `url(${data.bgPattern})` : 'none',
      opacity: data.bgPatternOpacity ?? 0.15
    }"></div>

    <div class="container position-relative z-index-2 py-5 py-md-5">
      <div class="row justify-content-center">
        <div class="col-12 text-center d-flex justify-content-center">
          
          <div class="banner-content-wrapper" :style="{ 
            maxWidth: data.contentWidth ? `${data.contentWidth}px` : '900px', 
            width: '100%' 
          }">
            
            <h2 class="banner-title" v-if="data.title" :style="{ 
              color: data.titleColor || '#000000',
              fontSize: data.titleSize ? `${data.titleSize}px` : '30px'
            }">
              {{ data.title }}
            </h2>
            
            <h6 class="banner-subtitle" v-if="data.subtitle" :style="{ 
              color: data.subtitleColor || '#000000',
              fontSize: data.subtitleSize ? `${data.subtitleSize}px` : '15px'
            }">
              {{ data.subtitle }}
            </h6>

          </div>

        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.study-work-banner {
  position: relative;
  overflow: hidden;
  display: flex;
  align-items: center;
}

.background-pattern {
  position: absolute;
  top: 0; left: 0; width: 100%; height: 100%;
  z-index: 1;
  background-repeat: repeat;
  background-position: center;
}

.z-index-2 {
  z-index: 2;
}

.banner-title {
  /* Eliminamos el max-width fijo, ahora lo controla el wrapper */
  margin: 0 auto 20px auto; 
  font-weight: 900;
  text-transform: uppercase;
  line-height: 1;
}

.banner-subtitle {
  /* Eliminamos el max-width fijo, ahora lo controla el wrapper */
  margin: 0 auto; 
  font-weight: 900;
  text-transform: uppercase;
  line-height: 1.2; /* Lo subí un pelín de 1 a 1.2 para mejor lectura si ocupa varias líneas */
}

@media (max-width: 767px) {
  .banner-title {
    margin-bottom: 15px;
  }
}
</style>