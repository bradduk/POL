<?php

namespace App\Controllers;

use App\Models\Category;
use Jenssegers\Blade\Blade;
use App\Models\Empresa;
use App\Models\User;
use App\Models\EmpresaTrabajo;

const TIPO_CATEGORY = 'empresas';
const TIPO_CATEGORY_PRO = 'empresas-pro';
const SUBTIPO_TRIGO = 'trigo';
const SUBTIPO_PAN = 'pan';

class EmpresaController
{

    private $blade;
    private $pol;
    private $urlA;
    private $urlB;

    public function __construct($pol)
    {
        $this->pol = $pol;
        $this->blade = new Blade([ RAIZ . 'App/Views'], RAIZ.'cache');
    }

    public function setUrls($urlA, $urlB)
    {
        $this->urlA = $urlA;
        $this->urlB = $urlB;
    }

    private function baseQuery()
    {
        return Category::where([
            'pais' => PAIS
        ])->where(function($query){
            $query->where(['tipo' => TIPO_CATEGORY])
                ->orWhere(['tipo' => TIPO_CATEGORY_PRO]);
        });
    }

    private function baseEmpresa()
    {
        $fieldsWhere = [
            'pais' => PAIS
        ];

        if($this->urlA == 'editar'){
            $fieldsWhere['ID'] = $this->urlB;
            $fieldsWhere['user_ID'] = $this->pol['user_ID'];
        }else{
            $fieldsWhere['url'] = $this->urlB;
        }

        $empresa = Empresa::where($fieldsWhere);

       return $empresa;
    }

    public function getCategory()
    {
        $fieldsWhere = [];

        if($this->urlA == 'editar'){
            $fieldsWhere['id'] = $this->getEmpresa()->cat_ID;
        }else{
            $fieldsWhere['url'] = $this->urlA;
        }

        return $this->baseQuery()
                    ->where($fieldsWhere)
                    ->first();
    }

    public function getEmpresa()
    {
        return $this->baseEmpresa()->first();
    }


    public function indexCategorias()
    {
        $categories = $this->baseQuery()
                        ->orderBy('orden')
                        ->get();

        return $this->blade->make('empresas.index', [ 
            'categories' => $categories,
            'pols_empresa' => $this->pol['config']['pols_empresa']
            ]);
    }


    public function verCategoria()
    {
        $categoria = $this->getCategory();
        return $this->blade->make('empresas.categorias', ['categoria' => $categoria]);
    }


    public function verEmpresa()
    {
        $empresa = $this->getEmpresa();

        //Actualiza visita
        $empresa->increment('pv');

        return $this->blade->make('empresas.empresa', [
            'empresa' => $empresa, 
            'pol' => $this->pol
        ]);
    }

    public function crearEmpresa()
    {
        $categories = $this->baseQuery()
                    ->orderBy('orden')
                    ->get();

        return $this->blade->make('empresas.crear', [
            'categories' => $categories,
            'pols_empresa' => $this->pol['config']['pols_empresa']
        ]);
    }


    public function editarEmpresa()
    {
        $empresa = $this->getEmpresa();
        
        return $this->blade->make('empresas.editar', [
            'empresa' => $empresa,
            'pols_empresa' => $this->pol['config']['pols_empresa']
        ]);
    }



    /**
     * ACCIONES NUEVAS
     */


    /**
     * Funcion de trabajar para empleados
     */

    public function accionTrabajar($empresa_ID)
    {
        
        $empresa = Empresa::find($empresa_ID);

        $trabajador = $empresa->soyEmpleado($this->pol['user_ID']);

        // yo trabajo para la empresa?
        if($trabajador){
            
            // tengo energia para trabajar?
            if($trabajador->user->energia > ENERGIA_TRABAJAR){

                // la empresa tiene fondos para pagar ?
                if($empresa->cuenta->pols >= $trabajador->sueldo ){

                    // Trabajar

                    $impuesto_trabajo = $this->pol['config']['impuestos_trabajo'];


                    $empresaTrabajo = new EmpresaTrabajo();
                    $empresaTrabajo->user_ID = $trabajador->user_ID;
                    $empresaTrabajo->empresa_ID = $empresa_ID;
                    $empresaTrabajo->salario_bruto = $trabajador->sueldo;
                    $empresaTrabajo->salario_neto = $trabajador->sueldo * ( (100-$impuesto_trabajo)/100 );
                    $empresaTrabajo->salario_impuesto = $trabajador->sueldo * ($impuesto_trabajo/100);
                    $empresaTrabajo->recursos_generados = RECURSOS_TRABAJO;
                    $empresaTrabajo->fecha = date('Y-m-d H:i:s');
                    $empresaTrabajo->save();



                }

            }


        }else{
            
        }

        print_r($this->pol['config']['impuestos_trabajo'] ); die();

        

        


        // trabajemos




    }


}