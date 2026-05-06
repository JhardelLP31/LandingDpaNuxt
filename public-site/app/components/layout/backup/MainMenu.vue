  <template>
    <nav class="navbar navbar-expand-lg navbar-dark bg-nav-grey py-0">
      <div class="container justify-content-center">
        
        <button class="navbar-toggler my-2" 
                type="button" 
                @click="toggleMenu"
                :class="{ 'collapsed': !isMenuOpen }"
                aria-expanded="false">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-center transition-height" 
            :class="{ 'show': isMenuOpen }" 
            id="mainNav">
          
          <ul class="navbar-nav gap-4 py-3 py-lg-0">
            
            <template v-for="item in menuItems" :key="item.id">
              
              <li v-if="item.children && item.children.length > 0" 
                  class="nav-item dropdown"
                  :class="{ 'show': activeDropdown === item.id }"> <a class="nav-link dropdown-toggle text-white cursor-pointer" 
                  href="#" 
                  role="button" 
                  @click.prevent="toggleDropdown(item.id)"
                  :aria-expanded="activeDropdown === item.id">
                  
                  {{ item.title }}
                  <i class="fas fa-chevron-down ms-2 small-icon" 
                    :class="{ 'rotate-icon': activeDropdown === item.id }"></i>
                </a>

                <ul class="dropdown-menu border-0 shadow-sm rounded-0 mt-0"
                    :class="{ 'show': activeDropdown === item.id }"
                    @click.stop> <li v-for="child in item.children" :key="child.id">
                    <component :is="isExternal(child.link) ? 'a' : 'router-link'" 
                              :to="!isExternal(child.link) ? child.link : undefined"
                              :href="isExternal(child.link) ? child.link : undefined"
                              :target="isExternal(child.link) ? '_blank' : undefined"
                              class="dropdown-item"
                              @click="closeMenu"> 
                      {{ child.title }}
                    </component>
                  </li>

                </ul>
              </li>

              <li v-else class="nav-item">
                <component :is="isExternal(item.link) ? 'a' : 'router-link'" 
                          :to="!isExternal(item.link) ? item.link : undefined"
                          :href="isExternal(item.link) ? item.link : undefined"
                          :target="isExternal(item.link) ? '_blank' : undefined"
                          class="nav-link text-white"
                          active-class="active-link"
                          @click="closeMenu"> 
                  {{ item.title }}
                </component>
              </li>

            </template>

          </ul>
        </div>
      </div>
    </nav>
  </template>

  <script setup lang="ts">
  import { ref, onMounted } from 'vue';
  import HttpClient from "@/helpers/http-client";

  // Estado del Menú Principal (Hamburguesa)
  const isMenuOpen = ref(false);
  // Estado de los Submenús (Dropdowns) - Guarda el ID del menú abierto
  const activeDropdown = ref<number | string | null>(null);

  const menuItems = ref<any[]>([]);

  // Toggle del menú hamburguesa
  const toggleMenu = () => isMenuOpen.value = !isMenuOpen.value;

  // Cierra todo (Hamburguesa y submenús)
  const closeMenu = () => {
      isMenuOpen.value = false;
      activeDropdown.value = null;
  };

  // --- LÓGICA NUEVA PARA DROPDOWNS ---
  const toggleDropdown = (id: number | string) => {
      // Si toco el mismo que ya está abierto, lo cierro (null). Si no, abro el nuevo.
      if (activeDropdown.value === id) {
          activeDropdown.value = null;
      } else {
          activeDropdown.value = id;
      }
  };

  const isExternal = (link: string) => {
    return link && (link.startsWith('http') || link.startsWith('//'));
  };

  const buildTreeSafe = (data: any[]) => {
    if (!Array.isArray(data)) return [];
    if (data.length > 0 && data[0].children) return data;

    try {
      const items = JSON.parse(JSON.stringify(data));
      const map: Record<string, any> = {};
      const roots: any[] = [];

      items.forEach((item: any) => { map[item.id] = item; item.children = []; });
      items.forEach((item: any) => {
        if (item.parent_id && map[item.parent_id]) {
          map[item.parent_id].children.push(item);
        } else {
          roots.push(item);
        }
      });
      return roots;
    } catch (e) {
      console.error('Error procesando menú:', e);
      return data;
    }
  };

  onMounted(async () => {
    try {
      const { data } = await HttpClient.get('public-menu'); 
      const rawData = Array.isArray(data) ? data : (data.data || []);
      menuItems.value = buildTreeSafe(rawData);
    } catch (e) {
      console.error("Error cargando menú", e);
    }
  });
  </script>

  <style scoped lang="scss">
  $esan-red: #e31140;

.bg-nav-grey {
  background-color: transparent; /* Antes #2c2c2c */
  border-bottom: none; /* Quitamos este borde para que no choque con el del padre */
}



  .nav-link {
    font-size: 1rem;
    font-weight: 500;
    padding: 1rem 0;
    transition: color 0.2s;
    cursor: pointer !important; /* Manito siempre */

    &:hover, &.active-link, &.router-link-active {
      color: $esan-red !important;
    }
  }

  .small-icon {
      font-size: 0.7rem;
      vertical-align: middle;
      transition: transform 0.3s ease;
  }

  /* Efecto rotación flecha al abrir */
  .rotate-icon {
      transform: rotate(180deg);
  }

  /* --- ESTILOS DROPDOWN --- */
  .dropdown-menu {
      background-color: transparent; /* Un color sólido oscuro para legibilidad */
      border-top: 3px solid $esan-red;
  }

  /* ESTO HACE LA MAGIA: Clase .show controlada por Vue */
  .dropdown-menu.show {
      display: block;
      animation: fadeIn 0.3s ease;
  }

  @keyframes fadeIn {
      from { opacity: 0; transform: translateY(-10px); }
      to { opacity: 1; transform: translateY(0); }
  }

  .dropdown-item {
      color: #fff;
      padding: 10px 20px;
      cursor: pointer;
      
      &:hover {
        background-color: $esan-red;
        color: white;
      }
      
      &.router-link-active {
          background-color: rgba($esan-red, 0.2);
          color: $esan-red;
          font-weight: bold;
      }
  }

  /* --- REGLAS RESPONSIVE --- */

  /* MÓVIL (Menor a 992px) */
  @media (max-width: 991.98px) {
      .dropdown-menu {
          border-top: none;
          border-left: 2px solid $esan-red; /* Borde al costado en móvil se ve mejor */
          background-color: #222; /* Un poco más oscuro para diferenciar */
          margin-left: 10px;
      }
  }

  /* ESCRITORIO (Mayor a 992px) */
  @media (min-width: 992px) {
      /* Mantenemos el Hover en Desktop para que sea fluido */
      .dropdown:hover .dropdown-menu {
          display: block;
      }
      
      /* Ajuste para que el hover no pelee con el click de Vue */
      .dropdown:hover .nav-link {
          color: $esan-red;
      }
  }
  </style>