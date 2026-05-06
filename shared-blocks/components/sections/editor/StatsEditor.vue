<script setup lang="ts">
const props = defineProps<{ modelValue: any }>();
const emit = defineEmits(['update:modelValue']);

const colors = [
  { name: 'Azul', value: '#144c74' },
  { name: 'Rojo', value: '#e31140' },
  { name: 'Gris', value: '#746c6c' },
  { name: 'Blanco', value: '#ffffff' }
];

const updateItem = (index: number, field: string, value: any) => {
  const newItems = [...props.modelValue.items];
  newItems[index] = { ...newItems[index], [field]: value };
  emit('update:modelValue', { ...props.modelValue, items: newItems });
};
</script>

<template>
  <div class="bento-editor">
    <div v-for="(item, i) in modelValue.items" :key="i" class="p-3 border rounded mb-3 bg-white shadow-sm">
      <div class="row g-2 mb-2">
        <div class="col-8">
          <input :value="item.title" @input="e => updateItem(i, 'title', (e.target as HTMLInputElement).value)" 
                 class="form-control form-control-sm fw-bold" placeholder="Título">
        </div>
        <div class="col-4">
          <select :value="item.size" @change="e => updateItem(i, 'size', (e.target as HTMLSelectElement).value)" 
                  class="form-select form-select-sm">
            <option value="small">Pequeño</option>
            <option value="medium">Largo (V)</option>
            <option value="large">Ancho (H)</option>
          </select>
        </div>
      </div>
      
      <div class="d-flex gap-2">
        <div v-for="color in colors" :key="color.value" 
             @click="updateItem(i, 'bgColor', color.value)"
             class="color-circle" 
             :style="{ backgroundColor: color.value, border: item.bgColor === color.value ? '2px solid black' : '1px solid #ddd' }">
        </div>
        <input :value="item.icon" @input="e => updateItem(i, 'icon', (e.target as HTMLInputElement).value)"
               class="form-control form-control-sm ms-auto" style="width: 120px;" placeholder="Icon class">
      </div>
    </div>
  </div>
</template>

<style scoped>
.color-circle {
  width: 25px;
  height: 25px;
  border-radius: 50%;
  cursor: pointer;
  transition: transform 0.2s;
}
.color-circle:hover { transform: scale(1.2); }
</style>