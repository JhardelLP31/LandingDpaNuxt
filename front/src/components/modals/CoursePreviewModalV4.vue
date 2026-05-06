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
        <div class="ide-window" v-if="isVisible">
            
            <div class="ide-top-bar">
                <div class="window-controls">
                    <span class="dot close-dot" @click="isVisible = false"></span>
                    <span class="dot min-dot"></span>
                    <span class="dot max-dot"></span>
                </div>
                <div class="tabs-container">
                    <div class="tab active">
                        <i class="las la-file-code text-warning me-2"></i>
                        <span>{{ course.slug || 'recurso' }}.json</span>
                        <span class="close-tab" @click="isVisible = false">×</span>
                    </div>
                    <div class="tab inactive d-none d-md-flex">
                        <i class="las la-image text-info me-2"></i>
                        <span>preview.png</span>
                    </div>
                </div>
                <div class="breadcrumbs d-none d-lg-block">
                    src > components > {{ course.category ? course.category.name.toLowerCase() : 'modules' }} > 
                    <span class="text-white">{{ course.title.substring(0, 15) }}...</span>
                </div>
            </div>

            <div class="ide-workspace">
                
                <aside class="ide-sidebar">
                    <div class="explorer-title">TIMELINE PREVIEW</div>
                    <div class="preview-container">
                        <div class="img-wrapper">
                            <img 
                                :src="formatImageUrl(course.image_path)" 
                                v-if="course.image_path" 
                                class="preview-img" 
                                alt="Asset Preview"
                            >
                            <div v-else class="empty-code">
                                <i class="las la-code-branch fs-1 mb-2"></i>
                                <span>// Image not found <br> 404 Exception</span>
                            </div>
                        </div>
                        
                        <div class="git-info">
                            <div class="git-item"><i class="las la-code-branch"></i> main</div>
                            <div class="git-item"><i class="las la-check-circle"></i> 0 errors</div>
                            <div class="git-item text-warning"><i class="las la-exclamation-triangle"></i> 0 warnings</div>
                        </div>
                    </div>
                </aside>

                <main class="ide-editor scroll-monokai">
                    
                    <div class="line-numbers">
                        <span v-for="n in 20" :key="n">{{ n }}</span>
                    </div>

                    <div class="code-content">
                        
                        <div class="code-block mb-4">
                            <span class="c-comment">/**</span><br>
                            <span class="c-comment"> * <span class="text-white fw-bold">{{ course.title }}</span></span><br>
                            <span class="c-comment"> * @version 2.0.0</span><br>
                            <span class="c-comment"> * @description {{ course.description || 'Sin descripción definida.' }}</span><br>
                            <span class="c-comment"> */</span>
                        </div>

                        <div class="code-block mb-4" v-if="course.content_blocks?.ventajas">
                            <span class="c-keyword">const</span> <span class="c-func">getVentajas</span> = () => {<br>
                            &nbsp;&nbsp;<span class="c-return">return</span> <span class="c-string">"{{ course.content_blocks.ventajas }}"</span>;<br>
                            }
                        </div>

                        <div class="code-block mb-4" v-if="course.content_blocks?.aplicacion">
                            <span class="c-class">Application</span>.<span class="c-method">runContext</span>({<br>
                            &nbsp;&nbsp;target: <span class="c-string">"Estudiantes"</span>,<br>
                            &nbsp;&nbsp;context: <span class="c-string">"{{ course.content_blocks.aplicacion }}"</span><br>
                            });
                        </div>

                        <div class="code-block mb-4" v-if="course.content_blocks?.laboratorios">
                            <span class="c-keyword">export default</span> {<br>
                            &nbsp;&nbsp;labsAvailable: <span class="c-boolean text-warning">{{ course.content_blocks.laboratorios }}</span><br>
                            }
                        </div>

                        <div class="ide-terminal mt-5">
                            <div class="terminal-bar">
                                <span>TERMINAL</span>
                                <span>OUTPUT</span>
                                <span>DEBUG CONSOLE</span>
                            </div>
                            <div class="terminal-body">
                                <div class="mb-2">
                                    <span class="prompt">user@esan-lab:~$</span> 
                                    <span class="typing-effect">npm install {{ course.slug || 'recurso-software' }} --save-dev</span>
                                </div>
                                
                                <div class="mt-3">
                                    <div v-if="course.video_url">
                                        <div v-if="isUrl(course.video_url)">
                                            <a :href="course.video_url" target="_blank" class="btn-execute">
                                                <i class="las la-play me-2"></i> EXECUTE DOWNLOAD SCRIPT
                                            </a>
                                        </div>
                                        <div v-else class="console-output">
                                            > <span class="text-success">Success!</span> Instructions received:<br>
                                            > {{ course.video_url }}
                                        </div>
                                    </div>
                                    <div v-else class="text-muted">
                                        > Process finished with exit code 0 (No link provided)
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </main>
            </div>

            <div class="ide-status-bar">
                <div class="left">
                    <div class="item bg-primary-brand text-white"><i class="las la-code-branch"></i> master*</div>
                    <div class="item"><i class="las la-sync"></i> 0</div>
                    <div class="item"><i class="las la-times-circle"></i> 0</div>
                    <div class="item"><i class="las la-exclamation-triangle"></i> 0</div>
                </div>
                <div class="right">
                    <div class="item">Ln 12, Col 45</div>
                    <div class="item">UTF-8</div>
                    <div class="item">JSON</div>
                    <div class="item"><i class="las la-bell"></i></div>
                </div>
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
/* --- 1. VS CODE THEME PALETTE (Dracula/Dark inspired) --- */
$bg-main: #1e1e1e;       /* Fondo del editor */
$bg-sidebar: #252526;    /* Fondo barra lateral */
$bg-activity: #333333;   /* Barra de titulo */
$text-main: #d4d4d4;     /* Texto normal */
$c-keyword: #569cd6;     /* const, var, function (Azul) */
$c-string: #ce9178;      /* Strings (Naranja suave) */
$c-class: #4ec9b0;       /* Clases (Verde agua) */
$c-method: #dcdcaa;      /* Métodos (Amarillo suave) */
$c-comment: #6a9955;     /* Comentarios (Verde) */
$brand-blue: #007acc;    /* VS Code Blue para status bar */

/* Font Family para todo el modal */
.ide-window {
    font-family: 'Consolas', 'Monaco', 'Courier New', monospace; /* Clave para el look */
    color: $text-main;
    background: $bg-main;
    width: 100%;
    height: 85vh; max-height: 900px;
    display: flex; flex-direction: column;
    border-radius: 8px;
    box-shadow: 0 20px 50px rgba(0,0,0,0.5);
    overflow: hidden;
    border: 1px solid #444;
}

/* --- 2. TOP BAR (Window Controls) --- */
.ide-top-bar {
    height: 40px;
    background: #3c3c3c;
    display: flex; align-items: center;
    padding-left: 10px;
    border-bottom: 1px solid #2d2d2d;
}

.window-controls {
    display: flex; gap: 8px; margin-right: 20px;
    .dot { width: 12px; height: 12px; border-radius: 50%; display: inline-block; }
    .close-dot { background: #ff5f56; cursor: pointer; &:hover { opacity: 0.8; } }
    .min-dot { background: #ffbd2e; }
    .max-dot { background: #27c93f; }
}

.tabs-container {
    display: flex; align-items: flex-end; height: 100%;
    .tab {
        background: $bg-main; color: white;
        padding: 8px 15px; font-size: 0.9rem;
        border-right: 1px solid #2d2d2d;
        display: flex; align-items: center; cursor: pointer;
        &.active { border-top: 2px solid $brand-blue; }
        &.inactive { background: #2d2d2d; color: #999; font-style: italic; }
        .close-tab { margin-left: 10px; font-size: 1.1rem; &:hover{ color: white; } }
    }
}

.breadcrumbs {
    margin-left: auto; margin-right: 15px; color: #888; font-size: 0.8rem;
}

/* --- 3. WORKSPACE (Grid Layout) --- */
.ide-workspace {
    display: flex; flex: 1; overflow: hidden;
    @media (max-width: 991px) { flex-direction: column; overflow-y: auto; }
}

/* SIDEBAR (Image) */
.ide-sidebar {
    width: 40%;
    background: $bg-sidebar;
    border-right: 1px solid #333;
    display: flex; flex-direction: column;
    @media (max-width: 991px) { width: 100%; height: 300px; flex-shrink: 0; }
}
.explorer-title {
    padding: 10px 20px; font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1px; color: #bbb; font-weight: bold;
}
.preview-container {
    padding: 20px; flex: 1; display: flex; flex-direction: column; align-items: center; justify-content: center;
}
.img-wrapper {
    width: 100%; height: 100%; border: 1px dashed #555; padding: 5px;
    display: flex; align-items: center; justify-content: center;
}
.preview-img { max-width: 100%; max-height: 300px; object-fit: contain; }
.git-info {
    margin-top: auto; padding-top: 20px; width: 100%;
    display: flex; gap: 15px; font-size: 0.8rem; color: #888;
}

/* EDITOR (Code) */
.ide-editor {
    width: 60%;
    background: $bg-main;
    display: flex;
    overflow-y: auto; /* Scroll interno */
    position: relative;
    @media (max-width: 991px) { width: 100%; height: auto; }
}

/* Scrollbar Theme */
.scroll-monokai::-webkit-scrollbar { width: 10px; background: $bg-main; }
.scroll-monokai::-webkit-scrollbar-thumb { background: #424242; border-radius: 0; }
.scroll-monokai::-webkit-scrollbar-thumb:hover { background: #4f4f4f; }

/* Line Numbers */
.line-numbers {
    width: 50px; flex-shrink: 0;
    text-align: right; padding-right: 15px; padding-top: 20px;
    color: #6e7681; font-size: 0.9rem; line-height: 1.6;
    border-right: 1px solid #333; margin-right: 20px;
    display: flex; flex-direction: column;
}

/* Code Content */
.code-content {
    padding: 20px 20px 20px 0;
    font-size: 1rem; line-height: 1.6; width: 100%;
}
.code-block { margin-bottom: 25px; }

/* Syntax Highlighting Classes */
.c-keyword { color: $c-keyword; }
.c-func { color: $c-method; }
.c-string { color: $c-string; }
.c-return { color: #c586c0; } /* Purple */
.c-class { color: $c-class; }
.c-method { color: $c-method; }
.c-comment { color: $c-comment; font-style: italic; }
.c-boolean { color: $c-keyword; }

/* --- 4. TERMINAL SECTION --- */
.ide-terminal {
    border-top: 1px solid #333; margin-top: 30px;
}
.terminal-bar {
    display: flex; gap: 20px; border-bottom: 1px solid #333; padding: 5px 0;
    span { 
        font-size: 0.8rem; cursor: pointer; color: #888; 
        &:first-child { color: white; border-bottom: 1px solid white; }
    }
}
.terminal-body {
    padding: 15px 0; background: #1e1e1e; font-size: 0.9rem;
}
.prompt { color: #87d7f2; margin-right: 10px; font-weight: bold; }
.typing-effect {
    overflow: hidden; white-space: nowrap; border-right: 2px solid white;
    animation: typing 2s steps(40, end), blink-caret .75s step-end infinite;
}

/* Button "Execute" */
.btn-execute {
    background: #238636; /* GitHub Green */
    color: white; border: 1px solid rgba(255,255,255,0.1);
    padding: 8px 16px; font-size: 0.9rem; text-decoration: none;
    display: inline-flex; align-items: center; border-radius: 4px;
    transition: 0.2s;
    &:hover { background: #2ea043; }
}

.console-output {
    background: #111; padding: 10px; border-left: 3px solid #238636; color: #ccc;
}

/* --- 5. STATUS BAR --- */
.ide-status-bar {
    height: 25px; background: $brand-blue; color: white;
    display: flex; justify-content: space-between; align-items: center;
    padding: 0 10px; font-size: 0.75rem; cursor: default;
    
    .left, .right { display: flex; align-items: center; }
    .item { margin-right: 15px; display: flex; align-items: center; gap: 5px; cursor: pointer; &:hover{ opacity: 0.8;} }
    .bg-primary-brand { background: #007acc; } /* Keep consistent */
}

@keyframes typing { from { width: 0 } to { width: 100% } }
@keyframes blink-caret { from, to { border-color: transparent } 50% { border-color: white; } }
</style>