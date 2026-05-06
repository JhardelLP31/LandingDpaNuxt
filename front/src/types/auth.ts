// src/types/auth.ts

// Mantenemos tu estructura base
export type Role = {
  id?: string | number; // Aceptamos ambos por si Laravel manda int
  name?: string;
};

export type User = {
  // Propiedades existentes
  email?: string;
  name?: string;
  surname?: string;
  password?: string;
  role?: Role;
  token?: string;
  permissions?: Array<string>;
  academic_unit_id?: number | null;
  // --- AGREGAMOS ESTAS PARA QUE COINCIDAN CON TU SISTEMA ---
  id?: number | string; // Vital para identificar al usuario
  avatar?: string;      // Para mostrar la foto en el navbar
  full_name?: string;   // Útil si tu backend ya lo concatena
  full_name2?: string;   // Útil si tu backend ya lo concatena
  role_id?: string | number;
};

export type ResponseAuthLogin = {
  user?: User;
  access_token?: string;
  // Agregamos estos que suelen venir en JWT standard (opcional)
  token_type?: string;
  expires_in?: number;
};