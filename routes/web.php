<?php

use App\Http\Controllers\ClienteController;
use App\Http\Controllers\ConfiguracionController;
use App\Http\Controllers\InicioController;
use App\Http\Controllers\LoteController;
use App\Http\Controllers\ManzanoController;
use App\Http\Controllers\NotificacionUserController;
use App\Http\Controllers\ParametrizacionController;
use App\Http\Controllers\PlanillaCuotaController;
use App\Http\Controllers\PortalController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\UrbanizacionController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\UsuarioController;
use App\Http\Controllers\VentaLoteController;
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
    Route::get("usuarios/notificacion/{user}", [NotificacionUserController::class, 'notificacion'])->name("usuarios.notificacion");


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
    Route::get("lotes/listadoByManzano", [LoteController::class, 'listadoByManzano'])->name("lotes.listadoByManzano");
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

    // CLIENTES
    Route::put("clientes/update_estado/{cliente}", [ClienteController::class, 'update_estado'])->name("clientes.update_estado");
    Route::get("clientes/api", [ClienteController::class, 'api'])->name("clientes.api");
    Route::get("clientes/paginado", [ClienteController::class, 'paginado'])->name("clientes.paginado");
    Route::get("clientes/listado", [ClienteController::class, 'listado'])->name("clientes.listado");
    Route::resource("clientes", ClienteController::class)->only(
        ["index", "store", "update", "show", "destroy"]
    );

    // VENTA LOTES
    Route::get("venta_lotes/api", [VentaLoteController::class, 'api'])->name("venta_lotes.api");
    Route::get("venta_lotes/paginado", [VentaLoteController::class, 'paginado'])->name("venta_lotes.paginado");
    Route::get("venta_lotes/listado", [VentaLoteController::class, 'listado'])->name("venta_lotes.listado");
    Route::resource("venta_lotes", VentaLoteController::class)->only(
        ["index", "store", "update", "show", "destroy"]
    );

    // NOTIFICACIONES
    Route::get("notificacion_users/api", [NotificacionUserController::class, 'api'])->name("notificacion_users.api");
    Route::get("notificacion_users/paginado", [NotificacionUserController::class, 'paginado'])->name("notificacion_users.paginado");
    Route::get("notificacion_users/listado", [NotificacionUserController::class, 'listado'])->name("notificacion_users.listado");
    Route::resource("notificacion_users", NotificacionUserController::class)->only(
        ["index", "show"]
    );

    // REPORTES
});
require __DIR__ . '/auth.php';
