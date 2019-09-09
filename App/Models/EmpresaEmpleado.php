<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model as Eloquent;

class EmpresaEmpleado extends Eloquent
{
    // protected $primaryKey = 'ID';
    protected $table = 'empresa_empleados';
    public $timestamps = false;

    public function user()
    {
        return $this->belongsTo(User::class, 'user_ID');
    }

}