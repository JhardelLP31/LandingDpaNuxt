<script setup lang="ts">
import { ref, watch } from 'vue';

const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue']);

// 1. Localizamos los datos
const localData = ref({ ...props.modelValue });

// 2. IMPORTANTE: Si el padre cambia el modelo (ej. carga desde DB o cambia de tipo), 
// actualizamos el estado local.
watch(() => props.modelValue, (newVal) => {
    localData.value = { ...newVal };
}, { deep: true });

// 3. Vigilamos cambios locales para emitir al padre (el Page Builder)
watch(localData, (newVal) => {
    emit('update:modelValue', { ...newVal });
}, { deep: true });
</script>

<template>
    <div class="row g-3 p-2 bg-white rounded border">
        <div class="col-12">
            <label class="x-small-label">TEXTO BARRA SUPERIOR</label>
            <input type="text" class="form-control form-control-sm modern-input" 
                   v-model="localData.topBarText" placeholder="Ej: Portal Académico">
        </div>
        
        <div class="col-md-6">
            <label class="x-small-label">ALTURA LOGO (PX)</label>
            <div class="input-group input-group-sm">
                <span class="input-group-text bg-light"><i class="las la-arrows-alt-v"></i></span>
                <input type="number" class="form-control" v-model="localData.logoHeight">
            </div>
        </div>

        <div class="col-md-6">
            <label class="x-small-label">ALINEACIÓN MENÚ</label>
            <select class="form-select form-select-sm modern-input" v-model="localData.menuAlignment">
                <option value="right">Derecha</option>
                <option value="center">Centro</option>
                <option value="left">Izquierda</option>
            </select>
        </div>

        <div class="col-12 border-top pt-2 mt-3">
            <div class="d-flex flex-column gap-2">
                <div class="form-check form-switch">
                    <input class="form-check-input" type="checkbox" v-model="localData.sticky" id="stickyCheck">
                    <label class="form-check-label small fw-bold" for="stickyCheck">Cabecera fija (Sticky)</label>
                </div>

                <div class="form-check form-switch">
                    <input class="form-check-input" type="checkbox" v-model="localData.showTopBar" id="topbarCheck">
                    <label class="form-check-label small fw-bold" for="topbarCheck">Mostrar barra informativa</label>
                </div>
            </div>
        </div>
    </div>
</template>

<style scoped>
.x-small-label {
    font-size: 0.65rem;
    font-weight: 800;
    color: #a0aec0;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    margin-bottom: 4px;
    display: block;
}
.modern-input {
    border: 1px solid #e2e8f0;
    border-radius: 6px;
}
.modern-input:focus {
    border-color: #4e73df;
    box-shadow: 0 0 0 2px rgba(78, 115, 223, 0.1);
}
</style>