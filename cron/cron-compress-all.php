<?php # POL.VirtualPol.com — Copyright (c) 2008 Javier González González <gonzo@virtualpol.com> — MIT License 



/* Este script unifica y comprime (minified) archivos js y css por optimización. */


function minify_css($t) {
	$t = preg_replace('#\s+#', ' ', $t);
	$t = preg_replace('#/\*.*?\*/#s', '', $t);
	$t = str_replace('; ', ';', $t);
	$t = str_replace(': ', ':', $t);
	$t = str_replace(' {', '{', $t);
	$t = str_replace('{ ', '{', $t);
	$t = str_replace(', ', ',', $t);
	$t = str_replace('} ', '}', $t);
	$t = str_replace(';}', '}', $t);
	$t = str_replace('  ', ' ', $t);
	return trim($t);
}

function minify_js($t) {
	//$t = preg_replace("/((?:\/\*(?:[^*]|(?:\*+[^*\/]))*\*+\/)|(?:\/\/.*))/", "", $t); /* elimina comentarios */
	//$t = str_replace(array("\r\n", "\r", "\t", "\n", '  ', '    ', '     '), '', $t); /* elimina tabulador, espacios, lineas nuevas, etc. */
	$t = preg_replace(array('(( )+\))','(\)( )+)'), ')', $t); /* elimina otros espacios antes y despues */
	return $t;
}

function compress_file($file, $tipo='js') {
	$result = file_get_contents('img/'.$file);
	$len_antes = strlen($result);
	echo '<tr><td><b>'.strtoupper($tipo).'</b></td><td>'.$file.'</td><td align="right"><b>'.num($len_antes).'</b>bytes</td>';
	switch ($tipo) {
		case 'js': $result = minify_js($result);  break;
		case 'css': 
			$result = minify_css($result); 
			break;
	}
	$len_ahora = strlen($result);
	echo '<td align="right">- <b>'.num($len_antes-$len_ahora).'</b>bytes = </td><td align="right"><b>'.num($len_ahora).'</b>bytes</td><td align="right">'.num(100-(($len_ahora*100)/$len_antes), 1).'%</td></tr>';
	$result = '/* '.$file.' */'."\n".$result."\n";
	return $result;
}


echo '<h2>Minify CSS</h2>

<table>';
$txt_css .= compress_file('style2.css', 'css');
file_put_contents('img/style_all.css', $txt_css);
echo '</table>';

echo '<h2>Minify JS</h2>

<table>';

$txt_js .= compress_file('scripts2.js', 'js');


// Variable JS para internacionalización
$txt_js .= '_ = {';
foreach (array('Ahora', 'ahora', 'años', 'meses','días','horas','minutos','min','seg','Pocos segundos','Segundos','En','Hace') AS $d) { 
	$txt_js .= '"'.$d.'":"'._($d).'",';
}
$txt_js .= '};';
//$txt_js .= 'ACCION_URL = "/accion/";';

file_put_contents('img/scripts_all.js', $txt_js);
echo '</table>';






// Funcion ubicada aqui porque no estorba. En algun sitio tiene que estar. Es solo para indexar en gettext.
function indexar_i18n() {
	// Funcion inutil, cuyo unico fin es indexar textos del sistema en el sistema gettext de i18n
	
	// tipos votacion
	$null = _('sondeo')._('referendum')._('parlamento')._('cargo')._('elecciones')._('votación');
	$null = _('Sondeo')._('Referendum')._('Parlamento')._('Cargo')._('Elecciones')._('Votación');
	
	// Tipos nucleo acceso
	$null = _('Privado') . _('Excluir')._('Afiliado')._('Confianza')._('Cargo')._('Grupos') . _('Nivel')._('Antiguedad')._('Autentificacion')._('Supervisores censo')._('Ciudadanos') . _('Ciudadanos global')._('Anonimos');
	
	// Estados votacion
	$null = _('ok')._('end')._('del')._('borrador');
	
	// Tiempos
	$null = _('años')._('meses')._('semanas')._('días')._('horas')._('minutos')._('segundos')._('Pocos segundos')._('Segundos');

	// Otros
	$null = _('puntos')._('estandar')._('multiple')._('ninguno') . _('turista')._('extranjero')._('ciudadano')._('expulsado')._('validar')._('borrado')._('activo') . _('inactivo')._('cancelado')._('cancelar')._('En')._('Hace')._('min')._('seg');
}



