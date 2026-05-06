// types/Banner.ts
export interface BannerAction {
  label: string;
  url: string;
}

export interface BannerStats {
  number: string;
  label: string;
}

export interface BannerSlide {
  id: string | number;
  imageUrl: string;
  // Detectamos dos layouts en tu HTML: uno con números (stats) y otro centrado estándar
  layout: 'stats-mode' | 'standard-mode'; 
  title: string; // Soporta HTML para los <br>
  preTitle?: string; // Para "Líderes en consultoría"
  stats?: BannerStats; // Para "23 AÑOS"
  action: BannerAction;
}