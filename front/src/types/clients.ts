export type ClientUser = {
    id?:string,
    full_name: string,
}
export type UbigeoClient = {
    id:string,
    name:string,
    province_id?:string,
    department_id?:string,
}
export type Client = {
    id:number,
    name:string,
    surname?:string,
    full_name:string,
    email:string,
    birth_date?:string,
    user_id:string,
    user:ClientUser,
    type_client:number,
    phone?:number,
    state:number,
    type_document?:string,
    n_document?:string,
    ubigeo_region:string,
    ubigeo_provincia:string,
    ubigeo_distrito:string,
    region:string,
    provincia:string,
    distrito:string,
    address:string,
    gender:string,
    created_at:string
}
export type Clients = {
    clients:  {
        data:Client[],
    },
    total: number,
    paginate: number,
}
export type ClientResponse = {
    message:string | number,
    message_text?:string,
    client?: Client,
}