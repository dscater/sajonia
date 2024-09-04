import axios from "axios";
import { onMounted, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oManzano = ref({
    id: 0,
    urbanizacion_id: null,
    nombre: "",
    descripcion: "",
    _method: "POST",
});

export const useManzanos = () => {
    const { flash } = usePage().props;
    const getManzanos = async () => {
        try {
            const response = await axios.get(route("manzanos.listado"), {
                headers: { Accept: "application/json" },
            });
            return response.data.manzanos;
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

    const getManzanosApi = async (data) => {
        try {
            const response = await axios.get(route("manzanos.paginado", data), {
                headers: { Accept: "application/json" },
            });
            return response.data.manzanos;
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
    const saveManzano = async (data) => {
        try {
            const response = await axios.post(route("manzanos.store", data), {
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

    const deleteManzano = async (id) => {
        try {
            const response = await axios.delete(route("manzanos.destroy", id), {
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

    const setManzano = (item = null) => {
        if (item) {
            oManzano.value.id = item.id;
            oManzano.value.urbanizacion_id = item.urbanizacion_id;
            oManzano.value.nombre = item.nombre;
            oManzano.value.descripcion = item.descripcion;
            oManzano.value._method = "PUT";
            return oManzano;
        }
        return false;
    };

    const limpiarManzano = () => {
        oManzano.value.id = 0;
        oManzano.value.urbanizacion_id = null;
        oManzano.value.nombre = "";
        oManzano.value.descripcion = "";
        oManzano.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oManzano,
        getManzanos,
        getManzanosApi,
        saveManzano,
        deleteManzano,
        setManzano,
        limpiarManzano,
    };
};
