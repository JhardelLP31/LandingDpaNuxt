import { fileURLToPath } from 'node:url'

export default defineNuxtConfig({
  compatibilityDate: '2024-11-01',
  devtools: { enabled: false },
  srcDir: 'app/',

  app: {
    head: {
      title: 'ESAN',
      charset: 'utf-8',
      viewport: 'width=device-width, initial-scale=1.0',
      link: [
        { rel: 'stylesheet', href: 'https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800&display=swap' },
        { rel: 'stylesheet', href: 'https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css' },
        { rel: 'stylesheet', href: 'https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css' }
      ]
    }
  },

  alias: {
    '@shared': fileURLToPath(new URL('../shared-blocks', import.meta.url))
  },

  vite: {
    server: {
      fs: { allow: ['..'] }
    },
    optimizeDeps: {
      include: ['axios', 'vue', 'vue-router']
    },
    // --- NUEVA CONFIGURACIÓN PARA SASS ---
    css: {
      preprocessorOptions: {
        scss: {
          quietDeps: true,
          // Si TS también se queja de 'silenceDeprecations', 
          // es que tus tipos de Vite son algo antiguos.
          silenceDeprecations: ['import', 'global-builtin', 'color-functions', 'if-function'],
        },
      },
    },
    // -------------------------------------
  },

  modules: ['@pinia/nuxt'],

  routeRules: {
    '/admin/**': { ssr: false },
    '/**': { ssr: true },
  },

  css: [
    '~/assets/scss/main.scss',
    '~/assets/fontawesome.6.7.2/css/all.min.css',
  ],

  runtimeConfig: {
    public: {
      apiBase: process.env.API_BASE || 'http://localhost:8000/api'
    }
  },

  components: [
    { path: '~/components/blocks', pathPrefix: false },
    '~/components'
  ],

  build: {
    transpile: ['vue3-apexcharts']
  }
})