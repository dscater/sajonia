<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\Pago;
use App\Models\VentaLote;
use App\Models\VentaPlanilla;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class VentaLoteController extends Controller
{
    public $validacion = [
        "cliente_id" => "required",
        "urbanizacion_id" => "required",
        "manzano_id" => "required",
        "lote_id" => "required",
        "fecha_formalizacion" => "required",
        "tipo_pago" => "required",
        "sistema" => "required",
        "estudios_com" => "required",
        "minuta" => "required",
        "titulacion" => "required",
    ];

    public $mensajes = [
        "cliente_id.required" => "Este campo es obligatorio",
        "urbanizacion_id.required" => "Este campo es obligatorio",
        "manzano_id.required" => "Este campo es obligatorio",
        "lote_id.required" => "Este campo es obligatorio",
        "fecha_formalizacion.required" => "Este campo es obligatorio",
        "tipo_pago.required" => "Este campo es obligatorio",
        "sistema.required" => "Este campo es obligatorio",
        "estudios_com.required" => "Este campo es obligatorio",
        "minuta.required" => "Este campo es obligatorio",
        "titulacion.required" => "Este campo es obligatorio",
    ];

    public function index()
    {
        return Inertia::render("VentaLotes/Index");
    }

    public function listado(Request $request)
    {
        $venta_lotes = VentaLote::with(["urbanizacion", "manzano"])->select("venta_lotes.*");

        if ($request->sin_planilla) {
            $venta_lotes = $venta_lotes->whereNotExists(function ($query) {
                $query->select(DB::raw(1))
                    ->from('planilla_cuotas')
                    ->whereRaw('planilla_cuotas.venta_lote_id = venta_lotes.id');
            });
        }

        $venta_lotes = $venta_lotes->get();
        return response()->JSON([
            "venta_lotes" => $venta_lotes
        ]);
    }

    public function byCliente(Request $request)
    {
        $venta_lotes = VentaLote::with(["urbanizacion", "manzano", "lote", "cliente.user"])->select("venta_lotes.*");
        if ($request->sin_pagar) {
            $venta_lotes->where("estado_pago", "PENDIENTE");
        }
        $venta_lotes->where("cliente_id", $request->id);
        $venta_lotes = $venta_lotes->get();
        return response()->JSON([
            "data" => $venta_lotes
        ]);
    }

    public function getCuota(Request $request)
    {
        $venta_lote = VentaLote::find($request->id);

        if ($venta_lote && count($venta_lote->venta_planillas) > 0) {

            $nro_cuotas = VentaPlanilla::where("venta_lote_id", $venta_lote->id)
                ->where("estado", 0)
                ->count();
            return response()->JSON([
                "nro_cuotas" => $nro_cuotas,
                "cuota" => $venta_lote->venta_planillas[0]->cuota,
                "correcto" => true
            ]);
        }
        return response()->JSON([
            "nro_cuotas" => 0,
            "cuota" => 0,
            "resante" => $venta_lote->restante,
            "correcto" => false
        ]);
    }

    public function api(Request $request)
    {
        // Log::debug($request);
        $venta_lotes = VentaLote::with(["urbanizacion", "manzano", "lote", "cliente.user"])->select("venta_lotes.*");
        if (Auth::user()->tipo == 'CLIENTE') {
            $venta_lotes->where("cliente_id", Auth::user()->cliente->id);
        }
        $venta_lotes = $venta_lotes->get();
        return response()->JSON([
            "data" => $venta_lotes
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $venta_lotes = VentaLote::with(["urbanizacion", "manzano"])->select("venta_lotes.*");

        if (trim($search) != "") {
            $venta_lotes->where("nombre", "LIKE", "%$search%");
        }

        $venta_lotes = $venta_lotes->paginate($request->itemsPerPage);
        return response()->JSON([
            "venta_lotes" => $venta_lotes
        ]);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $request["user_id"] = Auth::user()->id;
            $request["estado_pago"] = "PENDIENTE";
            $request["estado_cliente"] = "ACTIVO";
            $request["total_venta"] = 0;
            $request['fecha_registro'] = date('Y-m-d');
            // crear el VentaLote
            $nueva_venta_lote = VentaLote::create(array_map('mb_strtoupper', $request->all()));
            $total_venta = $nueva_venta_lote->lote->costo_contado;
            // verificar contado/credito
            if ($nueva_venta_lote->tipo_pago == 'CRÉDITO') {
                // generar planilla
                $fecha_ini = date("Y-m-d", strtotime($nueva_venta_lote->fecha_formalizacion));
                // plazo lote
                if (!$nueva_venta_lote->lote->planilla_cuota) {
                    throw new Exception("No es posible realizar la venta a CRÉDITO debido a que no se registro la Planilla de cuotas del lote seleccionado.");
                }
                $plazo = $nueva_venta_lote->lote->planilla_cuota->plazo;
                $total_venta = $nueva_venta_lote->lote->costo_credito;
                $cuota = $total_venta / $plazo;
                $cuota = round($cuota, 2);
                $suma_cuota = $cuota;
                $fecha_pago = $fecha_ini;
                for ($i = 1; $i <= $plazo; $i++) {
                    // crear planilla
                    $fecha_pago = date("Y-m-d", strtotime($fecha_pago . "+1 month"));
                    $nueva_venta_lote->venta_planillas()->create([
                        "cliente_id" => $nueva_venta_lote->cliente_id,
                        "nro_cuota" => $i,
                        "cuota" => $cuota,
                        "total_sumado" => $suma_cuota,
                        "estado" => 0,
                        "fecha_pago" => $fecha_pago,
                    ]);
                    $suma_cuota += (float)$cuota;
                }
            }
            $nueva_venta_lote->total_venta = $total_venta;
            $nueva_venta_lote->save();

            $nueva_venta_lote->lote->vendido = 1;
            $nueva_venta_lote->lote->save();

            $datos_original = HistorialAccion::getDetalleRegistro($nueva_venta_lote, "venta_lotes");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UNA VENTA DE LOTE',
                'datos_original' => $datos_original,
                'modulo' => 'VENTA DE LOTES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            if ($nueva_venta_lote->tipo_pago == 'CRÉDITO') {
                $request->session()->flash('planilla', $nueva_venta_lote->id);
                return redirect()->route("venta_lotes.index")->with('planilla', $nueva_venta_lote->id)->with('imprime_planilla', $nueva_venta_lote->id);
            } else {
                return redirect()->route("venta_lotes.index")->with("bien", "Registro realizado");
            }
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(VentaLote $venta_lote)
    {
        return response()->JSON($venta_lote);
    }

    public function update(VentaLote $venta_lote, Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            // pagos
            $pagos = Pago::where("venta_lote_id", $venta_lote->id)->get();
            if (count($pagos) < 1) {
                $tipo_anterior = $venta_lote->tipo_pago;
                $datos_original = HistorialAccion::getDetalleRegistro($venta_lote, "venta_lotes");
                $request["estado_pago"] = "PENDIENTE";
                $request["total_venta"] = 0;

                $venta_lote->update(array_map('mb_strtoupper', $request->all()));
                $total_venta = $venta_lote->lote->costo_contado;

                // verificar contado/credito
                if ($venta_lote->tipo_pago != $tipo_anterior) {
                    if ($tipo_anterior == 'CONTADO' && $venta_lote->tipo_pago == 'CRÉDITO') {
                        // generar planilla
                        $fecha_ini = date("Y-m-d", strtotime($venta_lote->fecha_formalizacion));
                        // plazo lote
                        if (!$venta_lote->lote->planilla_cuota) {
                            throw new Exception("No es posible realizar la venta a CRÉDITO debido a que no se registro la Planilla de cuotas del lote seleccionado.");
                        }
                        $plazo = $venta_lote->lote->planilla_cuota->plazo;
                        $total_venta = $venta_lote->lote->costo_credito;
                        $cuota = $total_venta / $plazo;
                        $cuota = round($cuota, 2);
                        $suma_cuota = $cuota;
                        $fecha_pago = $fecha_ini;
                        for ($i = 1; $i <= $plazo; $i++) {
                            // crear planilla
                            $fecha_pago = date("Y-m-d", strtotime($fecha_pago . "+1 month"));
                            $venta_lote->venta_planillas()->create([
                                "cliente_id" => $venta_lote->cliente_id,
                                "nro_cuota" => $i,
                                "cuota" => $cuota,
                                "total_sumado" => $suma_cuota,
                                "estado" => 0,
                                "fecha_pago" => $fecha_pago,
                            ]);
                            $suma_cuota += (float)$cuota;
                        }
                    } elseif ($venta_lote->tipo_pago == 'CONTADO' && $tipo_anterior == 'CRÉDITO') {

                        // eliminar planilla de pago
                        $venta_lote->venta_planillas()->delete();
                    }
                }
                $venta_lote->total_venta = $total_venta;
                $venta_lote->save();
            } else {
                throw new Exception("No es posible actualizar el registro porque ya existen pagos realizados");
            }

            $datos_nuevo = HistorialAccion::getDetalleRegistro($venta_lote, "venta_lotes");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UNA VENTA DE LOTE',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'VENTA DE LOTES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("venta_lotes.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(VentaLote $venta_lote)
    {
        DB::beginTransaction();
        try {
            $usos = Pago::where("venta_lote_id", $venta_lote->id)->get();
            if (count($usos) > 0) {
                throw ValidationException::withMessages([
                    'error' =>  "No es posible eliminar este registro porque esta siendo utilizado por otros registros",
                ]);
            }

            $venta_lote->lote->vendido = 0;
            $venta_lote->lote->save();

            $datos_original = HistorialAccion::getDetalleRegistro($venta_lote, "venta_lotes");
            $venta_lote->venta_planillas()->delete();
            $venta_lote->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UNA VENTA DE LOTE',
                'datos_original' => $datos_original,
                'modulo' => 'VENTA DE LOTES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'El registro se eliminó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }
}
