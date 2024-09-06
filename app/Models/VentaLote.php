<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class VentaLote extends Model
{
    use HasFactory;

    protected $fillable = [
        "user_id",
        "cliente_id",
        "urbanizacion_id",
        "manzano_id",
        "lote_id",
        "fecha_formalizacion",
        "total_venta",
        "estado_pago",
        "tipo_pago",
        "sistema",
        "estudios_com",
        "minuta",
        "titulacion",
        "estado_cliente",
        "fecha_registro",
    ];

    protected $appends = ["fecha_registro_t", "fecha_formalizacion_t"];

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }

    public function getFechaFormalizacionTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_formalizacion));
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function cliente()
    {
        return $this->belongsTo(Cliente::class, 'cliente_id');
    }

    public function urbanizacion()
    {
        return $this->belongsTo(Urbanizacion::class, 'urbanizacion_id');
    }

    public function manzano()
    {
        return $this->belongsTo(Manzano::class, 'manzano_id');
    }

    public function lote()
    {
        return $this->belongsTo(Lote::class, 'lote_id');
    }

    public function venta_planillas()
    {
        return $this->hasMany(VentaPlanilla::class, 'venta_lote_id');
    }
}
