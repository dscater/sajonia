<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pago extends Model
{
    use HasFactory;

    protected $fillable = [
        "cliente_id",
        "user_id",
        "venta_lote_id",
        "nro_cuotas",
        "cuota",
        "total_cuota",
        "descripcion",
        "fecha_pago",
        "fecha_registro",
    ];


    protected $appends = ["fecha_registro_t", "fecha_pago_t"];

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }

    public function getFechaPagoTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_pago));
    }

    public function cliente()
    {
        return $this->belongsTo(Cliente::class, 'cliente_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function venta_lote()
    {
        return $this->belongsTo(VentaLote::class, 'venta_lote_id');
    }
}
