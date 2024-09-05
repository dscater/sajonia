<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PlanillaCuota extends Model
{
    use HasFactory;

    protected $fillable = [
        "lote_id",
        "plazo",
        "descripcion",
        "fecha_registro",
    ];

    protected $appends = ["fecha_registro_t"];

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }

    public function lote()
    {
        return $this->belongsTo(Lote::class, 'lote_id');
    }
}
