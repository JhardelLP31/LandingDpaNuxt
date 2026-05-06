import axios from "axios";

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

        // --- 2. GESTIÓN DE LA UNIDAD ACADÉMICA (NUEVO) ---
        // Buscamos el ID en localStorage. Si no existe, puedes poner uno por defecto 
        // o dejarlo vacío para rutas públicas.
// En axiosInstance.interceptors.request.use ...

        const unitId = localStorage.getItem("academic_unit_id") || "1"; // <--- Añade el || "1" para que nunca viaje vacío

        if (unitId) {
            config.headers['X-Academic-Unit'] = unitId;
        }

        // Aseguramos que el servidor sepa que esperamos JSON
        config.headers['Accept'] = 'application/json';

        return config;
    },
    (error) => Promise.reject(error)
);

// B. Interceptor de RESPONSE
axiosInstance.interceptors.response.use(
    (response) => response,
    (error) => {
        // Atrapamos 401 (No autorizado) y 403 (Prohibido/Permisos) si lo deseas
        if (error.response && error.response.status === 401) {
            forceLogout();
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