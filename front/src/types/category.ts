export interface CategoryDB {
  id: number;
  name: string;        // Se usará para 'title'
  slug: string;        // Se usará para construir la 'url'
  description?: string; 
  image_path?: string; // Se usará para 'image'
  color?: string;      // Se usará para 'color'
  is_active: number;
}