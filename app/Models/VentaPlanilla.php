<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class VentaPlanilla extends Model
{
    use HasFactory;

    protected $fillable = [
        "venta_lote_id",
        "cliente_id",
        "nro_cuota",
        "cuota",
        "total_sumado",
        "estado",
        "fecha_pago",
    ];

    protected $appends = ["fecha_pago_t", "fecha_pago_registro"];

    // verificar a que pago App\Models\Pago pertenece
    public function getFechaPagoRegistroAttribute()
    {
        if ($this->estado == 1) {
            $pagos = Pago::where("venta_lote_id", $this->venta_lote_id)->orderBy("id", "asc")->get();
            $cuotas = 0;
            foreach ($pagos as $pago) {
                $cuotas += (int)$pago->nro_cuotas;
                if ($this->nro_cuota <= $cuotas) {
                    return Carbon::parse($pago->fecha_pago)
                        ->locale('es')
                        ->translatedFormat('d \\d\\e F \\d\\e Y');
                }
            }
        }
        return $this->verificaRetraso($this->fecha_pago, $this);
    }
    public function verificaRetraso($fecha, VentaPlanilla $ventaPlanilla = null)
    {
        if (!$fecha) return null;

        $fechaEsperada = Carbon::parse($fecha);
        $hoy = Carbon::now();

        // Si aún no está vencido
        if ($hoy->lessThanOrEqualTo($fechaEsperada)) {
            return 'SIN RETRASO';
        }

        $diff = $fechaEsperada->diff($hoy);

        if ($ventaPlanilla) {
            if ($diff->m >= 3 && $diff->d > 0) {
                // inhabilitar cuenta
                $user = $this->cliente->user;
                $user->acceso = 0;
                $user->save();
            }
        }

        return "{$diff->m} mes(es) y {$diff->d} día(s)";
    }

    public function getFechaPagoTAttribute()
    {
        return Carbon::parse($this->fecha_pago)
            ->locale('es')
            ->translatedFormat('d \\d\\e F \\d\\e Y');
    }

    public function venta_lote()
    {
        return $this->belongsTo(VentaLote::class, 'venta_lote_id');
    }

    public function cliente()
    {
        return $this->belongsTo(Cliente::class, 'cliente_id');
    }
}
