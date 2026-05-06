import { defineAsyncComponent } from 'vue';
// Configuración de Grupos para la Interfaz
export const blockGroups = [
    {
        label: 'Estructurales',
        color: 'outline-dark',
        icon: 'las la-desktop',
        keys: ['BannerHero', 'LegoSection', 'SpacerBlock']
    },
    {
        label: 'Institucional',
        color: 'outline-primary',
        icon: 'las la-building',
        keys: ['AboutCompany', 'OurTeacher', 'AchievementData', 'PartnerSlider', 'TestimonialsBlock']
    },
    {
        label: 'Grillas y Contenido',
        color: 'outline-success',
        icon: 'las la-th-large',
        keys: ['DynamicCourseGrid', 'NewsBentoGrid', 'ServiceGrid', 'SectorSection', 'UniversalGrid', 'NewsMega', 'NewsArticleView']
    },
    {
        label: 'Conversión y Footer',
        color: 'outline-danger',
        icon: 'las la-bullhorn',
        keys: [
            'FeatureBanner',
            'ContactSection',
            'Stats',
            'ImpactHeroBlock',
            'CategorySystemGrid',
            'CategoryTypeGrid',
            'CallToActionBlock',
            'NewsletterBlock',
            'FooterSimpleBlock',
            'WelcomeMessageBlock',
            'RawHtmlBlock',
            'VideoGalleryBlock',
        ]
    },
    {
        label: 'OldsSection / Soporte', 
        color: 'outline-secondary',     
        icon: 'las la-archive',         
        keys: [
            'ServiceDeskBlock',
            'StudentSupportBlock',
            'ResourceDownloadBlock',
            'ProcedureHeroBlock',
        ]
    },
];

// Mapa de iconos específicos (para mantener tus iconos originales)
export const blockIcons: Record<string, string> = {
    'BannerHero': 'las la-desktop',
    'LegoSection': 'las la-cubes',
    'AboutCompany': 'las la-building',
    'OurTeacher': 'las la-user-tie',
    'AchievementData': 'las la-trophy',
    'PartnerSlider': 'las la-handshake',
    'TestimonialsBlock': 'las la-quote-left',
    'DynamicCourseGrid': 'las la-graduation-cap',
    'NewsBentoGrid': 'las la-newspaper',
    'ServiceGrid': 'las la-concierge-bell',
    'SectorSection': 'las la-industry',
    'UniversalGrid': 'las la-th-large',
    'FeatureBanner': 'las la-bullhorn',
    'ContactSection': 'las la-envelope-open-text',
    'Stats': 'las la-chart-bar',
    'ImpactHeroBlock': 'las la-bolt',
    'CategorySystemGrid': 'las la-folder',
    'CategoryTypeGrid': 'las la-list',
    'CallToActionBlock': 'las la-external-link-alt',
    'FooterSimpleBlock': 'las la-arrow-down',
    'WelcomeMessageBlock': 'las la-comment-alt',
    'RawHtmlBlock': 'las la-code',
    'SpacerBlock': 'las la-arrows-alt-v',
    'ServiceDeskBlock': 'las la-headset',
    'StudentSupportBlock': 'las la-user-graduate',
    'VideoGalleryBlock': 'las la-photo-video',
    'ResourceDownloadBlock': 'las la-file-download',
    'ProcedureHeroBlock': 'las la-image', 
};
// 1. IMPORTACIÓN DE COMPONENTES
export const BlockComponents: any = {
    'CourseDetailBlock': defineAsyncComponent(() => import('../components/blocks/page/CourseDetailBlock.vue')),
    'DynamicCourseGrid': defineAsyncComponent(() => import('../components/blocks/grid/DynamicCourseGrid.vue')),
    'BannerHero': defineAsyncComponent(() => import('../components/blocks/page/BannerHero.vue')),
    'PartnerSlider': defineAsyncComponent(() => import('../components/blocks/page/PartnerSlider.vue')),
    'AboutCompany': defineAsyncComponent(() => import('../components/blocks/page/AboutCompany.vue')),
    'ContactSection': defineAsyncComponent(() => import('../components/blocks/page/ContactSection.vue')),
    'SectorSection': defineAsyncComponent(() => import('../components/blocks/grid/SectorSection.vue')),
    'AchievementData': defineAsyncComponent(() => import('../components/blocks/page/AchievementData.vue')),
    'OurTeacher': defineAsyncComponent(() => import('../components/blocks/page/OurTeacher.vue')),
    'FeatureBanner': defineAsyncComponent(() => import('../components/blocks/page/FeatureBanner.vue')),
    'NewsletterBlock': defineAsyncComponent(() => import('../components/blocks/page/NewsletterBlock.vue')),
    'ServiceGrid': defineAsyncComponent(() => import('../components/blocks/page/ServiceGrid.vue')),
    'UniversalGrid': defineAsyncComponent(() => import('../components/blocks/page/UniversalGrid.vue')),
    'LegoSection': defineAsyncComponent(() => import('../components/blocks/page/LegoSection.vue')),
    'NewsMega': defineAsyncComponent(() => import('../components/blocks/page/NewsMega.vue')),
    'NewsArticleView': defineAsyncComponent(() => import('../components/blocks/page/NewsArticle.vue')),
    'TestimonialsBlock': defineAsyncComponent(() => import('../components/blocks/page/TestimonialsBlock.vue')),
    'NewsBentoGrid': defineAsyncComponent(() => import('../components/blocks/grid/NewsBentoGrid.vue')),
    'Stats': defineAsyncComponent(() => import('../components/sections/page/Stats.vue')),
    'ImpactHeroBlock': defineAsyncComponent(() => import('../components/sections/page/ImpactHeroBlock.vue')),
    'CategorySystemGrid': defineAsyncComponent(() => import('../components/sections/page/CategorySystemGrid.vue')),
    'CategoryTypeGrid': defineAsyncComponent(() => import('../components/sections/grids/CategoryTypeGrid.vue')),
    'CallToActionBlock': defineAsyncComponent(() => import('../components/sections/page/CallToActionBlock.vue')),
    'FooterSimpleBlock': defineAsyncComponent(() => import('../components/sections/page/FooterSimpleBlock.vue')),
    'WelcomeMessageBlock': defineAsyncComponent(() => import('../components/sections/page/WelcomeMessageBlock.vue')),
    'RawHtmlBlock': defineAsyncComponent(() => import('../components/sections/page/RawHtmlBlock.vue')),
    'SpacerBlock': defineAsyncComponent(() => import('../components/sections/page/SpacerBlock.vue')),
    'ServiceDeskBlock': defineAsyncComponent(() => import('../components/sections/page/ServiceDeskBlock.vue')),
    'StudentSupportBlock': defineAsyncComponent(() => import('../components/sections/page/StudentSupportBlock.vue')),
    'VideoGalleryBlock': defineAsyncComponent(() => import('../components/sections/page/VideoGalleryBlock.vue')),
    'ResourceDownloadBlock': defineAsyncComponent(() => import('../components/sections/page/ResourceDownloadBlock.vue')),
    'ProcedureHeroBlock': defineAsyncComponent(() => import('../components/sections/page/ProcedureHeroBlock.vue')),
};
export const EditorComponents: any = {
    // --- NUEVO ---
    'FeatureBanner': defineAsyncComponent(() => import('../components/blocks/editors/FeatureBannerEditor.vue')),
    'BannerHero': defineAsyncComponent(() => import('../components/blocks/editors/BannerHeroEditor.vue')),
    'PartnerSlider': defineAsyncComponent(() => import('../components/blocks/editors/PartnerSliderEditor.vue')),
    'AchievementData': defineAsyncComponent(() => import('../components/blocks/editors/AchievementDataEditor.vue')),
    'ContactSection': defineAsyncComponent(() => import('../components/blocks/editors/ContactSectionEditor.vue')),
    'OurTeacher': defineAsyncComponent(() => import('../components/blocks/editors/OurTeacherEditor.vue')),
    'AboutCompany': defineAsyncComponent(() => import('../components/blocks/editors/AboutCompanyEditor.vue')),
    'NewsletterBlock': defineAsyncComponent(() => import('../components/blocks/editors/NewsletterEditor.vue')),
    'ServiceGrid': defineAsyncComponent(() => import('../components/blocks/editors/ServiceGridEditor.vue')),
    'UniversalGrid': defineAsyncComponent(() => import('../components/blocks/editors/UniversalGridEditor.vue')),
    'LegoSection': defineAsyncComponent(() => import('../components/blocks/editors/LegoSectionEditor.vue')),
    'NewsMega': defineAsyncComponent(() => import('../components/blocks/editors/NewsMegaEditor.vue')),
    'NewsArticleView': defineAsyncComponent(() => import('../components/blocks/editors/NewsArticleEditor.vue')),
    'TestimonialsBlock': defineAsyncComponent(() => import('../components/blocks/editors/TestimonialsEditor.vue')),
    'NewsBentoGrid': defineAsyncComponent(() => import('../components/blocks/editors/NewsBentoEditor.vue')),
    'Stats': defineAsyncComponent(() => import('../components/sections/editor/StatsEditor.vue')),
    'ImpactHeroBlock': defineAsyncComponent(() => import('../components/sections/editor/ImpactHeroBlockEditor.vue')),
    'CategorySystemGrid': defineAsyncComponent(() => import('../components/sections/editor/CategorySystemGridEditor.vue')),
    'CategoryTypeGrid': defineAsyncComponent(() => import('../components/sections/editorGrids/CategoryTypeGridEditor.vue')),
    'CallToActionBlock': defineAsyncComponent(() => import('../components/sections/editor/CallToActionBlock.vue')),
    'FooterSimpleBlock': defineAsyncComponent(() => import('../components/sections/editor/FooterSimpleEditor.vue')),
    'WelcomeMessageBlock': defineAsyncComponent(() => import('../components/sections/editor/WelcomeMessageEditor.vue')),
    'RawHtmlBlock': defineAsyncComponent(() => import('../components/sections/editor/RawHtmlEditor.vue')),
    'SpacerBlock': defineAsyncComponent(() => import('../components/sections/editor/SpacerEditor.vue')),
    'ServiceDeskBlock': defineAsyncComponent(() => import('../components/sections/editor/ServiceDeskBlock.vue')),
    'StudentSupportBlock': defineAsyncComponent(() => import('../components/sections/editor/StudentSupportEditor.vue')),
    'VideoGalleryBlock': defineAsyncComponent(() => import('../components/sections/editor/VideoGalleryEditor.vue')),
    'ResourceDownloadBlock': defineAsyncComponent(() => import('../components/sections/editor/ResourceDownloadEditor.vue')),
    'ProcedureHeroBlock': defineAsyncComponent(() => import('../components/sections/editor/ProcedureHeroEditor.vue')),
};
// 2. RESOLVER
export const resolveBlock = (type: string) => {
    return BlockComponents[type] || null;
};
export const resolveEditor = (type: string) => {
    return EditorComponents[type] || null;
};

// 3. ETIQUETAS (Nombres bonitos)
export const BlockLabels: Record<string, string> = {
    'CourseDetailBlock': '📚 Detalle de Curso (Landing)',
    'DynamicCourseGrid': '🔄 Galería Automática de Cursos',
    'BannerHero': '📸 Portada Principal (Hero)',
    'PartnerSlider': '🤝 Alianzas y Acreditaciones (Logos)',
    'AchievementData': '🏆 Banner de Logros Institucionales',
    'AboutCompany': '🏢 Nuestra Historia (Img + Texto)',
    'ContactSection': '📚 Seccion de Contacto',
    'SectorSection': '🏭 Grilla de Sectores (Desde BD)',
    'OurTeacher': '👨‍🏫 Nuestro Equipo (Grilla)',
    'FeatureBanner': '📢 Banner CTA (Fondo + Botón)',
    'NewsletterBlock': '📢 News',
    'ServiceGrid': '📢 Servicios',
    'UniversalGrid': '📢 Grid Universal',
    'NewsMega': '📰 Mega Grilla de Noticias (Bento)',
    'NewsArticleView': '📄 Blog: Detalle de Artículo',
    'LegoSection': '🧱 Constructor LEGO (Cols + Texto/Img)',
    'TestimonialsBlock': '💬 Testimonios (Carrusel Flotante)',
    'NewsBentoGrid': '📰 Bento Grid (Automático)',
    'Stats': '📰 Stats)',
    'ImpactHeroBlock': '💥 Hero de Impacto (ISO/Cert)',

    'CategorySystemGrid': '🎓 Grid de Cursos (Por Categoría)',
    'CategoryTypeGrid': '📂 Listado de Categorías (Por Tipo)',
    'CallToActionBlock': '🌗 Call To Action (Split Texto/Imagen)',
    'FooterSimpleBlock': '🔻 Footer (Social + Copyright)',
    'WelcomeMessageBlock': '👋 Mensaje de Bienvenida (Dir. TI)',
    'RawHtmlBlock': 'Bloque de HTML (Libre)',
    'SpacerBlock': 'Linea de Separación ',
    'ServiceDeskBlock': '🎧 Mesa de Ayuda (Service Desk)',
    'StudentSupportBlock': '🎓 Soporte Alumnos',
    'VideoGalleryBlock': '🎬 Galería de Videos (Youtube)',
    'ResourceDownloadBlock': '📥 Grilla de Descargas (con Sidebar)',
    'ProcedureHeroBlock': '🖼️ Banner Procedimientos (Full Width)',
};
// 4. DATOS INICIALES (Para evitar errores al crear)
export const BlockInitialData: Record<string, any> = {
    'ProcedureHeroBlock': {
        title: 'PROCEDIMIENTOS',
        bgImage: 'https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?q=80&w=1920&auto=format&fit=crop',
        overlayOpacity: 0.6,
        height: '300px'
    },
    'ResourceDownloadBlock': {
        pageTitle: "Alumnos",
        sidebarTitle: "MANUALES",
        cards: [
            { title: "VIDEOCONFERENCIA INSTRUCTIVO", links: [{ url: "#", label: "Descarga aquí" }] },
            { title: "INDUCCION PREGRADO", links: [{ url: "#", label: "Descarga aquí" }] },
        ]
    },

    'ServiceDeskBlock': {
        title: "MESA DE AYUDA O SERVIDESK",
        // Aquí va el HTML rico que editarás con Quill
        description: `
            <div style="text-align: justify;">Nos permite brindar a nuestros usuarios un único punto de contacto para registrar, identificar y optimizar el flujo de requerimientos e incidencias para una pronta atención logrando mejoras en los procesos y procedimientos de atención con nuestros clientes.</div>
            <div class="nota" style="margin-top: 15px;">
                <p style="text-align: justify;">
                    <br>Para mayor información, por favor comuníquese al Service Desk al número de teléfono <strong>317 7200 anexo 4000</strong> o envíe un correo al <a href="mailto:servicedesk..esan.edu.pe">servicedesk..esan.edu.pe</a> de lunes a viernes de 9:00 am a 9:00 pm.
                </p>
            </div>`,
        buttonText: "Ir a la plataforma",
        buttonUrl: "https://servicedesk.esan.edu.pe/",
        videoUrl: "https://www.youtube.com/watch?v=hQmclCZyy8s"
    },
    'SpacerBlock': {
        height: 60,         // Altura por defecto cómoda
        showLine: false,    // Por defecto invisible (solo espacio)
        config: {
            lineColor: '#dddddd',
            lineStyle: 'solid',
            lineWidth: '100%',
            lineThickness: 1
        }
    },
    'RawHtmlBlock': {
        htmlCode: '<h2>Título de ejemplo</h2><p>Edita este contenido usando las pestañas.</p>',
        helperImage: '', // Campo auxiliar para el selector
        config: {
            container: 'container',
            paddingY: 'py-5'
        }
    },
    'WelcomeMessageBlock': {
        // Imágenes vacías para que el usuario las suba
        mainImage: '',
        signatureImage: '',

        // Textos por defecto
        signatureTitle: 'Jefe del área de Tecnologías de Información',
        content: `<p>En nombre de todo el equipo de Esandata le damos la más cordial bienvenida a nuestra página web, en la cual esperamos que encuentren toda la información que necesitan acerca de nosotros.</p><p>El área de Tecnología de Información y de Sistemas de la Universidad ESAN es el área encargada de la gestión y administración de las redes de comunicaciones.</p>`,

        // CONFIGURACIÓN DE COLORES (Aquí está la magia)
        config: {
            textAlign: 'justify',

            bgSplitTop: '#f9f9f9',

            bgSplitBottom: '#14142b',

            cardBgColor: '#ffffff'
        }
    },
    'CallToActionBlock': {
        preTitle: 'NUESTROS',
        title: 'PROYECTOS',
        btnText: 'MÁS INFORMACIÓN',
        btnLink: '#',
        image: '', // Iniciará sin imagen o puedes poner una url por defecto
        config: {
            bgColor: 'transparent',
            invertLayout: false // Por defecto: Texto Izquierda | Imagen Derecha
        }
    },
    'FooterSimpleBlock': {
        copyrightText: '© Copyright {year} <strong>ESANDATA</strong>. All Rights Reserved.',
        socials: [
            {
                platform: 'Facebook',
                url: 'https://www.facebook.com/esandata',
                iconClass: 'fab fa-facebook' // Versión moderna de fa-facebook-official
            },
            {
                platform: 'YouTube',
                url: 'https://www.youtube.com/user/audiovisualesuesan',
                iconClass: 'fab fa-youtube' // Versión moderna de fa-youtube-square
            }
        ],
        config: {
            bgColor: '#ffffff', // El footer original parece tener fondo blanco o muy claro en la imagen
            textColor: '#333333',
            iconColor: '#555555'
        }
    },
    'CategorySystemGrid': {
        categoryId: null,       // ID Seleccionado
        titleOverride: '',      // Título opcional
    },

    // 2. Grid de Categorías (News, Post, etc)
    'CategoryTypeGrid': {
        selectedType: 'post',   // Tipo por defecto
        titleOverride: '',      // Título opcional
    },
    'ImpactHeroBlock': {
        title: 'RENOVACIÓN DE LA CERTIFICACIÓN ISO-9001-2015',
        description: 'La Unidad de Laboratorio de ESANDATA logra renovar la certificación ISO 9001-2015',
        image: '/images/logos-juntos.png',
        btnText: 'MÁS INFORMACIÓN',
        btnLink: '/noticias/iso-9001',
        config: {
            bgImage: 'https://images.unsplash.com/photo-1497366216548-37526070297c?auto=format&fit=crop&q=80',
            align: 'left', // left, center, right
            paddingTop: '80',
            paddingBottom: '80'
        }
    },
    'Stats': {
        title: 'NUESTRA PROPUESTA',
        subtitle: '¿Por qué elegir FRI ESAN?',
        items: [
            {
                id: 1,
                size: 'large', // Ocupa 2 columnas
                title: 'Excelencia Académica',
                desc: 'Respaldo de la Universidad ESAN con estándares internacionales.',
                icon: 'las la-university',
                bgColor: '#144c74', // Azul
                textColor: '#ffffff'
            },
            {
                id: 2,
                size: 'small',
                title: 'Plana Global',
                desc: 'Docentes de clase mundial.',
                icon: 'las la-globe',
                bgColor: '#e31140', // Rojo
                textColor: '#ffffff'
            },
            {
                id: 3,
                size: 'small',
                title: 'Certificación',
                desc: 'Certificados digitales con validación blockchain.',
                icon: 'las la-certificate',
                bgColor: '#ffffff', // Blanco
                textColor: '#144c74'
            },
            {
                id: 4,
                size: 'medium', // Ocupa 2 filas
                title: 'Networking Activo',
                desc: 'Conecta con más de 50,000 profesionales del sector público y privado en una red exclusiva de aprendizaje.',
                icon: 'las la-users',
                bgColor: '#eaeff5', // Gray-200 de tu SCSS
                textColor: '#2b2d3b'
            }
        ]
    },
    'TestimonialsBlock': {
        title: 'Que dicen de nosotros',
        subtitle: 'En la era digital, la satisfacción del cliente es nuestra mayor recompensa.',
        decorations: {
            leftSmall: 'https://i.pravatar.cc/150?u=3',
            leftLarge: 'https://i.pravatar.cc/150?u=1',
            rightSmall: 'https://i.pravatar.cc/150?u=6',
            rightLarge: 'https://i.pravatar.cc/150?u=5',
            bottomSmall: 'https://i.pravatar.cc/150?u=4'
        },
        items: [
            {
                name: 'Alejandra Miranda',
                role: 'Gerente de Alanda',
                quote: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore.',
                linkText: 'Ver proyecto',
                linkUrl: '#'
            },
            {
                name: 'Carlos Benitez',
                role: 'Director TI',
                quote: 'La implementación fue impecable. El equipo entendió perfectamente nuestras necesidades.',
                linkText: 'Ver caso',
                linkUrl: '#'
            },
            {
                name: 'Maria Gracia',
                role: 'Founder DesignCo',
                quote: 'Creatividad pura y dura. Superaron las expectativas visuales.',
                linkText: 'Ver web',
                linkUrl: '#'
            }
        ]
    },
    'NewsBentoGrid': {
        title: 'Actualidad & Tendencias',
        subtitle: 'Publicaciones Recientes',
        limit: 7
    },
    // Datos del Curso
    'CourseDetailBlock': {
        // Datos Básicos
        category: 'Categoría',
        categoryColor: '22c55e',
        title: 'Nuevo Curso',
        subtitle: '',
        // Detalles
        startDate: '',
        duration: '',
        price: '',
        schedule: '',
        // Contacto
        whatsappNumber: '51918378298',
        whatsappDisplay: '',
        // Contenido HTML
        presentation: '',
        // Listas (Arrays)
        objectives: ['Objetivo 1'],
        profile: ['Perfil 1'],
        benefits: ['Beneficio 1'],
        importantNotes: ['FRI ESAN se reserva el derecho de modificar la plana docente, por disponibilidad (previo aviso).'
            , 'La apertura está sujeta a un mínimo de participantes.'
            , 'Se emitirá certificado digital expedido por la Universidad ESAN.'
            , 'Se proporcionará material digital para las clases.'
            , 'Devoluciones: 45 días hábiles posteriores al envío de la solicitud de devolución.'
            , 'Los descuentos no son acumulables, a excepción del descuento de pago al contado (8%).'
            , 'La modalidad de clases es virtual en todos los cursos y diplomas ofrecidos por el FRI ESAN.'],        // NUEVO
        curriculum: ['Tema 1'],
        // Otros
        certification: '',
        teachers: [],
        brochureUrl: '',
    },

    'DynamicCourseGrid': {
        title: 'Próximos Inicios',
        limit: 4
    },
    'BannerHero': {
        autoPlayInterval: 5000,
        slides: [
            {
                id: 1,
                layout: 'standard-mode',
                imageUrl: '',
                title: 'TÍTULO PRINCIPAL<br>DEL BANNER',
                preTitle: 'Bienvenidos',
                btnText: 'CONTÁCTANOS',
                btnLink: '#contact',
                statsNumber: '10',
                statsLabel: 'AÑOS'
            }
        ]
    },
    'PartnerSlider': {
        title: 'RANKING, ACREDITACIONES Y MEMBRESÍAS',
        bgColor: '#f8f9fa',
        partners: [
            { image: '', alt: 'Logo 1' },
            { image: '', alt: 'Logo 2' },
            { image: '', alt: 'Logo 3' }
        ]
    },

    // --- NUEVO ---
    'AboutCompany': {
        title: 'NUESTRA HISTORIA',
        image: '',
        content: '<p>El instituto de Regulación y Finanzas - FRI ESAN - de la Universidad ESAN fue fundado en el año 2001. Como instituto buscamos colaborar en el desarrollo y fortalecimiento de las instituciones públicas y privadas de nuestro país.</p>'
    },
    'ContactSection': {
        title: 'AGENDEMOS UNA REUNIÓN',
        subtitle: 'Completa el formulario y uno de nuestros consultores se pondrá en contacto contigo a la brevedad.',
        buttonText: 'ENVIAR MENSAJE',
        image: '',
        fields: [
            // Antes tenías un solo 'nombre', ahora sepáralo:
            { type: 'text', label: 'Nombres', name: 'first_name', required: true, placeholder: 'Juan' },
            { type: 'text', label: 'Apellidos', name: 'last_name', required: true, placeholder: 'Perez' },
            { type: 'email', label: 'Correo', name: 'email', required: true, placeholder: 'correo@ejemplo.com' },
            { type: 'tel', label: 'Teléfono', name: 'phone', required: false, placeholder: '999...' },
            { type: 'textarea', label: 'Mensaje', name: 'message', required: true, placeholder: '...' }
        ]
    },
    'SectorSection': {
        title: 'Sectores' // Solo necesitamos el título, la data viene sola de la BD
    },
    'AchievementData': {
        subtitle: 'LOGROS ALCANZADOS',
        title: 'Algunos datos sobre nuestra institución',
        buttonText: 'CONTÁCTANOS',
        buttonLink: '#contact_section',
        backgroundImage: '', // Se puede dejar vacío para usar un color sólido o subir una imagen
        counters: [
            { id: 1, value: 20, suffix: '+', description: 'años de trayectoria en capacitación y consultoría.' },
            { id: 2, value: 1000, suffix: '+', description: 'empresas atendidas con éxito.' },
            { id: 3, value: 50000, suffix: "+", description: "profesionales capacitados globalmente." }
        ]
    },
    'OurTeacher': {
        title: 'Nuestro Equipo',
        description: 'Contamos con un equipo multidisciplinario de profesionales apasionados.',
        items: [
            {
                name: 'Nombre Apellido',
                position: 'Cargo del experto',
                hover_text: 'Especialista en...',
                linkedin: 'https://linkedin.com',
                image: ''
            }
        ]
    },
    'FeatureBanner': {
        title: 'Más de 250 instituciones públicas y privadas atendidas.',
        buttonText: 'CONTÁCTANOS',
        buttonLink: '#contact_section',
        backgroundImage: '' // Inicia vacío
    },
    'ServiceGrid': {
        items: [
            {
                title: 'APP y Proyectos',
                description: 'Formulación y evaluación financiera de proyectos públicos y privados.',
                link: '#',
                image: '' // Aquí irá la URL cuando suban la imagen
            },
            {
                title: 'Regulación Legal',
                description: 'Análisis normativo y soporte legal especializado en finanzas.',
                link: '#',
                image: ''
            },
            {
                title: 'Consultoría',
                description: 'Soluciones estratégicas para el crecimiento empresarial.',
                link: '#',
                image: ''
            }
        ]
    },

    // 👇 Y SI VAS A USAR EL NEWSLETTER, AGREGA ESTO TAMBIÉN
    'NewsletterBlock': {
        title: 'MANTENTE INFORMADO',
        subtitle: 'Suscríbete para recibir nuestras últimas noticias y novedades.',
        buttonText: 'SUSCRIBIRSE'
    },
    'UniversalGrid': {
        config: {
            columns: 3,
            cardStyle: 'swipe-red', // El rojo por defecto
            textAlign: 'left'
        },
        items: [
            { title: 'Item 1', description: 'Ejemplo...', image: '', link: '' },
            { title: 'Item 2', description: 'Ejemplo...', image: '', link: '' },
            { title: 'Item 3', description: 'Ejemplo...', image: '', link: '' }
        ]
    },
    'LegoSection': {
        rows: [
            {
                layout: '2-col', // Una fila dividida en dos
                columns: [
                    {
                        title: 'Título a la Izquierda',
                        subtitle: 'INTRODUCCIÓN',
                        text: 'Aquí puedes poner una imagen a la derecha y texto a la izquierda. Tú controlas el layout.',
                        align: 'text-start',
                        isCard: false,
                        headingSize: 'h2'
                    },
                    {
                        title: 'Imagen Destacada',
                        text: '',
                        image: '', // Aquí iría una imagen
                        align: 'text-center',
                        isCard: true, // Esto le pondrá borde y sombra
                        headingSize: 'h3'
                    }
                ]
            }
        ]
    },
    'NewsMega': {
        sectionTitle: 'ÚLTIMAS NOTICIAS',
        articles: [
            {
                category: 'DESTACADO',
                title: 'Título de la Noticia Principal <br> en Formato Grande',
                excerpt: 'Este es el resumen que solo se verá en la noticia principal de la izquierda...',
                imageUrl: '',
                date: '15 Ene, 2026',
                readTime: '5 min',
                author: 'Redacción',
                link: '#'
            },
            {
                category: 'TENDENCIA',
                title: 'Noticia Secundaria Superior',
                imageUrl: '',
                date: '14 Ene',
                readTime: '3 min',
                author: 'Admin',
                link: '#'
            },
            {
                category: 'ACTUALIDAD',
                title: 'Noticia Secundaria Inferior',
                imageUrl: '',
                date: '13 Ene',
                readTime: '4 min',
                author: 'Admin',
                link: '#'
            }
        ]
    },
    'NewsArticleView': {
        category: 'TENDENCIAS',
        accentColor: '#e63946',
        title: 'El futuro de la Educación Superior: <br> Más allá de las aulas',
        subtitle: 'Un análisis exhaustivo sobre cómo la tecnología está redefiniendo el aprendizaje presencial y virtual en las próximas décadas.',
        imageUrl: '',
        author: 'Dra. María González',
        authorRole: 'Directora de Postgrado',
        authorImage: '',
        date: '15 de Enero, 2026',
        readTime: '10 min',
        content: `
      <h2>El cambio de paradigma</h2>
      <p>La educación ya no es un lugar al que se va, sino una experiencia que se vive...</p>
      <blockquote>"La innovación no es solo usar tablets, es cambiar la forma en que conectamos el conocimiento."</blockquote>
      <p>Continúa redactando tu artículo aquí con Quill...</p>
    `
    },

};