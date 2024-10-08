<script>
const breadbrums = [
    {
        title: "Inicio",
        disabled: false,
        url: route("inicio"),
        name_url: "inicio",
    },
    {
        title: "Urbanizaciones",
        disabled: false,
        url: "",
        name_url: "",
    },
];
</script>
<script setup>
import { useApp } from "@/composables/useApp";
import { Head, Link, usePage } from "@inertiajs/vue3";
import { initDataTable } from "@/composables/datatable.js";
import { ref, onMounted, onBeforeUnmount } from "vue";
import PanelToolbar from "@/Components/PanelToolbar.vue";
const props = defineProps({
    urbanizacion: {
        type: Object,
        default: null,
    },
});
const { props: props_page } = usePage();
const url_assets = props_page.url_assets;
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
        <li class="breadcrumb-item active">Urbanizaciones</li>
    </ol>
    <!-- END breadcrumb -->
    <!-- BEGIN page-header -->
    <h1 class="page-header">Urbanizaciones</h1>
    <!-- END page-header -->

    <div class="row">
        <div class="col-md-12">
            <!-- BEGIN panel -->
            <div class="panel panel-inverse">
                <!-- BEGIN panel-heading -->
                <div class="panel-heading">
                    <h4 class="panel-title">
                        {{ props.urbanizacion.nombre }}
                    </h4>
                    <panel-toolbar :mostrar_loading="loading" />
                </div>
                <!-- END panel-heading -->
                <!-- BEGIN panel-body -->
                <div class="panel-body">
                    <div
                        class="row contenedor_manzanos"
                        v-for="manzano in props.urbanizacion.manzanos"
                    >
                        <div class="col-12">
                            <h6 class="title">
                                {{ manzano.nombre }}
                            </h6>
                            <div class="row">
                                <div
                                    class="col-md-3 lote"
                                    :class="{ vendido: lote.vendido == 1 }"
                                    v-for="lote in manzano.lotes"
                                >
                                    <div
                                        class="cont_lote"
                                        :style="{
                                            backgroundImage:
                                                'url(' +
                                                url_assets +
                                                '/imgs/fondoterreno.jpg)',
                                            backgroundSize: '100% 100%',
                                        }"
                                    >
                                        <span class="nom_lote">{{
                                            lote.nombre
                                        }}</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row mt-2">
                        <div class="col-md-3">
                            <Link
                                :href="route('urbanizacions.index')"
                                class="btn btn-secondary w-100"
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

<style scoped>
.contenedor_manzanos .title {
    font-weight: bold;
    width: 100%;
    margin-top: 20px;
    text-align: center;
    color: white;
    padding: 15px;
    background-color: black;
}
.contenedor_manzanos .lote .cont_lote {
    font-size: 1.2em;
    display: flex;
    justify-content: center;
    align-items: center;
    color: white;
    padding: 20px;
    height: 190px;
    background-color: #06bb7f;
}


.contenedor_manzanos .lote .cont_lote .nom_lote {
    display: inline-block;
    width: 100%;
    padding: 15px;
    background-color: rgba(4, 150, 11, 0.712);
    text-align: center;
}


.contenedor_manzanos .lote.vendido .cont_lote {
    background-color: transparent;
}
.contenedor_manzanos .lote.vendido .cont_lote .nom_lote {
    background-color: rgba(231, 14, 14, 0.76);
}
</style>
