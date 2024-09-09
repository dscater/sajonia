<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\Lote;
use App\Models\PlanillaCuota;
use App\Models\VentaLote;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class LoteController extends Controller
{
    public $validacion = [
        "urbanizacion_id" => "required",
        "manzano_id" => "required",
        "nombre" => "required",
        "ubicacion" => "required",
        "esquina" => "required",
        "esquina_area" => "required",
        "esquina_equipamiento" => "required",
        "avenida_estr" => "required",
        "avenida_union" => "required",
        "superficie" => "required",
        "costo_contado" => "required",
        "costo_credito" => "required",
    ];

    public $mensajes = [
        "urbanizacion_id.required" => "Este campo es obligatorio",
        "manzano_id.required" => "Este campo es obligatorio",
        "nombre.required" => "Este campo es obligatorio",
        "ubicacion.required" => "Este campo es obligatorio",
        "esquina.required" => "Este campo es obligatorio",
        "esquina_area.required" => "Este campo es obligatorio",
        "esquina_equipamiento.required" => "Este campo es obligatorio",
        "avenida_estr.required" => "Este campo es obligatorio",
        "avenida_union.required" => "Este campo es obligatorio",
        "superficie.required" => "Este campo es obligatorio",
        "costo_contado.required" => "Este campo es obligatorio",
        "costo_credito.required" => "Este campo es obligatorio",
    ];

    public function index()
    {
        return Inertia::render("Lotes/Index");
    }

    public function listado(Request $request)
    {
        $lotes = Lote::with(["urbanizacion", "manzano"])->select("lotes.*");

        if ($request->sin_planilla) {
            $lotes = $lotes->whereNotExists(function ($query) {
                $query->select(DB::raw(1))
                    ->from('planilla_cuotas')
                    ->whereRaw('planilla_cuotas.lote_id = lotes.id');
            });
        }

        $lotes = $lotes->get();
        return response()->JSON([
            "lotes" => $lotes
        ]);
    }

    public function listadoByManzano(Request $request)
    {
        $lotes = Lote::with(["manzano"])->select("lotes.*")->where("manzano_id", $request->id);

        if ($request->sin_venta) {
            if (!$request->data_id) {
                $lotes->whereNotExists(function ($query) {
                    $query->select(DB::raw(1))
                        ->from('venta_lotes')
                        ->whereRaw('venta_lotes.lote_id = lotes.id');
                });
            } else {
                $lotes = $lotes->whereNotExists(function ($query) {
                    $query->select(DB::raw(1))
                        ->from('planilla_cuotas')
                        ->whereRaw('planilla_cuotas.lote_id = lotes.id');
                })->orWhere(function ($subquery) use ($request) {
                    $subquery->whereIn('lotes.id', [$request->data_id]);
                });
            }
        }

        $lotes = $lotes->get();

        return response()->JSON([
            "lotes" => $lotes
        ]);
    }

    public function api(Request $request)
    {
        // Log::debug($request);
        $lotes = Lote::with(["urbanizacion", "manzano"])->select("lotes.*");
        $lotes = $lotes->get();
        return response()->JSON([
            "data" => $lotes
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $lotes = Lote::with(["urbanizacion", "manzano"])->select("lotes.*");

        if (trim($search) != "") {
            $lotes->where("nombre", "LIKE", "%$search%");
        }

        $lotes = $lotes->paginate($request->itemsPerPage);
        return response()->JSON([
            "lotes" => $lotes
        ]);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $request['fecha_registro'] = date('Y-m-d');
            // crear el Lote
            $nueva_lote = Lote::create(array_map('mb_strtoupper', $request->all()));
            $datos_original = HistorialAccion::getDetalleRegistro($nueva_lote, "lotes");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN LOTE',
                'datos_original' => $datos_original,
                'modulo' => 'LOTES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("lotes.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(Lote $lote)
    {
        return response()->JSON($lote);
    }

    public function update(Lote $lote, Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($lote, "lotes");
            $lote->update(array_map('mb_strtoupper', $request->all()));
            $datos_nuevo = HistorialAccion::getDetalleRegistro($lote, "lotes");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN LOTE',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'LOTES',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("lotes.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(Lote $lote)
    {
        DB::beginTransaction();
        try {
            $usos = PlanillaCuota::where("lote_id", $lote->id)->get();
            if (count($usos) > 0) {
                throw ValidationException::withMessages([
                    'error' =>  "No es posible eliminar este registro porque esta siendo utilizado por otros registros",
                ]);
            }
            $usos = VentaLote::where("lote_id", $lote->id)->get();
            if (count($usos) > 0) {
                throw ValidationException::withMessages([
                    'error' =>  "No es posible eliminar este registro porque esta siendo utilizado por otros registros",
                ]);
            }

            $datos_original = HistorialAccion::getDetalleRegistro($lote, "lotes");
            $lote->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN LOTE',
                'datos_original' => $datos_original,
                'modulo' => 'LOTES',
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
