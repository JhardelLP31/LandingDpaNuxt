// composables/useBranding.ts
import { ref, reactive } from 'vue';
import HttpClient from "@/helpers/http-client";
import Swal from "sweetalert2";
import { getInitialBrandingData } from '@shared/core/BrandingRegistry';

export function useBranding() {
    const loading = ref(false);
    const menus_list = ref<any[]>([]);
    const menu_tree = ref<any[]>([]);

    const form = reactive({
        id: null,
        academic_unit_id: null as number | null,
        primary_color: '#003366',
        secondary_color: '#ffffff',
        accent_color: '#ffcc00',
        header_type: 'HeaderOverlay',
        header_config: getInitialBrandingData('HeaderOverlay'),
        selected_menu_id: null as number | null,
        custom_css: '', // Aquí guardamos el JSON del diseño
        widgets_config: {
            whatsapp: { enabled: false, number: '', message: '' }
        }
    });

    // Cargar menús disponibles para el select
    const loadMenus = async (unitId: number) => {
        try {
            const res = await HttpClient.get('menus', { params: { academic_unit_id: unitId } });
            menus_list.value = res.data.data || res.data;
        } catch (e) { console.error("Error cargando menús", e); }
    };

    // Cargar el árbol del menú seleccionado para la previsualización
    const loadMenuTree = async () => {
        if (!form.selected_menu_id) {
            menu_tree.value = [];
            return;
        }
        try {
            const res = await HttpClient.get(`menus/${form.selected_menu_id}`);
            const data = res.data.data || res.data;
            menu_tree.value = data.items || [];
        } catch (e) { console.error("Error cargando items del menú", e); }
    };

    const loadInitialData = async (unitId: number) => {
        loading.value = true;
        form.academic_unit_id = unitId;
        await loadMenus(unitId);

        try {
            const res = await HttpClient.get(`unit-branding/unit/${unitId}`);
            const data = res.data.data || res.data;
            
            if (data) {
                form.id = data.id;
                form.primary_color = data.primary_color || form.primary_color;
                form.secondary_color = data.secondary_color || form.secondary_color;
                form.accent_color = data.accent_color || form.accent_color;
                form.selected_menu_id = data.selected_menu_id;

                // Desempaquetar la "magia" del JSON
                if (data.custom_css) {
                    try {
                        const parsed = JSON.parse(data.custom_css);
                        if (Array.isArray(parsed) && parsed[0]) {
                            form.header_type = parsed[0].type;
                            form.header_config = parsed[0].content;
                        }
                    } catch (e) { console.error("Error parseando diseño guardado"); }
                }
                
                if (form.selected_menu_id) await loadMenuTree();
            }
        } catch (e) { console.log("Iniciando configuración limpia"); 
        } finally { loading.value = false; }
    };

    const changeModel = (key: string) => {
        if (form.header_type === key) return;
        form.header_type = key;
        form.header_config = getInitialBrandingData(key);
    };

    const saveBranding = async () => {
        loading.value = true;
        try {
            // Empaquetar diseño en el custom_css para no romper la DB actual
            const designBlock = [{
                id: form.id || crypto.randomUUID(),
                type: form.header_type,
                content: form.header_config
            }];
            form.custom_css = JSON.stringify(designBlock);

            const res = await HttpClient.post('unit-branding', form);
            if (res.data.data?.id) form.id = res.data.data.id;

            Swal.fire({ toast: true, position: 'top-end', icon: 'success', title: '¡Publicado!', showConfirmButton: false, timer: 2000 });
        } catch (e) {
            Swal.fire("Error", "No se pudo guardar", "error");
        } finally { loading.value = false; }
    };

    return { 
        form, loading, menus_list, menu_tree, 
        loadInitialData, loadMenuTree, saveBranding, changeModel 
    };
}