import axios from "axios";
import { onMounted, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oVentaLote = ref({
    id: 0,
    user_id: "",
    cliente_id: "",
    urbanizacion_id: "",
    manzano_id: "",
    lote_id: "",
    fecha_formalizacion: "",
    total_venta: "",
    estado_pago: "",
    tipo_pago: "",
    sistema: "",
    estudios_com: "",
    minuta: "",
    titulacion: "",
    estado_cliente: "",
    _method: "POST",
});

export const useVentaLotes = () => {
    const { flash } = usePage().props;
    const getVentaLotes = async (data) => {
        try {
            const response = await axios.get(route("venta_lotes.listado"), {
                headers: { Accept: "application/json" },
                params: data,
            });
            return response.data.venta_lotes;
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

    const getVentaLotesApi = async (data) => {
        try {
            const response = await axios.get(
                route("venta_lotes.paginado", data),
                {
                    headers: { Accept: "application/json" },
                }
            );
            return response.data.venta_lotes;
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
    const saveVentaLote = async (data) => {
        try {
            const response = await axios.post(
                route("venta_lotes.store", data),
                {
                    headers: { Accept: "application/json" },
                }
            );
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

    const deleteVentaLote = async (id) => {
        try {
            const response = await axios.delete(
                route("venta_lotes.destroy", id),
                {
                    headers: { Accept: "application/json" },
                }
            );
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

    const setVentaLote = (item = null) => {
        if (item) {
            oVentaLote.value.id = item.id;
            oVentaLote.value.user_id = item.user_id;
            oVentaLote.value.cliente_id = item.cliente_id;
            oVentaLote.value.urbanizacion_id = item.urbanizacion_id;
            oVentaLote.value.manzano_id = item.manzano_id;
            oVentaLote.value.lote_id = item.lote_id;
            oVentaLote.value.fecha_formalizacion = item.fecha_formalizacion;
            oVentaLote.value.total_venta = item.total_venta;
            oVentaLote.value.estado_pago = item.estado_pago;
            oVentaLote.value.tipo_pago = item.tipo_pago;
            oVentaLote.value.sistema = item.sistema;
            oVentaLote.value.estudios_com = item.estudios_com;
            oVentaLote.value.minuta = item.minuta;
            oVentaLote.value.titulacion = item.titulacion;
            oVentaLote.value.estado_cliente = item.estado_cliente;
            oVentaLote.value._method = "PUT";
            return oVentaLote;
        }
        return false;
    };

    const limpiarVentaLote = () => {
        oVentaLote.value.id = 0;
        oVentaLote.value.user_id = "";
        oVentaLote.value.cliente_id = "";
        oVentaLote.value.urbanizacion_id = "";
        oVentaLote.value.manzano_id = "";
        oVentaLote.value.lote_id = "";
        oVentaLote.value.fecha_formalizacion = "";
        oVentaLote.value.total_venta = "";
        oVentaLote.value.estado_pago = "";
        oVentaLote.value.tipo_pago = "";
        oVentaLote.value.sistema = "";
        oVentaLote.value.estudios_com = "";
        oVentaLote.value.minuta = "";
        oVentaLote.value.titulacion = "";
        oVentaLote.value.estado_cliente = "";
        oVentaLote.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oVentaLote,
        getVentaLotes,
        getVentaLotesApi,
        saveVentaLote,
        deleteVentaLote,
        setVentaLote,
        limpiarVentaLote,
    };
};
