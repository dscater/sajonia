<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Configuracion extends Model
{
    use HasFactory;

    protected $fillable = [
        "nombre",
        "paterno",
        "materno",
        "ci",
        "ci_exp",
        "dir",
        "email",
        "fono",
        "password",
        "tipo",
        "foto",
        "fecha_registro",
    ];

    protected $appends = ["url_logo"];

    public function getUrlLogoAttribute()
    {
        return asset("imgs/" . $this->logo);
    }
}
