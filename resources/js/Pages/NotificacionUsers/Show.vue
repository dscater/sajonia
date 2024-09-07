<script>
const breadbrums = [
    {
        title: "Inicio",
        disabled: false,
        url: route("inicio"),
        name_url: "inicio",
    },
    {
        title: "Notificaciones",
        disabled: false,
        url: "",
        name_url: "",
    },
];
</script>
<script setup>
import { useApp } from "@/composables/useApp";
import { Head, Link } from "@inertiajs/vue3";
import { useNotificacionUsers } from "@/composables/notificacion_users/useNotificacionUsers";
import { initDataTable } from "@/composables/datatable.js";
import { ref, onMounted, onBeforeUnmount } from "vue";
import PanelToolbar from "@/Components/PanelToolbar.vue";
const props = defineProps({
    notificacion_user: {
        type: Object,
        default: null,
    },
});
const { setLoading } = useApp();
onMounted(() => {
    setTimeout(() => {
        setLoading(false);
    }, 300);
});

const { oNotificacionUser, setNotificacionUser } = useNotificacionUsers();
setNotificacionUser(props.notificacion_user);
const loading = ref(false);
onMounted(async () => {});
</script>
<template>
    <Head title="Notificaciones"></Head>

    <!-- BEGIN breadcrumb -->
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:;">Inicio</a></li>
        <li class="breadcrumb-item active">Notificaciones</li>
    </ol>
    <!-- END breadcrumb -->
    <!-- BEGIN page-header -->
    <h1 class="page-header">Notificaciones</h1>
    <!-- END page-header -->

    <div class="row">
        <div class="col-md-12">
            <!-- BEGIN panel -->
            <div class="panel panel-inverse">
                <!-- BEGIN panel-heading -->
                <div class="panel-heading">
                    <panel-toolbar
                        :mostrar_loading="loading"
                    />
                </div>
                <!-- END panel-heading -->
                <!-- BEGIN panel-body -->
                <div class="panel-body">
                    <div class="row">
                        <div class="col-12">
                            <p>
                                <strong>DESCRIPCIÓN: </strong>
                                {{
                                    oNotificacionUser.notificacion?.descripcion
                                }}
                            </p>
                            <p>
                                <strong>FECHA: </strong>
                                {{ oNotificacionUser.notificacion?.fecha }}
                            </p>
                            <p>
                                <strong>HORA: </strong>
                                {{ oNotificacionUser.notificacion?.hora }}
                            </p>
                        </div>
                        <div class="col-md-3">
                            <Link
                                :href="route('notificacion_users.index')"
                                class="btn btn-secondary"
                                ><i class="fa fa-arrow-left"></i> Volver</Link
                            >
                        </div>
                    </div>
                </div>
                <!-- END panel-body -->
            </div>
            <!-- END panel -->
        </div>
    </div>
</template>
