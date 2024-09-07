<?php

namespace App\Http\Controllers;

use App\Models\NotificacionUser;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;

class NotificacionUserController extends Controller
{

    public function index()
    {
        return Inertia::render("NotificacionUsers/Index");
    }

    public function listado()
    {
        $notificacion_users = NotificacionUser::select("notificacion_users.*")->where("user_id", Auth::user()->id)->get();
        return response()->JSON([
            "notificacion_users" => $notificacion_users
        ]);
    }

    public function api(Request $request)
    {
        // Log::debug($request);
        $notificacion_users = NotificacionUser::with(["notificacion"])->select("notificacion_users.*");
        $notificacion_users = $notificacion_users->where("user_id", Auth::user()->id)->get();
        return response()->JSON([
            "data" => $notificacion_users
        ]);
    }

    public function paginado(Request $request)
    {
        $search = $request->search;
        $notificacion_users = NotificacionUser::select("notificacion_users.*");

        if (trim($search) != "") {
            $notificacion_users->where("descripcion", "LIKE", "%$search%");
        }

        $notificacion_users = $notificacion_users->where("user_id", Auth::user()->Id)->paginate($request->itemsPerPage);
        return response()->JSON([
            "notificacion_users" => $notificacion_users
        ]);
    }

    public function show(NotificacionUser $notificacion_user)
    {
        $notificacion_user->update(["visto" => 1]);
        $notificacion_user = $notificacion_user->load(["notificacion"]);
        return Inertia::render("NotificacionUsers/Show", compact("notificacion_user"));
    }

    public function notificacion(Request $request)
    {
        $ultimo = $request->id;
        $sin_ver = 0;

        $notificacion_users = NotificacionUser::with(["notificacion", "user"])->where("user_id", Auth::user()->id)
            ->where("id", ">", $ultimo)
            ->orderBy("created_at", "desc")->get();

        $sin_ver = NotificacionUser::where("user_id", Auth::user()->id)->where("visto", 0)->count();
        if (count($notificacion_users) > 0) {
            $ultimo = $notificacion_users[0]->id;
        }

        return response()->JSON([
            "notificacion_users" => $notificacion_users,
            "ultimo" => $ultimo,
            "sin_ver" => $sin_ver,
        ]);
    }
}
