<?php # POL.VirtualPol.com — Copyright (c) 2008 Javier González González <gonzo@virtualpol.com> — MIT License 

$maxsim['output'] = 'text';
error_log("GET!: ".$_GET[1]);
if ($_GET[1] == 'log' AND nucleo_acceso($vp['acceso']['kick'])){
    error_log("SELECT msg_ID, msg, chat_ID, nick
    FROM chats_msg_log
    WHERE msg_ID = '".$_GET['ID']."' 
    ORDER BY ID");

    $res = mysql_query_old("SELECT msg_ID, msg, chat_ID, nick
            FROM chats_msg_log
            WHERE msg_ID = '".$_GET['ID']."' 
            ORDER BY ID");
    $resultado = array();
    while ($result = r($res)){
        array_push($resultado, $result);
    }
    print_r(json_encode($resultado));
}else{
    // Takes raw data from the request
    $json = file_get_contents('php://input');
    $data = json_decode($json);

    sql_old("INSERT INTO chats_msg_log (msg_ID, msg, chat_ID, nick)
            SELECT msg_ID, msg, chat_ID, nick
            FROM chats_msg
            WHERE msg_ID = '".$data->messageId."' ");
    sql_old("UPDATE chats_msg set msg = '".$data->text."', modificado = true WHERE msg_ID = '".$data->messageId."'");

    $resultado['actualizado'] = 'ok';
    print_r(json_encode($resultado));
}