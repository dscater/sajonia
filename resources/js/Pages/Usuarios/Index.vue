<script>
const breadbrums = [
    {
        title: "Inicio",
        disabled: false,
        url: route("inicio"),
        name_url: "inicio",
    },
    {
        title: "Usuarios",
        disabled: false,
        url: "",
        name_url: "",
    },
];
</script>
<script setup>
import { useApp } from "@/composables/useApp";
import { Head, Link } from "@inertiajs/vue3";
import { useUsuarios } from "@/composables/usuarios/useUsuarios";
import { initDataTable } from "@/composables/datatable.js";
import { ref, onMounted } from "vue";
import PanelToolbar from "@/Components/PanelToolbar.vue"
// import { useMenu } from "@/composables/useMenu";
import Formulario from "./Formulario.vue";
import FormPassword from "./FormPassword.vue";
// const { mobile, identificaDispositivo } = useMenu();
const { setLoading } = useApp();
onMounted(() => {
    setTimeout(() => {
        setLoading(false);
    }, 300);
});

const { getUsuarios, setUsuario, limpiarUsuario, deleteUsuario } =
    useUsuarios();
const responseUsuarios = ref([]);
const listUsuarios = ref([]);
const itemsPerPage = ref(5);

const search = ref("");
const options = ref({
    page: 1,
    itemsPerPage: itemsPerPage,
    sortBy: "",
    sortOrder: "desc",
    search: "",
});

const loading = ref(true);
const totalItems = ref(0);
let setTimeOutLoadData = null;
const cargarUsuarios = async () => {
    listUsuarios.value = await getUsuarios();
};
const accion_dialog = ref(0);
const open_dialog = ref(false);
const accion_dialog_pass = ref(0);
const open_dialog_pass = ref(false);

const agregarRegistro = () => {
    limpiarUsuario();
    accion_dialog.value = 0;
    open_dialog.value = true;
};
const editarUsuario = (item) => {
    setUsuario(item);
    accion_dialog.value = 1;
    open_dialog.value = true;
};
const updatePassword = (item) => {
    setUsuario(item);
    accion_dialog_pass.value = 1;
    open_dialog_pass.value = true;
};
const eliminarUsuario = (item) => {
    Swal.fire({
        title: "¿Quierés eliminar este registro?",
        html: `<strong>${item.full_name}</strong>`,
        showCancelButton: true,
        confirmButtonColor: "#B61431",
        confirmButtonText: "Si, eliminar",
        cancelButtonText: "No, cancelar",
        denyButtonText: `No, cancelar`,
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            let respuesta = await deleteUsuario(item.id);
            if (respuesta && respuesta.sw) {
                recargaUsuarios();
            }
        }
    });
};

onMounted(async () => {
    await cargarUsuarios();
    initDataTable();
});
</script>
<template>
    <Head title="Usuarios"></Head>

    <!-- BEGIN breadcrumb -->
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:;">Inicio</a></li>
        <li class="breadcrumb-item active">Usuarios</li>
    </ol>
    <!-- END breadcrumb -->
    <!-- BEGIN page-header -->
    <h1 class="page-header">Usuarios</h1>
    <!-- END page-header -->

    <div class="row">
        <div class="col-md-12">
            <!-- BEGIN panel -->
            <div class="panel panel-inverse">
                <!-- BEGIN panel-heading -->
                <div class="panel-heading">
                    <h4 class="panel-title btn-nuevo">
                        <button type="button" class="btn btn-primary"
                        @click="agregarRegistro">
                            <i class="fa fa-plus"></i> Nuevo
                        </button>
                    </h4>
                    <panel-toolbar />
                </div>
                <!-- END panel-heading -->
                <!-- BEGIN panel-body -->
                <div class="panel-body">
                    <table
                        id="data-table-responsive"
                        width="100%"
                        class="table table-striped table-bordered align-middle text-nowrap tabla_datos"
                    >
                        <thead>
                            <tr>
                                <th width="1%"></th>
                                <th width="1%" data-orderable="false"></th>
                                <th class="text-nowrap">Usuario</th>
                                <th class="text-nowrap">Nombre Completo</th>
                                <th class="text-nowrap">C.I.</th>
                                <th class="text-nowrap">Dirección</th>
                                <th class="text-nowrap">Teléfono</th>
                                <th class="text-nowrap">Tipo</th>
                                <th class="text-nowrap">Acceso</th>
                                <th class="text-nowrap">Acción</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr class="odd gradeX" v-for="item in listUsuarios">
                                <td width="1%" class="fw-bold">
                                    {{ this.id }}
                                </td>
                                <td width="1%">
                                    <img
                                        :src="item.url_foto"
                                        class="rounded h-30px my-n1 mx-n1"
                                    />
                                </td>
                                <td>{{ this.usuario }}</td>
                                <td>
                                    {{ this.nombre }} {{ this.paterno }}
                                    {{ this.materno }}
                                </td>
                                <td>{{ this.ci }} {{ this.ci_exp }}</td>
                                <td>{{ this.dir }}</td>
                                <td>{{ this.fono }}</td>
                                <td>{{ this.tipo }}</td>
                                <td></td>
                                <td class="btns-opciones">
                                    <a href="#" class="password evaluar"
                                        ><i
                                            class="fa fa-key"
                                            data-toggle="tooltip"
                                            data-placement="left"
                                            title="Cambiar Contraseña"
                                        ></i
                                    ></a>
                                    <a href="#" class="modificar"
                                        ><i
                                            class="fa fa-edit"
                                            data-toggle="tooltip"
                                            data-placement="left"
                                            title="Modificar"
                                        ></i
                                    ></a>
                                    <a href="#" class="eliminar"
                                        ><i
                                            class="fa fa-trash"
                                            data-toggle="tooltip"
                                            data-placement="left"
                                            title="Eliminar"
                                        ></i
                                    ></a>
                                </td>
                            </tr>
                        </tbody>
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
        @envio-formulario="cargarUsuarios"
        @cerrar-dialog="open_dialog = false"
    ></Formulario>
    <!-- <FormPassword
        :open_dialog="open_dialog_pass"
        :accion_dialog="accion_dialog_pass"
        @envio-formulario="open_dialog_pass = false"
        @cerrar-dialog="open_dialog_pass = false"
    ></FormPassword> -->
</template>
