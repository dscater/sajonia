<script setup>
import { useMenu } from "@/composables/useMenu";
import { useAppOptionStore } from "@/stores/app-option";
import { onMounted, ref } from "vue";
import { usePage, router, Link } from "@inertiajs/vue3";
import { useUser } from "@/composables/useUser";
import { slideToggle } from "@/composables/slideToggle.js";
const { oUser } = useUser();

// data
const {
    mobile,
    drawer,
    rail,
    width,
    menu_open,
    setMenuOpen,
    cambiarUrl,
    toggleDrawer,
} = useMenu();

const user_logeado = ref({
    permisos: [],
});
const appOption = useAppOptionStore();

const toggleAppSidebarMinified = () => {
    appOption.appSidebarMinified = !appOption.appSidebarMinified;
};

function appSidebarProfileToggle(e) {
    var targetSidebar = document.querySelector(
        ".app-sidebar:not(.app-sidebar-end)"
    );
    var targetMenu = e.target.closest(".menu-profile");
    var targetProfile = document.querySelector("#appSidebarProfileMenu");
    var expandTime =
        targetSidebar &&
        targetSidebar.getAttribute("data-disable-slide-animation")
            ? 0
            : 250;

    if (targetProfile) {
        if (targetProfile.style.display == "block") {
            targetMenu.classList.remove("active");
        } else {
            targetMenu.classList.add("active");
        }
        slideToggle(targetProfile, expandTime);
        targetProfile.classList.toggle("expand");
    }
}

const submenus = {
    "reportes.usuarios": "Reportes",
    "reportes.solicitud_mantenimiento": "Reportes",
    "reportes.servicio": "Reportes",
    "reportes.equipos": "Reportes",
    "reportes.historial_mantenimientos": "Reportes",
    "reportes.cantidad_mantenimiento_equipos": "Reportes",
    "reportes.cantidad_mantenimiento_mes": "Reportes",
};

const route_current = ref("");

router.on("navigate", (event) => {
    route_current.value = route().current();
    // if (mobile.value) {
    //     toggleDrawer(false);
    // }
});

const { props: props_page } = usePage();

onMounted(() => {
    let route_actual = route().current();
    // buscar en submenus y abrirlo si uno de sus elementos esta activo
    setMenuOpen([]);
    if (submenus[route_actual]) {
        setMenuOpen([submenus[route_actual]]);
    }

    if (props_page.auth) {
        user_logeado.value = props_page.auth?.user;
    }

    setTimeout(() => {
        scrollActive();
    }, 300);
});

const scrollActive = () => {
    let sidebar = document.querySelector("#sidebar");
    let menu = null;
    let activeChild = null;
    if (sidebar) {
        menu = sidebar.querySelector(".v-navigation-drawer__content");
        activeChild = sidebar.querySelector(".active");
    }
    // Verifica si se encontró un hijo activo
    if (activeChild) {
        let offsetTop = activeChild.offsetTop - sidebar.offsetTop;
        setTimeout(() => {
            menu.scrollTo({
                top: offsetTop,
                behavior: "smooth", // desplazamiento suave
            });
        }, 500);
    }
};

const logout = () => {
    router.post(route("logout"));
};
</script>
<template>
    <!-- BEGIN #sidebar -->
    <div id="sidebar" class="app-sidebar">
        <!-- BEGIN scrollbar -->
        <div
            class="app-sidebar-content"
            data-scrollbar="true"
            data-height="100%"
        >
            <!-- BEGIN menu -->
            <div class="menu">
                <div class="menu-profile">
                    <a
                        href="javascript:;"
                        class="menu-profile-link"
                        @click.prevent="appSidebarProfileToggle($event)"
                    >
                        <div class="menu-profile-cover with-shadow"></div>
                        <div class="menu-profile-image">
                            <img :src="oUser.url_foto" alt="" />
                        </div>
                        <div class="menu-profile-info">
                            <div class="d-flex align-items-center">
                                <div class="flex-grow-1">
                                    {{ oUser.full_name }}
                                </div>
                                <div class="menu-caret ms-auto"></div>
                            </div>
                            <small>{{ oUser.tipo }}</small>
                        </div>
                    </a>
                </div>
                <div id="appSidebarProfileMenu" class="collapse">
                    <div class="menu-item pt-5px">
                        <a href="#" class="menu-link">
                            <div class="menu-icon">
                                <i class="fa fa-cog"></i>
                            </div>
                            <div class="menu-text">Perfil</div>
                        </a>
                    </div>
                    <div class="menu-item pb-5px">
                        <a href="#" @click.prevent="logout()" class="menu-link">
                            <div class="menu-icon">
                                <i class="fa fa-sign-out"></i>
                            </div>
                            <div class="menu-text">Cerrar sesión</div>
                        </a>
                    </div>
                    <div class="menu-divider m-0"></div>
                </div>
                <div class="menu-header">Navegación</div>
                <div
                    class="menu-item"
                    :class="[route_current == 'inicio' ? 'active' : '']"
                >
                    <Link :href="route('inicio')" class="menu-link">
                        <div class="menu-icon">
                            <i class="fa fa-home"></i>
                        </div>
                        <div class="menu-text">Inicio</div>
                    </Link>
                </div>
                <div
                    class="menu-item"
                    :class="[route_current == 'notificacions.index' ? 'active' : '']"
                >
                    <Link :href="route('usuarios.index')" class="menu-link">
                        <div class="menu-icon">
                            <i class="fa fa-bell"></i>
                        </div>
                        <div class="menu-text">Notificaciones</div>
                    </Link>
                </div>
                <div
                    class="menu-item"
                    :class="[route_current == 'pagos.index' ? 'active' : '']"
                >
                    <Link :href="route('usuarios.index')" class="menu-link">
                        <div class="menu-icon">
                            <i class="fa fa-money-bill"></i>
                        </div>
                        <div class="menu-text">Pagos</div>
                    </Link>
                </div>
                <div
                    class="menu-item"
                    :class="[route_current == 'venta_lotes.index' ? 'active' : '']"
                >
                    <Link :href="route('usuarios.index')" class="menu-link">
                        <div class="menu-icon">
                            <i class="fa fa-clipboard-list"></i>
                        </div>
                        <div class="menu-text">Venta de Lotes</div>
                    </Link>
                </div>
                <div
                    class="menu-item"
                    :class="[route_current == 'clientes.index' ? 'active' : '']"
                >
                    <Link :href="route('usuarios.index')" class="menu-link">
                        <div class="menu-icon">
                            <i class="fa fa-user-friends"></i>
                        </div>
                        <div class="menu-text">Clientes</div>
                    </Link>
                </div>
                <div
                    class="menu-item"
                    :class="[route_current == 'planilla_cuotas.index' ? 'active' : '']"
                >
                    <Link :href="route('usuarios.index')" class="menu-link">
                        <div class="menu-icon">
                            <i class="fa fa-clipboard"></i>
                        </div>
                        <div class="menu-text">Planilla de cuotas</div>
                    </Link>
                </div>
                <div
                    class="menu-item"
                    :class="[route_current == 'lotes.index' ? 'active' : '']"
                >
                    <Link :href="route('usuarios.index')" class="menu-link">
                        <div class="menu-icon">
                            <i class="fa fa-list"></i>
                        </div>
                        <div class="menu-text">Lote</div>
                    </Link>
                </div>
                <div
                    class="menu-item"
                    :class="[route_current == 'manzanos.index' ? 'active' : '']"
                >
                    <Link :href="route('usuarios.index')" class="menu-link">
                        <div class="menu-icon">
                            <i class="fa fa-list"></i>
                        </div>
                        <div class="menu-text">Manzano</div>
                    </Link>
                </div>
                <div
                    class="menu-item"
                    :class="[route_current == 'urbanizacions.index' ? 'active' : '']"
                >
                    <Link :href="route('usuarios.index')" class="menu-link">
                        <div class="menu-icon">
                            <i class="fa fa-list-alt"></i>
                        </div>
                        <div class="menu-text">Urbanización</div>
                    </Link>
                </div>
                <div
                    class="menu-item"
                    :class="[route_current == 'usuarios.index' ? 'active' : '']"
                >
                    <Link :href="route('usuarios.index')" class="menu-link">
                        <div class="menu-icon">
                            <i class="fa fa-users"></i>
                        </div>
                        <div class="menu-text">Usuarios</div>
                    </Link>
                </div>
                <div class="menu-item has-sub">
                    <a href="javascript:;" class="menu-link">
                        <div class="menu-icon">
                            <i class="fa fa-file-pdf"></i>
                        </div>
                        <div class="menu-text">Reportes</div>
                        <div class="menu-caret"></div>
                    </a>
                    <div class="menu-submenu">
                        <div
                            class="menu-item"
                            :class="[
                                route_current == 'reportes.usuarios'
                                    ? 'active'
                                    : '',
                            ]"
                        >
                            <a href="#" class="menu-link"
                                ><div class="menu-text">Usuarios</div></a
                            >
                        </div>
                    </div>
                </div>
                <div
                    class="menu-item"
                    :class="[route_current == 'configuracions.index' ? 'active' : '']"
                >
                    <Link :href="route('usuarios.index')" class="menu-link">
                        <div class="menu-icon">
                            <i class="fa fa-cog"></i>
                        </div>
                        <div class="menu-text">Configuración</div>
                    </Link>
                </div>

                <!-- BEGIN minify-button -->
                <div class="menu-item d-flex">
                    <a
                        href="javascript:;"
                        class="app-sidebar-minify-btn ms-auto d-flex align-items-center text-decoration-none"
                        data-toggle="app-sidebar-minify"
                        @click.prevent="toggleAppSidebarMinified()"
                        ><i class="fa fa-angle-double-left"></i
                    ></a>
                </div>
                <!-- END minify-button -->
            </div>
            <!-- END menu -->
        </div>
        <!-- END scrollbar -->
    </div>
    <div class="app-sidebar-bg"></div>
    <div class="app-sidebar-mobile-backdrop">
        <a
            href="#"
            data-dismiss="app-sidebar-mobile"
            class="stretched-link"
        ></a>
    </div>
    <!-- END #sidebar -->
</template>
<style scoped></style>
