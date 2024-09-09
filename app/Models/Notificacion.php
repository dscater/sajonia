<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Notificacion extends Model
{
    use HasFactory;

    protected $fillable = [
        "tipo_notificacion",
        "descripcion",
        "fecha",
        "hora",
        "registro_id",
    ];

    protected $appends = ["fecha_t", "fecha_hora_t", "hace"];

    public function getFechaTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha));
    }

    public function getFechaHoraTAttribute()
    {
        return date("d/m/Y H:i", strtotime($this->fecha . ' ' . $this->hora));
    }

    public function getHaceAttribute()
    {
        $tiempo = $this->created_at->diffForHumans();
        return $tiempo;
    }


    public static function notificacion1()
    {
        $fecha_actual = date("Y-m-d");

        $fecha_pago = date("Y-m-d", strtotime($fecha_actual . '+5 days'));
        $venta_planillas = VentaPlanilla::where("estado", 0)->where("fecha_pago", $fecha_pago)->get();

        if (count($venta_planillas) > 0) {
            $notificacion = Notificacion::where("tipo_notificacion", "PAGO CUOTA")->where("fecha", $fecha_actual)->get()->first();
            if (!$notificacion) {
                $notificacion = Notificacion::create([
                    "tipo_notificacion" => "PAGO CUOTA",
                    "descripcion" => "LE COMUNICAMOS QUE DEBE PAGAR SU CUOTA RESPECTIVA YA QUE ESTÁ A PUNTO DE TERMINAR EL MES",
                    "fecha" => $fecha_actual,
                    "hora" => date("H:i:s")
                ]);
            }

            foreach ($venta_planillas as $item) {
                $user = $item->cliente->user;
                $notificacion_user = NotificacionUser::where("user_id", $user->id)
                    ->where("notificacion_id", $notificacion->id)->get()->first();
                if (!$notificacion_user) {
                    NotificacionUser::create([
                        "notificacion_id" => $notificacion->id,
                        "user_id" => $user->id,
                    ]);
                }
            }
        }
        return true;
    }

    public static function notificacion2()
    {
        $fecha_actual = date("Y-m-d");
        $array_meses = [
            "01" => "ENERO",
            "02" => "FEBRERO",
            "03" => "MARZO",
            "04" => "ABRIL",
            "05" => "MAYO",
            "06" => "JUNIO",
            "07" => "JULIO",
            "08" => "AGOSTO",
            "09" => "SEPTIEMBRE",
            "10" => "OCTUBRE",
            "11" => "NOVIEMBRE",
            "12" => "DICIEMBRE",
        ];

        $venta_planillas = VentaPlanilla::where("estado", 0)->where("fecha_pago", "<", $fecha_actual)->get();

        $users = User::whereIn("tipo", ["ADMINISTRADOR", "SUPERVISOR", "AGENTE INMOBILIARIO"])->get();

        if (count($venta_planillas) > 0) {
            foreach ($venta_planillas as $item) {
                $notificacion = Notificacion::where("tipo_notificacion", "PAGO SIN REALIZAR")
                    ->where("fecha", $fecha_actual)
                    ->where("registro_id", $item->id)
                    ->get()->first();
                if (!$notificacion) {
                    $notificacion = Notificacion::create([
                        "tipo_notificacion" => "PAGO SIN REALIZAR",
                        "descripcion" => "SE NOTIFICA QUE EL CLIENTE " . $item->cliente->user->full_name . " CON C.I. " . $item->cliente->user->full_ci . " NO PAGO SU CUOTA RESPECTIVA DEL MES " . $array_meses[date("m", strtotime($item->fecha_pago))],
                        "fecha" => $fecha_actual,
                        "hora" => date("H:i:s"),
                        "registro_id" => $item->id
                    ]);
                }

                // usuarios
                foreach ($users as $value) {
                    $notificacion_user = NotificacionUser::where("user_id", $value->id)
                        ->where("notificacion_id", $notificacion->id)->get()->first();
                    if (!$notificacion_user) {
                        NotificacionUser::create([
                            "notificacion_id" => $notificacion->id,
                            "user_id" => $value->id
                        ]);
                    }
                }

                // cliente
                $user = $item->cliente->user;
                $notificacion_user = NotificacionUser::where("user_id", $user->id)
                    ->where("notificacion_id", $notificacion->id)->get()->first();
                if (!$notificacion_user) {
                    NotificacionUser::create([
                        "notificacion_id" => $notificacion->id,
                        "user_id" => $user->id,
                    ]);
                }
            }
        }
        return true;
    }

    public static function notificacion3()
    {
        $fecha_actual = date("Y-m-d");
        $fecha_anterior = date("Y-m-d", strtotime($fecha_actual . '-90 days'));
        $venta_planillas = VentaPlanilla::where("estado", 0)->where("fecha_pago", "<=", $fecha_anterior)->get();

        $users = User::whereIn("tipo", ["ADMINISTRADOR", "SUPERVISOR", "AGENTE INMOBILIARIO"])->get();

        if (count($venta_planillas) > 0) {
            foreach ($venta_planillas as $item) {
                $notificacion = Notificacion::where("tipo_notificacion", "PAGO SIN REALIZAR")
                    ->where("fecha", $fecha_actual)
                    ->where("registro_id", $item->id)
                    ->get()->first();
                if (!$notificacion) {
                    $notificacion = Notificacion::create([
                        "tipo_notificacion" => "PAGO SIN REALIZAR 90",
                        "descripcion" => "SE NOTIFICA QUE EL CLIENTE " . $item->cliente->user->full_name . " CON C.I. " . $item->cliente->user->full_ci . " EXCEDIÓ LOS 90 DÍAS SIN PAGAR LA CUOTA RESPECTIVA DE SU LOTE DE TERRENO",
                        "fecha" => $fecha_actual,
                        "hora" => date("H:i:s"),
                        "registro_id" => $item->id
                    ]);
                }

                // usuarios
                foreach ($users as $value) {
                    $notificacion_user = NotificacionUser::where("user_id", $value->id)
                        ->where("notificacion_id", $notificacion->id)->get()->first();
                    if (!$notificacion_user) {
                        NotificacionUser::create([
                            "notificacion_id" => $notificacion->id,
                            "user_id" => $value->id
                        ]);
                    }
                }

                // cliente
                $user = $item->cliente->user;
                $notificacion_user = NotificacionUser::where("user_id", $user->id)
                    ->where("notificacion_id", $notificacion->id)->get()->first();
                if (!$notificacion_user) {
                    NotificacionUser::create([
                        "notificacion_id" => $notificacion->id,
                        "user_id" => $user->id,
                    ]);
                }
            }
        }
        return true;
    }

    public static function notificacion4()
    {
        $fecha_actual = date("Y-m-d");
        $clientes = Cliente::where("fechan", $fecha_actual)->get();

        if (count($clientes) > 0) {
            $users = User::whereIn("tipo", ["ADMINISTRADOR", "SUPERVISOR", "AGENTE INMOBILIARIO"])->get();

            foreach ($clientes as $item) {
                $notificacion = Notificacion::where("tipo_notificacion", "DISPENSA")
                    ->where("fecha", $fecha_actual)
                    ->where("registro_id", $item->id)
                    ->get()->first();
                if (!$notificacion) {
                    $notificacion = Notificacion::create([
                        "registro_id" => $item->id,
                        "tipo_notificacion" => "DISPENSA",
                        "descripcion" => "SE NOTIFICA QUE EL CLIENTE " . $item->user->full_name . " CON C.I. " . $item->user->full_ci . " YA CUMPLIÓ LOS 6 MESES DE DISPENSA",
                        "fecha" => $fecha_actual,
                        "hora" => date("H:i:s")
                    ]);
                }
                // usuarios
                foreach ($users as $value) {
                    $notificacion_user = NotificacionUser::where("user_id", $value->id)
                        ->where("notificacion_id", $notificacion->id)->get()->first();
                    if (!$notificacion_user) {
                        NotificacionUser::create([
                            "notificacion_id" => $notificacion->id,
                            "user_id" => $value->id
                        ]);
                    }
                }

                // cliente
                $user = $item->cliente->user;
                $notificacion_user = NotificacionUser::where("user_id", $user->id)
                    ->where("notificacion_id", $notificacion->id)->get()->first();
                if (!$notificacion_user) {
                    NotificacionUser::create([
                        "notificacion_id" => $notificacion->id,
                        "user_id" => $user->id,
                    ]);
                }
            }
        }
        return true;
    }
}
