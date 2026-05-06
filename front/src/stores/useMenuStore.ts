// stores/menuStore.ts
import { defineStore } from 'pinia';
import HttpClient from "@/helpers/http-client";

export const useMenuStore = defineStore('menu', {
  state: () => ({
    items: [],
    isLoaded: false, // <--- ESTA ES LA CLAVE
    loading: false
  }),

  actions: {
    async fetchPublicMenu() {
      // SI YA ESTÁ CARGADO, NO HAGAS NADA (Retorna lo que hay en memoria)
      if (this.isLoaded) return; 

      this.loading = true;
      try {
        const { data } = await HttpClient.get('public-menu');
        this.items = data;
        this.isLoaded = true; // Marcamos como cargado
      } catch (e) {
        console.error(e);
      } finally {
        this.loading = false;
      }
    }
  }
});