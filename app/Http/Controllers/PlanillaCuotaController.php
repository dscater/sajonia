<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\PlanillaCuota;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class PlanillaCuotaController extends Controller
{
    public $validacion = [
        "lote_id" => "required",
        "plazo" => "required|min:0",
    ];

    public $mensajes = [
        "plazo.required" => "Este campo es obligatorio",
        "plazo.min" => "Debes ingresar al menos :min caracteres",
        "lote_id.required" => "Este campo es obligatorio",
    ];

    public function index()
    {
        return Inertia::render("PlanillaCuotas/Index");
    }

    public function listado()
    {
        $planilla_cuotas = PlanillaCuota::with(["lote"])->select("planilla_cuotas.*")->get();
        return response()->JSON([
            "planilla_cuotas" => $planilla_cuotas
        ]);
    }

    public function api(Request $request)
    {
        // Log::debug($request);
        $planilla_cuotas = PlanillaCuota::with(["lote.urbanizacion", "lote.manzano"])->select("planilla_cuotas.*");
        $planilla_cuotas = $planilla_cuotas->get();
        return response()->JSON([
            "data" => $planilla_cuotas
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $planilla_cuotas = PlanillaCuota::with(["lote"])->select("planilla_cuotas.*");

        if (trim($search) != "") {
            $planilla_cuotas->where("plazo", "LIKE", "%$search%");
        }

        $planilla_cuotas = $planilla_cuotas->paginate($request->itemsPerPage);
        return response()->JSON([
            "planilla_cuotas" => $planilla_cuotas
        ]);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $request['fecha_registro'] = date('Y-m-d');
            // crear el PlanillaCuota
            $nueva_planilla_cuota = PlanillaCuota::create(array_map('mb_strtoupper', $request->all()));
            $datos_original = HistorialAccion::getDetalleRegistro($nueva_planilla_cuota, "planilla_cuotas");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UNA PLANILLA DE CUOTA',
                'datos_original' => $datos_original,
                'modulo' => 'PLANILLA DE CUOTAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("planilla_cuotas.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(PlanillaCuota $planilla_cuota)
    {
        return response()->JSON($planilla_cuota);
    }

    public function update(PlanillaCuota $planilla_cuota, Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($planilla_cuota, "planilla_cuotas");
            $planilla_cuota->update(array_map('mb_strtoupper', $request->all()));
            $datos_nuevo = HistorialAccion::getDetalleRegistro($planilla_cuota, "planilla_cuotas");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UNA PLANILLA DE CUOTA',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'PLANILLA DE CUOTAS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("planilla_cuotas.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(PlanillaCuota $planilla_cuota)
    {
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($planilla_cuota, "planilla_cuotas");
            $planilla_cuota->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UNA PLANILLA DE CUOTA',
                'datos_original' => $datos_original,
                'modulo' => 'PLANILLA DE CUOTAS',
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
