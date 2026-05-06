export const formatImageUrl = (url?: string) => {
  if (!url) return 'https://placehold.co/600x400?text=Sin+Imagen';

  // 1. DETECTAR URLS EXTERNAS
  // Si empieza con http PERO NO tiene "/storage/", asumimos que es externa (ej: ui-avatars) y la dejamos pasar.
  if (url.startsWith('http') && !url.includes('/storage/')) {
    return url;
  }

  // 2. EXTRAER EL PATH REAL
  // Si la URL viene completa (ej: http://127.0.0.1/storage/media/foto.jpg),
  // la cortamos para quedarnos solo con "storage/media/foto.jpg"
  let cleanPath = url;
  if (url.startsWith('http') && url.includes('/storage/')) {
     const match = url.match(/(storage\/.*)/);
     if (match) {
        cleanPath = match[1]; // Esto descarta el "http://127.0.0.1" malo
     }
  }

  // 3. OBTENER TU BASE CORRECTA (.ENV)
  const baseUrl = import.meta.env.VITE_API_URL.replace(/\/$/, ""); 
  
  // 4. LIMPIEZA FINAL
  // Quitamos 'public/' (si existiera), quitamos barra inicial
  cleanPath = cleanPath.replace('public/', "").replace(/^\//, "");
  
  // Aseguramos que empiece con 'storage/'
  if (!cleanPath.startsWith('storage/')) {
    cleanPath = 'storage/' + cleanPath;
  }

  // 5. RECONSTRUCCIÓN: Pega tu dominio bueno (puerto 8000) con el path limpio
  return `${baseUrl}/${cleanPath}`;
};