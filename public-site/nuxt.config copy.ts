// nuxt.config.ts
export default defineNuxtConfig({
  compatibilityDate: '2024-11-01',
  
  // Lo apago temporalmente para que no te salga el warning del iframe en la consola. 
  // Si quieres usar las devtools de Nuxt luego, ponlo en true.
  devtools: { enabled: false },

  // 0. IMPORTANTE: Indica que todo el código fuente está en la carpeta 'app'
  srcDir: 'app/',

  // 1. Módulos Core
  modules: ['@pinia/nuxt'],

  // 2. Reglas de Renderizado (El secreto de tu CMS)
  routeRules: {
    // El panel administrativo funciona como tu antigua SPA (sin SSR)
    '/admin/**': { ssr: false },
    // Las páginas públicas tienen SEO total (SSR)
    '/**': { ssr: true },
  },

  // 3. CSS Global
  // Al usar srcDir: 'app/', Nuxt ya sabe nativamente que '~' apunta a 'app/'.
  css: [
      '~/assets/scss/main.scss'
    ],

  // 4. Plugins
 /*plugins: [
    '~/plugins/bootstrap.client.ts',
    '~/plugins/apexcharts.client.ts'
  ],*/

  // 5. Variables de Entorno
  runtimeConfig: {
    public: {
      apiBase: process.env.API_BASE || 'http://localhost:8000/api'
    }
  },

  // 6. Configuración de Componentes
  // Esto permite que Nuxt encuentre tus bloques automáticamente
  components: [
    {
      path: '~/components/blocks',
      pathPrefix: false, // Así usas <BannerHero /> en vez de <BlocksBannerHero />
    },
    '~/components'
  ],

  // 7. Build & Transpile 
  // (OJO: Te faltaba esto de tu primer config, es vital para que ApexCharts no rompa el SSR)
  build: {
    transpile: ['vue3-apexcharts']
  }
})