<?php

namespace App\Models;

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

    protected $appends = ["fecha_registro_t"];

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
