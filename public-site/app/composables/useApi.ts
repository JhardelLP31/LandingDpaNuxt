export const useApi = () => {
  const config = useRuntimeConfig();

  return {
    getPage: (unitSlug: string, pageSlug: string) => {
      return $fetch<any>(`public/pages/${unitSlug}/${pageSlug}`, {
        baseURL: config.public.apiBase,
        headers: { 'Accept': 'application/json' },
        // Si queremos que no lance excepción en 404, podríamos usar un try/catch aquí,
        // pero es mejor manejarlo en la página como ya lo haces.
      });
    },

    getUnitBrandingBySlug: (unitSlug: string) => {
      return $fetch<any>(`public/unit-branding/${unitSlug}`, {
        baseURL: config.public.apiBase,
        headers: { 'Accept': 'application/json' },
        onResponseError({ response }) {
          console.error(`❌ Error Branding (${unitSlug}):`, response._data?.message);
        }
      });
    },

    // 👇 AQUÍ AGREGAMOS LA FUNCIÓN DE NOTICIAS 👇
    getNewsBySlug: (unitSlug: string, newsSlug: string) => {
      // OJO: Verifica que esta ruta ('public/news/...') coincida con la ruta que creaste en tu Laravel
      return $fetch<any>(`public/news/${unitSlug}/${newsSlug}`, {
        baseURL: config.public.apiBase,
        headers: { 'Accept': 'application/json' },
        onResponseError({ response }) {
          console.error(`❌ Error de Noticia (${unitSlug}/${newsSlug}):`, response._data?.message);
        }
      });
    }
  };
};