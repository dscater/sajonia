import axios from "axios";
import { onMounted, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oLote = ref({
    id: 0,
    urbanizacion_id: null,
    manzano_id: null,
    nombre: "",
    ubicacion: "",
    esquina: "",
    esquina_area: "",
    esquina_equipamiento: "",
    avenida_estr: "",
    avenida_union: "",
    superficie: "",
    costo_contado: "",
    costo_credito: "",
    _method: "POST",
});

export const useLotes = () => {
    const { flash } = usePage().props;
    const getLotes = async () => {
        try {
            const response = await axios.get(route("lotes.listado"), {
                headers: { Accept: "application/json" },
            });
            return response.data.lotes;
        } catch (err) {
            Swal.fire({
                icon: "error",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.response?.data
                        ? err.response?.data?.message
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            throw err; // Puedes manejar el error según tus necesidades
        }
    };

    const getLotesApi = async (data) => {
        try {
            const response = await axios.get(route("lotes.paginado", data), {
                headers: { Accept: "application/json" },
            });
            return response.data.lotes;
        } catch (err) {
            Swal.fire({
                icon: "error",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.response?.data
                        ? err.response?.data?.message
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            throw err; // Puedes manejar el error según tus necesidades
        }
    };
    const saveLote = async (data) => {
        try {
            const response = await axios.post(route("lotes.store", data), {
                headers: { Accept: "application/json" },
            });
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${flash.bien ? flash.bien : "Proceso realizado"}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            return response.data;
        } catch (err) {
            Swal.fire({
                icon: "error",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.response?.data
                        ? err.response?.data?.message
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            throw err; // Puedes manejar el error según tus necesidades
        }
    };

    const deleteLote = async (id) => {
        try {
            const response = await axios.delete(route("lotes.destroy", id), {
                headers: { Accept: "application/json" },
            });
            Swal.fire({
                icon: "success",
                title: "Correcto",
                text: `${flash.bien ? flash.bien : "Proceso realizado"}`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            return response.data;
        } catch (err) {
            Swal.fire({
                icon: "error",
                title: "Error",
                text: `${
                    flash.error
                        ? flash.error
                        : err.response?.data
                        ? err.response?.data?.message
                        : "Hay errores en el formulario"
                }`,
                confirmButtonColor: "#3085d6",
                confirmButtonText: `Aceptar`,
            });
            throw err; // Puedes manejar el error según tus necesidades
        }
    };

    const setLote = (item = null) => {
        if (item) {
            oLote.value.id = item.id;
            oLote.value.urbanizacion_id = item.urbanizacion_id;
            oLote.value.manzano_id = item.manzano_id;
            oLote.value.nombre = item.nombre;
            oLote.value.ubicacion = item.ubicacion;
            oLote.value.esquina = item.esquina;
            oLote.value.esquina_area = item.esquina_area;
            oLote.value.esquina_equipamiento = item.esquina_equipamiento;
            oLote.value.avenida_estr = item.avenida_estr;
            oLote.value.avenida_union = item.avenida_union;
            oLote.value.superficie = item.superficie;
            oLote.value.costo_contado = item.costo_contado;
            oLote.value.costo_credito = item.costo_credito;
            oLote.value._method = "PUT";
            return oLote;
        }
        return false;
    };

    const limpiarLote = () => {
        oLote.value.id = 0;
        oLote.value.urbanizacion_id = null;
        oLote.value.manzano_id = null;
        oLote.value.nombre = "";
        oLote.value.ubicacion = "";
        oLote.value.esquina = "";
        oLote.value.esquina_area = "";
        oLote.value.esquina_equipamiento = "";
        oLote.value.avenida_estr = "";
        oLote.value.avenida_union = "";
        oLote.value.superficie = "";
        oLote.value.costo_contado = "";
        oLote.value.costo_credito = "";
        oLote.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oLote,
        getLotes,
        getLotesApi,
        saveLote,
        deleteLote,
        setLote,
        limpiarLote,
    };
};
