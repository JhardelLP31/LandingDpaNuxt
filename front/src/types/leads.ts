export interface Lead {
    id: number;
    first_name: string;
    last_name: string;
    email: string;
    phone?: string;
    status: string; // Lo dejamos solo como string ('new', 'contacted', etc.)
    payload?: any; // Aquí guardaremos el message, formation_type, etc.
    marketing_metadata?: any; // Aquí guardaremos origin_url, ip, etc.
    created_at: string;
    updated_at?: string;
}

export interface LeadResponse {
    lead: Lead;
    message: string | number;
    message_text?: string;
}