  export const formatImageUrl = (url?: string) => {
      if (!url) return 'https://placehold.co/600x400?text=Subir+Imagen';

    let finalUrl = url;

    // 1. Si es relativa, construir la ruta completa
    if (!url.startsWith('http')) {
      const baseUrl = import.meta.env.VITE_API_URL;
      // Quitamos 'public/' si existe y aseguramos que empiece con 'storage/'
      let cleanPath = url.replace('public/', '');
      if (!cleanPath.startsWith('storage/')) cleanPath = 'storage/' + cleanPath;
      if (!cleanPath.startsWith('/')) cleanPath = '/' + cleanPath;
      
      finalUrl = `${baseUrl}${cleanPath}`;
    }

    // 2. Limpieza de dobles barras (Excepto en http://)
    // Esta regex es la que salvó tus imágenes
    return finalUrl.replace(/([^:]\/)\/+/g, "$1");
  };