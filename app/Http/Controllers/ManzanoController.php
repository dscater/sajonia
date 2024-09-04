<?php

namespace App\Http\Controllers;

use App\Models\HistorialAccion;
use App\Models\Lote;
use App\Models\Manzano;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;

class ManzanoController extends Controller
{
    public $validacion = [
        "urbanizacion_id" => "required",
        "nombre" => "required|min:1",
    ];

    public $mensajes = [
        "nombre.required" => "Este campo es obligatorio",
        "nombre.min" => "Debes ingresar al menos :min caracteres",
        "urbanizacion_id.required" => "Este campo es obligatorio",
    ];

    public function index()
    {
        return Inertia::render("Manzanos/Index");
    }

    public function listado()
    {
        $manzanos = Manzano::with(["urbanizacion"])->select("manzanos.*")->get();
        return response()->JSON([
            "manzanos" => $manzanos
        ]);
    }

    public function listadoByUrbanizacion(Request $request)
    {
        $manzanos = Manzano::with(["urbanizacion"])->select("manzanos.*")->where("urbanizacion_id", $request->id)->get();
        return response()->JSON([
            "manzanos" => $manzanos
        ]);
    }

    public function api(Request $request)
    {
        // Log::debug($request);
        $manzanos = Manzano::with(["urbanizacion"])->select("manzanos.*");
        $manzanos = $manzanos->get();
        return response()->JSON([
            "data" => $manzanos
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $manzanos = Manzano::with(["urbanizacion"])->select("manzanos.*");

        if (trim($search) != "") {
            $manzanos->where("nombre", "LIKE", "%$search%");
        }

        $manzanos = $manzanos->paginate($request->itemsPerPage);
        return response()->JSON([
            "manzanos" => $manzanos
        ]);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $request['fecha_registro'] = date('Y-m-d');
            // crear el Manzano
            $nueva_manzano = Manzano::create(array_map('mb_strtoupper', $request->all()));
            $datos_original = HistorialAccion::getDetalleRegistro($nueva_manzano, "manzanos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN MANZANO',
                'datos_original' => $datos_original,
                'modulo' => 'MANZANOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("manzanos.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(Manzano $manzano)
    {
        return response()->JSON($manzano);
    }

    public function update(Manzano $manzano, Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($manzano, "manzanos");
            $manzano->update(array_map('mb_strtoupper', $request->all()));
            $datos_nuevo = HistorialAccion::getDetalleRegistro($manzano, "manzanos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN MANZANO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'MANZANOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("manzanos.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(Manzano $manzano)
    {
        DB::beginTransaction();
        try {
            $usos = Lote::where("manzano_id", $manzano->id)->get();
            if (count($usos) > 0) {
                throw ValidationException::withMessages([
                    'error' =>  "No es posible eliminar este registro porque esta siendo utilizado por otros registros",
                ]);
            }

            $datos_original = HistorialAccion::getDetalleRegistro($manzano, "manzanos");
            $manzano->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN MANZANO',
                'datos_original' => $datos_original,
                'modulo' => 'MANZANOS',
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
