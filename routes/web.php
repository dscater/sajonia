<?php

use App\Http\Controllers\ConfiguracionController;
use App\Http\Controllers\InicioController;
use App\Http\Controllers\LoteController;
use App\Http\Controllers\ManzanoController;
use App\Http\Controllers\ParametrizacionController;
use App\Http\Controllers\PlanillaCuotaController;
use App\Http\Controllers\PortalController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\UrbanizacionController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\UsuarioController;
use Illuminate\Foundation\Application;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    if (Auth::check()) {
        return redirect()->route('inicio');
    }
    return Inertia::render('Auth/Login');
})->name("porta.index");

Route::get('/login', function () {
    if (Auth::check()) {
        return redirect()->route('inicio');
    }
    return Inertia::render('Auth/Login');
})->name("login");

Route::get("configuracions/getConfiguracion", [ConfiguracionController::class, 'getConfiguracion'])->name("configuracions.getConfiguracion");

Route::middleware('auth')->prefix("admin")->group(function () {
    // INICIO
    Route::get('/inicio', [InicioController::class, 'inicio'])->name('inicio');

    // CONFIGURACION
    Route::resource("configuracions", ConfiguracionController::class)->only(
        ["index", "show", "update"]
    );

    // USUARIO
    Route::get('profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::patch('profile/update_foto', [ProfileController::class, 'update_foto'])->name('profile.update_foto');
    Route::delete('profile', [ProfileController::class, 'destroy'])->name('profile.destroy');

    Route::get("getUser", [UserController::class, 'getUser'])->name('users.getUser');
    Route::get("permisos", [UserController::class, 'permisos']);

    // USUARIOS
    Route::put("usuarios/password/{user}", [UsuarioController::class, 'actualizaPassword'])->name("usuarios.password");
    Route::get("usuarios/api", [UsuarioController::class, 'api'])->name("usuarios.api");
    Route::get("usuarios/paginado", [UsuarioController::class, 'paginado'])->name("usuarios.paginado");
    Route::get("usuarios/listado", [UsuarioController::class, 'listado'])->name("usuarios.listado");
    Route::get("usuarios/listado/byTipo", [UsuarioController::class, 'byTipo'])->name("usuarios.byTipo");
    Route::get("usuarios/show/{user}", [UsuarioController::class, 'show'])->name("usuarios.show");
    Route::put("usuarios/update/{user}", [UsuarioController::class, 'update'])->name("usuarios.update");
    Route::delete("usuarios/{user}", [UsuarioController::class, 'destroy'])->name("usuarios.destroy");
    Route::resource("usuarios", UsuarioController::class)->only(
        ["index", "store"]
    );

    // URBACIONAZION
    Route::get("urbanizacions/api", [UrbanizacionController::class, 'api'])->name("urbanizacions.api");
    Route::get("urbanizacions/paginado", [UrbanizacionController::class, 'paginado'])->name("urbanizacions.paginado");
    Route::get("urbanizacions/listado", [UrbanizacionController::class, 'listado'])->name("urbanizacions.listado");
    Route::resource("urbanizacions", UrbanizacionController::class)->only(
        ["index", "store", "update", "show", "destroy"]
    );

    // MANZANOS
    Route::get("manzanos/api", [ManzanoController::class, 'api'])->name("manzanos.api");
    Route::get("manzanos/paginado", [ManzanoController::class, 'paginado'])->name("manzanos.paginado");
    Route::get("manzanos/listadoByUrbanizacion", [ManzanoController::class, 'listadoByUrbanizacion'])->name("manzanos.listadoByUrbanizacion");
    Route::get("manzanos/listado", [ManzanoController::class, 'listado'])->name("manzanos.listado");
    Route::resource("manzanos", ManzanoController::class)->only(
        ["index", "store", "update", "show", "destroy"]
    );

    // LOTES
    Route::get("lotes/api", [LoteController::class, 'api'])->name("lotes.api");
    Route::get("lotes/paginado", [LoteController::class, 'paginado'])->name("lotes.paginado");
    Route::get("lotes/listado", [LoteController::class, 'listado'])->name("lotes.listado");
    Route::resource("lotes", LoteController::class)->only(
        ["index", "store", "update", "show", "destroy"]
    );

    // PLANILLA CUOTAS
    Route::get("planilla_cuotas/api", [PlanillaCuotaController::class, 'api'])->name("planilla_cuotas.api");
    Route::get("planilla_cuotas/paginado", [PlanillaCuotaController::class, 'paginado'])->name("planilla_cuotas.paginado");
    Route::get("planilla_cuotas/listado", [PlanillaCuotaController::class, 'listado'])->name("planilla_cuotas.listado");
    Route::resource("planilla_cuotas", PlanillaCuotaController::class)->only(
        ["index", "store", "update", "show", "destroy"]
    );

    // REPORTES
});
require __DIR__ . '/auth.php';
