<?php

namespace App\Models;

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

    public function venta_lote()
    {
        return $this->belongsTo(VentaLote::class, 'venta_lote_id');
    }

    public function cliente()
    {
        return $this->belongsTo(Cliente::class, 'cliente_id');
    }
}
