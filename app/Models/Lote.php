<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Lote extends Model
{
    use HasFactory;

    protected $fillable = [
        "urbanizacion_id",
        "manzano_id",
        "nombre",
        "ubicacion",
        "esquina",
        "esquina_area",
        "esquina_equipamiento",
        "avenida_estr",
        "avenida_union",
        "superficie",
        "costo_contado",
        "costo_credito",
        "fecha_registro",
        "vendido"
    ];

    protected $appends = ["fecha_registro_t", "pagos_retrasados"];

    public function getPagosRetrasadosAttribute()
    {
        if ($this->venta_lote) {
            foreach ($this->venta_lote->venta_planillas as $venta_planilla) {
                return $this->verificaRetraso($venta_planilla->fecha_pago, $venta_planilla);
            }
        }

        return false;
    }

    public function verificaRetraso($fecha, VentaPlanilla $ventaPlanilla = null)
    {
        if (!$fecha) return null;

        $fechaEsperada = Carbon::parse($fecha);
        $hoy = Carbon::now();

        // Si aún no está vencido
        if ($hoy->lessThanOrEqualTo($fechaEsperada)) {
            return false;
        }

        $diff = $fechaEsperada->diff($hoy);

        if ($ventaPlanilla) {
            if ($diff->m >= 3 && $diff->d > 0) {
                return true;
            }
        }
        return false;
    }


    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }

    // relaciones
    public function urbanizacion()
    {
        return $this->belongsTo(Urbanizacion::class, 'urbanizacion_id');
    }

    public function manzano()
    {
        return $this->belongsTo(Manzano::class, 'manzano_id');
    }

    public function planilla_cuota()
    {
        return $this->hasOne(PlanillaCuota::class, 'lote_id');
    }

    public function venta_lote()
    {
        return $this->hasOne(VentaLote::class, 'lote_id');
    }
}
