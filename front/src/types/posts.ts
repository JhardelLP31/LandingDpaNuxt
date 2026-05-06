// 1. Definimos qué es una Categoría
export interface Category {
  id: number;
  name: string;
  slug?: string;
  color?: string; 
}

export interface Post {
  id: number;
  academic_unit_id?: number; // Agregado según tu esquema de DB
  user_id?: number;
  title: string;
  slug: string;
  type: string; 
  status: 'published' | 'draft' | 'archived';
  
  // Contenido dinámico
  content_blocks?: any[] | string; // Puede venir como array o string JSON
  excerpt?: string;
  
  // === LA SOLUCIÓN AL ERROR ===
  featured_image?: string | null; 
  featured_image_path?: string | null; 
  
  // SEO Config (Para que no te dé error al hacer el JSON.stringify)
  seo_config?: {
    title?: string;
    description?: string;
  } | string;

  start_date?: string; 
  end_date?: string;
  status_course?: string;
  published_at?: string;
  created_at: string;
  updated_at?: string;
  deleted_at?: string | null;

  // Relaciones
  category_id?: number;
  category?: Category | null;
}

// Respuesta del listado (Paginación de Laravel)
export interface PostsResponse {
  categories: Category[]; 
  pages: {
    data: Post[];
    current_page: number;
    last_page: number;
    total: number;
    per_page: number;
  };
  total: number;
  paginate: number;
}

// Respuesta al guardar/editar
export interface PostSingleResponse {
  success?: boolean; // Agregado para manejar la respuesta del backend
  post?: Post;
  data?: Post;
  page?: Post; // Laravel a veces lo envuelve con el nombre del modelo
  message: number | string;
  message_text: string;
}