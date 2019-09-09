<br /><div class="amarillo">{!! html_entity_decode($empresa->descripcion,ENT_COMPAT , 'UTF-8') !!}</div>

<p class="azul">{{ _('Fundador') }}: <b> {!! crear_link($empresa->user->nick ) !!}</b> | {{ _('creación') }}: <em> {{ explodear(" ", $empresa->time, 0) }} </em> | {{ _('sector') }} : <a href="/empresas/{{ $empresa->categoria->url }} ">{{ $empresa->categoria->nombre }}</a> | {{ _('visitas') }}: {{ $empresa->pv }}</p>



<div class="azul"> 
    <table>
        <tr>
            <th> {!! crear_link($empresa->user->nick ) !!} </th>
            <th> Energia</th>
            <th> Sueldo Bruto</th>
            <th> Impuesto Trabajo</th>
            <th></th>
        </tr>
        <tr>
            <td> </td>
            <td> -10% </td>
            <td> {!! pols(10) !!} {!! MONEDA !!} </td>
            <td> {!! pols(-1) !!} {!! MONEDA !!} </td>
            <td> 
                <form action="/accion.php?a=empresa&b=trabajar&ID={{ $empresa->ID }}" method="post">
                {!! boton( _('Trabajar'), 'submit', false, 'green') !!}
                </form> 
            </td>
        <tr>

    </table>
</div>

<table>
    <tr>
        <th>Empleado</th>
        <th>Sueldo</th>
        <th>acciones</th>

    </tr>
    @foreach ($empresa->empleados as $empleado)
        <tr>
            <td> {!! crear_link($empleado->user->nick ) !!} </td>
            <td> {!! pols($empleado->sueldo) !!} {!! MONEDA !!}</td>
        </tr>
    @endforeach
</table>

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