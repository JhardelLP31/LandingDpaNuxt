import { defineAsyncComponent } from 'vue';

export const BRANDING_REGISTRY: Record<string, any> = {
    HeaderClassic: {
        label: '🏛️ Institucional Clásico',
        icon: 'las la-university',
        component: defineAsyncComponent(() => import('../components/branding/previews/HeaderClassic.vue')),
        editor: defineAsyncComponent(() => import('../components/branding/editors/HeaderClassicEditor.vue')),
        initialData: { 
            sticky: true, 
            showTopBar: true, 
            logoHeight: 60, 
            menuAlignment: 'right',
            topBarText: 'Portal Académico Oficial',
            menu_id: null 
        }
    },
    HeaderMega: {
        label: '🚀 Mega Menú Premium',
        icon: 'las la-layer-group',
        component: defineAsyncComponent(() => import('../components/branding/previews/HeaderMega.vue')),
        editor: defineAsyncComponent(() => import('../components/branding/editors/HeaderMegaEditor.vue')),
        initialData: { 
            sticky: true, 
            logoHeight: 70, 
            containerType: 'container',
            heavyShadow: true,
            ctaText: 'POSGRADO',
            menu_id: null 
        }
    },
    // --- PIES DE PÁGINA (FOOTERS) ---
    FooterPro: {
        label: '🏁 Footer Institucional Pro',
        icon: 'las la-shoe-prints',
        component: defineAsyncComponent(() => import('../components/branding/previews/FooterPro.vue')),
        editor: defineAsyncComponent(() => import('../components/branding/editors/FooterProEditor.vue')),
        initialData: { 
            logoUrl: '',
            logoHeight: 60,
            description: 'Institución líder enfocada en la excelencia académica y la formación integral.',
            bgColor: '#1a1a1a',
            textColor: '#ffffff',
            accentColor: '#cc0033',
            address: 'Av. Universitaria 123, Lima - Perú',
            phone: '+51 1 123 4567',
            email: 'contacto@universidad.edu.pe',
            socialLinks: [
                { icon: 'bi bi-facebook', url: '#' },
                { icon: 'bi bi-linkedin', url: '#' },
                { icon: 'bi bi-instagram', url: '#' }
            ],
            footerColumns: [
                { 
                    title: 'Institución', 
                    links: [
                        { text: 'Sobre nosotros', url: '#' },
                        { text: 'Transparencia', url: '#' },
                        { text: 'Noticias', url: '#' }
                    ] 
                },
                { 
                    title: 'Admisión', 
                    links: [
                        { text: 'Pregrado', url: '#' },
                        { text: 'Posgrado', url: '#' },
                        { text: 'Becas', url: '#' }
                    ] 
                }
            ],
            copyrightText: `© ${new Date().getFullYear()} Universidad. Todos los derechos reservados.`
        }
    },
    /*HeaderModern: {
        label: '🌿 Moderno / Minimalista',
        icon: 'las la-leaf',
        component: defineAsyncComponent(() => import('../components/branding/previews/HeaderModern.vue')),
        editor: defineAsyncComponent(() => import('../components/branding/editors/HeaderModernEditor.vue')),
        initialData: { 
            transparent: false, 
            searchEnabled: true, 
            logoHeight: 45,
            glassEffect: true,
            menu_id: null 
        }
    }*/
};

export const resolveBrandingComponent = (type: string) => BRANDING_REGISTRY[type]?.component || null;
export const resolveBrandingEditor = (type: string) => BRANDING_REGISTRY[type]?.editor || null;
export const getInitialBrandingData = (type: string) => JSON.parse(JSON.stringify(BRANDING_REGISTRY[type]?.initialData || {}));