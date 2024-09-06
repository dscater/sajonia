<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useClientes } from "@/composables/clientes/useClientes";
import { useVentaLotes } from "@/composables/venta_lotes/useVentaLotes";
import { useUrbanizacions } from "@/composables/urbanizacions/useUrbanizacions";
import { watch, ref, computed, defineEmits, onMounted, nextTick } from "vue";
const props = defineProps({
    open_dialog: {
        type: Boolean,
        default: false,
    },
    accion_dialog: {
        type: Number,
        default: 0,
    },
});

const { oVentaLote, limpiarVentaLote } = useVentaLotes();
const { getUrbanizacions } = useUrbanizacions();
const { getClientes } = useClientes();
const accion = ref(props.accion_dialog);
const dialog = ref(props.open_dialog);
const listClientes = ref([]);
const listUrbanizacions = ref([]);
const listManzanos = ref([]);
const listLotes = ref([]);
const listTipoPagos = ref(["CONTADO", "CRÉDITO"]);
const listSistemas = ref(["PENDIENTE", "EN PROCESO", "FINALIZADO"]);
const listEstudios = ref(["PENDIENTE", "EN PROCESO", "FINALIZADO"]);
const listMinuta = ref(["PENDIENTE", "EN PROCESO", "FINALIZADO"]);
const listTitulacion = ref(["PENDIENTE", "EN PROCESO", "FINALIZADO"]);
const listEstadoCliente = ref([
    "ACTIVO",
    "VENCIMIENTO",
    "DISPENSA",
    "DEVOLUCIÓN",
    "EXCLUSIÓN",
]);
const oLote = ref(null);

let form = useForm(oVentaLote.value);
watch(
    () => props.open_dialog,
    async (newValue) => {
        dialog.value = newValue;
        if (dialog.value) {
            cargaListas();
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
            form = useForm(oVentaLote.value);
            if (form.id != 0) {
                getManzanosIdUrbanizacion(form.urbanizacion_id);
                getLotesIdManzano(form.manzano_id);
                getLoteById(form.lote_id);
            }
        }
    }
);
watch(
    () => props.accion_dialog,
    (newValue) => {
        accion.value = newValue;
    }
);

const cargaListas = async () => {
    listUrbanizacions.value = await getUrbanizacions();
    listClientes.value = await getClientes();
};

const getManzanos = (e) => {
    let id = e.target.value;
    form.manzano_id = "";
    axios
        .get(route("manzanos.listadoByUrbanizacion"), {
            params: {
                id: id,
            },
        })
        .then((response) => {
            listManzanos.value = response.data.manzanos;
        });
};

const getLotes = (e) => {
    let id = e.target.value;
    form.lote_id = "";
    axios
        .get(route("lotes.listadoByManzano"), {
            params: {
                id: id,
            },
        })
        .then((response) => {
            listLotes.value = response.data.lotes;
        });
};

const getLote = (e) => {
    let id = e.target.value;
    oLote.value = null;
    if (id && "" + id.trim() != "") {
        axios.get(route("lotes.show", id)).then((response) => {
            oLote.value = response.data;
        });
    }
};

const getManzanosIdUrbanizacion = (id) => {
    axios
        .get(route("manzanos.listadoByUrbanizacion"), {
            params: {
                id: id,
            },
        })
        .then((response) => {
            listManzanos.value = response.data.manzanos;
        });
};

const getLotesIdManzano = (id) => {
    axios
        .get(route("lotes.listadoByManzano"), {
            params: {
                id: id,
            },
        })
        .then((response) => {
            listLotes.value = response.data.lotes;
        });
};

const getLoteById = (id) => {
    oLote.value = null;
    if (id && id != "") {
        axios.get(route("lotes.show", id)).then((response) => {
            oLote.value = response.data;
        });
    }
};

const { flash } = usePage().props;

const tituloDialog = computed(() => {
    return accion.value == 0
        ? `<i class="fa fa-plus"></i>Agregar Registro`
        : `<i class="fa fa-edit"></i>Editar Registro`;
});

const enviarFormulario = () => {
    let url =
        form["_method"] == "POST"
            ? route("venta_lotes.store")
            : route("venta_lotes.update", form.id);

    form.post(url, {
        preserveScroll: true,
        forceFormData: true,
        onSuccess: () => {
            dialog.value = false;
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${flash.bien ? flash.bien : "Proceso realizado"}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            limpiarVentaLote();
            emits("envio-formulario");
        },
        onError: (err) => {
            console.log("ERROR");
            Swal.fire({
                icon: "info",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.error
                        ? err.error
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
        },
    });
};

const emits = defineEmits(["cerrar-dialog", "envio-formulario"]);

watch(dialog, (newVal) => {
    if (!newVal) {
        emits("cerrar-dialog");
    }
});

const cerrarDialog = () => {
    dialog.value = false;
    document.getElementsByTagName("body")[0].classList.remove("modal-open");
};
</script>

<template>
    <div
        class="modal fade"
        :class="{
            show: dialog,
        }"
        id="modal-dialog-form"
        :style="{
            display: dialog ? 'block' : 'none',
        }"
    >
        <div class="modal-dialog modal-xl">
            <div class="modal-content">
                <div class="modal-header bg-primary text-white">
                    <h4 class="modal-title" v-html="tituloDialog"></h4>
                    <button
                        type="button"
                        class="btn-close"
                        @click="cerrarDialog()"
                    ></button>
                </div>
                <div class="modal-body">
                    <form @submit.prevent="enviarFormulario()">
                        <div class="row">
                            <div class="col-md-4 mt-2">
                                <label>Cliente*</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.cliente_id,
                                    }"
                                    v-model="form.cliente_id"
                                    @change="getManzanos($event)"
                                >
                                    <option value="">- Seleccione -</option>
                                    <option
                                        v-for="item in listClientes"
                                        :value="item.id"
                                    >
                                        {{ item.user.full_name }}
                                    </option>
                                </select>
                                <ul
                                    v-if="form.errors?.cliente_id"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.cliente_id }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Fecha de Formalización*</label>
                                <input
                                    type="date"
                                    class="form-control"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.fecha_formalizacion,
                                    }"
                                    v-model="form.fecha_formalizacion"
                                />
                                <ul
                                    v-if="form.errors?.fecha_formalizacion"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.fecha_formalizacion }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Seleccionar Urbanización*</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.urbanizacion_id,
                                    }"
                                    v-model="form.urbanizacion_id"
                                    @change="getManzanos($event)"
                                >
                                    <option value="">- Seleccione -</option>
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
                            <div class="col-md-4 mt-2">
                                <label>Seleccionar Manzano*</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.manzano_id,
                                    }"
                                    v-model="form.manzano_id"
                                    @change="getLotes($event)"
                                >
                                    <option value="">- Seleccione -</option>
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
                            <div class="col-md-4 mt-2">
                                <label>Seleccionar Lote*</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error': form.errors?.lote_id,
                                    }"
                                    v-model="form.lote_id"
                                    @change="getLote($event)"
                                >
                                    <option value="">- Seleccione -</option>
                                    <option
                                        v-for="item in listLotes"
                                        :value="item.id"
                                    >
                                        {{ item.nombre }}
                                    </option>
                                </select>
                                <ul
                                    v-if="form.errors?.lote_id"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.lote_id }}
                                    </li>
                                </ul>
                            </div>
                            <div
                                class="col-md-12 mt-2 pt-2"
                                v-show="oLote != null"
                            >
                                <div class="card">
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-m12">
                                                <h5 class="w-100 text-center">
                                                    Información Lote
                                                </h5>
                                            </div>
                                            <div class="col-md-6">
                                                <p>
                                                    <strong>Ubicación:</strong>
                                                    {{ oLote?.ubicacion }}
                                                </p>
                                                <p>
                                                    <strong>Esquina:</strong>
                                                    {{ oLote?.esquina }}
                                                </p>
                                                <p>
                                                    <strong
                                                        >Esquina área
                                                        verde:</strong
                                                    >
                                                    {{ oLote?.esquina_area }}
                                                </p>
                                                <p>
                                                    <strong
                                                        >Esquina área de
                                                        equipamiento:</strong
                                                    >
                                                    {{
                                                        oLote?.esquina_equipamiento
                                                    }}
                                                </p>
                                                <p>
                                                    <strong
                                                        >Avenida
                                                        estructurante:</strong
                                                    >
                                                    {{ oLote?.avenida_estr }}
                                                </p>
                                            </div>
                                            <div class="col-md-6">
                                                <p>
                                                    <strong
                                                        >Avenida unión de dos
                                                        ciudades:</strong
                                                    >
                                                    {{ oLote?.avenida_union }}
                                                </p>
                                                <p>
                                                    <strong
                                                        >Superfice del
                                                        lote:</strong
                                                    >
                                                    {{ oLote?.superfice }}
                                                </p>
                                                <p>
                                                    <strong
                                                        >Costo al
                                                        contado:</strong
                                                    >
                                                    {{ oLote?.costo_contado }}
                                                </p>
                                                <p>
                                                    <strong
                                                        >Costo a
                                                        crédito:</strong
                                                    >
                                                    {{ oLote?.costo_credito }}
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Tipo de Pago*</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error': form.errors?.tipo_pago,
                                    }"
                                    v-model="form.tipo_pago"
                                >
                                    <option value="">- Seleccione -</option>
                                    <option
                                        v-for="item in listTipoPagos"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                                <ul
                                    v-if="form.errors?.tipo_pago"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.tipo_pago }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Sistema*</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error': form.errors?.sistema,
                                    }"
                                    v-model="form.sistema"
                                >
                                    <option value="">- Seleccione -</option>
                                    <option
                                        v-for="item in listSistemas"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                                <ul
                                    v-if="form.errors?.sistema"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.sistema }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Estudios Complementarios*</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.estudios_com,
                                    }"
                                    v-model="form.estudios_com"
                                >
                                    <option value="">- Seleccione -</option>
                                    <option
                                        v-for="item in listEstudios"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                                <ul
                                    v-if="form.errors?.estudios_com"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.estudios_com }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Minuta*</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error': form.errors?.minuta,
                                    }"
                                    v-model="form.minuta"
                                >
                                    <option value="">- Seleccione -</option>
                                    <option
                                        v-for="item in listMinuta"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                                <ul
                                    v-if="form.errors?.minuta"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.minuta }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Titulación*</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.titulacion,
                                    }"
                                    v-model="form.titulacion"
                                >
                                    <option value="">- Seleccione -</option>
                                    <option
                                        v-for="item in listTitulacion"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                                <ul
                                    v-if="form.errors?.titulacion"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.titulacion }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Estado del Cliente*</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.estado_cliente,
                                    }"
                                    v-model="form.estado_cliente"
                                >
                                    <option value="">- Seleccione -</option>
                                    <option
                                        v-for="item in listEstadoCliente"
                                        :value="item"
                                    >
                                        {{ item }}
                                    </option>
                                </select>
                                <ul
                                    v-if="form.errors?.estado_cliente"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.estado_cliente }}
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <a
                        href="javascript:;"
                        class="btn btn-white"
                        @click="cerrarDialog()"
                        ><i class="fa fa-times"></i> Cerrar</a
                    >
                    <button
                        type="button"
                        @click="enviarFormulario()"
                        class="btn btn-primary"
                    >
                        <i class="fa fa-save"></i>
                        Guardar
                    </button>
                </div>
            </div>
        </div>
    </div>
</template>
