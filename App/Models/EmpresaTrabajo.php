<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model as Eloquent;

class EmpresaTrabajo extends Eloquent
{
    // protected $primaryKey = 'ID';
    protected $table = 'empresas_trabajos';
    public $timestamps = false;

    public function user()
    {
        return $this->belongsTo(User::class, 'user_ID');
    }

    public function empresa()
    {
        return $this->belongsTo(Empresa::class, 'empresa_ID');
    }

}