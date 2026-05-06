import { fileURLToPath, URL } from 'node:url';

import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import Components from 'unplugin-vue-components/vite';
import { BootstrapVueNextResolver } from 'bootstrap-vue-next';

// https://vitejs.dev/config/

export default defineConfig({
  // CAMBIO: Ahora el proyecto entiende que vive en /admin/
  base: "/admin/", 
  plugins: [
    vue(),
    Components({
      resolvers: [BootstrapVueNextResolver()],
    }),
  ],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
      '@shared': fileURLToPath(new URL('../shared-blocks', import.meta.url))
    } 
  },
  server: {
    fs: {
      allow: ['..'] 
    },

  }
});