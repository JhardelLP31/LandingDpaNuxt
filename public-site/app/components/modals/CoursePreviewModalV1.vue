<template>
    <b-modal v-model="isVisible" size="xl" hide-footer hide-header centered body-class="p-0" content-class="bg-transparent border-0 shadow-none">
        
        <div class="unreal-card position-relative overflow-hidden">
            
            <div class="aurora-bg"></div>

            <button type="button" class="close-btn-floating" @click="isVisible = false">
                <i class="las la-times"></i>
            </button>

            <div class="modal-content-inner p-4 p-lg-5 position-relative" style="z-index: 2;">
                
                <article class="item-page">
                    
                    <div class="animate-enter delay-1 mb-5">
                        <span class="category-pill mb-3 d-inline-block">
                            {{ course.category ? course.category.name : 'Recurso Premium' }}
                        </span>
                        <h1 class="main-title text-white fw-bold display-4">
                            {{ course.title }}
                        </h1>
                        </div>

                    <div class="row g-5">
                        <div class="col-lg-4 animate-enter delay-2">
                            <div class="levitating-wrapper text-center">
                                <div class="image-glass-frame">
                                    <img :src="formatImageUrl(course.image_path)" 
                                         alt="Portada" 
                                         class="img-fluid" 
                                         v-if="course.image_path">
                                    <div v-else class="placeholder-glow d-flex align-items-center justify-content-center">
                                        <i class="las la-cube fs-1 text-white opacity-50"></i>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-lg-8 animate-enter delay-3">
                            
                            <div class="description-box mb-5">
                                <h4 class="section-title text-white mb-3">
                                    <i class="las la-align-left text-info me-2"></i>Sobre el software
                                </h4>
                                <p class="text-white-80 lh-lg lead" style="white-space: pre-line;">
                                    {{ course.description || 'Descripción no disponible.' }}
                                </p>
                            </div>

                            <div class="row g-4 mb-5">
                                <div class="col-md-6" v-if="course.content_blocks?.ventajas">
                                    <div class="magic-card h-100">
                                        <div class="icon-circle bg-gradient-purple">
                                            <i class="las la-bolt"></i>
                                        </div>
                                        <h5 class="text-white mt-3 fw-bold">Potencia</h5>
                                        <p class="text-white-50 mb-0 small">{{ course.content_blocks.ventajas }}</p>
                                    </div>
                                </div>
                                <div class="col-md-6" v-if="course.content_blocks?.aplicacion">
                                    <div class="magic-card h-100">
                                        <div class="icon-circle bg-gradient-blue">
                                            <i class="las la-graduation-cap"></i>
                                        </div>
                                        <h5 class="text-white mt-3 fw-bold">Académico</h5>
                                        <p class="text-white-50 mb-0 small">{{ course.content_blocks.aplicacion }}</p>
                                    </div>
                                </div>
                            </div>

                            <div class="download-zone p-4 rounded-3 border border-white border-opacity-10 position-relative overflow-hidden">
                                <div class="bg-blur-overlay"></div>
                                <div class="position-relative z-1">
                                    <h5 class="text-white fw-bold mb-3"><i class="las la-download text-success me-2"></i> Acceso al Recurso</h5>
                                    
                                    <div v-if="course.video_url">
                                        <div v-if="isUrl(course.video_url)">
                                            <a :href="course.video_url" target="_blank" class="btn-cyber w-100 text-center text-decoration-none">
                                                <span class="cyber-text">DESCARGAR AHORA</span>
                                                <span class="cyber-glitch"></span>
                                            </a>
                                        </div>
                                        <div v-else class="text-white p-3 border border-info rounded bg-info bg-opacity-10">
                                            <strong class="text-info">Instrucción:</strong> {{ course.video_url }}
                                        </div>
                                    </div>
                                    <div v-else class="text-white-50 fst-italic">
                                        No hay enlace configurado.
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="mt-5 pt-4 border-top border-white border-opacity-10 d-flex justify-content-between align-items-center animate-enter delay-4">
                        <span class="text-white-50 small tracking-widest">ESAN DATA TECHNOLOGY</span>
                        <div class="social-hologram">
                            <i class="lab la-facebook-f"></i>
                            <i class="lab la-twitter"></i>
                            <i class="lab la-linkedin-in"></i>
                        </div>
                    </div>

                </article>
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

<style scoped>
/* --- 1. FONDO Y ESTRUCTURA (GLASSMORPHISM) --- */
.unreal-card {
    background: rgba(16, 18, 27, 0.65); /* Fondo oscuro semitransparente */
    backdrop-filter: blur(20px); /* El efecto borroso clave */
    -webkit-backdrop-filter: blur(20px);
    border-radius: 24px;
    border: 1px solid rgba(255, 255, 255, 0.1);
    box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
    color: white;
    font-family: 'Outfit', sans-serif; /* Asegúrate de importar una fuente moderna si puedes */
    min-height: 600px;
}

/* Efecto Aurora de Fondo */
.aurora-bg {
    position: absolute;
    top: -50%;
    left: -50%;
    width: 200%;
    height: 200%;
    background: radial-gradient(circle at 50% 50%, rgba(76, 29, 149, 0.4), transparent 50%),
                radial-gradient(circle at 80% 20%, rgba(14, 165, 233, 0.3), transparent 40%);
    animation: rotateBg 15s linear infinite;
    z-index: 0;
}

@keyframes rotateBg {
    0% { transform: rotate(0deg); }
    100% { transform: rotate(360deg); }
}

/* --- 2. BOTÓN CERRAR FLOTANTE --- */
.close-btn-floating {
    position: absolute;
    top: 20px;
    right: 20px;
    background: rgba(255, 255, 255, 0.1);
    border: none;
    color: white;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    font-size: 1.2rem;
    cursor: pointer;
    z-index: 10;
    transition: all 0.3s ease;
}
.close-btn-floating:hover {
    background: rgba(255, 0, 85, 0.8);
    transform: rotate(90deg) scale(1.1);
}

/* --- 3. ANIMACIONES DE ENTRADA --- */
.animate-enter {
    opacity: 0;
    transform: translateY(30px);
    animation: fadeInUp 0.8s cubic-bezier(0.2, 0.8, 0.2, 1) forwards;
}
.delay-1 { animation-delay: 0.1s; }
.delay-2 { animation-delay: 0.2s; }
.delay-3 { animation-delay: 0.4s; }
.delay-4 { animation-delay: 0.6s; }

@keyframes fadeInUp {
    to { opacity: 1; transform: translateY(0); }
}

/* --- 4. TIPOGRAFÍA --- */
.category-pill {
    background: linear-gradient(90deg, #ff00cc, #333399);
    padding: 5px 15px;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: bold;
    letter-spacing: 1px;
    text-transform: uppercase;
    box-shadow: 0 0 15px rgba(255, 0, 204, 0.4);
}

.main-title {
    background: linear-gradient(to right, #ffffff, #a5f3fc);
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    text-shadow: 0 0 30px rgba(165, 243, 252, 0.3);
}

.text-white-80 { color: rgba(255, 255, 255, 0.8); }

/* --- 5. IMAGEN LEVITANDO --- */
.levitating-wrapper {
    animation: float 6s ease-in-out infinite;
}
.image-glass-frame {
    background: rgba(255, 255, 255, 0.05);
    padding: 15px;
    border-radius: 20px;
    border: 1px solid rgba(255, 255, 255, 0.2);
    box-shadow: 0 20px 40px rgba(0,0,0,0.4);
    transform: perspective(1000px) rotateY(-5deg);
    transition: transform 0.5s ease;
}
.image-glass-frame:hover {
    transform: perspective(1000px) rotateY(0deg) scale(1.02);
}
.image-glass-frame img {
    border-radius: 12px;
    width: 100%;
    display: block;
}

@keyframes float {
    0%, 100% { transform: translateY(0); }
    50% { transform: translateY(-15px); }
}

/* --- 6. TARJETAS MÁGICAS --- */
.magic-card {
    background: rgba(255, 255, 255, 0.03);
    border: 1px solid rgba(255, 255, 255, 0.05);
    padding: 20px;
    border-radius: 16px;
    transition: all 0.3s ease;
    cursor: default;
}
.magic-card:hover {
    background: rgba(255, 255, 255, 0.1);
    transform: translateY(-5px);
    box-shadow: 0 10px 20px rgba(0,0,0,0.2);
}
.icon-circle {
    width: 40px; height: 40px;
    border-radius: 10px;
    display: flex; align-items: center; justify-content: center;
    font-size: 1.2rem;
}
.bg-gradient-purple { background: linear-gradient(135deg, #a855f7, #6366f1); }
.bg-gradient-blue { background: linear-gradient(135deg, #06b6d4, #3b82f6); }

/* --- 7. BOTÓN CYBER --- */
.btn-cyber {
    display: block;
    background: linear-gradient(90deg, #00f260, #0575e6);
    color: white;
    font-weight: 900;
    padding: 15px;
    border-radius: 8px;
    position: relative;
    overflow: hidden;
    transition: all 0.3s ease;
    text-transform: uppercase;
    letter-spacing: 2px;
    border: none;
    box-shadow: 0 0 20px rgba(0, 242, 96, 0.4);
}
.btn-cyber:hover {
    box-shadow: 0 0 40px rgba(0, 242, 96, 0.8);
    transform: scale(1.02);
    color: white;
}
.btn-cyber::before {
    content: '';
    position: absolute;
    top: 0; left: -100%;
    width: 100%; height: 100%;
    background: linear-gradient(90deg, transparent, rgba(255,255,255,0.4), transparent);
    animation: shimmer 2s infinite;
}

@keyframes shimmer {
    100% { left: 100%; }
}

/* --- 8. SOCIAL HOLOGRAM --- */
.social-hologram i {
    color: rgba(255, 255, 255, 0.5);
    margin-left: 15px;
    font-size: 1.2rem;
    transition: 0.3s;
    cursor: pointer;
}
.social-hologram i:hover {
    color: #fff;
    text-shadow: 0 0 10px rgba(255,255,255,0.8);
    transform: scale(1.2);
}
</style>