import Swal from "sweetalert2";

export const handleApiError = (error: any, customTitle = "Error") => {
    // 1. Si no hay respuesta del servidor (backend caído o sin internet)
    if (!error.response) {
        Swal.fire("Error de Red", "No se pudo conectar con el servidor.", "error");
        return;
    }

    const status = error.response.status;
    const data = error.response.data;

    // 2. Evaluamos el código HTTP
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

        case 403: // Problemas de Roles/Permisos (Spatie)

            
            Swal.fire("Acceso Denegado", data.message || "No tienes permisos para realizar esta acción.", "error");
            break;

        case 401: // Token expirado (La redirección la sigue haciendo tu interceptor)
            Swal.fire("Sesión Expirada", "Por favor, vuelve a iniciar sesión.", "info");
            break;

        case 404: // Registro no encontrado
            Swal.fire("No encontrado", data.message || "El recurso solicitado no existe.", "info");
            break;

        default: // 500 y otros errores
            Swal.fire(customTitle, data.message || "Ocurrió un error inesperado en el servidor.", "error");
            break;
    }
};