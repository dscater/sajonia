<?php

namespace App\Models;

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

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function venta_lotes()
    {
        return $this->hasMany(VentaLote::class, 'cliente_id');
    }
}
