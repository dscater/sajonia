import axios from "axios";
import { onMounted, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oPago = ref({
    id: 0,
    cliente_id: "",
    user_id: "",
    venta_lote_id: "",
    nro_cuotas: "",
    cuota: "",
    total_cuota: "",
    descripcion: "",
    fecha_pago: "",
    _method: "POST",
});

export const usePagos = () => {
    const { flash } = usePage().props;
    const getPagos = async () => {
        try {
            const response = await axios.get(route("pagos.listado"), {
                headers: { Accept: "application/json" },
            });
            return response.data.pagos;
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

    const getPagosApi = async (data) => {
        try {
            const response = await axios.get(route("pagos.paginado", data), {
                headers: { Accept: "application/json" },
            });
            return response.data.pagos;
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
    const savePago = async (data) => {
        try {
            const response = await axios.post(route("pagos.store", data), {
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

    const deletePago = async (id) => {
        try {
            const response = await axios.delete(route("pagos.destroy", id), {
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

    const setPago = (item = null) => {
        if (item) {
            oPago.value.id = item.id;
            oPago.value.cliente_id = item.cliente_id;
            oPago.value.user_id = item.user_id;
            oPago.value.venta_lote_id = item.venta_lote_id;
            oPago.value.nro_cuotas = item.nro_cuotas;
            oPago.value.cuota = item.cuota;
            oPago.value.total_cuota = item.total_cuota;
            oPago.value.descripcion = item.descripcion;
            oPago.value._method = "PUT";
            return oPago;
        }
        return false;
    };

    const limpiarPago = () => {
        oPago.value.id = 0;
        oPago.value.cliente_id = "";
        oPago.value.user_id = "";
        oPago.value.venta_lote_id = "";
        oPago.value.nro_cuotas = "";
        oPago.value.cuota = "";
        oPago.value.total_cuota = "";
        oPago.value.descripcion = "";
        oPago.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oPago,
        getPagos,
        getPagosApi,
        savePago,
        deletePago,
        setPago,
        limpiarPago,
    };
};
