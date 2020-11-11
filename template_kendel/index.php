<?php # POL.VirtualPol.com — Copyright (c) 2008 Javier González González <gonzo@virtualpol.com> — MIT License 


// Errores y redirecciones.
if ($_SERVER['HTTP_HOST'] == 'ninguno.'.DOMAIN) { redirect('/'); }
if (isset($_GET['noti'])) { notificacion('visto', $_GET['noti']); }
//if (!isset($txt)) { $txt_nav = array('Error'); header('HTTP/1.1 404 Not Found'); $txt = '<h1 style="font-weight:normal;">ERROR 404: <b>'._('Página inexistente').'</b></h1>'; }
if (isset($_GET['error'])) { header('HTTP/1.1 401 Unauthorized'); $txt = '<h1 style="font-weight:normal;color:red;">ERROR: <b>'.escape(base64_decode($_GET['error'])).'</b></h1>'; }
if (!isset($pol['config']['pais_des'])) { $pol['config']['pais_des'] = _('Plataforma cerrada'); }
if (isset($txt_title)) { $txt_title .= ' - '.$pol['config']['pais_des']; }
else { $txt_title = $pol['config']['pais_des']; }



// Tapiz de fondo (1400x100)
if (isset($_GET['bg'])) { 
	$body_bg = 'url(\'//'.$_GET['bg'].'\')';
} else if (isset($pol['config']['bg'])) { 
	$body_bg = 'url(\''.IMG.'bg/'.$pol['config']['bg'].'\')'; 
} else { $body_bg = 'none'; }

?>
<!DOCTYPE html>
<html lang="<?=(isset($vp['lang'])?substr($vp['lang'],0,2):'es')?>">
<head>
<title><?=$txt_title?></title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<meta name="description" content="<?=(isset($txt_description)?$txt_description:$txt_title.' - '.$kw)?>" />

<meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
  <link rel="stylesheet" type="text/css" href="/img/style2.css?v=<?=VER?>" media="all" />
<link rel="stylesheet" type="text/css" href="/img/kendel_style.css" media="all" />
<style type="text/css">
#header { background:#FFF <?=$body_bg?> repeat scroll top left; }
</style>

<link href="/img/lib/font-awesome.min.css" rel="stylesheet">

<script type="text/javascript">
var _sf_startpt=(new Date()).getTime();
IMG = '/img/';
ACCION_URL = "/accion/";
p_scroll = false;
</script>


<link rel="shortcut icon" href="/favicon.ico" />
<link rel="image_src" href="/img/banderas/<?=PAIS?>.png" />

<?=$txt_header?>


<?php

foreach ((array)$maxsim['autoload'] AS $file)
	if (substr($file,-4)==='.css')
		echo '<link rel="stylesheet" enctype="text/css" href="/'.$file.'" media="all" />'."\n";

echo '
<style type="text/css">
'.$maxsim['template']['css'].'
</style>';

?>


<script type="text/javascript">
<?php
foreach ((array)$maxsim['template']['js_array'] AS $key => $value)
    echo $key.' = "'.str_replace('"', '\"', $value).'";'."\n";
?>
</script>

</head>


<body>
<div id="main" class="container main">
	<div id="header" class="row p-0 m-0">
		<div class="col-sm-2 p-0 m-0">
				<a href="/"><img class="img-fluid mh-100" src="/img/banderas/<?=PAIS?>_logo.png" alt="<?=PAIS?>" /></a>
		</div>
		<div class="row"></div>
		<div class="col-sm-10">
			<div class="row mb-5">
				<div class="col-sm-4">
					<span class="htxt"><?=$pol['config']['pais_des']?></span>
				</div>
				<div class="col-sm-8">
					<div class="float-sm-right">
						<?php
						unset($txt_header);
						if (isset($pol['user_ID'])) {
						echo '<span class="htxt">'.($pol['estado']=='extranjero'||$pol['estado']=='turista'?'<span style="margin-left:-10px;">'.boton(_('Solicitar ciudadanía'), '/registrar', false, 'small red').'</span>':'').' <a href="/perfil/'.$pol['nick'].'"><b>'.$pol['nick'].'</b>'.($pol['cargo']!=0&&$pol['cargo']!=99?' <img src="'.IMG.'cargos/'.$pol['cargo'].'.gif" width="16" height="16" alt="cargo" />':'').'</a>'.($pol['estado']!='ciudadano'?' (<b class="'.$pol['estado'].'">'.ucfirst($pol['estado']).'</b>)':'').(nucleo_acceso('supervisores_censo')?' | <a href="/sc">SC</a>':'').($pol['estado']=='extranjero'?'':' | <a href="/msg" title="'._('Mensajes privados').'"><span class="icon medium" data-icon="@"></span></a> ').(ECONOMIA&&$pol['estado']=='ciudadano'?' | <a href="/pols"><b>'.pols($pol['pols']).'</b> '.MONEDA.'</a>':'').' | <a href="/registrar/login/panel" title="'._('Opciones').'"><span class="icon medium" data-icon="z"></span></a> | <a href="/accion/logout"><b>'._('Salir').'</b></a></span>';
						} else {
						echo boton(_('Crear ciudadano'), '/registrar', false, 'large green').' '.boton(_('Iniciar sesión'), '/registrar/login?r='.$_SERVER['REQUEST_URI'], false, 'large blue');
						}
						?>
					</div>
				</div>
			</div>
			<div class="row align-items-end mt-5">
					<div class="col-sm-6">
						<div class="btn-group btn-group-lg">
								<a class="btn btn-light rounded-0" href="/"><img src="/img/ico/home.png" width="18" height="18" alt="home" style="margin:-4px;" /></a>
								<?php 
									foreach ($txt_nav AS $u => $a) {
									 	echo '<a class="btn btn-light" href="'.(!is_numeric($u)?$u:'#').'">'.$a.'</a>'; 
									 } ?>
						</div>	
					</div>

					<div class="col-sm-6">
						

						<ul class="ttabs right">
						
						<?php 
						foreach ($txt_tab AS $u => $a) { echo '<li'.(!is_numeric($u)&&$_SERVER['REQUEST_URI']==$u?' class="current"':'').'><a href="'.(!is_numeric($u)?$u:'#').'">'.$a.'</a></li>'; }
						?>
						</ul>
					</div>

			</div>	
		</div>
	</div>

	<div class="row overflow-auto">
		<div class="d-none d-sm-block col-sm-2">
			<div id="accordion">
				<div class="card">
					<div class="card-header">
						<a class="card-link" data-toggle="collapse" href="#collapseComunicacion"> <?=_('Comunicación')?>
						</a>
					</div>
					<div id="collapseComunicacion" class="collapse list-group" data-parent="#accordion">
						<a class="list-group-item list-group-item-action" href="/chat/list"><?=_('Chats')?></a>
						<a class="list-group-item list-group-item-action"  href="/foro"><?=_('Foros')?></a>
						<a class="list-group-item list-group-item-action"  href="/msg"><?=_('Mensajes privados')?></a>
					</div>
					<div class="card-header">
						<a class="card-link" data-toggle="collapse" href="#collapseInformacion"> <?=_('Información')?>
						</a>
					</div>
					<div id="collapseInformacion" class="collapse list-group" data-parent="#accordion">
						<a class="list-group-item list-group-item-action"  href="/msg"><?=_('Mensajes privados')?></a>
						<a class="list-group-item list-group-item-action" href="/info/censo"><?=_('Censo')?><span class="md"><?=num($pol['config']['info_censo'])?></span></a>
						<a class="list-group-item list-group-item-action" href="/doc"><b><?=_('Documentos')?></b><span class="md"><?=$pol['config']['info_documentos']?></span></a>
						<a class="list-group-item list-group-item-action" href="/info/supervision-del-censo"><?=_('Supervisión censo')?></a>
					</div>
					<div class="card-header">
						<a class="card-link" data-toggle="collapse" href="#collapseDemocracia"> <?=_('Democracia')?>
						</a>
					</div>
					<div id="collapseDemocracia" class="collapse list-group" data-parent="#accordion">
						<a class="list-group-item list-group-item-action" href="/elecciones"><?=_('Elecciones')?></a>
						<a class="list-group-item list-group-item-action" href="/votacion"><?=_('Votaciones')?><span class="md"><?=$pol['config']['info_consultas']?></span></a>
						<a class="list-group-item list-group-item-action" href="/cargos"><?=_('Cargos')?></a>
						<a class="list-group-item list-group-item-action" href="/control/judicial"><?=_('Judicial')?></a>
						<a class="list-group-item list-group-item-action" href="/control/gobierno"><?=_('Gobierno')?></a>
						<a class="list-group-item list-group-item-action" href="/partidos"><?=_('Partidos')?> <span class="md"><?=$pol['config']['info_partidos']?></span></a>
					</div>
					<div class="card-header">
						<a class="card-link" data-toggle="collapse" href="#collapseEconomia"> <?=_('Economia')?>
						</a>
					</div>
					<div id="collapseEconomia" class="collapse list-group" data-parent="#accordion">
						<a class="list-group-item list-group-item-action" href="/pols/cuentas"><?=_('Cuentas')?></a>
						<a class="list-group-item list-group-item-action" href="/empresas"><b><?=_('Empresas')?></b></a>
						<a class="list-group-item list-group-item-action" href="/pols"><?=_('Tus monedas')?></a>
						<a class="list-group-item list-group-item-action" href="/subasta"><?=_('Subastas')?></a>
						<a class="list-group-item list-group-item-action" href="/mapa"><?=_('Mapa')?></a>
						<a class="list-group-item list-group-item-action" href="/info/economia"><?=_('Economía global')?></a>
					</div>
				</div>					
			</div>

				<div style="overflow: hidden">

					<?php


					if (($pol['config']['socios_estado']=='true') AND (nucleo_acceso('ciudadanos')) AND (!nucleo_acceso('socios'))) {
						echo '<p style="text-align:center;">'.boton(_('Inscríbete como socio'), '/socios', false, 'orange small').'</p>';
					}




					echo '<p id="palabras">';

					foreach(explode(';', $pol['config']['palabras']) as $t) {
						$t = explode(':', $t);
						echo ($t[1]!=''?'<a href="//'.$t[1].'">'.$t[2].'</a>':$t[2]).($pol['user_ID']==$t[0]||nucleo_acceso($vp['acceso']['control_gobierno'])?' <a href="/subasta/editar" style="float:right;color:#CCC;">#</a>':'').'<br />';
					}

					echo '</p>';

					if (ECONOMIA AND substr($_SERVER['REQUEST_URI'], 0, 5) != '/mapa') {
						echo '<a href="/mapa" class="gris" style="float:right;">'._('mapa').'</a><a href="/subasta" class="gris">'._('Subasta').'</a>';
						if (!isset($cuadrado_size)) { $cuadrado_size = 16; }
						include('mapa/mapa.php');
						echo '<div style="margin:4px 0 0 6px;">'.$txt_mapa.'</div>';
					}
					?>


				</div>
		</div>


		<div class="col-sm-10 col-xs-12">
			<?=$echo?>
		</div>
	</div>



	<div class="row">


		<div class="col-sm-10">
			<?php
			echo '<table><tr><td height="30" nowrap="nowrap"><b>'.$pol['config']['pais_des'].'</b>'.(PRE?' &nbsp; <span style="color:red;font-size:24px;"><b>PRE-PRODUCCION</b></span>':'').'</td></tr></table>';

			if ((ECONOMIA) AND (isset($pol['config']['pols_frase']))) {
				echo '<div class="amarillo"><b>'.$pol['config']['pols_frase'].'</b></div>';
				if ($pol['config']['pols_fraseedit'] == $pol['user_ID']) { echo ' <a href="/subasta/editar" class="gris">#</a>'; }
			}

			if ((isset($pol['user_ID'])) AND ($pol['config']['palabra_gob'] != '')) {
				echo '<fieldset class="rich">'.(nucleo_acceso($vp['accesos']['control_gobierno'])?'<span style="float:right;"><a href="/control/gobierno">Editar</a></span>':'').$pol['config']['palabra_gob'].'</fieldset>';
			}
			?>	
		</div>

		<div  class="col-sm-2" style="text-align:center;">
			<p>
			<a href="/" title="VirtualPol"><img src="/img/logo/vp2.png" width="200" height="60" alt="VirtualPol" /></a>
			</p>
			
			<p><a target="_blank" href="/video"><?=_('Vídeo')?></a> | <a target="_blank" href="/documentacion"><?=_('Documentación')?></a> | <a target="_blank" href="/desarrollo"><?=_('Desarrollo')?></a> | <a target="_blank" href="/TOS" title="Condiciones de Uso">TOS</a><br />
			<span title="Epoca antigua en IRC" style="color:#999;">2004-</span>2008-2020
			<br />
			<span style="color:#BBB;">
				<?=implode(' ', profiler($maxsim['debug']['crono']))?>
			</span>
			</p>
		</div>

	</div>
</div>
<fieldset id="pnick" style="display:none;"></fieldset>


<script type="text/javascript">
/* GA */
var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-59186-46']);
_gaq.push(['_setDomainName', '.virtualpol.com']);
_gaq.push(['_trackPageview']);
(function() {
var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
})();


</script>
<script type="text/javascript" src="/img/scripts2.js?v=<?=VER?>"></script>

		<!--
	  <script src="/img/emoji/js/config.js"></script>
	  <script src="/img/emoji/js/util.js"></script>
	  <script src="/img/emoji/js/jquery.emojiarea.js"></script>
	  <script src="/img/emoji/js/emoji-picker.js"></script>
	  -->



<?php
foreach ((array)$maxsim['autoload'] AS $file)
	if (substr($file,-3)==='.js')
		echo '<script type="module" src="/'.$file.'"></script>'."\n";
?>

<script type="text/javascript">
<?=$maxsim['template']['js']?>
</script>



</body>
<?=$txt_footer?>

</html>