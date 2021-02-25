<?php # POL.VirtualPol.com — Copyright (c) 2008 Javier González González <gonzo@virtualpol.com> — MIT License 

$maxsim['output'] = 'text';

// Takes raw data from the request
$json = file_get_contents('php://input');

// Converts it into a PHP object
$data = json_decode($json);

error_log("Recibida peticion ".$data);


$ok = "OK";

return json_encode($ok);