<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('lotes', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("urbanizacion_id");
            $table->unsignedBigInteger("manzano_id");
            $table->string("nombre", 255);
            $table->string("ubicacion", 255);
            $table->string("esquina", 255);
            $table->string("esquina_area", 255);
            $table->string("esquina_equipamiento", 255);
            $table->string("avenida_estr", 255);
            $table->string("avenida_union", 255);
            $table->string("superficie", 255);
            $table->decimal("costo_contado", 24, 2);
            $table->decimal("costo_credito", 24, 2);
            $table->date("fecha_registro")->nullable();
            $table->timestamps();
            
            $table->foreign("manzano_id")->on("manzanos")->references("id");
            $table->foreign("urbanizacion_id")->on("urbanizacions")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('lotes');
    }
};
