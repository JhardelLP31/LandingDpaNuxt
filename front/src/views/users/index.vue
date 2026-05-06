<template>
    
        <b-row class="justify-content-center">
            <b-col cols="12">
                <b-card no-body>
                    <b-card-header>
                        <b-row class="align-items-center justify-content-between">
                            <b-col lg="3">
                                <b-card-title>💁 Usuarios</b-card-title>
                            </b-col>
                            <b-col lg="2">
                                <b-button type="button" variant="danger" v-if="useAuth.isPermitedRoute('register_user')" @click="ModalRegisterUser = !ModalRegisterUser">
                                    <i class="far fa-plus-square ml-3"></i> Registrar
                                </b-button>
                            </b-col>
                        </b-row>
                    </b-card-header>
                    <b-card-body class="pt-0">
                        <div class="table-responsive m-0" v-if="user_list && user_list?.length > 0">
                            <table class="table datatable">
                                <thead class="table-light">
                                    <tr>
                                        <th>Id</th>
                                        <th>Nombre y Apellido</th>
                                        <th>Role</th>
                                        <th>Correo</th>
                                        <th>Telefono</th>
                                        <th>Estado</th>
                                        <th>Fecha de registro</th>
                                        <th>Acción</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr v-for="(user, index) in user_list" :key="index">
                                        <td style="width: 16px">
                                            {{ user.id }}
                                        </td>
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <span class="thumb-md justify-content-center d-flex align-items-center bg-purple-subtle text-purple rounded-circle me-2">{{ avatarText(user.full_name) }}</span>
                                                <span>{{ user.full_name }}</span>
                                            </div>
                                        </td>
                                        <td>{{ (user.role.name == "Super-Admin" ? 'Administrador' : user.role.name) }}</td>
                                        <td>{{ user.email }}</td>
                                        <td>{{ user.phone }}</td>
                                        <td>
                                            <b-badge variant="success" v-if="user.state == 1">Activo</b-badge>
                                            <b-badge variant="danger" v-if="user.state == 2">Inactivo</b-badge>
                                        </td>
                                        <td>{{ user.created_at }}</td>
                                        <td>
                                            <a href="#" onclick="return false;" v-if="useAuth.isPermitedRoute('edit_user')" @click="editUser(user)">
                                                <i class="las la-pen text-secondary fs-22"></i>
                                            </a>{{ " " }}
                                            <a href="#" onclick="return false;" v-if="useAuth.isPermitedRoute('delete_user')" @click="deleteUser(user)">
                                                <i class="las la-trash-alt text-secondary fs-22"></i>
                                            </a>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <b-pagination
                            v-model="currentPage"
                            :total-rows="totalPage"
                            :per-page="perPageItem"
                            prev-text="Previous"
                            next-text="Next"
                        />
                    </b-card-body>
                </b-card>
            </b-col>
        </b-row>
        <b-modal
            v-model="ModalRegisterUser"
            :title="`🧑 ${user_selected ? 'Edición' : 'Registro'} de Usuario`"
            :header-class="`bg-${themeColor}`"
            title-class="m-0 text-white"
            :ok-variant="themeColor"
            hide-footer
            centered
            size="lg"
            >
            <b-row>
                <b-col lg="5">
                    <label for="name-user" class="col-form-label text-lg-end">Nombre: </label>
                    <b-form-input
                        type="text"
                        id="name-user"
                        v-model="name"
                        placeholder="Example: Jose"
                    />
                </b-col>
                <b-col lg="5">
                    <label for="surname-user" class="col-form-label text-lg-end">Apellido: </label>
                    <b-form-input
                        type="text"
                        id="surname-user"
                        v-model="surname"
                        placeholder="Example: Jose"
                    />
                </b-col>

                <b-col lg="4">
                    <label for="email-user" class="col-form-label text-lg-end">Email: </label>
                    <b-form-input
                        type="text"
                        id="email-user"
                        v-model="email"
                        placeholder="Example: laravest@gmail.com"
                    />
                </b-col>

                <b-col lg="4">
                    <label for="phone-user" class="col-form-label text-lg-end">Telefono: </label>
                    <b-form-input
                        type="number"
                        id="phone-user"
                        v-model="phone"
                        placeholder="Example: laravest@gmail.com"
                    />
                </b-col>
                <b-col lg="4">
                    <label for="role_user" class="col-form-label text-lg-end">Role: {{ role_id }} </label>
                    <select id="role_user">
                        <option value="">Selec. Rol</option>
                        <template v-for="(role, index) in roles" :key="index">
                            <option :value="role.id">{{ role.name }}</option>
                        </template>
                    </select>
                </b-col>
                <b-col lg="4">
                    <label for="academic_unit_id" class="col-form-label text-lg-end">Unidad Académica: </label>
                    <select id="academic_unit_selectr">
                        <option value="">Selec. Unidad</option>
                        <template v-for="(unit, index) in academic_units" :key="index">
                            <option :value="unit.id">{{ unit.name }}</option>
                        </template>
                    </select>
                </b-col>

                <b-col lg="4">
                    <label for="type-document-user" class="col-form-label text-lg-end">Tipo de documento: </label>
                    <select id="type_document_list">
                        <option value="DNI">DNI</option>
                        <option value="PASAPORTE">PASAPORTE</option>
                        <option value="CARNET DE EXTRANJERIA">CARNET DE EXTRANJERIA</option>
                        <option value="TARJETA MILITAR">TARJETA MILITAR</option>
                    </select>
                </b-col>

                <b-col lg="4">
                    <label for="n_document-user" class="col-form-label text-lg-end">N° de Documento: </label>
                    <b-form-input
                        type="number"
                        id="n_document-user"
                        v-model="n_document"
                        placeholder="Example: #######"
                    />
                </b-col>

                <b-col lg="4">
                    <label for="gender-user" class="col-form-label text-lg-end">Genero: </label>
                    <b-form-radio name="gender-user" @click="gender = 'M'" value="M" :checked="gender == 'M'">Masculino</b-form-radio>
                    {{ " " }}
                    <b-form-radio name="gender-user" @click="gender = 'F'" value="F" :checked="gender == 'F'">Femenino</b-form-radio>
                </b-col>

                <b-col lg="3">
                    <label for="state-user" class="col-form-label text-lg-end">Estado: </label>
                    <b-form-radio name="state-user" @click="state = 1" value="1" :checked="state == 1">Activo</b-form-radio>
                    {{ " " }}
                    <b-form-radio name="state-user" @click="state = 2" value="2" :checked="state == 2">Inactivo</b-form-radio>
                </b-col>

                <b-col lg="4">
                    <label for="password-user" class="col-form-label text-lg-end">Contraseña: </label>
                    <b-form-input
                        type="password"
                        id="password-user"
                        v-model="password"
                        placeholder="*********"
                    />
                </b-col>

                <b-col lg="5">
                    <label for="avatar-user" class="col-form-label text-lg-end">Avatar de Usuario: </label>
                    <b-input-group class="mb-3">
                        <b-form-file @change="loadFile($event)"  />
                        <b-input-group-text>Upload</b-input-group-text>
                    </b-input-group>

                    <img v-if="IMAGEN_PREVIZUALIZA" :src="IMAGEN_PREVIZUALIZA" alt="" width="100px" class="rounded d-block mx-auto" />
                </b-col>

                
                <b-alert
                    :model-value="success_alert"
                    variant="success"
                    dismissible
                    class="shadow-sm border-theme-white-2 rounded-pill"
                >
                    <div class="d-inline-flex justify-content-center align-items-center thumb-xs bg-danger rounded-circle mx-auto me-1">
                        <i class="fas fa-check align-self-center mb-0 text-white"></i>
                    </div>
                        {{ " " }} <strong>En hora buena!</strong> El usuario se ha {{ user_selected ? 'editado' : 'registrado' }} .
                    <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="alert"
                        aria-label="Close"
                    >
                    </button>
                </b-alert>

                <b-alert
                    :model-value="warning_alert"
                    variant="danger"
                    dismissible
                    class="shadow-sm border-theme-white-2 rounded-pill"
                >
                    <div class="d-inline-flex justify-content-center align-items-center thumb-xs bg-danger rounded-circle mx-auto me-1">
                        <i class="fas fa-check align-self-center mb-0 text-white"></i>
                    </div>
                        {{ " " }} <strong>Upps hubo algo!</strong> {{ message_text }}.
                    <button
                        type="button"
                        class="btn-close"
                        data-bs-dismiss="alert"
                        aria-label="Close"
                    >
                    </button>
                </b-alert>

                <b-col lg="12" class="mt-3">
                    <div class="modal-footer">
                        <b-button
                            type="button"
                            variant="secondary"
                            data-bs-dismiss="modal"
                            @click="exitModal"

                        >
                            Cerrar
                        </b-button>
                        <b-button type="button" variant="primary" @click="store">
                           {{ user_selected ? 'Editar' : 'Guardar' }}
                        </b-button>
                    </div>
                </b-col>
            </b-row>
        </b-modal>
    
</template>
<script setup lang="ts">
import DefaultLayout from "@/layouts/DefaultLayout.vue";
import { ref,onMounted, watch } from "vue";
import {
  DataTable,
    //   exportCSV,
    //   exportSQL,
    //   exportTXT,
    //   exportJSON,
} from "simple-datatables";
import HttpClient from "@/helpers/http-client";
import type { AxiosResponse } from "axios";
import { type Users,type User, type UserResponse, type RoleUser } from "@/types/users";

import Swal from "sweetalert2/dist/sweetalert2.js";
type TVueSwalInstance = typeof Swal & typeof Swal.fire;
import Selectr from "mobius1-selectr";

const error = ref("");
const user_list = ref<User[]>([]);
const ModalRegisterUser = ref(false);
const themeColor = ref<any>("danger");
const name = ref<string>("");
const surname = ref<string>("");
const email = ref<string>("");
const phone = ref<number>();
const password = ref<string>("");
const type_document = ref<string>("DNI");
const n_document = ref<string>();
const gender = ref<string>("M");
const state = ref<number>(1);
const role_id = ref<string>("");
const roles = ref<RoleUser[]>([]);
const type_document_list = ref<any>(null);
const role_user = ref<any>(null);

const FILE_AVATAR = ref<File>();
const IMAGEN_PREVIZUALIZA = ref<string | ArrayBuffer | null>(null);

const message_text = ref<string | undefined>("");
const success_alert = ref<boolean>(false);
const warning_alert = ref<boolean>(false);
const user_selected = ref<User | undefined>();

const academic_unit_id = ref<string | number>("");
const academic_units = ref<any[]>([]); // Para almacenar la lista que viene del backend
const academic_unit_selectr_inst = ref<any>(null); // Instancia de Selectr

import { useAuthStore } from "@/stores/auth";
const useAuth = useAuthStore();

const perPageItem = ref(5);
const totalPage = ref(0);
const currentPage = ref(1);


const exitModal = async() => {
    ModalRegisterUser.value = !ModalRegisterUser.value;

}
const list = async () => {
  try {
    const res: any = await HttpClient.get("users?page="+currentPage.value);
    
    user_list.value = res.data.users.data;
    roles.value = res.data.roles.filter(role => role.name !== 'Super-Admin');
    
    // 1. Guardamos las unidades académicas que vienen del backend
    academic_units.value = res.data.academic_units; 

    totalPage.value = res.data.total;
    perPageItem.value = res.data.paginate;

    setTimeout(() => {
        type_document_list.value = new Selectr("#type_document_list");
        role_user.value = new Selectr("#role_user");
        
        // 2. Inicializamos el nuevo Selectr de Unidades
        academic_unit_selectr_inst.value = new Selectr("#academic_unit_selectr");
        
        // Setear valores si existen
        type_document_list.value.setValue(type_document.value);
        role_user.value.setValue(role_id.value);
        academic_unit_selectr_inst.value.setValue(academic_unit_id.value);
    }, 50);
  } catch (e: any) {
    console.log(e);
  }
};

const editUser = async(user: User) => {
    user_selected.value = user;
    exitModal();
    name.value = user.name;
    surname.value = user.surname ?? '';
    email.value = user.email;
    phone.value = user.phone;
    type_document.value = user.type_document ?? '';
    n_document.value = user.n_document;
    gender.value = user.gender;
    state.value = user.state;
    role_id.value = user.role_id;
    IMAGEN_PREVIZUALIZA.value = user.avatar ?? null;
    type_document_list.value.setValue(user.type_document);
    role_user.value.setValue(user.role_id);
    academic_unit_id.value = user.academic_unit_id ?? '';
    
    // Actualizar el valor visual en Selectr
    if(academic_unit_selectr_inst.value) {
        academic_unit_selectr_inst.value.setValue(user.academic_unit_id);
    }
}

const store = async () => {
    warning_alert.value = false;message_text.value = "";
    type_document.value = type_document_list.value.getValue();
    role_id.value = role_user.value.getValue();
    const selectedRoleName = roles.value.find(r => r.id == role_id.value)?.name;
    if(selectedRoleName === 'Super-Admin'){
        message_text.value = "No tienes permisos para asignar este rol";
        warning_alert.value = true;
        return;
    }
    if(!name.value){
        message_text.value = "Necesitas digitar el nombre del usuario";
        setTimeout(() => {
            warning_alert.value = true;
        }, 25);
        return;
    }

    if(!surname.value){
        message_text.value = "Necesitas digitar el apellido del usuario";
        setTimeout(() => {
            warning_alert.value = true;
        }, 25);
        return;
    }

    if(!email.value){
        message_text.value = "Necesitas digitar el correo del usuario";
        setTimeout(() => {
            warning_alert.value = true;
        }, 25);
        return;
    }


    if(!user_selected.value && !password.value){
        message_text.value = "Necesitas digitar una contraseña para el usuario";
        setTimeout(() => {
            warning_alert.value = true;
        }, 25);
        return;
    }
    academic_unit_id.value = academic_unit_selectr_inst.value.getValue();


    let formData = new FormData();
    formData.append("name",name.value);
    formData.append("surname",surname.value);
    formData.append("email",email.value);
    formData.append("role_id",role_id.value);   
    formData.append("state",state.value+"");
    formData.append("gender",gender.value);
    formData.append("type_document",type_document.value);
    formData.append("n_document",n_document.value+"");
    formData.append("academic_unit_id", academic_unit_id.value + "");
    if(password.value){
        formData.append("password",password.value);
    }
    formData.append("phone",phone.value+"");
    if(FILE_AVATAR.value){
        formData.append("imagen",FILE_AVATAR.value);
    }
    try {
        
      const res: AxiosResponse<UserResponse> = !user_selected.value ? await HttpClient.post(
        "users",
        formData,
      ) : await HttpClient.post(
        "users/"+user_selected.value.id,
        formData,
      );
      
      console.log(res);
      if (res.data.message == 403) {
        setTimeout(() => {
            warning_alert.value = true;
        }, 25);
        message_text.value = res.data.message_text;
      }else if(res.data.user){
        if(user_selected.value){
            let INDEX = user_list.value.findIndex(usr => usr.id == res.data.user?.id);
            if(INDEX != -1){
                user_list.value[INDEX] = res.data.user;
            }
        }else{
            user_list.value?.unshift(res.data.user);
        }
        refreshData();
        success_alert.value = true;
      }
    } catch (e: any) {
      console.log(e);
      if (e.response?.data?.error) {
        if (error.value.length == 0) error.value = e.response?.data?.error;
      }
    }
}

const refreshData = () => {
    let backup = user_list.value;
    setTimeout(() => {
        if(!user_selected.value){
            ModalRegisterUser.value = false;
        }
        user_list.value = [];
        setTimeout(() => {
            user_list.value = backup;
            // setTimeout(() => {
            //     new DataTable("#datatable_1", {
            //         searchable: true,
            //         fixedHeight: false,
            //     });
            // }, 25);
        }, 25);
    }, 25);
}

const deleteUser = async(user:User) => {
    (Swal as TVueSwalInstance)
        .fire({
            title: "Confirmar la eliminación",
            text: "¿Estas seguro de eliminar el usuario '"+user.full_name+"'?",
            icon: "warning",
            showCancelButton: true,
            confirmButtonColor: "#3085d6",
            cancelButtonColor: "#d33",
            confirmButtonText: "Si, eliminalo!",
        })
        .then(async (result: any) => {
            if (result.isConfirmed) {
                try {
                    const res: AxiosResponse<UserResponse> = await HttpClient.delete(
                        "users/"+user.id
                    );
                    console.log(res);
                    (Swal as TVueSwalInstance).fire(
                        "Eliminado!",
                        "El usuario '"+user.name+"'"+" se ha sido eliminado",
                        "success",
                    );
                    let INDEX = user_list.value.findIndex(usr => usr.id == user.id);
                    if(INDEX != -1){
                        user_list.value.splice(INDEX,1);
                    }
                    refreshData();
                } catch (e: any) {
                    console.log(e);
                    if (e.response?.data?.error) {
                        if (error.value.length == 0) error.value = e.response?.data?.error;
                    }
                }

            }
        });
}

const loadFile = ($event:any) => {
    warning_alert.value = false;
    if($event.target.files[0].type.indexOf("image") < 0){
        warning_alert.value = true;
        IMAGEN_PREVIZUALIZA.value = null;
        message_text.value = "SOLAMENTE PUEDEN SER ARCHIVOS DE TIPO IMAGEN";
        return;
    }
    message_text.value = '';
    FILE_AVATAR.value = $event.target.files[0];
    let reader = new FileReader();
    if(FILE_AVATAR.value){
        reader.readAsDataURL(FILE_AVATAR.value);
        reader.onloadend = () => IMAGEN_PREVIZUALIZA.value = reader.result;
    }
}

const avatarText = (value:string) => {
    if (!value)
        return ''
    const nameArray = value.split(' ')
    
    return nameArray.map(word => word.charAt(0).toUpperCase()).join('')
}

watch(ModalRegisterUser,(value) => {
    if(!value){
        name.value = "";
        surname.value = "";
        email.value = "";
        phone.value = 0;
        type_document.value = "";
        n_document.value = "";
        gender.value = "M";
        state.value = 1;
        role_id.value = "";
        IMAGEN_PREVIZUALIZA.value = "";
        FILE_AVATAR.value = undefined;
        user_selected.value = undefined;
        success_alert.value = false;
        warning_alert.value = false;
        academic_unit_id.value = "";
        if(academic_unit_selectr_inst.value) academic_unit_selectr_inst.value.setValue("");
    }
})
watch(currentPage, (value) => {
    list();
})
onMounted(() => {
  list();
});
</script>