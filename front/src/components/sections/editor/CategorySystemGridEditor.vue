<script setup lang="ts">
import { ref, onMounted, watch } from 'vue';
import HttpClient from "@/helpers/http-client";

// 1. PROPS: Recibe los datos actuales del bloque desde el Page Builder
const props = defineProps<{
    modelValue: {
        categoryId?: number | string;
        titleOverride?: string; // Opcional: por si quieres cambiar el título
        subtitleOverride?: string;
    }
}>();

// 2. EMITS: Comunica los cambios al padre inmediatamente
const emit = defineEmits(['update:modelValue']);

// 3. STATE
const categories = ref<any[]>([]);
const loading = ref(false);

// Estado local para el formulario (copia de las props)
const localState = ref({
    categoryId: props.modelValue?.categoryId || null,
    titleOverride: props.modelValue?.titleOverride || '',
    subtitleOverride: props.modelValue?.subtitleOverride || ''
});

// 4. LOGICA: Cargar Categorías (Solo lectura)
const fetchCategories = async () => {
    loading.value = true;
    try {
        const response = await HttpClient.get('categories');
        // Ajusta esto según si tu API devuelve un array directo o { data: [...] }
        categories.value = response.data.data;        
    } catch (e) {
        console.error("Error cargando categorías:", e);
    } finally {
        loading.value = false;
    }
};

// 5. WATCH: Cuando cambia algo local, avisar al padre (Page Builder)
watch(localState, (newValue) => {
    emit('update:modelValue', { ...newValue });
}, { deep: true });

onMounted(() => {
    fetchCategories();
});
</script>

<template>
    <div class="p-3 bg-white">
        <div class="mb-4 border-bottom pb-2">
            <h6 class="fw-bold mb-0 text-dark">
                <i class="las la-shapes"></i> Configurar Categoría
            </h6>
        </div>

        <div v-if="loading" class="text-center py-2 text-muted small">
            <div class="spinner-border spinner-border-sm" role="status"></div>
            Cargando lista...
        </div>

        <div v-else>
            <div class="mb-3">
                <label class="form-label small fw-bold text-muted">Seleccionar Categoría</label>
                <select v-model="localState.categoryId" class="form-select form-select-sm">
                    <option :value="null">-- Selecciona una opción --</option>
                    <option v-for="cat in categories" :key="cat.id" :value="cat.id">
                        {{ cat.name }}
                    </option>
                </select>
                <div class="form-text x-small">
                    Esto cargará automáticamente la imagen y los cursos de esa categoría.
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label small fw-bold text-muted">Título Personalizado (Opcional)</label>
                <input 
                    type="text" 
                    v-model="localState.titleOverride" 
                    class="form-control form-control-sm" 
                    placeholder="Ej: Nuestra Especialidad"
                >
                <div class="form-text x-small">Deja vacío para usar el nombre de la categoría.</div>
            </div>

            <div class="mb-3">
                <label class="form-label small fw-bold text-muted">Subtítulo (Opcional)</label>
                <input 
                    type="text" 
                    v-model="localState.subtitleOverride" 
                    class="form-control form-control-sm" 
                    placeholder="Ej: RECURSOS DESTACADOS"
                >
            </div>
        </div>
    </div>
</template>

<style scoped>
.x-small { font-size: 0.75rem; }
</style>