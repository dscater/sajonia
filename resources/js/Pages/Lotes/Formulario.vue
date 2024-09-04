<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useLotes } from "@/composables/lotes/useLotes";
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

const { oLote, limpiarLote } = useLotes();
const { getUrbanizacions } = useUrbanizacions();
const accion = ref(props.accion_dialog);
const dialog = ref(props.open_dialog);
const listUrbanizacions = ref([]);
const listManzanos = ref([]);
let form = useForm(oLote.value);
watch(
    () => props.open_dialog,
    async (newValue) => {
        dialog.value = newValue;
        if (dialog.value) {
            cargaListas();
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
            form = useForm(oLote.value);
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

const { flash } = usePage().props;

const tituloDialog = computed(() => {
    return accion.value == 0
        ? `<i class="fa fa-plus"></i>Agregar Registro`
        : `<i class="fa fa-edit"></i>Editar Registro`;
});

const enviarFormulario = () => {
    let url =
        form["_method"] == "POST"
            ? route("lotes.store")
            : route("lotes.update", form.id);

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
            limpiarLote();
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
                                <label>Nombre Lote*</label>
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
                        </div>

                        <div class="row mt-3">
                            <div class="col-12">
                                <h4>UBICACIÓN</h4>
                            </div>
                            <div class="col-md-4">
                                <label>Calle*</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.ubicacion,
                                    }"
                                    v-model="form.ubicacion"
                                >
                                    <option value="">- Seleccione -</option>
                                    <option value="PARTE ESPECIAL">PARTE ESPECIAL</option>
                                    <option value="PARTE MEDIA">PARTE MEDIA</option>
                                    <option value="PARTE BAJA">PARTE BAJA</option>
                                </select>
                                <ul
                                    v-if="form.errors?.ubicacion"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.ubicacion }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Esquina*</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.esquina,
                                    }"
                                    v-model="form.esquina"
                                >
                                    <option value="">- Seleccione -</option>
                                    <option value="PARTE ESPECIAL">PARTE ESPECIAL</option>
                                    <option value="PARTE MEDIA">PARTE MEDIA</option>
                                    <option value="PARTE BAJA">PARTE BAJA</option>
                                </select>
                                <ul
                                    v-if="form.errors?.esquina"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.esquina }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Esquina Área Verde*</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.esquina_area,
                                    }"
                                    v-model="form.esquina_area"
                                >
                                    <option value="">- Seleccione -</option>
                                    <option value="FRENTE ÁREA VERDE">FRENTE ÁREA VERDE</option>
                                    <option value="NINGUNO">NINGUNO</option>
                                </select>
                                <ul
                                    v-if="form.errors?.esquina_area"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.esquina_area }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Esquina Área de Equipamiento*</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.esquina_equipamiento,
                                    }"
                                    v-model="form.esquina_equipamiento"
                                >
                                    <option value="">- Seleccione -</option>
                                    <option value="FRENTE ÁREA DE EQUIPAMIENTO">FRENTE ÁREA DE EQUIPAMIENTO</option>
                                    <option value="NINGUNO">NINGUNO</option>
                                </select>
                                <ul
                                    v-if="form.errors?.esquina_equipamiento"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.esquina_equipamiento }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Avenida Estructurante*</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.avenida_estr,
                                    }"
                                    v-model="form.avenida_estr"
                                >
                                    <option value="">- Seleccione -</option>
                                    <option value="ESQUINA AVENIDA ESTRUCTURANTE">ESQUINA AVENIDA ESTRUCTURANTE</option>
                                    <option value="NINGUNO">NINGUNO</option>
                                </select>
                                <ul
                                    v-if="form.errors?.avenida_estr"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.avenida_estr }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Avenida Unión de Dos Ciudades*</label>
                                <select
                                    class="form-select"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.avenida_union,
                                    }"
                                    v-model="form.avenida_union"
                                >
                                    <option value="">- Seleccione -</option>
                                    <option value="ESQUINA AVENIDA UNIÓN DE DOS CIUDADES">ESQUINA AVENIDA UNIÓN DE DOS CIUDADES</option>
                                    <option value="NINGUNO">NINGUNO</option>
                                </select>
                                <ul
                                    v-if="form.errors?.avenida_union"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.avenida_union }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Superficie Lote*</label>
                                <input
                                    type="text"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.superficie,
                                    }"
                                    v-model="form.superficie"
                                />
                                <ul
                                    v-if="form.errors?.superficie"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.superficie }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Costo al contado*</label>
                                <input
                                    type="number"
                                    step="0.01"
                                    class="form-control"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.costo_contado,
                                    }"
                                    v-model="form.costo_contado"
                                />
                                <ul
                                    v-if="form.errors?.costo_contado"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.costo_contado }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-4 mt-2">
                                <label>Costo a crédito*</label>
                                <input
                                    type="number"
                                    step="0.01"
                                    class="form-control"
                                    :class="{
                                        'parsley-error':
                                            form.errors?.costo_credito,
                                    }"
                                    v-model="form.costo_credito"
                                />
                                <ul
                                    v-if="form.errors?.costo_credito"
                                    class="parsley-errors-list filled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.costo_credito }}
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
