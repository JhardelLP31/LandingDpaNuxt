export interface PostMeta {
    id?: number;
    key: string;
    value: string;
}

export interface Category {
    id: number;
    name: string;
}

export interface Post {
  id: number;
  user_id: number;
  title: string;
  slug: string;
  type: 'page' | 'course' | 'landing' | 'news';
  status: 'published' | 'draft' | 'archived';
  
  // EL CORAZÓN DEL BUILDER
  content_blocks?: any[]; // Ahora lo tipamos como array
  
  excerpt?: string;
  featured_image_path?: string; // O 'imagen' según tu backend
  status_course?: string;
  
  // RELACIONES
  categories?: Category[]; // Relación Many-to-Many
  meta?: PostMeta[];       // Relación One-to-Many (Precios, fechas)
  
  created_at: string;
}