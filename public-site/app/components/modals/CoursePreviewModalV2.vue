<template>
    <b-modal 
        v-model="isVisible" 
        size="xl" 
        hide-footer 
        hide-header 
        centered 
        body-class="p-0" 
        content-class="bg-transparent border-0"
        no-fade
    >
        <div class="tech-interface-container" v-if="isVisible">
            
            <div class="interface-bg">
                <div class="grid-lines"></div>
                <div class="noise-overlay"></div>
            </div>

            <button class="close-holo-btn" @click="isVisible = false">
                <span class="cross"></span>
                <span class="label">CERRAR SISTEMA</span>
            </button>

            <div class="interface-body">
                
                <aside class="visualizer-col">
                    <div class="visualizer-frame">
                        <div class="scan-laser"></div>
                        <div class="scan-grid"></div>
                        
                        <img 
                            :src="formatImageUrl(course.image_path)" 
                            v-if="course.image_path" 
                            class="project-img" 
                            alt="Visualización"
                        >
                        <div v-else class="empty-state">
                            <i class="las la-cube"></i>
                            <span>NO SIGNAL</span>
                        </div>

                        <div class="meta-overlay">
                            <span class="badge-tech">IMG_RES: HIGH</span>
                            <span class="badge-tech text-accent">SECURE: TRUE</span>
                        </div>
                    </div>
                </aside>

                <main class="data-col cyber-scroll">
                    
                    <header class="data-header">
                        <div class="category-tag">
                            <i class="las la-tag"></i> 
                            {{ course.category ? course.category.name : 'RECURSO GENERAL' }}
                        </div>
                        <h1 class="data-title">
                            {{ course.title }}
                        </h1>
                        <div class="decor-line"></div>
                    </header>

                    <div class="content-sequence">
                        
                        <div class="data-section">
                            <h4 class="section-label">
                                <i class="las la-align-left text-accent"></i> DESCRIPCIÓN DEL SISTEMA
                            </h4>
                            <p class="section-text lead">
                                {{ course.description || 'No hay datos descriptivos disponibles en este momento.' }}
                            </p>
                        </div>

                        <div class="data-section" v-if="course.content_blocks?.ventajas">
                            <div class="info-card">
                                <div class="card-icon"><i class="las la-crosshairs"></i></div>
                                <div class="card-body">
                                    <strong>VENTAJAS TÁCTICAS</strong>
                                    <p>{{ course.content_blocks.ventajas }}</p>
                                </div>
                            </div>
                        </div>

                        <div class="data-section" v-if="course.content_blocks?.aplicacion">
                            <div class="info-card blue-theme">
                                <div class="card-icon"><i class="las la-microchip"></i></div>
                                <div class="card-body">
                                    <strong>APLICACIÓN ACADÉMICA</strong>
                                    <p>{{ course.content_blocks.aplicacion }}</p>
                                </div>
                            </div>
                        </div>

                        <div class="data-section" v-if="course.content_blocks?.laboratorios">
                            <div class="info-card accent-theme">
                                <div class="card-icon"><i class="las la-flask"></i></div>
                                <div class="card-body">
                                    <strong>DISPONIBILIDAD EN LABS</strong>
                                    <p class="fw-bold fs-5 mb-0">{{ course.content_blocks.laboratorios }}</p>
                                </div>
                            </div>
                        </div>

                        <div class="action-zone mt-5">
                            <div v-if="course.video_url">
                                <div v-if="isUrl(course.video_url)">
                                    <a :href="course.video_url" target="_blank" class="btn-hyper-download">
                                        <div class="btn-content">
                                            <i class="las la-cloud-download-alt fs-2 me-3"></i>
                                            <div class="text-start">
                                                <small class="d-block opacity-75">ENLACE DETECTADO</small>
                                                <span class="fw-bold">INICIAR DESCARGA</span>
                                            </div>
                                        </div>
                                        <div class="btn-glitch"></div>
                                    </a>
                                </div>
                                <div v-else class="terminal-msg">
                                    <span class="prompt">root@esan-tech:~$</span>
                                    <span class="command">mostrar_instruccion --target="descarga"</span>
                                    <div class="output mt-2 text-accent">
                                        >> {{ course.video_url }}
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    
                    <div class="data-footer mt-5 text-muted small">
                        <span>ID: {{ Math.floor(Math.random() * 999999) }}</span>
                        <span class="mx-2">|</span>
                        <span>ESTADO: ONLINE</span>
                    </div>

                </main>
            </div>

            <div class="tech-corner top-left"></div>
            <div class="tech-corner top-right"></div>
            <div class="tech-corner bottom-left"></div>
            <div class="tech-corner bottom-right"></div>
        </div>
    </b-modal>
</template>

<script setup lang="ts">
import { computed } from 'vue';
import { formatImageUrl } from "@/helpers/url";

const props = defineProps<{
    modelValue: boolean;
    course: any;
}>();

const emit = defineEmits(['update:modelValue']);

const isVisible = computed({
    get: () => props.modelValue,
    set: (value) => emit('update:modelValue', value)
});

const isUrl = (string: string) => {
    try { return Boolean(new URL(string)); } catch (e) { return false; }
};
</script>

<style scoped lang="scss">
/* --- 1. CONFIGURACIÓN Y VARIABLES --- */
$c-primary: #144c74; // Azul profundo
$c-secondary: #746c6c; // Gris neutro
$c-accent: #e31140; // Rojo vibrante
$c-dark: #0a1016; // Fondo muy oscuro

$anim-speed: 0.4s;

/* --- 2. CONTENEDOR PRINCIPAL (La Caja) --- */
.tech-interface-container {
    position: relative;
    width: 100%;
    /* Altura dinámica pero limitada: Esto arregla el "no se ve todo" */
    height: 85vh; 
    max-height: 900px;
    background-color: #ffffff;
    overflow: hidden;
    display: flex;
    flex-direction: column;
    box-shadow: 0 0 50px rgba($c-primary, 0.4);
    
    /* Animación de entrada: Expansión desde el centro */
    animation: interfaceBoot 0.5s cubic-bezier(0.16, 1, 0.3, 1) forwards;
    transform-origin: center;
}

@keyframes interfaceBoot {
    0% { transform: scaleY(0.01) scaleX(0); opacity: 0; }
    50% { transform: scaleY(0.01) scaleX(1); opacity: 1; }
    100% { transform: scaleY(1) scaleX(1); opacity: 1; }
}

/* --- 3. FONDO DECORATIVO --- */
.interface-bg {
    position: absolute; inset: 0; pointer-events: none; z-index: 0;
    .grid-lines {
        width: 100%; height: 100%;
        background-image: linear-gradient(rgba($c-secondary, 0.1) 1px, transparent 1px),
                          linear-gradient(90deg, rgba($c-secondary, 0.1) 1px, transparent 1px);
        background-size: 30px 30px;
    }
}

/* --- 4. LAYOUT GRID (El secreto del UX) --- */
.interface-body {
    display: grid;
    grid-template-columns: 40% 60%; /* Imagen 40%, Texto 60% */
    height: 100%;
    width: 100%;
    position: relative; z-index: 2;
    
    @media (max-width: 991px) {
        grid-template-columns: 1fr; /* En móviles una sola columna */
        grid-template-rows: 300px auto;
        overflow-y: auto; /* Scroll global en móvil */
    }
}

/* --- 5. COLUMNA VISUAL (Imagen) --- */
.visualizer-col {
    background: $c-dark;
    position: relative;
    border-right: 4px solid $c-primary;
    overflow: hidden;
}

.visualizer-frame {
    width: 100%; height: 100%; position: relative;
}

.project-img {
    width: 100%; height: 100%; object-fit: cover;
    opacity: 0.8; mix-blend-mode: luminosity;
    transition: 0.5s;
    &:hover { opacity: 1; mix-blend-mode: normal; transform: scale(1.05); }
}

.scan-laser {
    position: absolute; top: 0; left: 0; width: 100%; height: 2px;
    background: $c-accent;
    box-shadow: 0 0 15px $c-accent;
    z-index: 10;
    animation: scanDown 3s infinite linear;
    opacity: 0.5;
}
@keyframes scanDown { 0% { top: 0%; opacity: 0; } 10% { opacity: 1; } 90% { opacity: 1; } 100% { top: 100%; opacity: 0; } }

/* --- 6. COLUMNA DE DATOS (Con SCROLL) --- */
.data-col {
    padding: 3rem;
    overflow-y: auto; /* AQUÍ ESTÁ LA CLAVE: Scroll solo en el texto */
    position: relative;
    background: white;
}

/* Scrollbar personalizada */
.cyber-scroll::-webkit-scrollbar { width: 6px; }
.cyber-scroll::-webkit-scrollbar-track { background: #eee; }
.cyber-scroll::-webkit-scrollbar-thumb { background: $c-primary; }

/* Header */
.category-tag {
    color: $c-accent; font-weight: bold; letter-spacing: 2px; font-size: 0.8rem; margin-bottom: 0.5rem;
    display: flex; align-items: center; gap: 5px;
}
.data-title {
    font-size: 2.5rem; font-weight: 800; color: $c-primary; line-height: 1.1; margin-bottom: 1rem;
    text-transform: uppercase;
}
.decor-line { height: 4px; width: 50px; background: $c-accent; margin-bottom: 2rem; }

/* Secciones Animadas (Staggered) */
.content-sequence > * {
    opacity: 0; transform: translateY(20px);
    animation: slideUpFade 0.5s forwards;
}
.content-sequence > *:nth-child(1) { animation-delay: 0.3s; }
.content-sequence > *:nth-child(2) { animation-delay: 0.4s; }
.content-sequence > *:nth-child(3) { animation-delay: 0.5s; }
.content-sequence > *:nth-child(4) { animation-delay: 0.6s; }
.content-sequence > *:nth-child(5) { animation-delay: 0.7s; }

@keyframes slideUpFade { to { opacity: 1; transform: translateY(0); } }

.section-label { font-size: 1.1rem; color: $c-primary; font-weight: 700; border-bottom: 1px solid #ddd; padding-bottom: 10px; margin-bottom: 15px; }
.section-text { color: $c-secondary; font-size: 1.05rem; }

/* Tarjetas de Información */
.info-card {
    display: flex; align-items: flex-start; gap: 15px;
    background: #f8f9fa; border: 1px solid #e9ecef; border-left: 3px solid $c-secondary;
    padding: 15px; transition: 0.3s;
    
    .card-icon { 
        min-width: 40px; height: 40px; background: #e9ecef; color: $c-secondary;
        display: flex; align-items: center; justify-content: center; font-size: 1.2rem;
    }
    strong { display: block; color: $c-primary; margin-bottom: 5px; }
    p { margin: 0; color: #555; font-size: 0.95rem; }

    &:hover { transform: translateX(5px); background: white; box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
    
    &.blue-theme { border-left-color: $c-primary; .card-icon { color: $c-primary; background: rgba($c-primary, 0.1); } }
    &.accent-theme { border-left-color: $c-accent; .card-icon { color: $c-accent; background: rgba($c-accent, 0.1); } }
}

/* --- 7. BOTÓN CERRAR HOLOGRAMA --- */
.close-holo-btn {
    position: absolute; top: 20px; right: 20px; z-index: 50;
    background: transparent; border: 1px solid rgba($c-accent, 0.3);
    color: $c-accent; padding: 5px 15px;
    display: flex; align-items: center; gap: 10px;
    font-size: 0.8rem; font-weight: bold; cursor: pointer;
    transition: 0.3s;
    
    .cross::before { content: '✕'; font-size: 1.2rem; }
    &:hover { background: $c-accent; color: white; border-color: $c-accent; box-shadow: 0 0 15px $c-accent; }
}

/* --- 8. BOTÓN DESCARGA (HYPER) --- */
.btn-hyper-download {
    display: block; text-decoration: none;
    background: $c-primary; color: white;
    padding: 15px 25px; position: relative; overflow: hidden;
    clip-path: polygon(10px 0, 100% 0, 100% calc(100% - 10px), calc(100% - 10px) 100%, 0 100%, 0 10px);
    transition: 0.3s;

    .btn-content { position: relative; z-index: 2; display: flex; align-items: center; }
    
    &:hover {
        background: $c-accent;
        transform: translateY(-2px);
        box-shadow: 0 10px 30px rgba($c-accent, 0.4);
    }

    /* Brillo animado */
    &::after {
        content: ''; position: absolute; top: 0; left: -100%; width: 100%; height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
        animation: shine 3s infinite;
    }
}
@keyframes shine { 20% { left: 100%; } 100% { left: 100%; } }

/* Terminal MSG */
.terminal-msg {
    background: #222; color: #0f0; padding: 15px; font-family: monospace; border-left: 4px solid $c-accent;
    .prompt { color: $c-accent; margin-right: 10px; }
}

/* --- 9. ESQUINAS TECH --- */
.tech-corner {
    position: absolute; width: 20px; height: 20px; border: 2px solid $c-primary; pointer-events: none; z-index: 5;
    &.top-left { top: 0; left: 0; border-right: none; border-bottom: none; }
    &.top-right { top: 0; right: 0; border-left: none; border-bottom: none; }
    &.bottom-left { bottom: 0; left: 0; border-right: none; border-top: none; }
    &.bottom-right { bottom: 0; right: 0; border-left: none; border-top: none; }
}
</style>