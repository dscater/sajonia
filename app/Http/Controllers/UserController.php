<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;

class UserController extends Controller
{
    public static $permisos = [
        "ADMINISTRADOR" => [
            "usuarios.index",
            "usuarios.create",
            "usuarios.edit",
            "usuarios.destroy",

            "urbanizacions.index",
            "urbanizacions.create",
            "urbanizacions.edit",
            "urbanizacions.destroy",

            "manzanos.index",
            "manzanos.create",
            "manzanos.edit",
            "manzanos.destroy",

            "lotes.index",
            "lotes.create",
            "lotes.edit",
            "lotes.destroy",

            "planilla_cuotas.index",
            "planilla_cuotas.create",
            "planilla_cuotas.edit",
            "planilla_cuotas.destroy",

            "clientes.index",
            "clientes.create",
            "clientes.edit",
            "clientes.destroy",

            "venta_lotes.index",
            "venta_lotes.create",
            "venta_lotes.edit",
            "venta_lotes.destroy",

            "notificacion_users.index",
            "notificacion_users.show",

            "configuracions.index",
            "configuracions.create",
            "configuracions.edit",
            "configuracions.destroy",

            "reportes.usuarios",
        ],
        "SUPERVISOR" => [],
        "CLIENTE" => [],
        "AGENTE INMOBILIARIO" => [],
    ];

    public static function getPermisosUser()
    {
        $array_permisos = self::$permisos;
        if ($array_permisos[Auth::user()->tipo]) {
            return $array_permisos[Auth::user()->tipo];
        }
        return [];
    }


    public static function verificaPermiso($permiso)
    {
        if (in_array($permiso, self::$permisos[Auth::user()->tipo])) {
            return true;
        }
        return false;
    }

    public function permisos(Request $request)
    {
        return response()->JSON([
            "permisos" => $this->permisos[Auth::user()->tipo]
        ]);
    }

    public function getUser()
    {
        return response()->JSON([
            "user" => Auth::user()
        ]);
    }

    public static function getInfoBoxUser()
    {
        $tipo = Auth::user()->tipo;
        $array_infos = [];
        return $array_infos;
    }
}
