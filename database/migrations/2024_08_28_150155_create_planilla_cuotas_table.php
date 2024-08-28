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
        Schema::create('planilla_cuotas', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("lote_id");
            $table->integer("plazo");
            $table->string("descripcion", 600)->nullable();
            $table->date("fecha_registro")->nullable();
            $table->timestamps();
            $table->foreign("lote_id")->on("lotes")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('planilla_cuotas');
    }
};
