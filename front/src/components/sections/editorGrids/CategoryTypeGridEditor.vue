<script setup lang="ts">
import { ref, watch, onMounted } from 'vue';

// 1. Props: Recibe la configuración actual del bloque
const props = defineProps<{
    modelValue: {
        selectedType?: string; // 'news', 'post', etc.
        titleOverride?: string;
    }
}>();

const emit = defineEmits(['update:modelValue']);

// 2. Tipos disponibles (Basado en tu log anterior: 'news', 'post')
// Si tienes más tipos, agrégalos aquí.
const availableTypes = [
    { value: 'post', label: 'Artículos / Posts' },
    { value: 'news', label: 'Noticias / Novedades' },
    { value: 'course', label: 'Cursos (Si aplica)' },
    { value: 'project', label: 'Proyectos' }
];

// Estado local
const localState = ref({
    selectedType: props.modelValue?.selectedType || 'post', // Default a post
    titleOverride: props.modelValue?.titleOverride || ''
});

// 3. Emitir cambios en tiempo real
watch(localState, (newValue) => {
    emit('update:modelValue', { ...newValue });
}, { deep: true });

</script>

<template>
    <div class="p-3 bg-white">
        <div class="mb-4 border-bottom pb-2">
            <h6 class="fw-bold mb-0 text-dark">
                <i class="las la-filter"></i> Configurar Grid de Categorías
            </h6>
        </div>

        <div class="mb-3">
            <label class="form-label small fw-bold text-muted">Tipo de Categoría</label>
            <select v-model="localState.selectedType" class="form-select form-select-sm">
                <option v-for="type in availableTypes" :key="type.value" :value="type.value">
                    {{ type.label }} (type: {{ type.value }})
                </option>
            </select>
            <div class="form-text x-small">
                Filtrará las categorías que tengan este <code>type</code> en la base de datos.
            </div>
        </div>

        <div class="mb-3">
            <label class="form-label small fw-bold text-muted">Título de la Sección</label>
            <input 
                type="text" 
                v-model="localState.titleOverride" 
                class="form-control form-control-sm" 
                placeholder="Ej: Nuestras Áreas de Noticias"
            >
        </div>
    </div>
</template>

<style scoped>
.x-small { font-size: 0.75rem; }
</style>