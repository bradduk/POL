<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model as Eloquent;

class Cuenta extends Eloquent
{

    protected $table = 'cuentas';
    protected $primaryKey = 'ID';

    public $timestamps = false;


    public function empresa()
    {
        return $this->hasOne(Empresa::class, 'cuenta_ID', 'ID');
    }

}