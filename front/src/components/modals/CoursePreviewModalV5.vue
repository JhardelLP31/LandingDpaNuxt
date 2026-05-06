<template>
    <b-modal 
        v-model="isVisible" 
        size="xl" 
        hide-footer 
        hide-header 
        centered 
        body-class="p-0" 
        content-class="sys-spec-modal"
        no-fade
    >
        <div class="spec-sheet-container" v-if="isVisible">
            
            <header class="sheet-header">
                <div class="header-main">
                    <div class="d-flex align-items-center mb-1">
                        <span class="sys-id">SYS-ID: {{ course.id || '001' }}</span>
                        <span class="divider">|</span>
                        <span class="category-text">{{ course.category ? course.category.name : 'GENERAL' }}</span>
                    </div>
                    <h1 class="course-title">{{ course.title }}</h1>
                </div>
                <button class="btn-close-tech" @click="isVisible = false">
                    <i class="las la-times"></i>
                </button>
                <div class="accent-line"></div>
            </header>

            <div class="sheet-body">
                
                <aside class="visual-col">
                    <div class="image-frame">
                        <span class="corner tl"></span><span class="corner tr"></span>
                        <span class="corner bl"></span><span class="corner br"></span>
                        
                        <img 
                            :src="formatImageUrl(course.image_path)" 
                            v-if="course.image_path" 
                            class="spec-image" 
                            alt="Vista del Sistema"
                        >
                        <div v-else class="no-image">
                            <i class="las la-cube"></i>
                            <p>IMAGEN NO DISPONIBLE</p>
                        </div>
                    </div>

                    <div class="status-panel mt-3">
                        <div class="status-row">
                            <span class="label">ESTADO:</span>
                            <span class="value text-success fw-bold">ACTIVO</span>
                        </div>
                        <div class="status-row">
                            <span class="label">VERSIÓN:</span>
                            <span class="value">FINAL</span>
                        </div>
                        <div class="status-row">
                            <span class="label">ACCESO:</span>
                            <span class="value">PÚBLICO</span>
                        </div>
                    </div>
                </aside>

                <main class="data-col scroll-tech">
                    
                    <section class="data-section">
                        <h4 class="section-title">
                            <i class="las la-align-justify text-accent"></i> Descripción
                        </h4>
                        <div class="section-content">
                            <p class="description-text">
                                {{ course.description || 'Sin descripción detallada disponible.' }}
                            </p>
                        </div>
                    </section>

                    <section class="data-section" v-if="course.content_blocks?.ventajas">
                        <h4 class="section-title">
                            <i class="las la-check-square text-primary"></i> Ventajas
                        </h4>
                        <div class="section-content bg-light-gray">
                            <p>{{ course.content_blocks.ventajas }}</p>
                        </div>
                    </section>

                    <section class="data-section" v-if="course.content_blocks?.aplicacion">
                        <h4 class="section-title">
                            <i class="las la-chalkboard-teacher text-primary"></i> Aplicación en clases
                        </h4>
                        <div class="section-content bg-light-blue">
                            <p>{{ course.content_blocks.aplicacion }}</p>
                        </div>
                    </section>

                    <section class="data-section" v-if="course.content_blocks?.laboratorios">
                        <h4 class="section-title">
                            <i class="las la-flask text-accent"></i> Laboratorios con el software
                        </h4>
                        <div class="section-content border-accent">
                            <p class="fw-bold text-dark mb-0">{{ course.content_blocks.laboratorios }}</p>
                        </div>
                    </section>

                    <div class="download-area mt-5">
                        <div v-if="course.video_url">
                            <div v-if="isUrl(course.video_url)">
                                <a :href="course.video_url" target="_blank" class="btn-tech-download">
                                    <span class="icon-box"><i class="las la-download"></i></span>
                                    <span class="text-box">
                                        <small>RECURSO EXTERNO</small>
                                        <strong>IR AL LINK DE DESCARGA</strong>
                                    </span>
                                    <span class="arrow-box"><i class="las la-angle-right"></i></span>
                                </a>
                            </div>
                            
                            <div v-else class="info-note">
                                <strong class="note-label">Instrucción de Descarga:</strong>
                                <p class="note-text">{{ course.video_url }}</p>
                            </div>
                        </div>
                    </div>

                </main>
            </div>
            
            <footer class="sheet-footer">
                ESAN DATA TECHNOLOGY // ENGINEERING RESOURCES
            </footer>

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
/* --- VARIABLES DE TU MARCA --- */
$brand-primary: #144c74; // Azul profundo
$brand-secondary: #746c6c; // Gris neutro
$brand-accent: #e31140; // Rojo vibrante
$bg-white: #ffffff;
$bg-light: #f8f9fa;

/* --- RESET MODAL --- */
:deep(.sys-spec-modal) {
    background: transparent !important;
    border: none !important;
    box-shadow: none !important;
}

/* --- CONTENEDOR PRINCIPAL --- */
.spec-sheet-container {
    background: $bg-white;
    width: 100%;
    height: 85vh; max-height: 900px;
    display: flex; flex-direction: column;
    box-shadow: 0 25px 50px rgba(0,0,0,0.3);
    border-radius: 4px; /* Bordes sutiles, no muy redondos */
    overflow: hidden;
    font-family: 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
    
    /* Animación de entrada suave y profesional */
    animation: slideUpFade 0.4s ease-out forwards;
}

@keyframes slideUpFade {
    from { opacity: 0; transform: translateY(20px); }
    to { opacity: 1; transform: translateY(0); }
}

/* --- HEADER --- */
.sheet-header {
    background: $brand-primary;
    color: white;
    padding: 20px 30px;
    position: relative;
    display: flex; justify-content: space-between; align-items: flex-start;
}

.header-main {
    flex-grow: 1;
}

.sys-id, .category-text {
    font-size: 0.75rem; letter-spacing: 1px; opacity: 0.8; text-transform: uppercase;
}
.divider { margin: 0 10px; opacity: 0.5; }

.course-title {
    margin: 5px 0 0 0;
    font-size: 2rem;
    font-weight: 700;
    line-height: 1.1;
}

.btn-close-tech {
    background: rgba(255,255,255,0.1);
    border: 1px solid rgba(255,255,255,0.2);
    color: white;
    width: 40px; height: 40px;
    display: flex; align-items: center; justify-content: center;
    font-size: 1.2rem; cursor: pointer; transition: 0.2s;
    &:hover { background: $brand-accent; border-color: $brand-accent; }
}

.accent-line {
    position: absolute; bottom: 0; left: 0; width: 100%; height: 4px;
    background: $brand-accent;
}

/* --- BODY LAYOUT --- */
.sheet-body {
    display: flex; flex: 1; overflow: hidden;
    @media (max-width: 991px) { flex-direction: column; overflow-y: auto; }
}

/* --- COLUMNA IZQUIERDA (Visual) --- */
.visual-col {
    width: 35%;
    background: $bg-light;
    padding: 30px;
    border-right: 1px solid #e0e0e0;
    display: flex; flex-direction: column;
    @media (max-width: 991px) { width: 100%; border-right: none; border-bottom: 1px solid #e0e0e0; }
}

.image-frame {
    position: relative;
    padding: 10px;
    border: 1px solid #ccc;
    background: white;
    box-shadow: 0 5px 15px rgba(0,0,0,0.05);
    
    .spec-image { width: 100%; height: auto; display: block; }
    .no-image { 
        height: 200px; display: flex; flex-direction: column; align-items: center; justify-content: center; 
        background: #eee; color: $brand-secondary; 
        i { font-size: 3rem; margin-bottom: 10px; }
    }

    /* Esquinas técnicas */
    .corner {
        position: absolute; width: 10px; height: 10px; border: 2px solid $brand-primary;
        &.tl { top: -1px; left: -1px; border-right: none; border-bottom: none; }
        &.tr { top: -1px; right: -1px; border-left: none; border-bottom: none; }
        &.bl { bottom: -1px; left: -1px; border-right: none; border-top: none; }
        &.br { bottom: -1px; right: -1px; border-left: none; border-top: none; }
    }
}

.status-panel {
    border: 1px solid #ddd; background: white; padding: 15px;
    .status-row {
        display: flex; justify-content: space-between; margin-bottom: 8px; font-size: 0.85rem;
        &:last-child { margin-bottom: 0; }
        .label { color: $brand-secondary; font-weight: 600; }
        .value { font-weight: 500; color: #333; }
    }
}

/* --- COLUMNA DERECHA (Datos) --- */
.data-col {
    width: 65%;
    padding: 40px;
    background: white;
    overflow-y: auto;
    @media (max-width: 991px) { width: 100%; padding: 20px; }
}

/* Scrollbar técnica */
.scroll-tech::-webkit-scrollbar { width: 8px; }
.scroll-tech::-webkit-scrollbar-track { background: #f1f1f1; }
.scroll-tech::-webkit-scrollbar-thumb { background: $brand-secondary; border-radius: 4px; }

/* Secciones */
.data-section { margin-bottom: 35px; }

.section-title {
    font-size: 1.1rem; color: $brand-primary; font-weight: 700; text-transform: uppercase;
    border-bottom: 2px solid #eee; padding-bottom: 10px; margin-bottom: 15px;
    display: flex; align-items: center; gap: 10px;
}

.section-content {
    font-size: 1rem; line-height: 1.6; color: $brand-secondary;
    
    &.bg-light-gray { background: #f8f9fa; padding: 15px; border-left: 4px solid $brand-secondary; border-radius: 0 4px 4px 0; }
    &.bg-light-blue { background: rgba($brand-primary, 0.05); padding: 15px; border-left: 4px solid $brand-primary; border-radius: 0 4px 4px 0; }
    &.border-accent { padding: 15px; border: 1px solid #eee; border-left: 4px solid $brand-accent; }
}

.description-text { white-space: pre-line; text-align: justify; }

/* Botón Descarga */
.btn-tech-download {
    display: flex; text-decoration: none; border-radius: 4px; overflow: hidden;
    background: $brand-primary; transition: transform 0.2s;
    &:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(20, 76, 116, 0.3); }
    
    .icon-box {
        width: 60px; background: darken($brand-primary, 10%); color: white;
        display: flex; align-items: center; justify-content: center; font-size: 1.5rem;
    }
    .text-box {
        flex-grow: 1; padding: 10px 20px; color: white; display: flex; flex-direction: column; justify-content: center;
        small { font-size: 0.7rem; opacity: 0.8; letter-spacing: 1px; }
        strong { font-size: 1rem; }
    }
    .arrow-box {
        width: 40px; display: flex; align-items: center; justify-content: center; color: white;
        font-size: 1.2rem; background: rgba(0,0,0,0.1);
    }
}

.info-note {
    background: #fff5f5; border: 1px solid #ffcccc; padding: 15px; border-radius: 4px;
    .note-label { color: $brand-accent; display: block; margin-bottom: 5px; }
    .note-text { margin: 0; color: #333; }
}

/* --- FOOTER --- */
.sheet-footer {
    background: #f1f1f1; color: $brand-secondary;
    padding: 10px 30px; font-size: 0.7rem; text-align: right; letter-spacing: 1px;
    border-top: 1px solid #ddd; font-weight: bold;
}

/* Clases de utilidad texto */
.text-primary { color: $brand-primary !important; }
.text-accent { color: $brand-accent !important; }
.text-dark { color: #333 !important; }
</style>