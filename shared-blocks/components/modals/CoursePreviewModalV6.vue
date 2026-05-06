<template>
    <b-modal 
        v-model="isVisible" 
        size="xl" 
        hide-footer 
        hide-header 
        centered 
        body-class="p-0" 
        content-class="sys-modal-wrapper"
        no-fade
    >
        <div class="eng-system-interface" v-if="isVisible">
            
            <div class="system-bg">
                <div class="moving-grid"></div>
            </div>

            <header class="sys-header">
                <div class="loader-line"></div>

                <div class="header-content">
                    <div class="sys-meta">
                        <span class="badge-tech">SYS_ID: {{ course.id || 'NULL' }}</span>
                        <span class="badge-tech category">{{ course.category ? course.category.name : 'MODULE' }}</span>
                    </div>
                    
                    <h1 class="sys-title">
                        <span class="glitch-text" :data-text="course.title">{{ decodedTitle }}</span>
                    </h1>
                </div>

                <button class="btn-sys-close" @click="isVisible = false">
                    <span class="cross-icon"></span>
                    <svg class="circular-progress" viewBox="0 0 100 100">
                        <circle cx="50" cy="50" r="45"></circle>
                    </svg>
                </button>
            </header>

            <div class="sys-body">
                
                <aside class="col-visual">
                    <div class="visual-frame">
                        <div class="scanner-bar"></div>
                        <div class="scanner-overlay"></div>
                        
                        <div class="corner-bracket tl"></div>
                        <div class="corner-bracket tr"></div>
                        <div class="corner-bracket bl"></div>
                        <div class="corner-bracket br"></div>

                        <img 
                            :src="formatImageUrl(course.image_path)" 
                            v-if="course.image_path" 
                            class="sys-image" 
                            alt="System Visualization"
                        >
                        <div v-else class="no-signal">
                            <i class="las la-microchip"></i>
                            <span>NO VISUAL DATA</span>
                        </div>
                    </div>

                    <div class="quick-stats">
                        <div class="stat-item delay-1">
                            <small>LATENCY</small>
                            <strong>0.4ms</strong>
                        </div>
                        <div class="stat-item delay-2">
                            <small>STATUS</small>
                            <strong class="text-success">READY</strong>
                        </div>
                        <div class="stat-item delay-3">
                            <small>ENCRYPTION</small>
                            <strong>AES-256</strong>
                        </div>
                    </div>
                </aside>

                <main class="col-data custom-scrollbar">
                    
                    <div class="content-stream">
                        
                        <div class="data-module reveal-group">
                            <div class="module-header">
                                <i class="las la-align-left text-accent"></i> 
                                <span>SYSTEM_DESCRIPTION</span>
                                <div class="line-grow"></div>
                            </div>
                            <div class="module-content">
                                <p class="typewriter-effect">
                                    {{ course.description || 'Inicializando protocolo de descripción... Datos no encontrados en el sector 7G.' }}
                                </p>
                            </div>
                        </div>

                        <div class="data-module reveal-group delay-100" v-if="course.content_blocks?.ventajas">
                            <div class="module-header">
                                <i class="las la-check-circle text-primary"></i> 
                                <span>CORE_ADVANTAGES</span>
                                <div class="line-grow"></div>
                            </div>
                            <div class="tech-card-container">
                                <div class="tech-card">
                                    <div class="card-deco"></div>
                                    <p>{{ course.content_blocks.ventajas }}</p>
                                </div>
                            </div>
                        </div>

                        <div class="data-module reveal-group delay-200" v-if="course.content_blocks?.aplicacion">
                            <div class="module-header">
                                <i class="las la-network-wired text-primary"></i> 
                                <span>DEPLOYMENT_TARGET</span>
                                <div class="line-grow"></div>
                            </div>
                            <div class="module-content highlight-bg">
                                <p>{{ course.content_blocks.aplicacion }}</p>
                            </div>
                        </div>

                        <div class="data-module reveal-group delay-300" v-if="course.content_blocks?.laboratorios">
                            <div class="module-header">
                                <i class="las la-server text-accent"></i> 
                                <span>PHYSICAL_AVAILABILITY</span>
                                <div class="line-grow"></div>
                            </div>
                            <div class="lab-indicator">
                                <span class="blink-dot"></span>
                                {{ course.content_blocks.laboratorios }}
                            </div>
                        </div>

                        <div class="action-module mt-5 reveal-group delay-400">
                            <div v-if="course.video_url">
                                <div v-if="isUrl(course.video_url)">
                                    <a :href="course.video_url" target="_blank" class="btn-quantum">
                                        <div class="btn-border"></div>
                                        <span class="btn-text">
                                            <i class="las la-download"></i> INITIATE TRANSFER
                                        </span>
                                        <span class="btn-glare"></span>
                                    </a>
                                </div>
                                <div v-else class="console-log">
                                    <span class="prompt">></span> {{ course.video_url }}<span class="cursor">_</span>
                                </div>
                            </div>
                        </div>

                    </div>
                </main>
            </div>
        </div>
    </b-modal>
</template>

<script setup lang="ts">
import { computed, ref, watch, onMounted } from 'vue';
import { formatImageUrl } from "@/helpers/url";

const props = defineProps<{
    modelValue: boolean;
    course: any;
}>();

const emit = defineEmits(['update:modelValue']);

// Control de visibilidad
const isVisible = computed({
    get: () => props.modelValue,
    set: (value) => emit('update:modelValue', value)
});

// Lógica de "Decoder Effect" para el título
const decodedTitle = ref('');
const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%&*';

const runDecoderEffect = (targetText: string) => {
    let iterations = 0;
    const interval = setInterval(() => {
        decodedTitle.value = targetText
            .split('')
            .map((letter, index) => {
                if (index < iterations) return targetText[index];
                return characters[Math.floor(Math.random() * characters.length)];
            })
            .join('');

        if (iterations >= targetText.length) clearInterval(interval);
        iterations += 1 / 2; // Velocidad de decodificación
    }, 30);
};

// Disparar animación cuando se abre el modal
watch(isVisible, (newVal) => {
    if (newVal && props.course?.title) {
        decodedTitle.value = ''; // Reset
        setTimeout(() => runDecoderEffect(props.course.title), 300); // Pequeño delay inicial
    }
});

const isUrl = (string: string) => {
    try { return Boolean(new URL(string)); } catch (e) { return false; }
};
</script>

<style scoped lang="scss">
/* --- 1. VARIABLES (Tu paleta solicitada) --- */
$c-blue: #144c74;
$c-gray: #746c6c;
$c-red: #e31140;
$c-white: #ffffff;
$c-dark-text: #2c3e50;
$c-bg-tech: #fcfcfc;

/* --- 2. CONFIGURACIÓN DEL MODAL --- */
:deep(.sys-modal-wrapper) {
    background: transparent !important;
    border: none !important;
    padding: 0 !important;
}

/* --- 3. CONTENEDOR MAESTRO --- */
.eng-system-interface {
    background: $c-white;
    width: 100%;
    /* Altura Fija en Desktop para UX de aplicación */
    height: 85vh; 
    max-height: 900px;
    
    display: flex; flex-direction: column;
    position: relative;
    overflow: hidden;
    
    box-shadow: 0 0 0 1px rgba($c-blue, 0.2), 0 30px 80px rgba(0,0,0,0.4);
    border-radius: 4px;

    /* Animación de Entrada: Despliegue Técnico */
    animation: interfaceUnfold 0.6s cubic-bezier(0.23, 1, 0.32, 1) forwards;
    transform-origin: center top;
}

@keyframes interfaceUnfold {
    0% { transform: scaleY(0.01) scaleX(0.5); opacity: 0; }
    50% { transform: scaleY(0.01) scaleX(1); opacity: 1; }
    100% { transform: scaleY(1) scaleX(1); opacity: 1; }
}

/* Fondo Grid Animado */
.system-bg {
    position: absolute; inset: 0; pointer-events: none; z-index: 0;
    opacity: 0.4;
    .moving-grid {
        width: 200%; height: 200%;
        background-image: 
            linear-gradient(rgba($c-blue, 0.05) 1px, transparent 1px),
            linear-gradient(90deg, rgba($c-blue, 0.05) 1px, transparent 1px);
        background-size: 40px 40px;
        animation: panGrid 60s linear infinite;
    }
}
@keyframes panGrid { 0% { transform: translate(0, 0); } 100% { transform: translate(-50px, -50px); } }

/* --- 4. HEADER --- */
.sys-header {
    background: $c-white;
    border-bottom: 2px solid $c-blue;
    padding: 20px 30px;
    position: relative; z-index: 10;
    display: flex; justify-content: space-between; align-items: center;
}

.loader-line {
    position: absolute; top: 0; left: 0; height: 3px; width: 100%;
    background: linear-gradient(90deg, transparent, $c-red, transparent);
    animation: loadScan 2s ease-in-out infinite;
}
@keyframes loadScan { 0% { transform: translateX(-100%); } 100% { transform: translateX(100%); } }

.sys-meta {
    display: flex; gap: 10px; margin-bottom: 5px;
    .badge-tech {
        background: $c-blue; color: white; padding: 2px 6px; font-size: 0.7rem; 
        font-family: monospace; letter-spacing: 1px;
    }
    .badge-tech.category { background: $c-gray; }
}

.sys-title {
    font-family: 'Segoe UI', sans-serif; font-weight: 800; font-size: 2rem;
    color: $c-blue; margin: 0; line-height: 1; text-transform: uppercase;
    
    /* El efecto decoder lo maneja JS, pero aquí damos estilo base */
    min-height: 2rem;
}

.btn-sys-close {
    width: 50px; height: 50px; border: none; background: transparent;
    position: relative; display: flex; align-items: center; justify-content: center;
    cursor: pointer;
    
    .cross-icon::before, .cross-icon::after {
        content: ''; position: absolute; width: 20px; height: 2px; background: $c-blue;
        top: 50%; left: 50%; transition: 0.3s;
    }
    .cross-icon::before { transform: translate(-50%, -50%) rotate(45deg); }
    .cross-icon::after { transform: translate(-50%, -50%) rotate(-45deg); }

    .circular-progress {
        position: absolute; inset: 0; width: 100%; height: 100%; fill: none; stroke: $c-red;
        stroke-width: 2; stroke-dasharray: 283; stroke-dashoffset: 283; /* 2*PI*45 */
        transform: rotate(-90deg); transition: stroke-dashoffset 0.4s;
    }

    &:hover {
        .cross-icon::before, .cross-icon::after { background: $c-red; transform: translate(-50%, -50%) rotate(180deg); }
        .circular-progress { stroke-dashoffset: 0; }
    }
}

/* --- 5. CUERPO Y COLUMNAS --- */
.sys-body {
    display: flex; flex: 1; overflow: hidden; position: relative; z-index: 5;
}

/* Columna Izquierda (Visual) */
.col-visual {
    width: 40%;
    background: #f8f9fa;
    border-right: 1px solid #e0e0e0;
    padding: 30px;
    display: flex; flex-direction: column; justify-content: center;
    position: relative;
}

.visual-frame {
    position: relative; overflow: hidden;
    border: 1px solid rgba($c-blue, 0.3);
    background: #000; /* Fondo negro para resaltar imagen */
    box-shadow: 0 10px 30px rgba(0,0,0,0.1);
}

.sys-image {
    width: 100%; height: auto; display: block; opacity: 0.9;
    filter: contrast(1.1) grayscale(0.2);
    transition: 0.5s;
}
.visual-frame:hover .sys-image { filter: none; opacity: 1; }

/* Efecto Escáner */
.scanner-bar {
    position: absolute; top: 0; left: 0; width: 100%; height: 2px;
    background: $c-red; box-shadow: 0 0 10px $c-red; z-index: 10;
    animation: scanning 3s linear infinite;
    opacity: 0.7;
}
.scanner-overlay {
    position: absolute; inset: 0; 
    background: linear-gradient(to bottom, transparent 0%, rgba($c-blue, 0.1) 50%, transparent 100%);
    background-size: 100% 200%;
    animation: scanningOverlay 3s linear infinite;
    pointer-events: none; z-index: 9;
}
@keyframes scanning { 0% { top: -5%; opacity: 0; } 10% { opacity: 1; } 90% { opacity: 1; } 100% { top: 105%; opacity: 0; } }
@keyframes scanningOverlay { 0% { background-position: 0% -100%; } 100% { background-position: 0% 200%; } }

/* Esquinas Bracket */
.corner-bracket {
    position: absolute; width: 15px; height: 15px; border: 2px solid $c-blue; z-index: 20;
    transition: 0.3s;
    &.tl { top: 5px; left: 5px; border-right: none; border-bottom: none; }
    &.tr { top: 5px; right: 5px; border-left: none; border-bottom: none; }
    &.bl { bottom: 5px; left: 5px; border-right: none; border-top: none; }
    &.br { bottom: 5px; right: 5px; border-left: none; border-top: none; }
}
.visual-frame:hover .corner-bracket { width: 25px; height: 25px; border-color: $c-red; }

.quick-stats {
    display: flex; justify-content: space-around; margin-top: 20px;
    .stat-item {
        text-align: center; opacity: 0; animation: fadeUp 0.5s forwards;
        small { display: block; font-size: 0.6rem; color: $c-gray; letter-spacing: 1px; }
        strong { font-family: monospace; color: $c-blue; font-size: 0.9rem; }
    }
    .delay-1 { animation-delay: 0.8s; }
    .delay-2 { animation-delay: 0.9s; }
    .delay-3 { animation-delay: 1.0s; }
}
@keyframes fadeUp { from { opacity: 0; transform: translateY(10px); } to { opacity: 1; transform: translateY(0); } }

/* Columna Derecha (Data) */
.col-data {
    width: 60%;
    padding: 40px;
    background: $c-white;
    overflow-y: auto; /* Scroll Desktop */
    position: relative;
}

/* Scrollbar Personalizada */
.custom-scrollbar::-webkit-scrollbar { width: 8px; }
.custom-scrollbar::-webkit-scrollbar-track { background: #f1f1f1; }
.custom-scrollbar::-webkit-scrollbar-thumb { background: #ccc; border-radius: 4px; border: 2px solid #f1f1f1; }
.custom-scrollbar::-webkit-scrollbar-thumb:hover { background: $c-blue; }

/* Animaciones de Bloques (Reveal) */
.reveal-group {
    opacity: 0; transform: translateX(20px);
    animation: revealSlide 0.6s cubic-bezier(0.215, 0.610, 0.355, 1.000) forwards;
}
.delay-100 { animation-delay: 0.4s; }
.delay-200 { animation-delay: 0.5s; }
.delay-300 { animation-delay: 0.6s; }
.delay-400 { animation-delay: 0.7s; }

@keyframes revealSlide { to { opacity: 1; transform: translateX(0); } }

/* Estilos de Módulos */
.data-module { margin-bottom: 30px; }

.module-header {
    display: flex; align-items: center; gap: 10px; margin-bottom: 12px;
    color: $c-blue; font-weight: 700; font-size: 0.9rem; letter-spacing: 0.5px;
    
    .line-grow {
        flex-grow: 1; height: 1px; background: rgba($c-blue, 0.2);
        transform-origin: left; transform: scaleX(0);
        animation: growLine 0.8s ease forwards 0.5s;
    }
}
@keyframes growLine { to { transform: scaleX(1); } }

.module-content {
    font-size: 1rem; color: #555; line-height: 1.6; text-align: justify;
    &.highlight-bg { background: rgba($c-blue, 0.03); padding: 15px; border-left: 3px solid $c-blue; }
}

/* Cards de Ventajas */
.tech-card {
    background: white; border: 1px solid #eee; padding: 15px;
    position: relative; overflow: hidden; transition: 0.3s;
    box-shadow: 0 5px 10px rgba(0,0,0,0.03);
    
    .card-deco {
        position: absolute; top: 0; right: 0; width: 30px; height: 30px;
        background: linear-gradient(135deg, transparent 50%, rgba($c-blue, 0.1) 50%);
    }
    &:hover {
        transform: translateY(-5px); border-color: $c-blue;
        box-shadow: 0 10px 20px rgba($c-blue, 0.1);
    }
}

/* Laboratorio Indicador */
.lab-indicator {
    display: flex; align-items: center; gap: 10px; font-weight: bold; color: $c-dark-text;
    padding: 10px; border: 1px dashed $c-red; background: rgba($c-red, 0.02);
    
    .blink-dot {
        width: 10px; height: 10px; background: $c-red; border-radius: 50%;
        animation: blink 1.5s infinite;
    }
}
@keyframes blink { 50% { opacity: 0.3; } }

/* Botón Quantum */
.btn-quantum {
    display: block; position: relative; text-decoration: none;
    padding: 18px 30px; background: $c-blue; overflow: hidden;
    color: white; font-weight: bold; letter-spacing: 1px;
    clip-path: polygon(15px 0, 100% 0, 100% calc(100% - 15px), calc(100% - 15px) 100%, 0 100%, 0 15px);
    transition: 0.3s;

    .btn-text { position: relative; z-index: 2; display: flex; align-items: center; gap: 10px; }
    
    .btn-glare {
        position: absolute; top: 0; left: -100%; width: 50%; height: 100%;
        background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
        transform: skewX(-20deg); transition: 0.5s; z-index: 1;
    }

    &:hover {
        background: darken($c-blue, 5%);
        transform: scale(1.02);
        .btn-glare { left: 150%; transition: 0.8s ease-in-out; }
    }
}

.console-log {
    background: #222; color: #0f0; font-family: monospace; padding: 15px; border-radius: 4px;
    .prompt { color: $c-red; margin-right: 10px; }
    .cursor { animation: blink 1s infinite; }
}

/* --- 6. RESPONSIVE ROBUSTO --- */
@media (max-width: 991px) {
    .eng-system-interface {
        height: auto !important;
        max-height: none !important;
        overflow: visible !important;
        border-radius: 0;
        animation: fadeUp 0.4s ease-out forwards; /* Animación más simple en móvil */
    }

    .sys-body {
        flex-direction: column;
    }

    .col-visual {
        width: 100%;
        padding: 20px;
        border-right: none;
        border-bottom: 2px solid $c-blue;
    }
    
    .visual-frame { height: 250px; }
    .sys-image { object-fit: cover; height: 100%; }

    .col-data {
        width: 100%;
        padding: 25px 20px;
        overflow: visible; /* Importante para que el scroll sea nativo del body */
    }

    .sys-header {
        position: sticky; top: 0; z-index: 100;
        padding: 15px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.1);
    }
    .sys-title { font-size: 1.4rem; }
}
</style>