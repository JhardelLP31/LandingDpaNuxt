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
        <div class="space-interface-container" v-if="isVisible">
            
            <div class="cosmos-bg">
                <div class="stars"></div>
                <div class="nebula-glow"></div>
            </div>

            <button class="close-portal-btn" @click="isVisible = false">
                <div class="ring"></div>
                <i class="las la-times"></i>
            </button>

            <div class="interface-body">
                
                <aside class="visualizer-col">
                    <div class="orbital-frame">
                        <div class="orbit-ring ring-1"></div>
                        <div class="orbit-ring ring-2"></div>
                        <div class="radar-sweep"></div>
                        
                        <img 
                            :src="formatImageUrl(course.image_path)" 
                            v-if="course.image_path" 
                            class="project-img" 
                            alt="Visualización"
                        >
                        <div v-else class="empty-state">
                            <i class="las la-planet fs-1 mb-3"></i>
                            <span>SEÑAL PERDIDA</span>
                        </div>

                        <div class="meta-overlay">
                            <span class="holo-badge">TIPO: PLANETARIO</span>
                            <span class="holo-badge text-cyan">SCAN: COMPLETO</span>
                        </div>
                    </div>
                </aside>

                <main class="data-col space-scroll">
                    
                    <header class="data-header">
                        <div class="category-tag">
                            <i class="las la-rocket"></i> 
                            {{ course.category ? course.category.name : 'RECURSO GALÁCTICO' }}
                        </div>
                        <h1 class="data-title glow-text">
                            {{ course.title }}
                        </h1>
                        <div class="stardust-line"></div>
                    </header>

                    <div class="content-sequence">
                        
                        <div class="data-section">
                            <h4 class="section-label">
                                <i class="las la-satellite text-cyan me-2"></i> INFORME DE MISIÓN
                            </h4>
                            <p class="section-text lead">
                                {{ course.description || 'Datos de la misión no disponibles en los archivos.' }}
                            </p>
                        </div>

                        <div class="data-section" v-if="course.content_blocks?.ventajas">
                            <div class="holo-card purple-theme">
                                <div class="card-icon"><i class="las la-meteor"></i></div>
                                <div class="card-body">
                                    <strong>VENTAJAS DEL SISTEMA</strong>
                                    <p>{{ course.content_blocks.ventajas }}</p>
                                </div>
                            </div>
                        </div>

                        <div class="data-section" v-if="course.content_blocks?.aplicacion">
                            <div class="holo-card cyan-theme">
                                <div class="card-icon"><i class="lab la-galactic-republic"></i></div>
                                <div class="card-body">
                                    <strong>APLICACIÓN EN CAMPO</strong>
                                    <p>{{ course.content_blocks.aplicacion }}</p>
                                </div>
                            </div>
                        </div>

                        <div class="data-section" v-if="course.content_blocks?.laboratorios">
                            <div class="holo-card gold-theme highlight">
                                <div class="card-icon"><i class="las la-atom"></i></div>
                                <div class="card-body">
                                    <strong>DISPONIBILIDAD EN ESTACIONES</strong>
                                    <p class="fw-bold fs-5 mb-0 text-white">{{ course.content_blocks.laboratorios }}</p>
                                </div>
                            </div>
                        </div>

                        <div class="action-zone mt-5 pt-4">
                            <div v-if="course.video_url">
                                <div v-if="isUrl(course.video_url)">
                                    <a :href="course.video_url" target="_blank" class="btn-warp-drive">
                                        <div class="thruster-effect"></div>
                                        <span class="btn-content">
                                            <i class="las la-shuttle-space fs-2 me-3"></i>
                                            <div class="text-start">
                                                <small class="d-block opacity-75 fw-light">COORDENADAS RECIBIDAS</small>
                                                <span class="fw-bold tracking-wider">INICIAR SALTO HIPERESPACIAL</span>
                                            </div>
                                        </span>
                                    </a>
                                </div>
                                <div v-else class="transmission-box">
                                    <div class="trans-header">
                                        <i class="las la-satellite-dish me-2 spinning"></i> TRANSMISIÓN ENTRANTE...
                                    </div>
                                    <div class="trans-body text-cyan">
                                        "{{ course.video_url }}"
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                    
                    <div class="data-footer mt-5 text-muted small opacity-50">
                        <span>SECTOR: {{ Math.floor(Math.random() * 999) }}-Alpha</span>
                        <span class="mx-3">||</span>
                        <span>ESTADO DE LA NAVE: OPERATIVO</span>
                    </div>

                </main>
            </div>
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
/* --- 1. PALETA ESPACIAL --- */
$s-dark: #050a14;     // Negro espacio profundo
$s-panel: #0c1626;    // Azul muy oscuro para paneles
$s-cyan: #00f2ff;     // Cian eléctrico (Color principal)
$s-purple: #bd00ff;   // Violeta nebulosa
$s-gold: #ffd700;     // Dorado para destacados
$s-text: #e1e6f5;     // Blanco azulado para texto

/* Utilidades */
.text-cyan { color: $s-cyan !important; }
.tracking-wider { letter-spacing: 1.5px; }
.glow-text { text-shadow: 0 0 15px rgba($s-cyan, 0.6); }

/* --- 2. CONTENEDOR PRINCIPAL (La Ventana de la Nave) --- */
.space-interface-container {
    position: relative;
    width: 100%;
    height: 85vh; max-height: 900px; /* Mantiene la estructura rectangular */
    background-color: $s-dark;
    overflow: hidden;
    display: flex;
    flex-direction: column;
    border-radius: 20px; /* Bordes redondeados orgánicos */
    border: 1px solid rgba($s-cyan, 0.3);
    box-shadow: 0 0 60px rgba($s-cyan, 0.2), inset 0 0 30px rgba($s-dark, 0.8);
    
    /* Animación de "Warp In" */
    animation: warpIn 0.6s cubic-bezier(0.22, 1, 0.36, 1) forwards;
    transform-origin: center;
}

@keyframes warpIn {
    0% { transform: scale(0.1); opacity: 0; filter: blur(20px); }
    70% { transform: scale(1.05); opacity: 1; filter: blur(0px); }
    100% { transform: scale(1); }
}

/* --- 3. FONDO CÓSMICO ANIMADO --- */
.cosmos-bg {
    position: absolute; inset: 0; pointer-events: none; z-index: 0;
    overflow: hidden;
    
    .stars {
        position: absolute; width: 200%; height: 200%;
        background-image: 
            radial-gradient(1px 1px at 10% 10%, white, transparent),
            radial-gradient(1px 1px at 20% 30%, white, transparent),
            radial-gradient(2px 2px at 40% 70%, white, transparent),
            radial-gradient(1px 1px at 60% 40%, white, transparent),
            radial-gradient(2px 2px at 80% 80%, white, transparent);
        background-size: 300px 300px;
        opacity: 0.3;
        animation: starMove 100s linear infinite;
    }
    
    .nebula-glow {
        position: absolute; top: -50%; left: -50%; width: 200%; height: 200%;
        background: radial-gradient(circle at center, rgba($s-purple, 0.2) 0%, transparent 60%),
                    radial-gradient(circle at 80% 30%, rgba($s-cyan, 0.2) 0%, transparent 50%);
        filter: blur(50px);
        animation: nebulaPulse 15s ease-in-out infinite alternate;
    }
}
@keyframes starMove { 0% { transform: translateY(0); } 100% { transform: translateY(-50%); } }
@keyframes nebulaPulse { 0% { opacity: 0.5; transform: scale(1) rotate(0deg); } 100% { opacity: 1; transform: scale(1.1) rotate(10deg); } }

/* --- 4. LAYOUT GRID (Misma estructura sólida) --- */
.interface-body {
    display: grid; grid-template-columns: 40% 60%; height: 100%; width: 100%;
    position: relative; z-index: 2;
    @media (max-width: 991px) { grid-template-columns: 1fr; grid-template-rows: 350px auto; overflow-y: auto; }
}

/* --- 5. COLUMNA VISUAL (Escáner Orbital) --- */
.visualizer-col {
    background: rgba($s-panel, 0.8);
    position: relative; overflow: hidden;
    border-right: 1px solid rgba($s-cyan, 0.2);
}

.orbital-frame {
    width: 100%; height: 100%; position: relative;
    display: flex; align-items: center; justify-content: center;
}

.project-img {
    width: 100%; height: 100%; object-fit: cover;
    opacity: 0.9; position: relative; z-index: 2;
    mask-image: linear-gradient(to bottom, black 80%, transparent 100%);
}

.empty-state {
    color: rgba($s-cyan, 0.5); text-align: center; z-index: 2;
    display: flex; flex-direction: column; align-items: center;
}

/* Animaciones orbitales */
.orbit-ring {
    position: absolute; border: 1px solid rgba($s-cyan, 0.3); border-radius: 50%;
    position: absolute; top: 50%; left: 50%; translate: -50% -50%;
    &.ring-1 { width: 80%; height: 80%; border-top-color: $s-cyan; animation: spin 20s linear infinite; }
    &.ring-2 { width: 60%; height: 60%; border-bottom-color: $s-purple; animation: spin 15s linear infinite reverse; }
}
.radar-sweep {
    position: absolute; top: 50%; left: 50%; width: 50%; height: 2px;
    background: linear-gradient(90deg, $s-cyan, transparent);
    transform-origin: left center;
    animation: spin 4s linear infinite;
    opacity: 0.5; z-index: 5;
}
@keyframes spin { 100% { transform: rotate(360deg) translate(-50%, -50%); } }

.meta-overlay {
    position: absolute; bottom: 20px; left: 20px; z-index: 10;
    display: flex; gap: 10px;
}
.holo-badge {
    background: rgba($s-cyan, 0.1); border: 1px solid rgba($s-cyan, 0.4);
    color: $s-text; padding: 4px 10px; font-size: 0.7rem; letter-spacing: 1px;
    backdrop-filter: blur(5px);
}

/* --- 6. COLUMNA DE DATOS (HUD Scrollable) --- */
.data-col {
    padding: 3rem; overflow-y: auto; position: relative;
    background: rgba($s-panel, 0.95); color: $s-text;
}
/* Scrollbar espacial */
.space-scroll::-webkit-scrollbar { width: 5px; }
.space-scroll::-webkit-scrollbar-track { background: rgba($s-cyan, 0.05); }
.space-scroll::-webkit-scrollbar-thumb { background: $s-cyan; border-radius: 10px; box-shadow: 0 0 5px $s-cyan; }

/* Header */
.category-tag {
    color: $s-purple; font-weight: bold; letter-spacing: 2px; font-size: 0.8rem; margin-bottom: 0.5rem;
    display: flex; align-items: center; gap: 5px; text-transform: uppercase;
}
.data-title {
    font-size: 2.5rem; font-weight: 800; color: white; line-height: 1.1; margin-bottom: 1.5rem;
}
.stardust-line { 
    height: 2px; width: 100%; 
    background: linear-gradient(90deg, transparent, $s-cyan, $s-purple, transparent);
    margin-bottom: 2.5rem; opacity: 0.7;
}

/* Secciones */
.section-label { 
    font-size: 1rem; color: $s-cyan; font-weight: 700; letter-spacing: 1px;
    margin-bottom: 15px; display: flex; align-items: center;
}
.section-text { color: rgba($s-text, 0.8); font-size: 1.05rem; font-weight: 300; }

/* Tarjetas Holográficas */
.holo-card {
    display: flex; align-items: flex-start; gap: 15px;
    background: rgba($s-cyan, 0.05); 
    border: 1px solid rgba($s-cyan, 0.2);
    padding: 20px; border-radius: 12px;
    transition: 0.3s; position: relative; overflow: hidden;
    backdrop-filter: blur(10px);
    
    .card-icon { 
        min-width: 45px; height: 45px; background: rgba($s-cyan, 0.1); color: $s-cyan;
        display: flex; align-items: center; justify-content: center; font-size: 1.4rem;
        border-radius: 50%; box-shadow: 0 0 15px rgba($s-cyan, 0.2);
    }
    strong { display: block; color: white; margin-bottom: 8px; letter-spacing: 0.5px; }
    p { margin: 0; color: rgba($s-text, 0.9); font-size: 0.95rem; font-weight: 300; }

    &:hover { 
        transform: translateY(-5px); 
        background: rgba($s-cyan, 0.1);
        box-shadow: 0 10px 30px rgba($s-cyan, 0.15);
        border-color: rgba($s-cyan, 0.5);
    }

    &.purple-theme { 
        border-color: rgba($s-purple, 0.2); 
        .card-icon { color: $s-purple; background: rgba($s-purple, 0.1); box-shadow: 0 0 15px rgba($s-purple, 0.2); }
        &:hover { border-color: rgba($s-purple, 0.5); background: rgba($s-purple, 0.1); }
    }
    
    &.highlight {
        background: linear-gradient(135deg, rgba($s-gold, 0.1), rgba($s-purple, 0.05));
        border-color: $s-gold;
        .card-icon { color: $s-gold; background: rgba($s-gold, 0.1); box-shadow: 0 0 20px rgba($s-gold, 0.4); }
    }
}

/* --- 7. BOTÓN CERRAR (Portal) --- */
.close-portal-btn {
    position: absolute; top: 20px; right: 20px; z-index: 50;
    width: 40px; height: 40px;
    background: rgba($s-dark, 0.5); color: $s-cyan;
    border: none; border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    font-size: 1.2rem; cursor: pointer;
    transition: 0.3s;
    
    .ring {
        position: absolute; inset: -5px; border: 2px solid $s-cyan; border-radius: 50%;
        border-top-color: transparent; animation: spin 4s linear infinite; opacity: 0; transition: 0.3s;
    }
    &:hover { 
        color: white; background: $s-cyan; box-shadow: 0 0 25px $s-cyan; 
        transform: rotate(90deg);
        .ring { opacity: 1; }
    }
}

/* --- 8. BOTÓN WARP DRIVE (Descarga) --- */
.btn-warp-drive {
    display: block; text-decoration: none;
    background: linear-gradient(90deg, $s-cyan, $s-purple);
    padding: 2px; /* Para el borde gradiente */
    border-radius: 12px; position: relative; overflow: hidden;
    transition: 0.3s;

    .btn-content {
        background: rgba($s-dark, 0.9);
        display: flex; align-items: center;
        padding: 15px 25px; border-radius: 10px;
        color: white; position: relative; z-index: 2;
        transition: 0.3s;
    }
    
    .thruster-effect {
        position: absolute; top: 0; left: -100%; width: 200%; height: 100%;
        background: linear-gradient(90deg, transparent, rgba($s-cyan, 0.8), rgba($s-purple, 0.8), transparent);
        opacity: 0; transition: 0.5s; z-index: 1; filter: blur(10px);
    }

    &:hover {
        transform: scale(1.02) translateY(-2px);
        box-shadow: 0 10px 40px rgba($s-purple, 0.4);
        .btn-content { background: rgba($s-dark, 0.6); }
        .thruster-effect { opacity: 1; left: 100%; transition: 1.5s ease-in-out; }
        i { animation: shake 0.5s infinite; }
    }
}
@keyframes shake { 0%, 100% { transform: translateX(0); } 25% { transform: translateX(-2px); } 75% { transform: translateX(2px); } }

/* Transmisión Box (Texto) */
.transmission-box {
    background: rgba($s-cyan, 0.05); border: 1px dashed rgba($s-cyan, 0.3);
    padding: 20px; border-radius: 12px; font-family: monospace;
    .trans-header { color: $s-purple; margin-bottom: 10px; font-weight: bold; letter-spacing: 1px; }
    .trans-body { font-size: 1.1rem; word-break: break-all; }
    .spinning { animation: spin 2s linear infinite; }
}

/* Animación de entrada en cascada */
.content-sequence > * { opacity: 0; transform: translateY(20px); animation: slideUpGlow 0.6s forwards; }
.content-sequence > *:nth-child(1) { animation-delay: 0.2s; }
.content-sequence > *:nth-child(2) { animation-delay: 0.3s; }
.content-sequence > *:nth-child(3) { animation-delay: 0.4s; }
.content-sequence > *:nth-child(4) { animation-delay: 0.5s; }
.content-sequence > *:nth-child(5) { animation-delay: 0.6s; }

@keyframes slideUpGlow { to { opacity: 1; transform: translateY(0); text-shadow: 0 0 10px rgba($s-cyan, 0.2); } }
</style>