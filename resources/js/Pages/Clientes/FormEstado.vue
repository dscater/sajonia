<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useClientes } from "@/composables/clientes/useClientes";
import { watch, ref, computed, defineEmits } from "vue";
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

const { oCliente, limpiarCliente } = useClientes();
const accion = ref(props.accion_dialog);
const dialog = ref(props.open_dialog);
const listEstadoCliente = ref([
    "ACTIVO",
    "VENCIMIENTO",
    "DISPENSA",
    "DEVOLUCIÓN",
    "EXCLUSIÓN",
]);
let form = useForm({
    estado_cliente: "",
});
watch(
    () => props.open_dialog,
    (newValue) => {
        dialog.value = newValue;
        form.estado_cliente = oCliente.value.estado_cliente;
        document.getElementsByTagName("body")[0].classList.add("modal-open");
    }
);
watch(
    () => props.accion_dialog,
    (newValue) => {
        accion.value = newValue;
    }
);

const { flash } = usePage().props;

const tituloDialog = computed(() => {
    return accion.value == 0
        ? `Agregar Cliente`
        : `Actualizar Estado de Cliente`;
});

const enviarFormulario = () => {
    let url = route("clientes.update_estado", oCliente.value.cliente_id);

    form.put(url, {
        preserveScroll: true,
        onSuccess: () => {
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${flash.bien ? flash.bien : "Proceso realizado"}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            form.estado = "";
            limpiarCliente();
            emits("envio-formulario");
        },
        onError: (err) => {
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
        <div class="modal-dialog">
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
                            <div class="px-4 text-center col-md-12">
                                <span class="text-body-2"
                                    >{{ oCliente.nombre }}
                                    {{ oCliente.paterno }}
                                    {{ oCliente.materno }}</span
                                >
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-12">
                                <label>Seleccionar estado:</label>
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
