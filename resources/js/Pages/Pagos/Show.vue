<script>
const breadbrums = [
    {
        title: "Inicio",
        disabled: false,
        url: route("inicio"),
        name_url: "inicio",
    },
    {
        title: "Pagos",
        disabled: false,
        url: "",
        name_url: "",
    },
];
</script>
<script setup>
import { useApp } from "@/composables/useApp";
import { Head, Link } from "@inertiajs/vue3";
import { usePagos } from "@/composables/pagos/usePagos";
import { initDataTable } from "@/composables/datatable.js";
import { ref, onMounted, onBeforeUnmount } from "vue";
import PanelToolbar from "@/Components/PanelToolbar.vue";
const props = defineProps({
    pago: {
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

const loading = ref(false);
onMounted(async () => {});
</script>
<template>
    <Head title="Pagos"></Head>

    <!-- BEGIN breadcrumb -->
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:;">Inicio</a></li>
        <li class="breadcrumb-item active">Pagos</li>
    </ol>
    <!-- END breadcrumb -->
    <!-- BEGIN page-header -->
    <h1 class="page-header">Pagos</h1>
    <!-- END page-header -->

    <div class="row">
        <div class="col-md-12">
            <!-- BEGIN panel -->
            <div class="panel panel-inverse">
                <!-- BEGIN panel-heading -->
                <div class="panel-heading">
                    <panel-toolbar :mostrar_loading="loading" />
                </div>
                <!-- END panel-heading -->
                <!-- BEGIN panel-body -->
                <div class="panel-body">
                    <div class="row">
                        <div class="col-12">
                            <p>
                                <strong>CLIENTE: </strong>
                                {{ props.pago?.cliente?.user.full_name }}
                            </p>
                            <p>
                                <strong>MONTO CUOTA: </strong>
                                {{ props.pago?.cuota }}
                            </p>
                            <p>
                                <strong>NRO. DE CUTOAS: </strong>
                                {{ props.pago?.nro_cuotas }}
                            </p>
                            <p>
                                <strong>MONTO TOTAL: </strong>
                                {{ props.pago?.total_cuota }}
                            </p>
                            <p>
                                <strong>DESCRIPCIÓN: </strong>
                                {{ props.pago?.descripcion }}
                            </p>
                            <p>
                                <strong>FECHA DE PAGO: </strong>
                                {{ props.pago?.fecha_pago_t }}
                            </p>
                        </div>
                        <div class="col-md-3">
                            <Link
                                :href="route('pagos.index')"
                                class="btn btn-secondary mx-1"
                                ><i class="fa fa-arrow-left"></i> Volver</Link
                            >
                            <a
                                :href="route('pagos.pdf', props.pago.id)"
                                class="btn btn-primary mx-1"
                                target="_blank"
                                ><i class="fa fa-print"></i> Imprimir</a
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
