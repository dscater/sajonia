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
        Schema::create('venta_lotes', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("user_id");
            $table->unsignedBigInteger("cliente_id");
            $table->unsignedBigInteger("urbanizacion_id");
            $table->unsignedBigInteger("manzano_id");
            $table->unsignedBigInteger("lote_id");
            $table->date("fecha_formalizacion");
            $table->decimal("total_venta");
            $table->string("estado_pago");
            $table->string("tipo_pago");
            $table->string("sistema");
            $table->string("estudios_com");
            $table->string("minuta");
            $table->string("titulacion");
            $table->string("estado_cliente");
            $table->date("fecha_registro");
            $table->timestamps();

            $table->foreign("user_id")->on("users")->references("id");
            $table->foreign("cliente_id")->on("clientes")->references("id");
            $table->foreign("urbanizacion_id")->on("urbanizacions")->references("id");
            $table->foreign("manzano_id")->on("manzanos")->references("id");
            $table->foreign("lote_id")->on("lotes")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('venta_lotes');
    }
};
