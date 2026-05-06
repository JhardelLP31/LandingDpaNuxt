import { defineAsyncComponent } from 'vue';

// =========================================================================
// 1. EL REGISTRO MAESTRO (Debe ir PRIMERO para que el resto pueda leerlo)
// =========================================================================
export const BLOCK_REGISTRY: Record<string, any> = {
    // --- ESTRUCTURALES ---
    BannerHero: {
        label: '📸 Portada Principal (Hero)',
        icon: 'las la-desktop',
        group: 'Estructurales',
        component: defineAsyncComponent(() => import('../components/blocks/page/BannerHero.vue')),
        editor: defineAsyncComponent(() => import('../components/blocks/editors/BannerHeroEditor.vue')),
        initialData: { autoPlayInterval: 5000, slides: [{ id: 1, layout: 'standard-mode', title: 'TÍTULO PRINCIPAL', preTitle: 'Bienvenidos', btnText: 'CONTÁCTANOS', btnLink: '#contact' }] }
    },
    LegoSection: {
        label: '🧱 Constructor LEGO (Cols + Texto/Img)',
        icon: 'las la-cubes',
        group: 'Estructurales',
        component: defineAsyncComponent(() => import('../components/blocks/page/LegoSection.vue')),
        editor: defineAsyncComponent(() => import('../components/blocks/editors/LegoSectionEditor.vue')),
        initialData: { rows: [] }
    },
    SpacerBlock: {
        label: 'Linea de Separación',
        icon: 'las la-arrows-alt-v',
        group: 'Estructurales',
        component: defineAsyncComponent(() => import('../components/sections/page/SpacerBlock.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/editor/SpacerEditor.vue')),
        initialData: { height: 60, showLine: false, config: { lineColor: '#dddddd', lineStyle: 'solid', lineWidth: '100%', lineThickness: 1 } }
    },
    HeaderInnovaBlock: {
        label: '🖥️ Cabecera Innova (Hero + Menú)',
        icon: 'las la-heading',
        group: 'Estructurales',
        component: defineAsyncComponent(() => import('../components/header/blocks/HeaderInnovaBlock.vue')),
        editor: defineAsyncComponent(() => import('../components/header/editors/HeaderInnovaEditor.vue')),
        initialData: {
            logoUrl: '/imagenes/logoInnova.png',
            heroImage: '/imagenes/slider01.png',
            heroTitle: 'innova esan',
            heroSubtitle: 'the business challenge',
            navLinks: [
                { id: 1, label: 'Time Line', url: '#timeline' },
                { id: 2, label: 'The Business Challenge', url: '#business' },
                { id: 3, label: 'Postula', url: '#postula' }
            ]
        }
    },

    // --- INSTITUCIONAL ---
    AboutCompany: {
        label: '🏢 Nuestra Historia (Img + Texto)',
        icon: 'las la-building',
        group: 'Institucional',
        component: defineAsyncComponent(() => import('../components/blocks/page/AboutCompany.vue')),
        editor: defineAsyncComponent(() => import('../components/blocks/editors/AboutCompanyEditor.vue')),
        initialData: { title: 'NUESTRA HISTORIA', image: '', content: '<p>El instituto de Regulación y Finanzas...</p>' }
    },
    OurTeacher: {
        label: '👨‍🏫 Nuestro Equipo (Grilla)',
        icon: 'las la-user-tie',
        group: 'Institucional',
        component: defineAsyncComponent(() => import('../components/blocks/page/OurTeacher.vue')),
        editor: defineAsyncComponent(() => import('../components/blocks/editors/OurTeacherEditor.vue')),
        initialData: { title: 'Nuestro Equipo', items: [] }
    },
    AchievementData: {
        label: '🏆 Banner de Logros Institucionales',
        icon: 'las la-trophy',
        group: 'Institucional',
        component: defineAsyncComponent(() => import('../components/blocks/page/AchievementData.vue')),
        editor: defineAsyncComponent(() => import('../components/blocks/editors/AchievementDataEditor.vue')),
        initialData: { subtitle: 'LOGROS ALCANZADOS', counters: [] }
    },
    PartnerSlider: {
        label: '🤝 Alianzas y Acreditaciones (Logos)',
        icon: 'las la-handshake',
        group: 'Institucional',
        component: defineAsyncComponent(() => import('../components/blocks/page/PartnerSlider.vue')),
        editor: defineAsyncComponent(() => import('../components/blocks/editors/PartnerSliderEditor.vue')),
        initialData: { title: 'RANKING Y ACREDITACIONES', partners: [] }
    },
    TestimonialsBlock: {
        label: '💬 Testimonios (Carrusel Flotante)',
        icon: 'las la-quote-left',
        group: 'Institucional',
        component: defineAsyncComponent(() => import('../components/blocks/page/TestimonialsBlock.vue')),
        editor: defineAsyncComponent(() => import('../components/blocks/editors/TestimonialsEditor.vue')),
        initialData: { title: 'Que dicen de nosotros', items: [] }
    },

    // --- GRILLAS Y CONTENIDO ---
    DynamicCourseGrid: {
        label: '🔄 Galería Automática de Cursos',
        icon: 'las la-graduation-cap',
        group: 'Grillas',
        component: defineAsyncComponent(() => import('../components/blocks/grid/DynamicCourseGrid.vue')),
        editor: defineAsyncComponent(() => import('../components/blocks/editors/UniversalGridEditor.vue')),
        initialData: { title: 'Próximos Inicios', limit: 4 }
    },
    NewsBentoGrid: {
        label: '📰 Bento Grid (Automático)',
        icon: 'las la-newspaper',
        group: 'Grillas',
        component: defineAsyncComponent(() => import('../components/blocks/grid/NewsBentoGrid.vue')),
        editor: defineAsyncComponent(() => import('../components/blocks/editors/NewsBentoEditor.vue')),
        initialData: { title: 'Actualidad & Tendencias', limit: 7 }
    },
    ServiceGrid: {
        label: '📢 Servicios',
        icon: 'las la-concierge-bell',
        group: 'Grillas',
        component: defineAsyncComponent(() => import('../components/blocks/page/ServiceGrid.vue')),
        editor: defineAsyncComponent(() => import('../components/blocks/editors/ServiceGridEditor.vue')),
        initialData: { items: [] }
    },
    SectorSection: {
        label: '🏭 Grilla de Sectores (Desde BD)',
        icon: 'las la-industry',
        group: 'Grillas',
        component: defineAsyncComponent(() => import('../components/blocks/grid/SectorSection.vue')),
        editor: defineAsyncComponent(() => import('../components/blocks/editors/UniversalGridEditor.vue')),
        initialData: { title: 'Sectores' }
    },
    UniversalGrid: {
        label: '📢 Grid Universal',
        icon: 'las la-th-large',
        group: 'Grillas',
        component: defineAsyncComponent(() => import('../components/blocks/page/UniversalGrid.vue')),
        editor: defineAsyncComponent(() => import('../components/blocks/editors/UniversalGridEditor.vue')),
        initialData: { config: { columns: 3 }, items: [] }
    },
    NewsMega: {
        label: '📰 Mega Grilla de Noticias (Bento)',
        icon: 'las la-th-large',
        group: 'Grillas',
        component: defineAsyncComponent(() => import('../components/blocks/page/NewsMega.vue')),
        editor: defineAsyncComponent(() => import('../components/blocks/editors/NewsMegaEditor.vue')),
        initialData: { sectionTitle: 'ÚLTIMAS NOTICIAS', articles: [] }
    },
    NewsArticleView: {
        label: '📄 Blog: Detalle de Artículo',
        icon: 'las la-newspaper',
        group: 'Grillas',
        component: defineAsyncComponent(() => import('../components/blocks/page/NewsArticle.vue')),
        editor: defineAsyncComponent(() => import('../components/blocks/editors/NewsArticleEditor.vue')),
        initialData: { title: 'Título del artículo', content: '' }
    },

    // --- CONVERSIÓN Y FOOTER ---
    FeatureBanner: {
        label: '📢 Banner CTA (Fondo + Botón)',
        icon: 'las la-bullhorn',
        group: 'Conversion',
        component: defineAsyncComponent(() => import('../components/blocks/page/FeatureBanner.vue')),
        editor: defineAsyncComponent(() => import('../components/blocks/editors/FeatureBannerEditor.vue')),
        initialData: { title: 'Texto del banner', buttonText: 'CONTACTO' }
    },
    ContactSection: {
        label: '📚 Seccion de Contacto',
        icon: 'las la-envelope-open-text',
        group: 'Conversion',
        component: defineAsyncComponent(() => import('../components/blocks/page/ContactSection.vue')),
        editor: defineAsyncComponent(() => import('../components/blocks/editors/ContactSectionEditor.vue')),
        initialData: { title: 'AGENDEMOS UNA REUNIÓN', fields: [] }
    },
    Stats: {
        label: '📊 Stats',
        icon: 'las la-chart-bar',
        group: 'Conversion',
        component: defineAsyncComponent(() => import('../components/sections/page/Stats.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/editor/StatsEditor.vue')),
        initialData: { title: 'NUESTRA PROPUESTA', items: [] }
    },
    ImpactHeroBlock: {
        label: '💥 Hero de Impacto (ISO/Cert)',
        icon: 'las la-bolt',
        group: 'Conversion',
        component: defineAsyncComponent(() => import('../components/sections/page/ImpactHeroBlock.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/editor/ImpactHeroBlockEditor.vue')),
        initialData: { title: 'RENOVACIÓN ISO', config: { align: 'left' } }
    },
    CategorySystemGrid: {
        label: '🎓 Grid de Cursos (Por Categoría)',
        icon: 'las la-folder',
        group: 'Conversion',
        component: defineAsyncComponent(() => import('../components/sections/page/CategorySystemGrid.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/editor/CategorySystemGridEditor.vue')),
        initialData: { categoryId: null }
    },
    CategoryTypeGrid: {
        label: '📂 Listado de Categorías (Por Tipo)',
        icon: 'las la-list',
        group: 'Conversion',
        component: defineAsyncComponent(() => import('../components/sections/grids/CategoryTypeGrid.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/editorGrids/CategoryTypeGridEditor.vue')),
        initialData: { selectedType: 'post' }
    },
    CallToActionBlock: {
        label: '🌗 Call To Action (Split)',
        icon: 'las la-external-link-alt',
        group: 'Conversion',
        component: defineAsyncComponent(() => import('../components/sections/page/CallToActionBlock.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/editor/CallToActionBlock.vue')),
        initialData: { title: 'PROYECTOS', config: { invertLayout: false } }
    },
    NewsletterBlock: {
        label: '📧 Newsletter',
        icon: 'las la-envelope',
        group: 'Conversion',
        component: defineAsyncComponent(() => import('../components/blocks/page/NewsletterBlock.vue')),
        editor: defineAsyncComponent(() => import('../components/blocks/editors/NewsletterEditor.vue')),
        initialData: { title: 'MANTENTE INFORMADO' }
    },
    FooterSimpleBlock: {
        label: '🔻 Footer (Social + Copyright)',
        icon: 'las la-arrow-down',
        group: 'Conversion',
        component: defineAsyncComponent(() => import('../components/sections/page/FooterSimpleBlock.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/editor/FooterSimpleEditor.vue')),
        initialData: { copyrightText: '© {year} ESANDATA', socials: [] }
    },
    WelcomeMessageBlock: {
        label: '👋 Mensaje de Bienvenida',
        icon: 'las la-comment-alt',
        group: 'Conversion',
        component: defineAsyncComponent(() => import('../components/sections/page/WelcomeMessageBlock.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/editor/WelcomeMessageEditor.vue')),
        initialData: { signatureTitle: 'Jefe IT', content: '' }
    },
    RawHtmlBlock: {
        label: 'Bloque de HTML (Libre)',
        icon: 'las la-code',
        group: 'Conversion',
        component: defineAsyncComponent(() => import('../components/sections/page/RawHtmlBlock.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/editor/RawHtmlEditor.vue')),
        initialData: { htmlCode: '<h2>Título</h2>' }
    },
    VideoGalleryBlock: {
        label: '🎬 Galería de Videos',
        icon: 'las la-photo-video',
        group: 'Conversion',
        component: defineAsyncComponent(() => import('../components/sections/page/VideoGalleryBlock.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/editor/VideoGalleryEditor.vue')),
        initialData: { videos: [] }
    },

    // --- SOPORTE ---
    ServiceDeskBlock: {
        label: '🎧 Mesa de Ayuda',
        icon: 'las la-headset',
        group: 'Soporte',
        component: defineAsyncComponent(() => import('../components/sections/page/ServiceDeskBlock.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/editor/ServiceDeskBlock.vue')),
        initialData: { title: "MESA DE AYUDA", description: '' }
    },
    StudentSupportBlock: {
        label: '🎓 Soporte Alumnos',
        icon: 'las la-user-graduate',
        group: 'Soporte',
        component: defineAsyncComponent(() => import('../components/sections/page/StudentSupportBlock.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/editor/StudentSupportEditor.vue')),
        initialData: { title: 'Soporte' }
    },
    ResourceDownloadBlock: {
        label: '📥 Grilla de Descargas',
        icon: 'las la-file-download',
        group: 'Soporte',
        component: defineAsyncComponent(() => import('../components/sections/page/ResourceDownloadBlock.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/editor/ResourceDownloadEditor.vue')),
        initialData: { pageTitle: "Alumnos", cards: [] }
    },
    ProcedureHeroBlock: {
        label: '🖼️ Banner Procedimientos',
        icon: 'las la-image',
        group: 'Soporte',
        component: defineAsyncComponent(() => import('../components/sections/page/ProcedureHeroBlock.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/editor/ProcedureHeroEditor.vue')),
        initialData: { title: 'PROCEDIMIENTOS', height: '300px' }
    },
    TimelineInnovaBlock: {
        label: '⏳ Timeline Alterno',
        icon: 'las la-clock',
        group: 'Soporte',
        component: defineAsyncComponent(() => import('../components/sections/innova/blocks/TimelineInnovaBlock.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/innova/editors/TimelineInnovaEditor.vue')),
        initialData: {
            title: 'TIME LINE',
            image: 'imagenes/landing/presentacion.png',
            items: [
                { label: 'Convocatoria', content: '<ul><li>Webinar informativo</li></ul>', active: true },
                { label: 'Selección', content: '<ul><li>Publicación de resultados</li></ul>', active: false }
            ]
        }
    },
    CtaPostulacionBlock: {
        label: '🎯 CTA Postulación',
        icon: 'las la-clock',
        group: 'Soporte',
        component: defineAsyncComponent(() => import('../components/sections/innova/blocks/CtaPostulacionBlock.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/innova/editors/CtaPostulacionEditor.vue')),
        initialData: {
            title: 'POSTULACIÓN',
            description: 'La postulación a la convocatoria del concurso es totalmente gratuita y abierta a todas las personas que deseen postular y que cumplan los requisitos y criterios de la convocatoria (Bases de la Convocatoria).',
            buttonText: 'Más información',
            buttonLink: 'https://forms.gle/92arYWEZFHZziC56A',
            image: 'imagenes/landing/postulacion.png',
            overlayColor1: 'rgba(33, 118, 255, 0.80)',
            overlayColor2: 'rgba(33, 118, 255, 0.80)'
        }
    },
    ProgramasBlock: {
        label: '🎓 Nuestros Programas',
        icon: 'las la-layer-group',
        group: 'Soporte', // O el grupo que prefieras ponerle
        component: defineAsyncComponent(() => import('../components/sections/innova/blocks/ProgramasBlock.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/innova/editors/ProgramasEditor.vue')),
        initialData: {
            sectionRotulo: 'Nuestros',
            sectionTitle: 'programas',
            items: [
                {
                    id: '1',
                    title: 'Start',
                    subtitle: 'Descubre oportunidades',
                    description: 'Inicia tu camino en la comunidad, desarrolla habilidades innovadoras y descubre las oportunidades para iniciar tu emprendimiento. A través de charlas inspiradoras, ideathones con retos empresariales, ferias y workshops especializados.<br><br><strong>Innova Ignite, Emprende ESAN, Innovation&Research Week, etc</strong>',
                    image: 'imagenes/pre-incubacion.png',
                    color1: 'rgba(33, 118, 255, 0.60)',
                    color2: 'rgba(0, 33, 77, 0.60)'
                },
                {
                    id: '2',
                    title: 'Explorer',
                    subtitle: 'Valida el cliente y demanda',
                    description: 'Aprende nuevas metodologías y herramientas ágiles para implementarlas en tu proyecto de emprendimiento. Validar el cliente y el mercado será clave para el buen desarrollo de producto y la etapa comercial. Además, descubre en la comunidad a tu futuro socio.<br><br><strong>Modalidad:</strong> Online <br><strong>Santander X Explorer con el apoyo Innova ESAN.</strong>',
                    image: 'imagenes/cultura.png',
                    color1: 'rgba(33, 118, 255, 0.60)',
                    color2: 'rgba(0, 33, 77, 0.60)'
                },
                {
                    id: '3',
                    title: 'Venture Lab',
                    subtitle: 'Mejora tu producto e inicia ventas',
                    description: 'El programa de incubación de empresas con el que validas tu PMV y las condiciones para iniciar tu empresa, primeras ventas y estar listo para buscar financiamiento. Recibirás guía de nuestra red de mentores y seguimiento de nuestro staff. Sé parte de nuestra red de la emprendedores de ESAN.<br><br><strong>The Business Challenge:</strong> Concurso de becas hasta el 13 de febrero.<br><strong>Venture Lab:</strong> marzo-julio <br><strong>Modalidad:</strong> Híbrida',
                    image: 'imagenes/incubacion.png',
                    color1: 'rgba(33, 118, 255, 0.60)',
                    color2: 'rgba(0, 33, 77, 0.60)'
                },
                {
                    id: '4',
                    title: 'Venture Capital 101',
                    subtitle: 'Inicia tu camino como inversionista',
                    description: 'Conoce los primeros pasos para convertirte en un inversionista en startups. Aprende de los protagonistas del ecosistema de venture capital en Perú y Latam y descubre los beneficios de ser parte de la red. <br><br><strong>Inicio:</strong> abril 2025 <br><strong>Modalidad:</strong> virtual <br><strong>Duración:</strong> 6 semanas <br>Fundamentos de Venture Capital con PECAP',
                    image: 'imagenes/aceleracion.png',
                    color1: 'rgba(33, 118, 255, 0.60)',
                    color2: 'rgba(0, 33, 77, 0.60)'
                }
            ]
        }
    },
    VisitanosBlock: {
        label: '📍 Visítanos (Mapa)',
        icon: 'las la-map-marker',
        group: 'Conversion', // Ponlo en el grupo que te cuadre mejor
        component: defineAsyncComponent(() => import('../components/sections/innova/blocks/VisitanosBlock.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/innova/editors/VisitanosEditor.vue')),
        initialData: {
            title: 'campus esan',
            address: 'Jr. Alonso de Molina 1652, Santiago de Surco 15023',
            // Te dejé un iframe real de ESAN para que cargue de una, pero lo pueden cambiar en el CMS
            mapUrl: 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3900.7417483669145!2d-76.9655655241477!3d-12.105436188136357!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9105c71363650f95%3A0xd64d7dfae5435b80!2sUniversidad%20ESAN!5e0!3m2!1ses-419!2spe!4v1700000000000!5m2!1ses-419!2spe',
            backgroundColor: '#ffffff',
            textColor: '#333333'
        }
    },
    FooterBlock: {
        label: '🦶 Footer (Pie de página)',
        icon: 'las la-shoe-prints',
        group: 'Soporte',
        component: defineAsyncComponent(() => import('../components/sections/innova/blocks/FooterBlock.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/innova/editors/FooterEditor.vue')),
        initialData: {
            // ... (Añadir los datos iniciales que quieras)
        }
    },
    CareerHeroBlock: {
        label: '🚀 Hero de Carrera (DPA)',
        icon: 'las la-graduation-cap',
        group: 'Programas',
        component: defineAsyncComponent(() => import('../components/sections/programs/blocks/CareerHero.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/programs/editors/CareerHeroEditor.vue')),
        initialData: {
            name: 'DPA Ingeniería de Sistemas',
            description: 'DESARROLLA TECNOLOGÍAS DE INFORMACIÓN EN BENEFICIO DE TU EMPRESA U ORGANIZACIÓN',
            branding_color: '#8c357f',
            bg_overlay: 'rgba(30, 10, 40, 0.8)',
            image: '', // Aquí puedes poner una ruta por defecto
            curriculum_json: [
                { modality: 'Presencial', url: '' },
                { modality: 'Semipresencial', url: '' },
                { modality: 'A Distancia', url: '' }
            ]
        }
    },
    CountersBlock: {
        label: '🔢 Contadores Animados',
        icon: 'las la-sort-numeric-up', // Ícono de números para Line Awesome
        bgColor: '#d31245',   // <-- Agregado
        textColor: '#ffffff', // <-- Agregado
        group: 'Programas', // O el grupo que prefieras ('Contenido', 'Programas', etc.)
        component: defineAsyncComponent(() => import('../components/sections/programs/blocks/BlockCounters.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/programs/editors/BlockCountersEditor.vue')),
        initialData: {
            title: 'Por qué elegir ESAN',
            counters: [
                { prefix: 'TOP', number: 1, label: 'Escuela de Posgrado', note: '*' },
                { prefix: 'TOP', number: 5, label: 'Carreras Universitarias', note: '*' },
                { prefix: '+', number: 17200, label: 'Graduados de Pregrado y Maestrías', note: '' },
                { prefix: 'TOP', number: 3, label: 'Ranking Merco Empresas 2024', note: '' }
            ]
        }
    },
    AboutCareerBlock: {
        label: 'ℹ️ Acerca de la Carrera',
        icon: 'las la-info-circle',
        group: 'Programas',
        component: defineAsyncComponent(() => import('../components/sections/programs/blocks/AboutCareer.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/programs/editors/AboutCareerEditor.vue')),
        initialData: {
            tag: 'ACERCA DE LA CARRERA',
            title: '¡Bienvenido a la carrera de Ingeniería de Sistemas para gente que trabaja!',
            subtitle: 'La carrera de Ingeniería de Sistemas forma profesionales con una visión estratégica...',
            description: 'Desarrollarás habilidades para modelar sistemas de negocio, crear modelos de toma de decisiones...',
            image: 'https://tu-dominio.com/imagen-ejemplo.jpg',
            bgColor: '#ffffff',
            textColor: '#1e1e1e',
            tagColor: '#8c357f'
        }
    },
    CareerDetailsBlock: {
        label: '📊 Detalles de Carrera',
        icon: 'las la-info-circle',
        group: 'Programas',
        component: defineAsyncComponent(() => import('../components/sections/programs/blocks/CareerDetails.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/programs/editors/CareerDetailsEditor.vue')),
        initialData: {
            image: 'https://tuservidor.com/foto-chica.jpg',
            items: [
                { icon: 'las la-calendar', text: '10 Semestres' },
                { icon: 'las la-chart-bar', text: '200 Créditos' },
                { icon: 'las la-graduation-cap', text: 'Grado de Bachiller en Ingeniería de Sistemas' },
                { icon: 'las la-university', text: 'Título de Ingeniero de Sistemas' }
            ],
            branding_color: '#8c357f'
        }
    },
    VideoBlock: {
        label: '▶️ Video Destacado',
        icon: 'bi bi-play-btn',
        group: 'Programas', // Puedes cambiarlo a 'Programas' si prefieres tenerlo en el mismo grupo
        component: defineAsyncComponent(() => import('../components/sections/programs/blocks/VideoBlock.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/programs/editors/VideoBlockEditor.vue')),
        initialData: {
            title: 'CAFÉ DPA con Joseph Ballón',
            description: 'Cómo la carrera de Ingeniería de Sistemas integra conocimientos y habilidades para abordar las diversas áreas del mercado laboral actual.',
            videoUrl: 'https://www.youtube.com/watch?v=dQw4w9WgXcQ',
            bgImage: 'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?q=80&w=1920&auto=format&fit=crop', // Imagen por defecto de servidores
            textColor: '#ffffff',
            overlayColor: '#001a33', // Un azul oscuro muy elegante por defecto
            overlayOpacity: 0.7
        }
    },
    CareerDevelopmentBlock: {
        label: '🚀 Desarrollo y Especialización',
        icon: 'bi bi-person-workspace',
        group: 'Programas',
        component: defineAsyncComponent(() => import('../components/sections/programs/blocks/CareerDevelopment.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/programs/editors/CareerDevelopmentEditor.vue')),
        initialData: {
            bgColor: '#fcf5fb', // Fondo rosa muy pálido
            textColor: '#1e293b',
            accentColor: '#8c357f', // Morado ESAN

            devTitle: 'Desarrollo Profesional',
            devSubtitle: 'Como graduado, podrás trabajar en:',
            devImage: 'https://images.unsplash.com/photo-1573164713988-8665fc963095?q=80&w=800&auto=format&fit=crop', // Reemplazar por asset real
            devItems: [
                'Posiciones de gerencia en áreas de tecnología de la información.',
                'Gerencia en inteligencia de negocios.',
                'Gerencia en tecnologías de información.',
                'Consultoría independiente.',
                'Administrador de proyectos de tecnología.'
            ],

            specTitle: 'Áreas de Especialización',
            specSubtitle: 'Nuestra carrera cuenta con una estructura curricular flexible, que te brinda una amplia gama de créditos electivos para que personalices tu formación y potencies tus oportunidades laborales al finalizar tus estudios.',
            specItems: [
                { title: 'Sistemas de Información', icon: 'bi-cpu' },
                { title: 'Ciencias de Datos', icon: 'bi-database' }
            ]
        }
    },
    FooterBlockLanding: {
        label: '⚓ Pie de Página',
        icon: 'bi bi-layout-text-window-reverse',
        group: 'Estructurales', // O el grupo donde guardes Headers/Footers
        component: defineAsyncComponent(() => import('../components/sections/programs/blocks/FooterBlockLanding.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/programs/editors/FooterBlockLandingEditor.vue')),
        initialData: {
            bgColor: '#151e2d',
            textColor: '#e2e8f0',
            iconHoverColor: '#8c357f',

            logoImage: '', // Dejar vacío para que aparezca el texto DPA ESAN hasta que elijan logo
            slogan: 'Trabajar y estudiar es crecer X 2.',
            copyrightText: 'Universidad ESAN.',

            socialLinks: {
                linkedin: 'https://www.linkedin.com/school/universidad-esan/',
                facebook: 'https://www.facebook.com/uesan/',
                instagram: 'https://www.instagram.com/uesan_oficial/',
                twitter: 'https://twitter.com/universidadesan'
            }
        }
    },
    NavbarBlock: {
        label: '🔝 Barra de Navegación',
        icon: 'bi bi-distribute-vertical',
        group: 'Estructurales', // O el grupo donde pusiste el Footer
        component: defineAsyncComponent(() => import('../components/sections/programs/blocks/NavbarBlock.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/programs/editors/NavbarBlockEditor.vue')),
        initialData: {
            bgColor: '#ffffff',
            buttonColor: '#8c357f', // El plum/morado
            buttonTextColor: '#ffffff',
            logoImage: '', // Pon aquí la URL de la imagen del logo rojo de DPA ESAN
            buttonText: 'COMUNÍCATE',
            buttonLink: '#comunicate', // Este ancla saltará directo a tu formulario
            isSticky: true // Activado por defecto para que se quede pegado al hacer scroll
        }
    },
    HeroWelcome: {
        label: '🚀 Hero Bienvenida',
        icon: 'bi bi-star-fill',
        group: 'Hero',
        component: defineAsyncComponent(() => import('../components/sections/hero/blocks/HeroWelcome.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/hero/editors/HeroWelcomeEditor.vue')),
        initialData: {
            title: 'BIENVENIDOS AL DPA',
            subtitle: 'Formación profesional universitaria de adultos con experiencia laboral',
            image: 'https://images.unsplash.com/photo-1560250097-0b93528c311a?auto=format&fit=crop&q=80&w=800',
            primaryBtnText: 'INSCRÍBETE A LAS CHARLAS',
            primaryBtnUrl: '#',
            secondaryBtnText: 'SOLICITA INFORMACIÓN',
            secondaryBtnUrl: '#',
            bgGradient: 'linear-gradient(135deg, #003057 0%, #004b87 100%)',
            textColor: '#ffffff',
            btnColor: '#ff3131' // El rojo vibrante de la imagen
        }
    },
    FooterSimple: {
        label: '📝 Footer Simple',
        icon: 'las la-shoe-prints', // Un ícono representativo para el pie de página
        group: 'Footer',
        component: defineAsyncComponent(() => import('../components/sections/footer/blocks/FooterSimple.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/footer/editors/FooterSimpleEditor.vue')),
        initialData: {
            bgColor: '#151515',
            textColor: '#a3a3a3',
            leftText: '© Copyright 2024 - Universidad ESAN | Todos los derechos reservados.',
            rightText: 'Razón Social: Universidad ESAN | RUC: 20136507720'
        }
    },
    HeaderDynamic: {
        label: '🌟 Header Transparente',
        icon: 'las la-bars', // Ícono representativo de menú/navegación
        group: 'Header',
        component: defineAsyncComponent(() => import('../components/sections/header/blocks/HeaderDynamic.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/header/editors/HeaderDynamicEditor.vue')),
        initialData: {
            logoDesktop: '', // URL vacía para que el placeholder actúe, o puedes poner la URL del logo de ESAN
            logoMobile: '',
            logoUrl: '#',
            textColor: '#ffffff',
            bgColor: 'transparent',
            menuItems: [

            ]
        }
    },
    FutureProfessional: {
        label: '🌐 Hero Futuro Profesional',
        icon: 'las la-globe', // Ícono representativo por el globo terráqueo del diseño
        group: 'Hero', // <--- Asignado al grupo que pediste
        // Ajusta estas rutas según dónde hayas guardado exactamente los archivos .vue
        component: defineAsyncComponent(() => import('../components/sections/hero/blocks/FutureProfessionalSection.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/hero/editors/FutureProfessionalEditor.vue')),
        initialData: {
            // Textos por defecto (los de tu imagen de referencia)
            introText: '¡Tu futuro profesional comienza aquí! Regístrate ya y sé parte de nuestra charla virtual DPA.',
            mainQuote: '¡MANTENTE ATENTO!\nMuy pronto, nuevos eventos para ti.',

            // Imágenes vacías para que el editor muestre el botón de "+"
            featuredImage: '',
            bgPattern: '',

            // Colores por defecto (el degradado morado/azul original)
            bgGradient1: '#311b92',
            bgGradient2: '#1a237e',
            bgGradient3: '#0d1246',
            bgPatternOpacity: 0.3,
            textColor: '#ffffff'
        }
    },
    StudyWorkBanner: {
        label: '🟠 Banner Balance DPA',
        icon: 'las la-balance-scale', // Ícono representativo del balance estudiar/trabajar
        group: 'Institucional', // o el que prefieras
        component: defineAsyncComponent(() => import('../components/sections/institucional/blocks/StudyWorkBanner.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/institucional/editors/StudyWorkBannerEditor.vue')),
        initialData: {
            title: 'ESTUDIAR Y TRABAJAR ES POSIBLE',
            subtitle: 'ENCUENTRA EL BALANCE PARA CRECER PROFESIONALMENTE SIN DESCUIDAR TU TRABAJO.',
            titleSize: 30, // NUEVO
            subtitleSize: 15, // NUEVO
            contentWidth: 900,
            bgColor: '#ffb300', // Un naranja brillante por defecto
            bgPattern: '', // Para subir la imagen de los puntitos
            bgPatternOpacity: 0.15,
            titleColor: '#000000',
            subtitleColor: '#000000',
            fontFamily: 'inherit' // Respeta la fuente global de la página
        }
    },
    FeatureSplit: {
        label: '↔️ Modalidad (Imagen/Texto)',
        icon: 'las la-exchange-alt', // Ícono que representa la inversión de columnas
        group: 'Institucional', // Encaja bien aquí o en 'Grillas'
        component: defineAsyncComponent(() => import('../components/sections/institucional/blocks/FeatureSplitSection.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/institucional/editors/FeatureSplitEditor.vue')),
        initialData: {
            title: 'MODALIDAD PRESENCIAL Y SEMIPRESENCIAL',
            description: 'Estudia en el campus, en tu casa o\n en el lugar que desees.',
            imageSrc: '', // URL vacía para que salga el placeholder y suban la foto
            btnText: 'MÁS INFORMACIÓN',
            btnUrl: '#', 
            bgColor: '#ffffff',
            btnColor: '#ff2b2b', 
            textColor: '#333333',
            titleColor: '#000000',
            inverted: false // Por defecto, imagen a la izquierda
        }
    },
    BenefitsSplit: {
        label: '🛡️ Beneficios (Texto/Grilla)',
        icon: 'las la-th-large',
        group: 'Institucional',
        component: defineAsyncComponent(() => import('../components/sections/institucional/blocks/BenefitsSplitSection.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/institucional/editors/BenefitsSplitEditor.vue')),
        initialData: {
            title: '¿POR QUÉ ESTUDIAR EN EL DPA?',
            imageSrc: '', // Para subir la foto de la videollamada
            bgColor: '#f8f9fa',
            titleColor: '#000000',
            textColor: '#555555',
            features: [
                { icon: '', title: 'RESPALDO DE ESAN', text: 'Toda la experiencia y liderazgo de ESAN está presente en el DPA, lo que asegura un alto nivel de calidad.' },
                { icon: '', title: 'LICENCIAMIENTO INSTITUCIONAL SUNEDU', text: 'La Universidad ESAN cumple con todas las Condiciones Básicas de Calidad exigidas.' },
                { icon: '', title: 'EDUCACIÓN GERENCIAL', text: 'Nuestras carreras universitarias están orientadas a la gestión empresarial.' },
                { icon: '', title: 'GRADO Y TÍTULO A NOMBRE DE LA NACIÓN', text: 'El DPA otorga grados y títulos a nombre de la Nación en cumplimiento de la Ley.' }
            ]
        }
    },
    LeadFormHero: {
        label: '📝 Formulario Hero (Marketing)',
        icon: 'las la-address-card',
        group: 'Form', // O el grupo que prefieras, ej: 'Hero'
        component: defineAsyncComponent(() => import('../components/sections/forms/blocks/LeadFormSection.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/forms/editors/LeadFormSectionEditor.vue')),
        initialData: {
            bgImage: 'https://www.ue.edu.pe/img/home/fondo-carreras-dpa.jpg',
            formPosition: 'derecha',
            themeColor: '#ff2b2b',
            marketingTitle: '¡TRANSFORMA TU FUTURO! DA EL PRIMER PASO HACIA TU EXCELENCIA PROFESIONAL',
            marketingDescription: '',
            marketingImage: 'https://www.ue.edu.pe/img/home/img-carreras-dpa.webp',
            formConfig: {
                campaign_id: null,
                title: 'Comunícate',
                subtitle: 'Déjanos tus datos y un asesor absolverá tus dudas.',
                condition: 'https://www.ue.edu.pe/pregrado/politica-de-privacidad',
                button_text: 'Enviar mis datos',
                success_title: '¡Solicitud enviada!',
                success_message: 'Un asesor se pondrá en contacto contigo muy pronto.',
                show_phone: true,
                show_consult: true,
                show_courses: false,
                courses_list: []
            }
        }
    },
    SingleImage: {
        label: '🖼️ Imagen Única',
        icon: 'las la-image',
        group: 'Image', // Aquí le asignamos el nuevo grupo
        component: defineAsyncComponent(() => import('../components/sections/images/blocks/SingleImageSection.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/images/editors/SingleImageEditor.vue')),
        initialData: {
            imageUrl: '', // Que empiece vacío para obligar al usuario a subir una
            alignment: 'center',
            maxWidth: '100%',
            padding: 'py-5'
        }
    },
    DpaProgramsGrid: {
        label: '🏫 Grilla de Carreras DPA',
        icon: 'las la-th',
        group: 'Programas', // Tienes un grupo 'Programas de Estudio'
        component: defineAsyncComponent(() => import('../components/sections/studyPrograms/blocks/DpaProgramsGrid.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/studyPrograms/editors/DpaProgramsGridEditor.vue')),
        initialData: {
            title: 'Nuestras Carreras DPA',
            subtitle: 'Conoce nuestra oferta académica y transforma tu futuro',
            programs: [] // Arranca vacío hasta que le den al botón de Sincronizar
        }
    },
    TestimonialSlider: {
        label: '💬 Slider de Testimonios',
        icon: 'las la-quote-right',
        group: 'Testimonios', // Este es el nuevo grupo
        component: defineAsyncComponent(() => import('../components/sections/testimonials/blocks/TestimonialSlider.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/testimonials/editors/TestimonialSliderEditor.vue')),
        initialData: {
            bgType: 'color',
            bgColor: '#2a1515',
            bgImage: '',
            bgGradient: 'linear-gradient(135deg, #2a1515 0%, #1a0d0d 100%)',
            titleColor: '#ffffff',
            titleSize: '1.8rem',
            quoteColor: '#f8f9fa',
            quoteSize: '1.1rem',
            authorColor: '#cccccc',
            authorSize: '0.9rem',
            title: 'ESTUDIA CON LOS PROFESIONALES DE LOS NEGOCIOS',
            testimonials: [
                {
                    id: Date.now(),
                    quote: '"La carrera de Ingeniería de Sistemas integra la tecnología con los negocios, lo que es clave para hacer frente a la transformación digital que hoy experimentamos".',
                    image: '',
                    name: 'Daniella Tapia Villanes',
                    role: 'Alumna Ingeniería de Sistemas (Analista de Transformación Digital)'
                }
            ]
        }
    },
    DarkFooter: {
        label: '🌙 Footer Institucional Pro',
        icon: 'fa-solid fa-shoe-prints',
        group: 'Footer',
        component: defineAsyncComponent(() => import('../components/sections/footer/blocks/DarkFooter.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/footer/editors/DarkFooterEditor.vue')),
        initialData: {
            bgColor: '#0a0a0a',
            textColor: '#ffffff',
            fontFamily: 'Montserrat, sans-serif',
            socials: [
                { icon: 'fa-brands fa-facebook-f', url: '#' },
                { icon: 'fa-brands fa-instagram', url: '#' },
                { icon: 'fa-brands fa-youtube', url: '#' },
                { icon: 'fa-brands fa-linkedin-in', url: '#' },
                { icon: 'fa-brands fa-tiktok', url: '#' }
            ],
            complaintsBookImg: 'https://via.placeholder.com/150x60?text=Libro+Reclamaciones',
            complaintsBookUrl: '#',
            locationTitle: 'UBÍCANOS',
            locationText: 'Alonso de Molina 1652, Monterrico, Surco, Lima - Perú',
            locationEmail: 'exitoesan@ue.edu.pe',
            scheduleTitle: 'HORARIOS DE ATENCIÓN',
            scheduleText: 'Oficina de Admisión de Pregrado\nHorario de atención presencial: Lunes a viernes de 10:00 - 6:45 p.m.',
            copyright: '© Copyright 2024 - Universidad ESAN | Todos los derechos reservados.',
            companyInfo: 'Razón Social: Universidad ESAN | RUC: 20136507720'
        }
    },
    MultiModalidadSection: {
        label: '🎓 Sección de Modalidades DPA',
        icon: 'las la-graduation-cap', // Icono para el constructor
        group: 'Estructurales', // O el grupo que prefieras
        component: defineAsyncComponent(() => import('../components/sections/images/blocks/MultiModalidadSection.vue')),
        editor: defineAsyncComponent(() => import('../components/sections/images/editors/MultiModalidadEditor.vue')),
        initialData: {
            // Fondo de Sección dinámico
            bgType: 'color', // 'color', 'gradient', 'image'
            bgColor: '#ffffff', // Fondo blanco limpio por defecto
            bgImage: '', // Fondo de imagen (como la de image_3.png si quieres)
            bgGradient: 'linear-gradient(135deg, #f0f0f0 0%, #ffffff 100%)', // Un degradado suave
            
            // Espaciado (Padding)
            padding: {
                top: 80,
                bottom: 80
            },
            
            // Columna Izquierda
            imageLeft: '/images/2026/02/18/3_modalidades1.webp', // Imagen por defecto del HTML
            spaceHeight: 30, // Altura del sppb-empty-space
            buttonText: 'MÁS INFORMACIÓN',
            buttonUrl: '#',
            buttonTarget: '_blank',
            
            // Columna Derecha
            imageRight: '/images/2026/02/18/nueva_modalidad.webp', // Imagen por defecto del HTML
        }
    },
};

// =========================================================================
// 2. DEFINICIÓN DE GRUPOS
// =========================================================================
const baseGroups = [
    { id: 'Header', label: 'Cabeceras', color: 'outline-warning', icon: 'las la-heading' },
    { id: 'Estructurales', label: 'Estructurales', color: 'outline-dark', icon: 'las la-desktop' },
    { id: 'Institucional', label: 'Institucional', color: 'outline-primary', icon: 'las la-building' },
    { id: 'Grillas', label: 'Grillas y Contenido', color: 'outline-success', icon: 'las la-th-large' },
    { id: 'Conversion', label: 'Conversión y CTA', color: 'outline-danger', icon: 'las la-bullhorn' },
    { id: 'Soporte', label: 'OldsSection / Soporte', color: 'outline-secondary', icon: 'las la-archive' },
    { id: 'Programas', label: '🎓 Programas de Estudio', color: 'outline-info', icon: 'las la-graduation-cap' },
    { id: 'Hero', label: 'Heros', color: 'outline-primary', icon: 'las la-star' }, 
    { id: 'Form', label: 'Formularios', color: 'outline-primary', icon: 'las la-building' }, 
    { id: 'Image', label: '🖼️ Imágenes y Medios', color: 'outline-info', icon: 'las la-image' }, 
    { id: 'Footer', label: 'Pie de Página', color: 'outline-dark', icon: 'las la-shoe-prints' },
    { id: 'Testimonios', label: '💬 Testimonios', color: 'outline-warning', icon: 'las la-comment-dots' },
];

// =========================================================================
// 3. ASIGNACIÓN AUTOMÁTICA DE BLOQUES A SUS GRUPOS
// =========================================================================
export const blockGroups = baseGroups.map(group => {
    return {
        ...group,
        keys: Object.keys(BLOCK_REGISTRY).filter(
            key => BLOCK_REGISTRY[key].group === group.id
        )
    };
});

// =========================================================================
// 4. EXPORTACIONES DINÁMICAS (Para que el Builder los lea)
// =========================================================================
export const BlockComponents = Object.keys(BLOCK_REGISTRY).reduce((acc, key) => {
    acc[key] = BLOCK_REGISTRY[key].component;
    return acc;
}, {} as Record<string, any>);

export const EditorComponents = Object.keys(BLOCK_REGISTRY).reduce((acc, key) => {
    acc[key] = BLOCK_REGISTRY[key].editor;
    return acc;
}, {} as Record<string, any>);

export const BlockLabels = Object.keys(BLOCK_REGISTRY).reduce((acc, key) => {
    acc[key] = BLOCK_REGISTRY[key].label;
    return acc;
}, {} as Record<string, string>);

export const blockIcons = Object.keys(BLOCK_REGISTRY).reduce((acc, key) => {
    acc[key] = BLOCK_REGISTRY[key].icon;
    return acc;
}, {} as Record<string, string>);


export const resolveBlock = (type: string) => BlockComponents[type] || null;
export const resolveEditor = (type: string) => EditorComponents[type] || null;
export const getInitialData = (type: string) => JSON.parse(JSON.stringify(BLOCK_REGISTRY[type]?.initialData || {}));