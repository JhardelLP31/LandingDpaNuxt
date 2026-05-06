export type Categorie = {
    id:string,
    name:string,
    state:number,
    imagen:string,
    created_at:string
}
export type Categories = {
    total: number,
    paginate: number,
    categories: Categorie[]
}
export type CategorieResponse = {
    message:string | number,
    message_text?:string,
    categorie?: Categorie,
}