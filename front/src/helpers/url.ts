export const formatImageUrl = (url?: string) => {
  if (!url) return 'https://placehold.co/600x400?text=Sin+Imagen';

  // 1. Caso especial: Si ya es una URL externa (no local)
  if (url.startsWith('http') && !url.includes('/storage/')) {
    return url;
  }

  // 2. Extraer solo la parte importante: media/foto.jpg
  // Buscamos lo que esté después de /storage/ o storage/
  let cleanPath = url;
  if (url.includes('storage/')) {
    cleanPath = url.split('storage/').pop() || ''; 
  }

  const baseUrl = import.meta.env.VITE_API_URL.replace(/\/+$/, ""); 
  
  // 4. Limpieza del path
  cleanPath = cleanPath
    .replace('public/', "")
    .replace(/^\/+/, "") 
    .replace(/\/+/g, "/");

  // 5. Reconstrucción forzada
  return `${baseUrl}/storage/${cleanPath}`;
};