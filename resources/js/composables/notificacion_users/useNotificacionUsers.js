import axios from "axios";
import { onMounted, ref } from "vue";
import { usePage } from "@inertiajs/vue3";

const oNotificacionUser = ref({
    id: 0,
    notificacion_id: "",
    user_id: "",
    visto: 0,
    notificacion: null,
    _method: "POST",
});

export const useNotificacionUsers = () => {
    const { flash } = usePage().props;
    const getNotificacionUsers = async () => {
        try {
            const response = await axios.get(
                route("notificacion_users.listado"),
                {
                    headers: { Accept: "application/json" },
                }
            );
            return response.data.notificacion_users;
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

    const getNotificacionUsersApi = async (data) => {
        try {
            const response = await axios.get(
                route("notificacion_users.paginado", data),
                {
                    headers: { Accept: "application/json" },
                }
            );
            return response.data.notificacion_users;
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
    const saveNotificacionUser = async (data) => {
        try {
            const response = await axios.post(
                route("notificacion_users.store", data),
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

    const deleteNotificacionUser = async (id) => {
        try {
            const response = await axios.delete(
                route("notificacion_users.destroy", id),
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

    const setNotificacionUser = (item = null) => {
        if (item) {
            oNotificacionUser.value.id = item.id;
            oNotificacionUser.value.notificacion_id = item.notificacion_id;
            oNotificacionUser.value.user_id = item.user_id;
            oNotificacionUser.value.visto = item.visto;
            oNotificacionUser.value.notificacion = item.notificacion;
            oNotificacionUser.value._method = "PUT";
            return oNotificacionUser;
        }
        return false;
    };

    const limpiarNotificacionUser = () => {
        oNotificacionUser.value.id = 0;
        oNotificacionUser.value.notificacion_id = "";
        oNotificacionUser.value.user_id = "";
        oNotificacionUser.value.visto = 0;
        oNotificacionUser.value.notificacion = null;
        oNotificacionUser.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oNotificacionUser,
        getNotificacionUsers,
        getNotificacionUsersApi,
        saveNotificacionUser,
        deleteNotificacionUser,
        setNotificacionUser,
        limpiarNotificacionUser,
    };
};
