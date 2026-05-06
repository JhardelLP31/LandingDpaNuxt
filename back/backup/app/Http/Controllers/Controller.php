<?php

namespace App\Http\Controllers;

abstract class Controller
{
    protected function respondSuccess($data = [], $message = 'Operación exitosa')
    {
        return response()->json([
            'success' => true,
            'code'    => 200,
            'message' => $message,
            'data'    => $data
        ], 200);
    }
    protected function respondError($message, $code = 403, $data = [])
    {
        return response()->json([
            'success' => false,   
            'code'    => $code,  
            'message' => $message,
            'data'    => $data
        ], 200); 
    }
}
