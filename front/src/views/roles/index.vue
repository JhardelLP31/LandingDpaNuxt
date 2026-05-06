<template>
  <div class="p-4">
    <div class="d-md-flex align-items-center justify-content-between mb-4">
      <div ">
        <h4 class="fw-bold mb-1">Gestión de Roles</h4>
        <p class="text-muted small mb-0">Define qué puede hacer cada perfil de usuario en la plataforma.</p>
      </div>
      
      <div class="d-flex gap-2 mt-3 mt-md-0">
        <div class="position-relative">
          <i class="las la-search position-absolute" style="left: 12px; top: 50%; transform: translateY(-50%); color: #6c757d; z-index: 4;"></i>
          <input 
            type="text" 
            v-model="searchQuery" 
            class="form-control ps-5" 
            placeholder="Buscar rol..."
            style="width: 250px;"
          >
        </div>

        <b-button 
          variant="success" 
          v-if="useAuth.isPermitedRoute('register_role')" 
          @click="openModal()"
        >
          <i class="fas fa-plus me-1"></i> Registrar
        </b-button>
      </div>
    </div>

    <b-card no-body class="shadow-sm">
      <div class="table-responsive">
        <table class="table table-hover align-middle mb-0">
          <thead class="table-light">
            <tr>
              <th class="ps-3">ID</th>
              <th>Rol</th>
              <th>Permisos</th>
              <th>Fecha Registro</th>
              <th class="text-center">Acción</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="role in rolesVisibles" :key="role.id">
              <td class="ps-3">#{{ role.id }}</td>
              <td><strong class="text-dark">{{ role.name }}</strong></td>
              <td>
                <div class="d-flex flex-wrap gap-1">
                  <span 
                    v-for="p in role.permissions_pluck.slice(0, 3)" 
                    :key="p" 
                    class="badge bg-secondary"
                  >
                    {{ p }}
                  </span>
                  <small v-if="role.permissions_pluck.length > 3" class="text-muted fw-bold">
                    +{{ role.permissions_pluck.length - 3 }}
                  </small>
                </div>
              </td>
              <td>{{ role.created_at }}</td>
              <td class="text-center">
                <b-button variant="link" class="text-primary p-1" @click="editRole(role)" title="Editar">
                  <i class="las la-pen fs-20"></i>
                </b-button>
                <b-button variant="link" class="text-danger p-1" @click="deleteRole(role)" title="Eliminar">
                  <i class="las la-trash-alt fs-20"></i>
                </b-button>
              </td>
            </tr>
            <tr v-if="rolesVisibles.length === 0">
              <td colspan="5" class="text-center py-4 text-muted">No se encontraron roles.</td>
            </tr>
          </tbody>
        </table>
      </div>

      <div class="d-flex justify-content-between align-items-center p-3 border-top">
        <small class="text-muted">Total registros: {{ totalPage }}</small>
        <b-pagination
          v-model="currentPage"
          :total-rows="totalPage"
          :per-page="perPageItem"
          size="sm"
          class="mb-0"
        />
      </div>
    </b-card>

<b-modal
  v-model="ModalRegisterRole"
  :title="`${role_selected ? 'Edición' : 'Registro'} de Rol`"

  size="xl"
  centered
  scrollable
  title-class="fw-bold"
  :header-bg-variant="role_selected ? 'primary' : 'success'"
  header-text-variant="white"
  body-class="p-0 bg-light"
              hide-footer
>


  <div class="p-4 border-bottom bg-white sticky-top" style="z-index: 1020;">
    <b-row class="align-items-center">
      <b-col md="3" lg="2">
        <label class="form-label fw-bold mb-md-0 text-secondary">Nombre del Rol:</label>
      </b-col>
      <b-col md="9" lg="10">
        <b-input-group>
          <template #prepend>
            <b-input-group-text class="bg-light border-end-0">
              <i class="fas fa-tag text-muted"></i>
            </b-input-group-text>
          </template>
          <b-form-input
            v-model="name"
            placeholder="Ej: Administrador, Vendedor, Editor..."
            class="form-control-lg border-start-0"
            autofocus
          />
        </b-input-group>
      </b-col>
    </b-row>
  </div>

  <div class="p-4">
    <div class="d-flex align-items-center justify-content-between mb-4">
      <div>
        <h5 class="mb-1 fw-bold text-dark">
          <i class="fas fa-key text-warning me-2"></i>Matriz de Permisos
        </h5>
        <p class="text-muted small mb-0">Gestiona los accesos específicos para cada módulo del sistema.</p>
      </div>
      <b-badge pill variant="info" class="px-3 py-2">
        {{ permission_selected.length }} permisos seleccionados
      </b-badge>
    </div>

    <b-row class="g-4">
      <b-col md="6" lg="4" v-for="(modulo, idx) in permission_list" :key="`mod-${idx}`">
        <div class="card h-100 shadow-sm border-0 module-card overflow-hidden">
          <div class="card-header bg-white d-flex justify-content-between align-items-center py-3 border-bottom-0">
            <span class="fw-bold small text-uppercase text-primary" style="letter-spacing: 0.5px;">
              {{ modulo.name }}
            </span>
            <b-form-checkbox 
              @change="toggleModule(modulo)"
              :checked="isModuleFull(modulo)"
              switch
              variant="success"
              class="cursor-pointer"
            ></b-form-checkbox>
          </div>
          
          <div class="card-body pt-0 px-3 pb-3">
            <div class="rounded-3 p-2 bg-light">
              <div v-for="p in modulo.permisos" :key="p.permiso" class="permission-row rounded py-1 px-2 mb-1">
                <b-form-checkbox 
                  v-model="permission_selected"
                  :value="p.permiso"
                  :id="`perm-${p.permiso}`"
                  class="cursor-pointer small"
                >
                  <span :class="{'fw-bold text-dark': permission_selected.includes(p.permiso)}">
                    {{ p.name }}
                  </span>
                </b-form-checkbox>
              </div>
            </div>
          </div>
        </div>
      </b-col>
    </b-row>
  </div>

  <div class="d-flex justify-content-end gap-2 p-3 bg-white border-top shadow-sm sticky-bottom">
    <b-button variant="outline-secondary" class="px-4" @click="ModalRegisterRole = false">
      Cancelar
    </b-button>
    <b-button 
      :variant="role_selected ? 'primary' : 'success'" 
      class="px-5 fw-bold"
      @click="store" 
      :disabled="loading || !name"
    >
      <b-spinner small v-if="loading" class="me-2"></b-spinner>
      <i class="fas fa-save me-2" v-else></i>
      {{ role_selected ? 'Actualizar Rol' : 'Guardar Rol' }} 
    </b-button>
  </div>
</b-modal>


  </div>
</template>

<script setup lang="ts">
import { ref, onMounted, computed, watch } from "vue";
import HttpClient from "@/helpers/http-client";
import type { AxiosResponse } from "axios";
import { PERMISOS, type Role, type Roles, type RoleResponse } from "@/types/roles";
import { useAuthStore } from "@/stores/auth";
import Swal from "sweetalert2";

const useAuth = useAuthStore();
const loading = ref(false);
const searchQuery = ref("");
const role_list = ref<Role[]>([]);
const ModalRegisterRole = ref(false);
const permission_list = ref(PERMISOS);

const name = ref("");
const permission_selected = ref<string[]>([]);
const role_selected = ref<Role | null>(null);

const currentPage = ref(1);
const totalPage = ref(0);
const perPageItem = ref(10);

// Lógica de búsqueda en tiempo real
const rolesVisibles = computed(() => {
  let filtered = role_list.value.filter(role => role.name !== 'Super-Admin');
  if (searchQuery.value) {
    filtered = filtered.filter(role => 
      role.name.toLowerCase().includes(searchQuery.value.toLowerCase())
    );
  }
  return filtered;
});

const list = async () => {
  try {
    const res: AxiosResponse<Roles> = await HttpClient.get(`role?page=${currentPage.value}`);
    role_list.value = res.data.roles;
    totalPage.value = res.data.total;
    perPageItem.value = res.data.paginate;
  } catch (e) {
    console.error("Error al listar roles:", e);
  }
};

const openModal = () => {
  role_selected.value = null;
  name.value = "";
  permission_selected.value = [];
  ModalRegisterRole.value = true;
};

const editRole = (role: Role) => {
  role_selected.value = role;
  name.value = role.name;
  permission_selected.value = [...role.permissions_pluck];
  ModalRegisterRole.value = true;
};

// Seleccionar/Deseleccionar todos los permisos de un módulo
const toggleModule = (modulo: any) => {
  const allModulePerms = modulo.permisos.map((p: any) => p.permiso);
  const allSelected = allModulePerms.every((p: string) => permission_selected.value.includes(p));
  
  if (allSelected) {
    // Quitar todos
    permission_selected.value = permission_selected.value.filter(p => !allModulePerms.includes(p));
  } else {
    // Añadir los que falten
    const toAdd = allModulePerms.filter((p: string) => !permission_selected.value.includes(p));
    permission_selected.value.push(...toAdd);
  }
};

// Verifica si todos los permisos de un módulo están seleccionados (para el switch)
const isModuleFull = (modulo: any) => {
  if (!modulo.permisos || modulo.permisos.length === 0) return false;
  return modulo.permisos.every((p: any) => permission_selected.value.includes(p.permiso));
};

const store = async () => {
  // 1. Validaciones previas
  if (!name.value.trim()) {
    Swal.fire("Campo requerido", "Por favor, escribe un nombre para el rol.", "warning");
    return;
  }
  
  if (permission_selected.value.length === 0) {
    Swal.fire("Permisos requeridos", "Debes seleccionar al menos un permiso para este rol.", "warning");
    return;
  }

  loading.value = true;
  
  try {
    const data = { 
      name: name.value.trim(), 
      permissions: permission_selected.value 
    };

    // 2. Ejecutar petición directa
    let res;
    if (role_selected.value) {
      res = await HttpClient.patch(`role/${role_selected.value.id}`, data);
    } else {
      res = await HttpClient.post("role", data);
    }

    // 3. Éxito
    if (res.status === 200 || res.status === 201) {
      ModalRegisterRole.value = false;
      await list();
      Swal.fire({
        title: "¡Éxito!",
        text: role_selected.value ? "Rol actualizado correctamente." : "Rol registrado correctamente.",
        icon: "success",
        timer: 2000,
        showConfirmButton: false
      });
    }
  } catch (e: any) {
    console.error("Error al guardar:", e);
    const errorMsg = e.response?.data?.message || "Ocurrió un error inesperado al guardar.";
    Swal.fire("Error", errorMsg, "error");
  } finally {
    loading.value = false;
  }
};

const deleteRole = async (role: Role) => {
  const result = await Swal.fire({
    title: "¿Estás seguro?",
    text: `Vas a eliminar el rol "${role.name}". Esta acción no se puede deshacer.`,
    icon: "warning",
    showCancelButton: true,
    confirmButtonColor: "#dc3545",
    cancelButtonColor: "#6c757d",
    confirmButtonText: "Sí, eliminar",
    cancelButtonText: "Cancelar"
  });

  if (result.isConfirmed) {
    try {
      await HttpClient.delete(`role/${role.id}`);
      await list();
      Swal.fire("Eliminado", "El rol ha sido eliminado.", "success");
    } catch (e: any) {
      console.error("Error al eliminar:", e);
      Swal.fire("Error", "No se pudo eliminar el rol.", "error");
    }
  }
};

watch(currentPage, list);
onMounted(list);
</script>

<style scoped>
.fs-20 { 
  font-size: 20px; 
}

/* Área de scroll para los permisos */
.permissions-container {
  max-height: 55vh; 
  overflow-y: auto;
  scrollbar-width: thin;
  scrollbar-color: #cbd5e0 transparent;
}

.permissions-container::-webkit-scrollbar {
  width: 6px;
}
.permissions-container::-webkit-scrollbar-track {
  background: transparent;
}
.permissions-container::-webkit-scrollbar-thumb {
  background-color: #cbd5e0;
  border-radius: 10px;
}

/* Tarjetas de Módulos */
.module-card {
  border: 1px solid #e2e8f0 !important;
  transition: all 0.2s ease-in-out;
}
.module-card:hover {
  border-color: #cbd5e0 !important;
  box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06) !important;
}

/* Items de Permisos */
.permission-item {
  transition: background-color 0.15s ease;
}
.permission-item:hover {
  background-color: #f1f5f9;
}

/* Utilidades adicionales */
.cursor-pointer {
  cursor: pointer;
}
.tracking-wider {
  letter-spacing: 0.05em;
}
/* Estilo extra para que se vea premium */
.module-card {
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}
.module-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;
}
.permission-row:hover {
  background-color: rgba(0, 123, 255, 0.05);
}
.cursor-pointer {
  cursor: pointer !important;
}
.sticky-top, .sticky-bottom {
  position: sticky;
}
    </style>