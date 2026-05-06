<script setup lang="ts">
import { reactive, ref, watch, computed } from 'vue';
import { formatImageUrl } from '@/helpers/url';
import HttpClient from "@/helpers/http-client"; 
import Swal from 'sweetalert2'; 

// --- 1. CONFIGURACIÓN Y PROPS ---
interface Field {
  type: 'text' | 'email' | 'tel' | 'textarea';
  label: string;
  name: string;
  required: boolean;
  placeholder?: string;
}

interface ContactData {
  title?: string;
  subtitle?: string;
  image?: string;
  buttonText?: string;
  fields: Field[]; 
}

const props = defineProps<{ data: ContactData; }>();

// --- 2. ESTADO DEL FORMULARIO ---
const formState = reactive<Record<string, any>>({});
const isSubmitting = ref(false);

// --- 3. LÓGICA DE SELECTS EN CASCADA ---
const formationType = ref(''); // Primer Select (Tipo)
const selectedProgram = ref(''); // Segundo Select (El curso específico)
const programsList = ref<any[]>([]); // Lista que llenaremos desde la API
const isLoadingPrograms = ref(false);

// Opciones fijas para el primer select
const formationOptions = [
    { value: 'Curso', text: 'Curso' },
    { value: 'Diplomado', text: 'Diplomado' },
    { value: 'Programa', text: 'Programa' }
];

// 🔥 EL WATCHER MÁGICO 🔥
watch(formationType, async (newValue) => {
    // 1. Limpiamos
    selectedProgram.value = '';
    programsList.value = [];
    
    if (!newValue) return;

    // 2. Cargamos
    isLoadingPrograms.value = true;
    try {
        const { data } = await HttpClient.get('courses/search', { 
            params: { search: newValue } 
        });
        

        programsList.value = Array.isArray(data) ? data : (data.data || []);

    } catch (error) {
        console.error("Error cargando programas", error);
        Swal.fire("Error", "No se pudieron cargar los cursos.", "error");
    } finally {
        isLoadingPrograms.value = false;
    }
});


// --- 4. ENVÍO ---
const handleSubmit = async () => {
  isSubmitting.value = true;
  
  try {
      const payload = {
          origin_url: window.location.href,
          formation_type: formationType.value,
          course_interest: selectedProgram.value,
          ...formState
      };

      await HttpClient.post('leads', payload);

      Swal.fire({
          icon: 'success',
          title: '¡Recibido!',
          text: 'Gracias por tu interés.',
          timer: 2500,
          showConfirmButton: false,
          confirmButtonColor: '#e31140'
      });

      // Resetear
      Object.keys(formState).forEach(key => delete formState[key]);
      formationType.value = ''; 
      
  } catch (e: any) {
      console.error('Error:', e);
      Swal.fire("Error", "Ocurrió un error al enviar.", "error");
  } finally {
      isSubmitting.value = false;
  }
};

const inputFields = computed(() => props.data?.fields.filter(f => f.type !== 'textarea' && f.name !== 'message') || []);
const messageField = computed(() => props.data?.fields.find(f => f.type === 'textarea' || f.name === 'message'));
</script>

<template>
  <div id="contact_section" v-if="data" class="consultation-form section-spacing">
    <div class="container">
      
      <div class="theme-title-one text-center mb-5 fade-in-up">
        <h2 style="color: #e31140;" class="section-title text-uppercase fw-bold display-6">
          {{ data.title || 'AGENDEMOS UNA REUNIÓN' }}
        </h2>
        <p v-if="data.subtitle" class="text-black mt-3" style="font-size: 16px;">
        {{ data.subtitle }}
        </p>      </div>

      <div class="row align-items-stretch no-gutters">
        
        <div class="col-xl-6 col-lg-5 col-12 d-none d-lg-block fade-in-up">
          <div class="img-box h-100 w-100 rounded-start"
            :style="{ 
              backgroundImage: data.image ? `url(${formatImageUrl(data.image)})` : 'none',
              backgroundColor: '#f8f9fa',
              minHeight: '400px', backgroundSize: 'cover', backgroundPosition: 'center'
            }">
          </div>
        </div>

        <div class="col-xl-6 col-lg-7 col-12 fade-in-up" style="animation-delay: 0.2s;">
          <div class="form-wrapper bg-white shadow-sm p-4 p-lg-5 rounded-end h-100">
            
            <form @submit.prevent="handleSubmit">
              <div class="row g-3">
                
                <div v-for="(field, index) in inputFields" :key="index" class="col-md-6">
                  <input :type="field.type" v-model="formState[field.name]"
                    class="form-control"
                    :placeholder="field.placeholder + (field.required ? ' *' : '')" 
                    :required="field.required">
                </div>

                <div class="col-12">
                    <div class="row g-3">
                        
                        <div class="col-md-6">
                            <select v-model="formationType" class="form-select custom-select" required>
                                <option value="" disabled selected>Formación de Interés*</option>
                                <option v-for="opt in formationOptions" :key="opt.value" :value="opt.value">
                                    {{ opt.text }}
                                </option>
                            </select>
                        </div>

                        <div class="col-md-6 position-relative">
                            <select 
                                v-model="selectedProgram" 
                                class="form-select custom-select"
                                :disabled="!formationType || isLoadingPrograms" 
                                required
                            >
                                <option value="" disabled selected v-if="!formationType">
                                    ← Selecciona un tipo primero
                                </option>
                                
                                <option value="" disabled selected v-else-if="isLoadingPrograms">
                                    Cargando lista...
                                </option>

                                <option value="" disabled selected v-else-if="programsList.length === 0">
                                    No hay programas disponibles
                                </option>
                                
                                <option value="" disabled selected v-else>
                                    Selecciona el programa *
                                </option>

                                <option v-for="prog in programsList" :key="prog.id" :value="prog.name || prog.title">
                                    {{ prog.name || prog.title || prog.nombre || 'Nombre no encontrado' }}
                                </option>
                            </select>

                            <div v-if="isLoadingPrograms" class="spinner-overlay">
                                <div class="spinner-border spinner-border-sm text-danger" role="status"></div>
                            </div>
                        </div>

                    </div>
                </div>

                <div v-if="messageField" class="col-12">
                   <textarea v-model="formState[messageField.name]" class="form-control" rows="3" 
                    :placeholder="messageField.placeholder" :required="messageField.required"></textarea>
                </div>

              </div>
              
              <button :disabled="isSubmitting" class="theme-button-one btn btn-primary mt-4 w-100 fw-bold py-3 text-uppercase">
                <span v-if="isSubmitting" class="spinner-border spinner-border-sm me-2"></span>
                {{ isSubmitting ? 'ENVIANDO...' : (data.buttonText || 'ENVIAR MENSAJE') }}
              </button>
            </form>

          </div>
        </div>

      </div>
    </div>
  </div>
</template>

<style scoped>
/* Estilos necesarios */
.section-title::after { content: ''; display: block; width: 40px; height: 4px; background-color: #e31140; margin: 10px auto 0; }
.form-wrapper { transition: transform 0.3s ease; border: 1px solid #f0f0f0; }
.form-wrapper:hover { transform: translateY(-5px); box-shadow: 0 20px 40px rgba(0,0,0,0.1) !important; }

/* Inputs bonitos */
.form-control, .form-select {
    background: #f9f9f9; border: 1px solid #eee; padding: 12px 15px; min-height: 50px;
    color: #333; transition: all 0.3s;
}
.form-control:focus, .form-select:focus {
    background: #fff; border-color: #e31140; box-shadow: 0 0 0 4px rgba(227, 17, 64, 0.1);
}
.form-select:disabled { background-color: #e9ecef; cursor: not-allowed; opacity: 0.7; }

/* 🔥 CSS FIX PARA QUE SE VEA EL TEXTO 🔥 */
.custom-select {
    color: #2c3e50 !important;
    background-color: #fff !important;
}
.custom-select option {
    color: #000 !important; /* Texto negro forzado */
    background-color: #fff !important; /* Fondo blanco forzado */
    font-size: 16px;
    padding: 10px;
}

/* Spinner Overlay para el Select */
.spinner-overlay { position: absolute; right: 25px; top: 15px; pointer-events: none; }

/* Animaciones */
.fade-in-up { animation: fadeInUp 0.8s ease forwards; opacity: 0; }
@keyframes fadeInUp { from { opacity: 0; transform: translateY(20px); } to { opacity: 1; transform: translateY(0); } }
</style>