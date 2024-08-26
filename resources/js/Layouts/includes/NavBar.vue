<script setup>
// Composables
import { usePage, Link, router } from "@inertiajs/vue3";
import { onMounted, ref } from "vue";
import { useConfiguracion } from "@/composables/configuracion/useConfiguracion";
import { useMenu } from "@/composables/useMenu";
import { useUser } from "@/composables/useUser";
const { props } = usePage();
const { oUser } = useUser();
var url_assets = "";
var url_principal = "";
const { drawer, width, rail, mobile, toggleDrawer, cambiarUrl } = useMenu();

const user = {
    initials: "JD",
    fullName: "John Doe",
    email: "john.doe@doe.com",
};

const { oConfiguracion } = useConfiguracion();

const logout = () => {
    router.post(route("logout"));
};

const open_perfil = ref(false);
const open_menu_usuario = () => {
    open_perfil.value = !open_perfil.value;
};

onMounted(() => {
    url_assets = props.url_assets;
    url_principal = props.url_principal;
    console.log(oUser);
});
</script>
<template>
    <div class="navbar-item navbar-user dropdown">
        <a
            href="#"
            class="navbar-link dropdown-toggle d-flex align-items-center"
            :class="[open_perfil ? 'show' : '']"
            data-bs-toggle="dropdown"
            @click="open_menu_usuario()"
        >
            <img :src="oUser.url_foto" alt="" />
            <span class="d-none d-md-inline">{{ oUser.usuario }}</span>
            <b class="caret ms-6px"></b>
        </a>
        <div
            class="dropdown-menu dropdown-menu-end me-1"
            :class="[open_perfil ? 'show' : '']"
        >
            <a href="#" class="dropdown-item">Perfil</a>
            <div class="dropdown-divider"></div>
            <a href="#" @click.prevent="logout()" class="dropdown-item"
                >Cerrar sesión</a
            >
        </div>
    </div>
</template>

<style scoped>
.dropdown-menu.show {
    position: absolute;
    inset: 0px 0px auto auto;
    margin: 0px;
    transform: translate(0px, 52px);
}
</style>
