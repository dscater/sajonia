<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Manzano extends Model
{
    use HasFactory;

    protected $fillable = [
        "urbanizacion_id",
        "nombre",
        "descripcion",
        "fecha_registro",
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

    public function lotes()
    {
        return $this->hasMany(Lote::class, 'manzano_id');
    }
}
