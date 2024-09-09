<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class AgenteInteligenteController extends Controller
{
    public function generarNotificaciones($inscripciones)
    {
        // Array para almacenar las notificaciones
        $notificaciones = array();

        // Generar notificaciones para cada tipo de registro
        $notificiones = $this->detectarEventos();

        if (!empty($notificiones)) {
            foreach ($notificiones as $notificacion) {
                // inicializar la notificacion
                $notificacion_generada = Notificacion::create([
                    "tipo_notificacion" => $notificacion->tipo_notificacion,
                    "descripcion" => $notificacion->descripcion,
                    "registro_id" => $notificacion->id,
                    "fecha" => $notificacion->fecha,
                    "hora" => $notificacion->hora,
                ]);

                $notificacion = $this->generarNotificacion($notificacion_generada);
                if ($notificacion) {
                    $notificaciones[] = $notificacion;
                }
            }
        }
        return $notificaciones;
    }

    // Obtener eventos/notificiones
    private function detectarEventos()
    {
        // segun la fecha actual
        $fecha_actual = date("Y-m-d");


        $notificaciones = [];

        // buscar en las planillas
        $fecha_pago = date("Y-m-d", strtotime($fecha_actual . '+5 days'));
        // pagos proximos
        $venta_planillas = VentaPlanilla::where("estado", 0)->where("fecha_pago", $fecha_pago)->get();
        if (count($venta_planillas) > 0) {

            foreach ($venta_planillas as $item) {
                $notificaciones[] = [
                    "tipo_notificacion" => "PAGO CUOTA",
                    "descripcion" => "LE COMUNICAMOS QUE DEBE PAGAR SU CUOTA RESPECTIVA YA QUE ESTÁ A PUNTO DE TERMINAR EL MES",
                    "fecha" => $fecha_actual,
                    "hora" => date("H:i:s"),
                    "registro_id" => $item->id
                ];
            }
        }

        // pagos sin realizar
        $venta_planillas = VentaPlanilla::where("estado", 0)->where("fecha_pago", "<", $fecha_actual)->get();
        if (count($venta_planillas) > 0) {
            foreach ($venta_planillas as $item) {
                $notificaciones[] = [
                    "tipo_notificacion" => "PAGO SIN REALIZAR",
                    "descripcion" => "SE NOTIFICA QUE EL CLIENTE " . $item->cliente->user->full_name . " CON C.I. " . $item->cliente->user->full_ci . " NO PAGO SU CUOTA RESPECTIVA DEL MES " . $array_meses[date("m", strtotime($item->fecha_pago))],
                    "fecha" => $fecha_actual,
                    "hora" => date("H:i:s"),
                    "registro_id" => $item->id
                ];
            }
        }

        // exedio 90 dias
        $fecha_anterior = date("Y-m-d", strtotime($fecha_actual . '-90 days'));
        $venta_planillas = VentaPlanilla::where("estado", 0)->where("fecha_pago", "<=", $fecha_anterior)->get();
        if (count($venta_planillas) > 0) {
            foreach ($venta_planillas as $item) {
                $notificaciones[] = [
                    "tipo_notificacion" => "PAGO SIN REALIZAR 90",
                    "descripcion" => "SE NOTIFICA QUE EL CLIENTE " . $item->cliente->user->full_name . " CON C.I. " . $item->cliente->user->full_ci . " EXCEDIÓ LOS 90 DÍAS SIN PAGAR LA CUOTA RESPECTIVA DE SU LOTE DE TERRENO",
                    "fecha" => $fecha_actual,
                    "hora" => date("H:i:s"),
                    "registro_id" => $item->id
                ];
            }
        }

        // meses de dispensa
        $clientes = Cliente::where("fechan", $fecha_actual)->get();
        if (count($clientes) > 0) {
            foreach ($clientes as $item) {
                $notificaciones[] = [
                    "tipo_notificacion" => "DISPENSA",
                    "descripcion" => "SE NOTIFICA QUE EL CLIENTE " . $item->user->full_name . " CON C.I. " . $item->user->full_ci . " YA CUMPLIÓ LOS 6 MESES DE DISPENSA",
                    "fecha" => $fecha_actual,
                    "hora" => date("H:i:s"),
                    "registro_id" => $item->id
                ];
            }
        }

        return $notificaciones;
    }

    // Generar una notificación para un evento dado
    private function generarNotificacion($notificacion)
    {
        // obtener los usuarios que recibiran la notificación
        $usuarios = User::whereIn("tipo")->get();
        foreach ($usuarios as $item) {
            $notificacion->notificacion_users()->create([
                "user_id" => $item->id,
                "visto" => 0,
            ]);
        }
        return $notificacion;
    }
}
