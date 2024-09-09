<script>
const breadbrums = [
    {
        title: "Inicio",
        disabled: false,
        url: route("inicio"),
        name_url: "inicio",
    },
    {
        title: "Reporte Lotes de Terrenos",
        disabled: false,
        url: "",
        name_url: "",
    },
];
</script>

<script setup>
import { useApp } from "@/composables/useApp";
import { computed, onMounted, ref } from "vue";
import { Head, usePage } from "@inertiajs/vue3";
import { useUrbanizacions } from "@/composables/urbanizacions/useUrbanizacions";
const { getUrbanizacions } = useUrbanizacions();
const { setLoading } = useApp();

onMounted(() => {
    setTimeout(() => {
        setLoading(false);
    }, 300);
});

const listUrbanizacions = ref([]);
const listManzanos = ref([
    {
        id: "todos",
        nombre: "TODOS",
    },
]);

const listOcupados = ref([
    {
        value: "todos",
        label: "TODOS",
    },
    {
        value: 0,
        label: "DISPONIBLES",
    },
    {
        value: 1,
        label: "OCUPADOS",
    },
]);

const form = ref({
    urbanizacion_id: "todos",
    manzano_id: "todos",
    ocupado: "todos",
});

const generando = ref(false);
const txtBtn = computed(() => {
    if (generando.value) {
        return "Generando Reporte...";
    }
    return "Generar Reporte";
});

const generarReporte = () => {
    generando.value = true;
    const url = route("reportes.r_lotes_terrenos", form.value);
    window.open(url, "_blank");
    setTimeout(() => {
        generando.value = false;
    }, 500);
};

const cargarListas = async () => {
    listUrbanizacions.value = await getUrbanizacions();
    listUrbanizacions.value.unshift({
        id: "todos",
        nombre: "TODOS",
    });
};

const getManzanosByUrbanizacion = (e) => {
    let id = e.target.value;
    form.manzano_id = "";
    listManzanos.value = [
        {
            id: "todos",
            nombre: "TODOS",
        },
    ];
    axios
        .get(route("manzanos.listadoByUrbanizacion"), {
            params: {
                id: id,
            },
        })
        .then((response) => {
            listManzanos.value = [
                ...listManzanos.value,
                ...response.data.manzanos,
            ];
        });
};

onMounted(() => {
    cargarListas();
});
</script>
<template>
    <Head title="Reporte Lotes de Terrenos"></Head>
    <!-- BEGIN breadcrumb -->
    <ol class="breadcrumb">
        <li class="breadcrumb-item"><a href="javascript:;">Inicio</a></li>
        <li class="breadcrumb-item active">Reportes > Lotes de Terrenos</li>
    </ol>
    <!-- END breadcrumb -->
    <!-- BEGIN page-header -->
    <h1 class="page-header">Reportes > Lotes de Terrenos</h1>
    <!-- END page-header -->
    <div class="row">
        <div class="col-md-6 mx-auto">
            <div class="card">
                <div class="card-body">
                    <form @submit.prevent="generarReporte">
                        <div class="row">
                            <div class="col-md-12 mt-2">
                                <label>Seleccionar Urbanización*</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.urbanizacion_id,
                                    }"
                                    v-model="form.urbanizacion_id"
                                    @change="getManzanosByUrbanizacion($event)"
                                >
                                    <option
                                        v-for="item in listUrbanizacions"
                                        :value="item.id"
                                    >
                                        {{ item.nombre }}
                                    </option>
                                </select>
                                <ul
                                    v-if="form.errors?.urbanizacion_id"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.urbanizacion_id }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-12 mt-2">
                                <label>Seleccionar Manzanos*</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.manzano_id,
                                    }"
                                    v-model="form.manzano_id"
                                >
                                    <option
                                        v-for="item in listManzanos"
                                        :value="item.id"
                                    >
                                        {{ item.nombre }}
                                    </option>
                                </select>
                                <ul
                                    v-if="form.errors?.manzano_id"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.manzano_id }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-12 mt-2">
                                <label>Seleccionar Estado Lote*</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error': form.errors?.ocupado,
                                    }"
                                    v-model="form.ocupado"
                                >
                                    <option
                                        v-for="item in listOcupados"
                                        :value="item.value"
                                    >
                                        {{ item.label }}
                                    </option>
                                </select>
                                <ul
                                    v-if="form.errors?.ocupado"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.ocupado }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-12 text-center mt-3">
                                <button
                                    class="btn btn-primary"
                                    block
                                    @click="generarReporte"
                                    :disabled="generando"
                                    v-text="txtBtn"
                                ></button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</template>
