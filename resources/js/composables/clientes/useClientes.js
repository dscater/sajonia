import axios from "axios";
import { onMounted, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oCliente = ref({
    id: 0,
    cliente_id: "",
    nombre: "",
    paterno: "",
    materno: "",
    ci: "",
    ci_exp: "",
    fono: "",
    acceso: 0 + "",
    estado_cliente: "",
    _method: "POST",
});

export const useClientes = () => {
    const { flash } = usePage().props;
    const getClientes = async () => {
        try {
            const response = await axios.get(route("clientes.listado"), {
                headers: { Accept: "application/json" },
            });
            return response.data.clientes;
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

    const getClientesByTipo = async (data) => {
        try {
            const response = await axios.get(route("clientes.byTipo"), {
                headers: { Accept: "application/json" },
                params: data,
            });
            return response.data.clientes;
        } catch (error) {
            console.error("Error:", error);
            throw error; // Puedes manejar el error según tus necesidades
        }
    };

    const getClientesApi = async (data) => {
        try {
            const response = await axios.get(route("clientes.paginado", data), {
                headers: { Accept: "application/json" },
            });
            return response.data.clientes;
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
    const saveCliente = async (data) => {
        try {
            const response = await axios.post(route("clientes.store", data), {
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

    const deleteCliente = async (id) => {
        try {
            const response = await axios.delete(route("clientes.destroy", id), {
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

    const setCliente = (item = null) => {
        if (item) {
            oCliente.value.id = item.id;
            oCliente.value.cliente_id = item.cliente_id;
            oCliente.value.nombre = item.nombre;
            oCliente.value.paterno = item.paterno;
            oCliente.value.materno = item.materno;
            oCliente.value.ci = item.ci;
            oCliente.value.ci_exp = item.ci_exp;
            oCliente.value.fono = item.fono;
            oCliente.value.acceso = item.acceso;
            oCliente.value.estado_cliente = item.estado_cliente;
            oCliente.value._method = "PUT";
            return oCliente;
        }
        return false;
    };

    const limpiarCliente = () => {
        oCliente.value.id = 0;
        oCliente.value.cliente_id = "";
        oCliente.value.nombre = "";
        oCliente.value.paterno = "";
        oCliente.value.materno = "";
        oCliente.value.ci = "";
        oCliente.value.ci_exp = "";
        oCliente.value.fono = "";
        oCliente.value.estado_cliente = "";
        (oCliente.value.acceso = 0 + ""), (oCliente.value._method = "POST");
    };

    onMounted(() => {});

    return {
        oCliente,
        getClientes,
        getClientesApi,
        saveCliente,
        deleteCliente,
        setCliente,
        limpiarCliente,
        getClientesByTipo,
    };
};
