<br /><div class="amarillo">{!! html_entity_decode($empresa->descripcion,ENT_COMPAT , 'UTF-8') !!}</div>

<p class="azul">{{ _('Fundador') }}: <b> {!! crear_link($empresa->user->nick ) !!}</b> | {{ _('creación') }}: <em> {{ explodear(" ", $empresa->time, 0) }} </em> | {{ _('sector') }} : <a href="/empresas/{{ $empresa->categoria->url }} ">{{ $empresa->categoria->nombre }}</a> | {{ _('cuenta') }}: #{{ $empresa->cuenta->ID }}  | {{ _('visitas') }}: {{ $empresa->pv }}</p>

@foreach ( $empresa->soyEmpleado($pol['user_ID']) as $miEmpleado)
<div class="azul"> 
    <table>
        <tr>
            <th> {!! crear_link($miEmpleado->user->nick ) !!} </th>
            <th> Energia</th>
            <th> Sueldo Bruto</th>
            <th> Impuesto Trabajo</th>
            <th></th>
        </tr>
        <tr>
            <td> </td>
            <td> -{{ ENERGIA_TRABAJAR }}% </td>
            <td> {!! pols($miEmpleado->sueldo) !!} {!! MONEDA !!} </td>
            <td> {!! pols(-$miEmpleado->sueldo * ( ($pol['config']['impuestos_trabajo']) /100) ) !!} {!! MONEDA !!} </td>
            <td> 
                <form action="/accion.php?a=empresa&b=trabajar&ID={{ $empresa->ID }}" method="post">
                {!! boton( _('Trabajar'), 'submit', false, 'green') !!}
                </form> 
            </td>
        <tr>

    </table>
</div>
@endforeach

<fieldset>
    <legend>Mis empleados</legend>
    <table width="100%" border="0" cellpadding="3" cellspacing="0">
        <tr class="alt first">
            <th>Empleado</th>
            <th>Sueldo</th>
            <th>acciones</th>

        </tr>
        @foreach ($empresa->empleados as $empleado)
            <tr align="center">
                <td> {!! crear_link($empleado->user->nick ) !!} </td>
                <td> {!! pols($empleado->sueldo) !!} {!! MONEDA !!}</td>
            </tr>
        @endforeach
    </table>
</fieldset>


<fieldset class="verde">
    <legend>
        Recursos
    </legend>
    <p>  <b>Total Recursos:</b> {{ 90 }} {!! TRIGO !!} </p>

</fieldset>



<br>

@if ($empresa->user->ID == $pol['user_ID'])
<table width="100%">
    <tr>
 	    <td>
            <form action="/accion.php?a=empresa&b=acciones&ID={{ $empresa->ID }}" method="post">
            {{ _('Ceder acciones a') }}: <input type="text" name="nick" size="8" maxlength="20" value="" /> <br>
            {{ _('Cantidad de acciones a') }}: <input type="text" name="cantidad" size="8" maxlength="3" value="" /> <br>
            {!! boton( _('Ceder'), 'submit', false, 'small' )  !!} [ {{ _('En desarrollo') }} ]
            </form>
        </td>

        <td align="right">
            <form action="/accion.php?a=empresa&b=ceder&ID={{ $empresa->ID }}" method="post">
                {!! boton( _('Ceder a'), 'submit', false, 'small') !!}
                <input type="text" name="nick" size="8" maxlength="20" value="" />
            </form>

            {!! boton('X', "/accion.php?a=empresa&b=eliminar&ID=$empresa->ID", '¿Estas seguro de querer ELIMINAR definitivamente esta empresa?', 'red') !!} 

            {!! boton(_('Editar'), "/empresas/editar/$empresa->ID") !!}
        </td>

    </tr>
</table>
@endif