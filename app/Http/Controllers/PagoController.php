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
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;
use App\library\numero_a_letras\src\NumeroALetras;
use PDF;

class PagoController extends Controller
{
    public $validacion = [
        "cliente_id" => "required",
        "venta_lote_id" => "required",
        "nro_cuotas" => "required",
        "cuota" => "required",
        "total_cuota" => "required",
        "fecha_pago" => "required",
    ];

    public $mensajes = [
        "cliente_id.required" => "Este campo es obligatorio",
        "venta_lote_id.required" => "Este campo es obligatorio",
        "nro_cuotas.required" => "Este campo es obligatorio",
        "cuota.required" => "Este campo es obligatorio",
        "total_cuota.required" => "Este campo es obligatorio",
        "fecha_pago.required" => "Este campo es obligatorio",
    ];

    public function index()
    {
        return Inertia::render("Pagos/Index");
    }

    public function listado()
    {
        $pagos = Pago::with(["cliente", "user", "venta_lote.urbanizacion", "venta_lote.manzano", "venta_lote.lote"])->select("pagos.*")->get();
        return response()->JSON([
            "pagos" => $pagos
        ]);
    }

    public function api(Request $request)
    {
        // Log::debug($request);
        $pagos = Pago::with(["cliente.user", "user", "venta_lote.urbanizacion", "venta_lote.manzano", "venta_lote.lote"])->select("pagos.*");
        $pagos = $pagos->get();
        return response()->JSON([
            "data" => $pagos
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $pagos = Pago::with(["cliente", "user", "venta_lote.urbanizacion", "venta_lote.manzano", "venta_lote.lote"])->select("pagos.*");

        if (trim($search) != "") {
            $pagos->where("plazo", "LIKE", "%$search%");
        }

        $pagos = $pagos->paginate($request->itemsPerPage);
        return response()->JSON([
            "pagos" => $pagos
        ]);
    }

    public function store(Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $request['user_id'] = Auth::user()->id;
            $request['fecha_registro'] = date('Y-m-d');

            $venta_lote = VentaLote::where("id", $request->venta_lote_id)
                ->get()->first();

            if ($venta_lote->restante < $request->total_cuota) {
                throw new Exception("El monto total supera al restante de: " . $venta_lote->restante);
            }

            // crear el Pago
            $nuevo_pago = Pago::create(array_map('mb_strtoupper', $request->all()));

            // registrar en la planilla
            $venta_planillas = VentaPlanilla::where("venta_lote_id", $nuevo_pago->venta_lote_id)
                ->where("estado", 0)
                ->orderBy("id", "asc")
                ->get();

            for ($i = 0; $i < $request->nro_cuotas; $i++) {
                $venta_planillas[$i]->estado = 1;
                $venta_planillas[$i]->save();
            }

            if ($nuevo_pago->venta_lote->restante == 0) {
                $nuevo_pago->venta_lote->estado = "CANCELADO";
                $nuevo_pago->venta_lote->save();
            }

            $datos_original = HistorialAccion::getDetalleRegistro($nuevo_pago, "pagos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'CREACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' REGISTRO UN PAGO',
                'datos_original' => $datos_original,
                'modulo' => 'PAGOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("pagos.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function show(Pago $pago)
    {
        $pago = $pago->load(["cliente.user", "user", "venta_lote"]);

        return Inertia::render("Pagos/Show", compact("pago"));
    }

    public function pdf(Pago $pago)
    {
        $pago = $pago->load(["cliente.user", "user", "venta_lote"]);

        $convertir = new NumeroALetras();
        $array_monto = explode('.', $pago->total_cuota);

        $literal = $convertir->convertir($array_monto[0]);
        $literal .= " " . (isset($array_monto[1]) ? $array_monto[1] : '00') . "/100." . " Bolivianos";
        $pdf = PDF::loadView('reportes.comprobante', compact("pago", "literal"))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('comprobante.pdf');
    }


    public function update(Pago $pago, Request $request)
    {
        $request->validate($this->validacion, $this->mensajes);
        DB::beginTransaction();
        try {
            $datos_original = HistorialAccion::getDetalleRegistro($pago, "pagos");
            $pago->update(array_map('mb_strtoupper', $request->all()));
            $datos_nuevo = HistorialAccion::getDetalleRegistro($pago, "pagos");
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'MODIFICACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' MODIFICÓ UN PAGO',
                'datos_original' => $datos_original,
                'datos_nuevo' => $datos_nuevo,
                'modulo' => 'PAGOS',
                'fecha' => date('Y-m-d'),
                'hora' => date('H:i:s')
            ]);

            DB::commit();
            return redirect()->route("pagos.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function destroy(Pago $pago)
    {
        DB::beginTransaction();
        try {
            // actualizar planillas
            $venta_planillas = VentaPlanilla::where("venta_lote_id", $pago->venta_lote_id)
                ->where("estado", 1)
                ->orderBy("id", "desc")
                ->get();

            for ($i = 0; $i < $pago->nro_cuotas; $i++) {
                $venta_planillas[$i]->estado = 0;
                $venta_planillas[$i]->save();
            }


            $datos_original = HistorialAccion::getDetalleRegistro($pago, "pagos");
            $pago->delete();
            HistorialAccion::create([
                'user_id' => Auth::user()->id,
                'accion' => 'ELIMINACIÓN',
                'descripcion' => 'EL USUARIO ' . Auth::user()->usuario . ' ELIMINÓ UN PAGO',
                'datos_original' => $datos_original,
                'modulo' => 'PAGOS',
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
