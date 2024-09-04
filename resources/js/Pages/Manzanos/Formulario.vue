<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useManzanos } from "@/composables/manzanos/useManzanos";
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

const { oManzano, limpiarManzano } = useManzanos();
const { getUrbanizacions } = useUrbanizacions();
const accion = ref(props.accion_dialog);
const dialog = ref(props.open_dialog);
const listUrbanizacions = ref([]);
let form = useForm(oManzano.value);
watch(
    () => props.open_dialog,
    async (newValue) => {
        dialog.value = newValue;
        if (dialog.value) {
            cargaListas();
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
            form = useForm(oManzano.value);
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
            ? route("manzanos.store")
            : route("manzanos.update", form.id);

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
            limpiarManzano();
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
                                <label>Seleccionar Urbanización*</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error': form.errors?.urbanizacion_id,
                                    }"
                                    v-model="form.urbanizacion_id"
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
                            <div class="col-md-6 mt-2">
                                <label>Nombre Manzano*</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.nombre,
                                    }"
                                    v-model="form.nombre"
                                />
                                <ul
                                    v-if="form.errors?.nombre"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.nombre }}
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
