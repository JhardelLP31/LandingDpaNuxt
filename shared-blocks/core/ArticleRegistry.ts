import { defineAsyncComponent } from 'vue';

// Registro centralizado de plantillas de noticias
export const ARTICLE_LAYOUT_REGISTRY: Record<string, any> = {
    classic: {
        id: 'classic',
        label: '📰 Diseño Clásico',
        description: 'Imagen principal arriba, título y texto a una columna debajo.',
        icon: 'las la-newspaper',
        // Este es el componente que renderizará la noticia en el frontend de la página
        component: defineAsyncComponent(() => import('../components/articles/layouts/ArticleClassic.vue')),
    },
    hero: {
        id: 'hero',
        label: '🔥 Moderno (Hero)',
        description: 'Imagen gigante de fondo ocupando toda la pantalla con título superpuesto.',
        icon: 'las la-image',
        component: defineAsyncComponent(() => import('../components/articles/layouts/ArticleHero.vue')),
    },
    editorial: {
        id: 'editorial',
        label: '📖 Estilo Editorial',
        description: 'Diseño tipo revista, imagen a un lado y contenido fluyendo al otro.',
        icon: 'las la-book-open',
        component: defineAsyncComponent(() => import('../components/articles/layouts/ArticleEditorial.vue')),
    }
};

// Funciones Helper
export const resolveArticleLayout = (type: string) => {
    // Si el tipo no existe, retornamos el clásico por defecto para que no se rompa la web
    return ARTICLE_LAYOUT_REGISTRY[type]?.component || ARTICLE_LAYOUT_REGISTRY['classic'].component;
};

// Utilidad para obtener la lista de opciones (Ideal para tu Sidebar en el NewsEditor)
export const getAvailableArticleLayouts = () => {
    return Object.values(ARTICLE_LAYOUT_REGISTRY).map(layout => ({
        id: layout.id,
        label: layout.label,
        description: layout.description,
        icon: layout.icon
    }));
};