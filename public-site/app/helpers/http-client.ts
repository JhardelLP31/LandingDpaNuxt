import axios from "axios";
import Swal from "sweetalert2"; // <-- 1. IMPORTANTE: Importar SweetAlert2

const axiosInstance = axios.create({
    baseURL: import.meta.env.VITE_API_BASE_URL,
});

// --- FUNCIONES DE AYUDA ---
function parseJwt(token: string) {
    try {
        const base64Url = token.split('.')[1];
        const base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');
        const jsonPayload = decodeURIComponent(atob(base64).split('').map(function (c) {
            return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
        }).join(''));
        return JSON.parse(jsonPayload);
    } catch (e) {
        return null;
    }
}

function isTokenExpired(token: string) {
    const decodedToken = parseJwt(token);
    if (!decodedToken || !decodedToken.exp) return true;
    return decodedToken.exp < Math.floor(Date.now() / 1000);
}

function forceLogout() {
    localStorage.removeItem("token");
    localStorage.removeItem("user");
    localStorage.removeItem("academic_unit_id"); // Limpiar también la unidad
    if (window.location.pathname.indexOf("auth/sign-in") === -1) {
        window.location.href = "/auth/sign-in";
    }
}

// A. Interceptor de REQUEST
axiosInstance.interceptors.request.use(
    (config) => {
        const token = localStorage.getItem("token");
        
        // --- 1. GESTIÓN DEL TOKEN ---
        if (token) {
            if (isTokenExpired(token)) {
                forceLogout();
                return Promise.reject(new Error("Token expirado localmente"));
            }
            config.headers.Authorization = "Bearer " + token;
        }

        // --- 2. GESTIÓN DE LA UNIDAD ACADÉMICA ---
        const unitId = localStorage.getItem("academic_unit_id") || "1"; 

        if (unitId) {
            config.headers['X-Academic-Unit'] = unitId;
        }

        // Aseguramos que el servidor sepa que esperamos JSON
        config.headers['Accept'] = 'application/json';

        return config;
    },
    (error) => Promise.reject(error)
);

// B. Interceptor de RESPONSE (ACTUALIZADO CON MANEJO GLOBAL DE ERRORES)
axiosInstance.interceptors.response.use(
    (response) => response,
    (error) => {
        // 1. Si el servidor no responde en absoluto (Error de red o backend caído)
        if (!error.response) {
            Swal.fire("Error de Red", "No se pudo conectar con el servidor.", "error");
            return Promise.reject(error);
        }

        const status = error.response.status;
        const data = error.response.data;

        switch (status) {
            case 422: 
                const errors = data.errors;
                const msg = errors ? Object.values(errors).flat().join('<br>') : data.message;
                Swal.fire({
                    title: "Error de Validación",
                    html: msg,
                    icon: "warning",
                });
                break;

            case 403: 
                Swal.fire("Acceso Denegado", data.message || "No tienes permisos para realizar esta acción.", "error");
                break;

            case 401: 
                Swal.fire("Sesión Expirada", "Tu sesión ha terminado. Por favor, vuelve a iniciar sesión.", "info").then(() => {
                    forceLogout(); 
                });
                break;

            case 404: 
                Swal.fire("No encontrado", data.message || "El recurso solicitado no existe.", "info");
                break;

            case 500: 
            default:
                Swal.fire("Error del Servidor", data.message || "Ocurrió un error inesperado. Contacta a soporte.", "error");
                break;
        }


        return Promise.reject(error);
    }
);

const HttpClient = {
    get: axiosInstance.get,
    post: axiosInstance.post,
    put: axiosInstance.put,
    delete: axiosInstance.delete,
    patch: axiosInstance.patch,
};

export default HttpClient;