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
        Schema::create('venta_planillas', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("venta_lote_id");
            $table->unsignedBigInteger("cliente_id");
            $table->integer("nro_cuota");
            $table->decimal("cuota");
            $table->decimal("total_sumado");
            $table->integer("estado"); // 1(pagado) | 0(pendiente)
            $table->date("fecha_pago");
            $table->timestamps();

            $table->foreign("venta_lote_id")->on("venta_lotes")->references("id");
            $table->foreign("cliente_id")->on("clientes")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('venta_planillas');
    }
};
