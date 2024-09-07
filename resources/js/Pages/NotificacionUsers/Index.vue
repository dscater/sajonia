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
import { Head, Link, router } from "@inertiajs/vue3";
import { useNotificacionUsers } from "@/composables/notificacion_users/useNotificacionUsers";
import { initDataTable } from "@/composables/datatable.js";
import { ref, onMounted, onBeforeUnmount } from "vue";
import PanelToolbar from "@/Components/PanelToolbar.vue";
// import { useMenu } from "@/composables/useMenu";
// const { mobile, identificaDispositivo } = useMenu();
const { setLoading } = useApp();
onMounted(() => {
    setTimeout(() => {
        setLoading(false);
    }, 300);
});

const {
    getNotificacionUsers,
    setNotificacionUser,
    limpiarNotificacionUser,
    deleteNotificacionUser,
} = useNotificacionUsers();

const columns = [
    {
        title: "",
        data: "id",
    },
    {
        title: "DESCRIPCIÓN",
        data: "notificacion.descripcion",
    },
    {
        title: "FECHA Y HORA",
        data: "notificacion.fecha_hora_t",
    },
    {
        title: "ACCIONES",
        data: null,
        render: function (data, type, row) {
            return `
                <button class="mx-0 rounded-0 btn btn-info show" data-id="${row.id}"><i class="fa fa-eye"></i></button>
            `;
        },
    },
];
const loading = ref(true);

const accionesRow = () => {
    // editar
    $("#table-notificacion_user").on("click", "button.show", function (e) {
        e.preventDefault();
        let id = $(this).attr("data-id");
        router.get(route("notificacion_users.show", id));
    });
};

var datatable = null;
const datatableInitialized = ref(false);
const updateDatatable = () => {
    datatable.ajax.reload();
};

onMounted(async () => {
    datatable = initDataTable(
        "#table-notificacion_user",
        columns,
        route("notificacion_users.api")
    );
    datatableInitialized.value = true;
    accionesRow();
});
onBeforeUnmount(() => {
    if (datatable) {
        datatable.clear();
        datatable.destroy(false); // Destruye la instancia del DataTable
        datatable = null;
        datatableInitialized.value = false;
    }
});
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
                    <h4 class="panel-title btn-nuevo">
                        <button
                            type="button"
                            class="btn btn-primary"
                            @click="agregarRegistro"
                        >
                            <i class="fa fa-plus"></i> Nuevo
                        </button>
                    </h4>
                    <panel-toolbar
                        :mostrar_loading="loading"
                        @loading="updateDatatable"
                    />
                </div>
                <!-- END panel-heading -->
                <!-- BEGIN panel-body -->
                <div class="panel-body">
                    <table
                        id="table-notificacion_user"
                        width="100%"
                        class="table table-striped table-bordered align-middle text-nowrap tabla_datos"
                    >
                        <thead></thead>
                        <tbody></tbody>
                    </table>
                </div>
                <!-- END panel-body -->
            </div>
            <!-- END panel -->
        </div>
    </div>
</template>
