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
        Schema::create('pagos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("user_id");
            $table->unsignedBigInteger("cliente_id");
            $table->unsignedBigInteger("venta_lote_id");
            $table->integer("nro_cuotas");
            $table->decimal("cuota", 24, 2);
            $table->decimal("total_cuota", 24, 2);
            $table->string("descripcion", 900)->nullable();
            $table->date("fecha_pago");
            $table->date("fecha_registro")->nullable();
            $table->timestamps();
            $table->foreign("user_id")->on("users")->references("id");
            $table->foreign("cliente_id")->on("clientes")->references("id");
            $table->foreign("venta_lote_id")->on("venta_lotes")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('pagos');
    }
};
