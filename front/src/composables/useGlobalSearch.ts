import { ref } from 'vue';
import HttpClient from "@/helpers/http-client";

export function useGlobalSearch() {
  const search = ref('');
  const results = ref<any[]>([]); // Inicializamos como array vacío
  const loading = ref(false);

  const performSearch = async (val: string) => {
    if (!val || val.length < 3) {
      results.value = [];
      return;
    }

    loading.value = true;
    try {
      const response = await HttpClient.get('global-search', { params: { q: val } });
      
      results.value = response.data.data || [];
    } catch (error) {
      console.error("Error en la búsqueda:", error);
      results.value = []; // Si falla, vaciamos para que no explote la vista
    } finally {
      loading.value = false;
    }
  };

  return {
    search,
    results,
    loading,
    performSearch
  };
}