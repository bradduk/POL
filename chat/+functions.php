<?php # POL.VirtualPol.com — Copyright (c) 2008 Javier González González <gonzo@virtualpol.com> — MIT License 




$txt_menu = 'comu';


function acceso_check($chat_ID, $ac=null) {
	global $link;
	if (isset($ac)) { $check = array($ac); } else { $check = array('leer','escribir','escribir_ex'); }
	$result = mysql_query_old("SELECT HIGH_PRIORITY acceso_leer, acceso_escribir, acceso_escribir_ex, acceso_cfg_leer, acceso_cfg_escribir, acceso_cfg_escribir_ex, pais FROM chats WHERE chat_ID = ".$chat_ID." LIMIT 1");
	while ($r = r($result)) { 
		foreach ($check AS $a) { $acceso[$a] = nucleo_acceso($r['acceso_'.$a], $r['acceso_cfg_'.$a]); }
	}
	if (isset($ac)) { return $acceso[$ac]; } else { return $acceso; }
}

/* ID CARGO 00:00 NICK MSG
m0 - m normal
p - m privado
e - evento
c - print comando
*/
function chat_refresh($chat_ID, $msg_ID=0) {
	global $link, $_SESSION;
	$t = '';

	if (acceso_check($chat_ID, 'leer') === true) { // Permite leer  

		error_log("SELECT HIGH_PRIORITY msg_ID, tipo, time, c.nick as nick, u.ID as user_ID, msg FROM chats_msg c, users u 
		WHERE chat_ID = ".$chat_ID." AND SUBSTRING_INDEX(c.nick, '&rarr;', 1) = u.nick AND 
		msg_ID > ".$msg_ID."".(isset($_SESSION['pol']['user_ID'])?" AND (user_ID = '0' OR user_ID = ".$_SESSION['pol']['user_ID']." OR (tipo = 'p' AND nick LIKE '".$_SESSION['pol']['nick']."&rarr;%'))":" AND tipo != 'p'")." 
		ORDER BY msg_ID DESC LIMIT 1000");

		$res = mysql_query_old("SELECT HIGH_PRIORITY c.cargo as cargo, msg_ID, tipo, time, c.nick as nick, u.ID as user_ID, msg FROM chats_msg c, users u 
WHERE chat_ID = ".$chat_ID." AND SUBSTRING_INDEX(c.nick, '&rarr;', 1) = u.nick AND 
msg_ID > ".$msg_ID."".(isset($_SESSION['pol']['user_ID'])?" AND (user_ID = '0' OR user_ID = ".$_SESSION['pol']['user_ID']." OR (tipo = 'p' AND c.nick LIKE '".$_SESSION['pol']['nick']."&rarr;%'))":" AND tipo != 'p'")." 
ORDER BY msg_ID DESC LIMIT 1000");
		$result = [];
		while ($r = r($res)) {
			$t = [];
			$t['msg_ID'] = $r['msg_ID'];
			$t['tipo'] = $r['tipo']!='m'?$r['tipo']:$r['cargo'];
			$t['time'] = substr($r['time'], 11, 5);
			$t['nick'] = $r['nick'];
			$t['user_ID'] = $r['user_ID'];
			$t['msg'] = $r['msg'];

			$result[] = $t;
		}
		return $result;
	}
}
