<script setup lang="ts">
import { ref, onMounted, computed } from 'vue';
import HttpClient from "@/helpers/http-client";

const devSocialUrl = import.meta.env.VITE_URL_DEV || '#';
const rawMenuItems = ref<any[]>([]);

// --- 1. FUNCIÓN PARA ARMAR EL ÁRBOL ---
// Convierte la lista plana de la BD en estructura Padre -> Hijos
const buildTreeSafe = (data: any[]) => {
  if (!Array.isArray(data)) return [];
  if (data.length > 0 && data[0].children) return data; // Si ya viene armado, lo devuelve

  try {
    const items = JSON.parse(JSON.stringify(data));
    const map: Record<string, any> = {};
    const roots: any[] = [];

    items.forEach((item: any) => { map[item.id] = item; item.children = []; });
    items.forEach((item: any) => {
      if (item.parent_id && map[item.parent_id]) {
        map[item.parent_id].children.push(item);
      } else {
        roots.push(item);
      }
    });
    return roots;
  } catch (e) {
    console.error('Error procesando menú:', e);
    return data;
  }
};

// --- 2. FILTRO: SOLO ITEMS SIN HIJOS ---
// Esta es la lógica clave para la sección "Institucional"
const institutionalLinks = computed(() => {
    return rawMenuItems.value.filter(item => {
        // Se queda solo si NO tiene hijos o el array de hijos está vacío
        return !item.children || item.children.length === 0;
    });
});

// Helper para detectar links externos (http/https)
const isExternal = (link: string) => {
    return link && (link.startsWith('http') || link.startsWith('//'));
};

onMounted(async () => {
    try {
        // PETICIÓN REAL A LA API
        const { data } = await HttpClient.get('public-menu');
        const listaCruda = Array.isArray(data) ? data : (data.data || []);
        
        // Procesamos la respuesta
        rawMenuItems.value = buildTreeSafe(listaCruda);

    } catch (e) {
        console.error("Error cargando menú del footer", e);
    }
});
</script>

<template>
    <footer class="bg-black text-white pt-5 pb-2 mt-auto">
        <div class="container">

            <div class="row g-4 border-bottom border-secondary pb-5">

                <div class="col-lg-4 col-md-6">
                    <div class="mb-4">
                        <img src="@/assets/images/LogoHorizontal.png" alt="Universidad ESAN" height="60" class="d-block filter-white">
                    </div>

                    <p class="text-secondary small mb-3 text-justify">
                        En el Centro de Desarrollo Emprendedor de la Universidad ESAN, nuestra misión es formar y apoyar a emprendedores, profesionales, empresarios y ejecutivos, en su desarrollo y crecimiento profesional. Ofrecemos programas de formación integral, actividades para la creación de empresas y asesoría empresarial de alta calidad.
                    </p>

                    <p class="text-secondary small mb-2">
                        <i class="bi bi-geo-alt-fill text-danger me-2"></i>
                        Alonso de Molina 1652, Monterrico, Surco, Lima - Perú
                    </p>
                    <p class="text-secondary small mb-2">
                        <i class="bi bi-telephone-fill text-danger me-2"></i>
                        (511) 317-7200
                    </p>
                    <p class="text-secondary small">
                        <i class="bi bi-envelope-fill text-danger me-2"></i>
                        admision@esan.edu.pe
                    </p>

                    <div class="d-flex gap-3 mt-4">
                        <a href="https://www.facebook.com/CDE.ESAN/" class="social-btn" target="_blank" rel="noopener">
                            <i class="fab fa-facebook-f"></i>
                        </a>
                        <a href="https://www.instagram.com/cde_esan/" class="social-btn" target="_blank" rel="noopener">
                            <i class="fab fa-instagram"></i>
                        </a>
                        <a href="https://www.linkedin.com/company/cde-esan/" class="social-btn" target="_blank" rel="noopener">
                            <i class="fab fa-linkedin-in"></i>
                        </a>
                        <a href="https://www.youtube.com/@cde-universidadesan866" class="social-btn" target="_blank" rel="noopener">
                            <i class="fab fa-youtube"></i>
                        </a>
                    </div>
                </div>

                <div class="col-lg-3 col-md-6">
                    <h6 class="text-uppercase fw-bold text-danger mb-3">ESAN</h6>
                    <ul class="list-unstyled">
                        <li><a href="https://www.ue.edu.pe/" target="_blank" class="footer-link">Carreras de Pregrado</a></li>
                        <li><a href="https://www.esan.edu.pe/maestrias" target="_blank" class="footer-link">Maestrías Especializadas</a></li>
                        <li><a href="https://www.esan.edu.pe/mba" target="_blank" class="footer-link">MBA</a></li>
                        <li><a href="https://www.esan.edu.pe/educacion-ejecutiva" target="_blank" class="footer-link">Programas para Ejecutivos</a></li>
                        <li><a href="https://www.esan.edu.pe/doctorado" target="_blank" class="footer-link">Doctorados</a></li>
                        <li><a href="https://www.ue.edu.pe/pregrado/centro-de-idiomas" target="_blank" class="footer-link">Idiomas</a></li>
                    </ul>
                </div>

                <div class="col-lg-2 col-md-6">
                    <h6 class="text-uppercase fw-bold text-danger mb-3">Navegación</h6>
                    <ul class="list-unstyled">
                        
                        <li v-for="item in institutionalLinks" :key="item.id">
                            <component 
                                :is="isExternal(item.link) ? 'a' : 'router-link'"
                                :to="!isExternal(item.link) ? item.link : undefined"
                                :href="isExternal(item.link) ? item.link : undefined"
                                :target="isExternal(item.link) ? '_blank' : undefined"
                                class="footer-link"
                            >
                                {{ item.title }}
                            </component>
                        </li>

                        </ul>
                </div>

                <div class="col-lg-3 col-md-6">
                    <h6 class="text-uppercase fw-bold text-danger mb-3">Calidad Acreditada</h6>
                    <p class="text-secondary small mb-3">
                        Somos reconocidos internacionalmente por las acreditadoras más importantes del mundo.
                    </p>
                    <div class="d-flex flex-wrap gap-2">
                        <div class="accreditation-box">AACSB</div>
                        <div class="accreditation-box">AMBA</div>
                        <div class="accreditation-box">EQUIS</div>
                    </div>
                </div>

            </div>

            <div class="row pt-3 align-items-center">
                <div class="col-md-7 text-center text-md-start">
                    <p class="small text-secondary mb-0">
                        &copy; {{ new Date().getFullYear() }} Universidad ESAN | 
                        <!--<span>Desarrollado por el Equipo de Desarrollo Web - ESAN DATA</span>-->
                        <span>ESAN DATA</span>
                    </p>
                </div>
                <div class="col-md-5 text-center text-md-end">
                    <a href="#" class="small text-secondary text-decoration-none me-3 hover-white">Políticas de Privacidad</a>
                    <a href="#" class="small text-secondary text-decoration-none me-3 hover-white">Libro de Reclamaciones</a>
                    <router-link to="/auth/sign-in" class="small staff-access hover-white text-decoration-none">
                        <i class="bi bi-shield-lock me-1"></i>Intranet
                    </router-link>
                </div>
            </div>

            <!--<div class="row mt-0">
                <div class="col-12 text-center text-md-center">
                    <a :href="devSocialUrl" target="_blank" class="developer-signature">
                        <span class="dot"></span> Software Developer
                    </a>
                </div>
            </div>-->

        </div>
    </footer>
</template>

<style scoped lang="scss">
.bg-black { background-color: #111111; }
.text-justify { text-align: justify; }

// Vuelve blanco el logo si es oscuro
.filter-white { filter: brightness(0) invert(1); opacity: 0.9; }

.footer-link {
    color: #999;
    text-decoration: none;
    font-size: 0.9rem;
    margin-bottom: 8px;
    display: block;
    transition: all 0.2s;
    cursor: pointer;
    &:hover { color: white; transform: translateX(5px); }
}

.social-btn {
    width: 35px; height: 35px;
    background-color: #222; color: white;
    border-radius: 50%;
    display: flex; align-items: center; justify-content: center;
    text-decoration: none; transition: all 0.3s;
    font-size: 1rem;
    &:hover { background-color: #e31140; transform: translateY(-3px); }
}

.accreditation-box {
    background: #222; color: #777;
    font-weight: bold; padding: 5px 10px;
    font-size: 0.8rem; border-radius: 4px;
    border: 1px solid #333; cursor: default;
    &:hover { color: white; border-color: #e31140; }
}

.hover-white:hover { color: white !important; }

.staff-access {
    color: #ffffff !important;
    font-weight: 500; transition: color 0.3s;
    &:hover { color: #e31140 !important; }
}

.developer-signature {
    font-family: 'Courier New', Courier, monospace;
    font-size: 11px; text-transform: uppercase;
    letter-spacing: 2px; color: #4b4b4b;
    text-decoration: none; display: inline-flex;
    align-items: center; transition: all 0.4s ease;
    padding-bottom: 5px;
    .dot {
        width: 3px; height: 3px; background-color: #e31140;
        border-radius: 50%; margin-right: 6px; opacity: 0.5;
    }
    &:hover {
        color: #ff0000 !important; letter-spacing: 3px;
        .dot { opacity: 1; box-shadow: 0 0 5px #e31140; }
    }
}
</style>