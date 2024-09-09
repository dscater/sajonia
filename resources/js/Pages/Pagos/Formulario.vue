<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { usePagos } from "@/composables/pagos/usePagos";
import { useClientes } from "@/composables/clientes/useClientes";
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

const { oPago, limpiarPago } = usePagos();
const { getClientes } = useClientes();
const accion = ref(props.accion_dialog);
const dialog = ref(props.open_dialog);
const listClientes = ref([]);
const listVentaLotes = ref([]);

const getVentaLotes = (e) => {
    form.venta_lote_id = "";
    listVentaLotes.value = [];
    if (form.cliente_id != "") {
        axios
            .get(route("venta_lotes.byCliente"), {
                params: {
                    id: form.cliente_id,
                    sin_pagar: true,
                },
            })
            .then((response) => {
                listVentaLotes.value = response.data.data;
            });
    }
};

const correcto = ref(true);

const getCuota = (e) => {
    form.cuota = "";
    if (form.venta_lote_id != "") {
        axios
            .get(route("venta_lotes.getCuota"), {
                params: {
                    id: form.venta_lote_id,
                },
            })
            .then((response) => {
                form.cuota = response.data.cuota;
                correcto.value = response.data.correcto;
            });
    }
};

const calculaTotal = () => {
    form.total_cuota = 0;
    if (form.cuota && form.nro_cuotas) {
        form.total_cuota = parseFloat(form.cuota) * parseFloat(form.nro_cuotas);
        form.total_cuota = form.total_cuota.toFixed(2);
    }
};

let form = useForm(oPago.value);
watch(
    () => props.open_dialog,
    async (newValue) => {
        dialog.value = newValue;
        if (dialog.value) {
            cargaListas();
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
            form = useForm(oPago.value);
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
    listClientes.value = await getClientes({ sin_planilla: true });
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
            ? route("pagos.store")
            : route("pagos.update", form.id);

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
            limpiarPago();
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
                            <div class="col-md-6 mt-2">
                                <label>Seleccionar Cliente*</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.cliente_id,
                                    }"
                                    v-model="form.cliente_id"
                                    @change="getVentaLotes($event)"
                                >
                                    <option value="">- Seleccione -</option>
                                    <option
                                        v-for="item in listClientes"
                                        :value="item.id"
                                    >
                                        {{ item.user.nombre }}
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
                            <div class="col-md-6 mt-2">
                                <label>Seleccionar Venta de Lote*</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.venta_lote_id,
                                    }"
                                    v-model="form.venta_lote_id"
                                    @change="getCuota($event)"
                                >
                                    <option value="">- Seleccione -</option>
                                    <option
                                        v-for="item in listVentaLotes"
                                        :value="item.id"
                                    >
                                        {{ item.urbanizacion.nombre }} -
                                        {{ item.manzano.nombre }} -
                                        {{ item.lote.nombre }}
                                    </option>
                                </select>
                                <ul
                                    v-if="form.errors?.venta_lote_id"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.venta_lote_id }}
                                    </li>
                                </ul>
                                <ul
                                    v-if="!correcto"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        El lote no tiene configurada su planilla
                                        de cuotas
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-6 mt-2">
                                <label>Cuota*</label>
                                <input
                                    type="number"
                                    step="1"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.cuota,
                                    }"
                                    v-model="form.cuota"
                                    readonly
                                    @change="calculaTotal()"
                                    @keyup="calculaTotal()"
                                />
                                <ul
                                    v-if="form.errors?.cuota"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.cuota }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-6 mt-2">
                                <label>Nro. de cuotas*</label>
                                <input
                                    type="number"
                                    step="1"
                                    class="form-control"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.nro_cuotas,
                                    }"
                                    v-model="form.nro_cuotas"
                                    @change="calculaTotal()"
                                    @keyup="calculaTotal()"
                                />
                                <ul
                                    v-if="form.errors?.nro_cuotas"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.nro_cuotas }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-6 mt-2">
                                <label>Descripción</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.descripcion,
                                    }"
                                    v-model="form.descripcion"
                                />
                                <ul
                                    v-if="form.errors?.descripcion"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.descripcion }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-6 mt-2">
                                <label>Fecha de Pago*</label>
                                <input
                                    type="date"
                                    class="form-control"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.fecha_pago,
                                    }"
                                    v-model="form.fecha_pago"
                                />
                                <ul
                                    v-if="form.errors?.fecha_pago"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.fecha_pago }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-12 m-3">
                                <h4 class="w-100 text-center">
                                    Total: {{ form.total_cuota }}
                                </h4>
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
