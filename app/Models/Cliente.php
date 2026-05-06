<?php

namespace App\Models;

use Carbon\Carbon;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cliente extends Model
{
    use HasFactory;

    protected $fillable = [
        "user_id",
        "estado_cliente",
        "fecha_estado",
        "fechan"
    ];

    protected $appends = ["fecha_estado_texto", "fecha_n_texto"];

    public function getFechaEstadoTextoAttribute()
    {
        if ($this->fecha_estado) {
            return Carbon::parse($this->fecha_estado)
                ->locale("es")
                ->translatedFormat("d \\d\\e F \\d\\e Y");
        }
        return "";
    }

    public function getFechaNTextoAttribute()
    {
        if ($this->fechan) {
            return Carbon::parse($this->fechan)
                ->locale("es")
                ->translatedFormat("d \\d\\e F \\d\\e Y");
        }
        return "";
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function venta_lotes()
    {
        return $this->hasMany(VentaLote::class, 'cliente_id');
    }
}
