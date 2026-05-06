// composables/useUnitBranding.ts
export const useUnitBranding = (brandingData: any, unitSlug: string) => {
  
  // 1. Procesar bloques de custom_css
  const brandingBlocks = computed(() => {
    if (!brandingData?.custom_css) return [];
    try {
      const parsed = typeof brandingData.custom_css === 'string' 
        ? JSON.parse(brandingData.custom_css) : brandingData.custom_css;
      return Array.isArray(parsed) ? parsed : [parsed];
    } catch (e) { return []; }
  });

  // 2. Info del Header
  const headerInfo = computed(() => {
    const block = brandingBlocks.value.find((b: any) => b.type?.toLowerCase().includes('header'));
    if (!block) return null;
    return {
      type: block.type,
      content: { 
        ...(block.content || block), 
        logoUrl: brandingData.logo_primary?.url || block.content?.logoUrl 
      }
    };
  });

  // 3. Info del Footer
  const footerInfo = computed(() => {
    const block = brandingBlocks.value.find((b: any) => b.type?.toLowerCase().includes('footer'));
    return block ? { type: block.type, content: block.content || block } : null;
  });

  // 4. Lógica del Menú (Tu menuTree)
  const menuTree = computed(() => {
    const menuObj = brandingData?.menu;
    if (!menuObj) return [];
    
    const mapItems = (items: any[]): any[] => {
      return items.map(item => {
        let url = `/${unitSlug}`;
        if (item.content_id && item.content?.slug) {
          url = item.content.slug === 'inicio' ? `/${unitSlug}` : `/${unitSlug}/${item.content.slug}`;
        } else if (item.url) {
          url = item.url.startsWith('http') || item.url.startsWith('#') 
            ? item.url : `/${unitSlug}/${item.url.replace(/^\//, '')}`;
        }
        return { ...item, url, to: url, children: item.children ? mapItems(item.children) : [] };
      });
    };
    return mapItems(menuObj.items || []);
  });

  // 5. Variables CSS
  const cssVars = computed(() => ({
    '--global-primary': brandingData?.primary_color || '',
    '--global-accent': brandingData?.accent_color || '',
  }));

  return { headerInfo, footerInfo, menuTree, cssVars };
}