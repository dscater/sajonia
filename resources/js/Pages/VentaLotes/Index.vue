<script>
const breadbrums = [
    {
        title: "Inicio",
        disabled: false,
        url: route("inicio"),
        name_url: "inicio",
    },
    {
        title: "Venta de Lotes",
        disabled: false,
        url: "",
        name_url: "",
    },
];
</script>
<script setup>
import { useApp } from "@/composables/useApp";
import { Head, Link, usePage } from "@inertiajs/vue3";
import { useVentaLotes } from "@/composables/venta_lotes/useVentaLotes";
import { initDataTable } from "@/composables/datatable.js";
import { ref, onMounted, onBeforeUnmount } from "vue";
import PanelToolbar from "@/Components/PanelToolbar.vue";
// import { useMenu } from "@/composables/useMenu";
import Formulario from "./Formulario.vue";
// const { mobile, identificaDispositivo } = useMenu();
const { props } = usePage();
const { setLoading } = useApp();
onMounted(() => {
    setTimeout(() => {
        setLoading(false);
    }, 300);
});

const { getVentaLotes, setVentaLote, limpiarVentaLote, deleteVentaLote } =
    useVentaLotes();

const columns = [
    {
        title: "",
        data: "id",
    },
    {
        title: "FECHA DE FORMALIZACIÓN",
        data: "fecha_formalizacion_t",
    },
    {
        title: "URBANIZACIÓN",
        data: "urbanizacion.nombre",
    },
    {
        title: "MANZANO",
        data: "manzano.nombre",
    },
    {
        title: "LOTE",
        data: "lote.nombre",
    },
    {
        title: "CLIENTE",
        data: "cliente.user.full_name",
    },
    {
        title: "TIPO DE PAGO",
        data: "tipo_pago",
    },
    {
        title: "SISTEMA",
        data: "sistema",
    },
    {
        title: "ESTUDIOS COMPLEMENTARIOS",
        data: "estudios_com",
    },
    {
        title: "MINUTA",
        data: "minuta",
    },
    {
        title: "TITULACIÓN",
        data: "titulacion",
    },
    {
        title: "ESTADO DE CLIENTE",
        data: "estado_cliente",
    },
    {
        title: "TOTAL VENTA",
        data: "total_venta",
    },
    {
        title: "FECHA DE REGISTRO",
        data: "fecha_registro_t",
    },
    {
        title: "ACCIONES",
        data: null,
        render: function (data, type, row) {
            let planilla = `<button class="mx-0 rounded-0 btn btn-primary planilla" data-id="${row.id}"><i class="fa fa-file-pdf"></i></button>`;
            if (row.tipo_pago == "CONTADO") {
                planilla = "";
            }
            let editar = ` <button class="mx-0 rounded-0 btn btn-warning editar" data-id="${row.id}"><i class="fa fa-edit"></i></button>`;
            let eliminar = `<button class="mx-0 rounded-0 btn btn-danger eliminar"
                 data-id="${row.id}" 
                 data-nombre="${row.cliente.user.full_name}" 
                 data-url="${route(
                     "venta_lotes.destroy",
                     row.id
                 )}"><i class="fa fa-trash"></i></button>`;

            if (!props.auth.user.permisos.includes("venta_lotes.edit")) {
                editar = "";
            }
            if (!props.auth.user.permisos.includes("venta_lotes.destroy")) {
                eliminar = "";
            }
            return `${planilla}${editar}${eliminar}`;
        },
    },
];
const loading = ref(false);
const accion_dialog = ref(0);
const open_dialog = ref(false);

const agregarRegistro = () => {
    limpiarVentaLote();
    accion_dialog.value = 0;
    open_dialog.value = true;
};

const accionesRow = () => {
    // planilla
    $("#table-venta_lote").on("click", "button.planilla", function (e) {
        e.preventDefault();
        let id = $(this).attr("data-id");
        const url = route("reportes.planilla_venta", {
            venta_lote_id: id,
        });
        window.open(url, "_blank");
    });
    // editar
    $("#table-venta_lote").on("click", "button.editar", function (e) {
        e.preventDefault();
        let id = $(this).attr("data-id");
        axios.get(route("venta_lotes.show", id)).then((response) => {
            setVentaLote(response.data);
            accion_dialog.value = 1;
            open_dialog.value = true;
        });
    });
    // eliminar
    $("#table-venta_lote").on("click", "button.eliminar", function (e) {
        e.preventDefault();
        let nombre = $(this).attr("data-nombre");
        let id = $(this).attr("data-id");
        Swal.fire({
            title: "¿Quierés eliminar este registro?",
            html: `<strong>${nombre}</strong>`,
            showCancelButton: true,
            confirmButtonColor: "#B61431",
            confirmButtonText: "Si, eliminar",
            cancelButtonText: "No, cancelar",
            denyButtonText: `No, cancelar`,
        }).then(async (result) => {
            /* Read more about isConfirmed, isDenied below */
            if (result.isConfirmed) {
                let respuesta = await deleteVentaLote(id);
                if (respuesta && respuesta.sw) {
                    updateDatatable();
                }
            }
        });
    });
};

var datatable = null;
const datatableInitialized = ref(false);
const updateDatatable = () => {
    datatable.ajax.reload();
};

onMounted(async () => {
    if (props.planilla) {
        const url = route("reportes.planilla_venta", {
            venta_lote_id: props.planilla,
        });
        window.open(url, "_blank");
    }

    datatable = initDataTable(
        "#table-venta_lote",
        columns,
        route("venta_lotes.api")
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
    <Head title="Venta de Lotes"></Head>

    <!-- BEGIN breadcrumb -->
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:;">Inicio</a></li>
        <li class="breadcrumb-item active">Venta de Lotes</li>
    </ol>
    <!-- END breadcrumb -->
    <!-- BEGIN page-header -->
    <h1 class="page-header">Venta de Lotes</h1>
    <!-- END page-header -->

    <div class="row">
        <div class="col-md-12">
            <!-- BEGIN panel -->
            <div class="panel panel-inverse">
                <!-- BEGIN panel-heading -->
                <div class="panel-heading">
                    <h4
                        class="panel-title btn-nuevo"
                        v-if="
                            props.auth.user.permisos.includes(
                                'venta_lotes.create'
                            )
                        "
                    >
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
                        id="table-venta_lote"
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

    <Formulario
        :open_dialog="open_dialog"
        :accion_dialog="accion_dialog"
        @envio-formulario="updateDatatable"
        @cerrar-dialog="open_dialog = false"
    ></Formulario>
</template>
