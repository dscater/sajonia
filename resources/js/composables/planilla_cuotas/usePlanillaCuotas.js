import axios from "axios";
import { onMounted, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oPlanillaCuota = ref({
    id: 0,
    lote_id: "",
    plazo: "",
    descripcion: "",
    _method: "POST",
});

export const usePlanillaCuotas = () => {
    const { flash } = usePage().props;
    const getPlanillaCuotas = async () => {
        try {
            const response = await axios.get(route("planilla_cuotas.listado"), {
                headers: { Accept: "application/json" },
            });
            return response.data.planilla_cuotas;
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

    const getPlanillaCuotasApi = async (data) => {
        try {
            const response = await axios.get(
                route("planilla_cuotas.paginado", data),
                {
                    headers: { Accept: "application/json" },
                }
            );
            return response.data.planilla_cuotas;
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
    const savePlanillaCuota = async (data) => {
        try {
            const response = await axios.post(
                route("planilla_cuotas.store", data),
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

    const deletePlanillaCuota = async (id) => {
        try {
            const response = await axios.delete(
                route("planilla_cuotas.destroy", id),
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

    const setPlanillaCuota = (item = null) => {
        if (item) {
            oPlanillaCuota.value.id = item.id;
            oPlanillaCuota.value.lote_id = item.lote_id;
            oPlanillaCuota.value.plazo = item.plazo;
            oPlanillaCuota.value.descripcion = item.descripcion;
            oPlanillaCuota.value._method = "PUT";
            return oPlanillaCuota;
        }
        return false;
    };

    const limpiarPlanillaCuota = () => {
        oPlanillaCuota.value.id = 0;
        oPlanillaCuota.value.lote_id = "";
        oPlanillaCuota.value.plazo = "";
        oPlanillaCuota.value.descripcion = "";
        oPlanillaCuota.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oPlanillaCuota,
        getPlanillaCuotas,
        getPlanillaCuotasApi,
        savePlanillaCuota,
        deletePlanillaCuota,
        setPlanillaCuota,
        limpiarPlanillaCuota,
    };
};
