-- virtualpol.api definition

CREATE TABLE `api` (
  `api_ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `item_ID` varchar(255) DEFAULT NULL,
  `pais` varchar(30) DEFAULT NULL,
  `tipo` enum('facebook','twitter') DEFAULT 'facebook',
  `estado` enum('activo','inactivo') DEFAULT 'activo',
  `nombre` varchar(255) DEFAULT NULL,
  `linea_editorial` text,
  `url` varchar(255) DEFAULT NULL,
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `acceso_escribir` text,
  `acceso_borrador` text,
  `clave` text,
  `num` mediumint(9) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`api_ID`),
  KEY `pais` (`pais`),
  KEY `estado` (`estado`),
  KEY `tipo` (`tipo`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;


-- virtualpol.api_posts definition

CREATE TABLE `api_posts` (
  `post_ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pais` varchar(255) DEFAULT NULL,
  `api_ID` mediumint(9) unsigned DEFAULT NULL,
  `estado` enum('publicado','cron','borrado','pendiente') NOT NULL DEFAULT 'pendiente',
  `mensaje_ID` varchar(900) DEFAULT NULL,
  `pendiente_user_ID` mediumint(8) unsigned DEFAULT NULL,
  `publicado_user_ID` mediumint(9) unsigned DEFAULT NULL,
  `borrado_user_ID` mediumint(8) unsigned DEFAULT NULL,
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `time_cron` datetime DEFAULT '0000-00-00 00:00:00',
  `message` text,
  `picture` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `source` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`post_ID`),
  KEY `pais` (`pais`),
  KEY `estado` (`estado`)
) ENGINE=MyISAM AUTO_INCREMENT=89 DEFAULT CHARSET=utf8;


-- virtualpol.articulo definition

CREATE TABLE `articulo` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `publico` enum('true','false') NOT NULL DEFAULT 'false',
  `ID_usuario` int(11) unsigned NOT NULL,
  `ID_empresa` int(11) unsigned NOT NULL,
  `contenido` text NOT NULL,
  `titulo` text NOT NULL,
  `adelanto` text,
  `precio_suscriptores` float(11,2) unsigned DEFAULT NULL,
  `precio` float(11,2) unsigned DEFAULT NULL,
  `valoracion` int(5) unsigned NOT NULL,
  `valoracion_n_votos` int(11) unsigned NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;


-- virtualpol.articulo_comentarios definition

CREATE TABLE `articulo_comentarios` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Articulo` int(11) unsigned NOT NULL,
  `ID_Usuario` int(11) unsigned NOT NULL,
  `contenido` text NOT NULL,
  `fecha_creacion` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- virtualpol.articulo_usuario definition

CREATE TABLE `articulo_usuario` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_Articulo` int(11) unsigned NOT NULL,
  `ID_Usuario` int(11) unsigned NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;


-- virtualpol.cargos definition

CREATE TABLE `cargos` (
  `ID` smallint(6) NOT NULL AUTO_INCREMENT,
  `pais` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `cargo_ID` smallint(6) unsigned NOT NULL DEFAULT '0',
  `asigna` smallint(5) NOT NULL DEFAULT '7',
  `nombre` varchar(32) NOT NULL DEFAULT '',
  `nombre_extra` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `nivel` tinyint(3) NOT NULL DEFAULT '1',
  `num` smallint(5) NOT NULL DEFAULT '0',
  `salario` mediumint(9) unsigned NOT NULL DEFAULT '0',
  `autocargo` enum('true','false') CHARACTER SET utf8 NOT NULL DEFAULT 'false',
  `elecciones` datetime DEFAULT NULL,
  `elecciones_electos` tinyint(3) unsigned DEFAULT NULL,
  `elecciones_cada` smallint(5) unsigned DEFAULT NULL,
  `elecciones_durante` tinyint(3) unsigned DEFAULT NULL,
  `elecciones_votan` varchar(999) CHARACTER SET utf8 DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `nivel` (`nivel`),
  KEY `nombre` (`nombre`),
  KEY `asigna` (`asigna`),
  KEY `cargo_ID` (`cargo_ID`),
  KEY `pais` (`pais`),
  KEY `elecciones` (`elecciones`)
) ENGINE=MyISAM AUTO_INCREMENT=623 DEFAULT CHARSET=latin1;


-- virtualpol.cargos_users definition

CREATE TABLE `cargos_users` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `cargo_ID` smallint(5) NOT NULL DEFAULT '0',
  `pais` varchar(30) DEFAULT NULL,
  `user_ID` mediumint(8) NOT NULL DEFAULT '0',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `cargo` enum('true','false') NOT NULL DEFAULT 'false',
  `aprobado` enum('ok','no') NOT NULL DEFAULT 'ok',
  `nota` decimal(3,1) unsigned NOT NULL DEFAULT '0.0',
  PRIMARY KEY (`ID`),
  KEY `cargo` (`cargo`),
  KEY `user_ID` (`user_ID`),
  KEY `cargo_ID` (`cargo_ID`),
  KEY `aprobado` (`aprobado`),
  KEY `pais` (`pais`),
  KEY `nota` (`nota`)
) ENGINE=MyISAM AUTO_INCREMENT=13362 DEFAULT CHARSET=utf8;


-- virtualpol.cat definition

CREATE TABLE `cat` (
  `ID` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `pais` varchar(30) DEFAULT NULL,
  `url` varchar(80) NOT NULL DEFAULT '',
  `nombre` varchar(80) NOT NULL DEFAULT '',
  `num` smallint(6) unsigned NOT NULL DEFAULT '0',
  `nivel` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `tipo` enum('empresas','docs','cargos') NOT NULL DEFAULT 'docs',
  `orden` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `url` (`url`,`nivel`,`tipo`,`orden`,`nombre`,`num`),
  KEY `tipo` (`tipo`),
  KEY `orden` (`orden`)
) ENGINE=MyISAM AUTO_INCREMENT=111 DEFAULT CHARSET=utf8;


-- virtualpol.chats definition

CREATE TABLE `chats` (
  `chat_ID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `estado` enum('activo','bloqueado','en_proceso','expirado','borrado') NOT NULL DEFAULT 'en_proceso',
  `pais` varchar(30) DEFAULT NULL,
  `url` varchar(90) NOT NULL,
  `titulo` varchar(90) NOT NULL,
  `user_ID` mediumint(8) unsigned NOT NULL,
  `admin` varchar(900) NOT NULL DEFAULT '',
  `acceso_leer` varchar(30) NOT NULL DEFAULT 'anonimos',
  `acceso_escribir` varchar(30) DEFAULT 'ciudadanos_global',
  `acceso_escribir_ex` varchar(30) NOT NULL DEFAULT 'ciudadanos_global',
  `acceso_cfg_leer` varchar(900) DEFAULT '',
  `acceso_cfg_escribir` varchar(900) DEFAULT '',
  `acceso_cfg_escribir_ex` varchar(900) NOT NULL DEFAULT '',
  `fecha_creacion` datetime NOT NULL,
  `fecha_last` datetime NOT NULL,
  `dias_expira` smallint(5) unsigned DEFAULT NULL,
  `url_externa` varchar(500) DEFAULT NULL,
  `stats_visitas` int(12) unsigned NOT NULL DEFAULT '0',
  `stats_msgs` int(12) unsigned NOT NULL DEFAULT '0',
  `GMT` tinyint(2) NOT NULL DEFAULT '1',
  PRIMARY KEY (`chat_ID`),
  UNIQUE KEY `url` (`url`),
  KEY `estado` (`estado`),
  KEY `pais` (`pais`(1)),
  KEY `acceso_leer` (`acceso_leer`),
  KEY `acceso_escribir` (`acceso_escribir`),
  KEY `acceso_cfg_leer` (`acceso_cfg_leer`(333)),
  KEY `acceso_cfg_escribir` (`acceso_cfg_escribir`(333)),
  KEY `stats_msgs` (`stats_msgs`),
  KEY `fecha_last` (`fecha_last`),
  KEY `acceso_escribir_ex` (`acceso_escribir_ex`),
  KEY `acceso_cfg_escribir_ex` (`acceso_cfg_escribir_ex`)
) ENGINE=MyISAM AUTO_INCREMENT=724 DEFAULT CHARSET=latin1;


-- virtualpol.chats_msg definition

CREATE TABLE `chats_msg` (
  `msg_ID` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `chat_ID` smallint(5) unsigned NOT NULL,
  `nick` varchar(32) CHARACTER SET latin1 NOT NULL,
  `msg` varchar(900) CHARACTER SET latin1 NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `cargo` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `user_ID` mediumint(6) unsigned NOT NULL DEFAULT '0',
  `tipo` enum('m','p','e','c') CHARACTER SET latin1 NOT NULL DEFAULT 'm',
  `IP` bigint(12) DEFAULT NULL,
  `modificado` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`msg_ID`),
  KEY `chat_ID` (`chat_ID`),
  KEY `nick` (`nick`),
  KEY `time` (`time`),
  KEY `cargo` (`cargo`),
  KEY `user_ID` (`user_ID`),
  KEY `tipo` (`tipo`),
  KEY `msg` (`msg`(333)),
  KEY `IP` (`IP`)
) ENGINE=MyISAM AUTO_INCREMENT=4738329 DEFAULT CHARSET=utf8;


-- virtualpol.chats_msg_log definition

CREATE TABLE `chats_msg_log` (
  `ID` int(8) unsigned NOT NULL AUTO_INCREMENT,
  `msg_ID` int(8) unsigned NOT NULL,
  `chat_ID` smallint(5) unsigned NOT NULL,
  `nick` varchar(32) CHARACTER SET latin1 NOT NULL,
  `msg` varchar(900) CHARACTER SET latin1 NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=4738172 DEFAULT CHARSET=utf8;


-- virtualpol.config definition

CREATE TABLE `config` (
  `ID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `pais` varchar(30) DEFAULT NULL,
  `dato` varchar(100) NOT NULL DEFAULT '',
  `valor` text NOT NULL,
  `autoload` enum('si','no') NOT NULL DEFAULT 'si',
  PRIMARY KEY (`ID`),
  KEY `dato` (`dato`),
  KEY `autoload` (`autoload`),
  KEY `pais` (`pais`),
  KEY `valor` (`valor`(255))
) ENGINE=MyISAM AUTO_INCREMENT=731 DEFAULT CHARSET=utf8;


-- virtualpol.cuentas definition

CREATE TABLE `cuentas` (
  `ID` mediumint(8) NOT NULL AUTO_INCREMENT,
  `pais` varchar(30) DEFAULT NULL,
  `nombre` varchar(25) CHARACTER SET utf8 NOT NULL,
  `user_ID` mediumint(8) NOT NULL DEFAULT '0',
  `pols` int(10) NOT NULL DEFAULT '0',
  `nivel` tinyint(3) NOT NULL DEFAULT '0',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `exenta_impuestos` tinyint(1) NOT NULL DEFAULT '0',
  `gobierno` enum('true','false') CHARACTER SET utf8 DEFAULT 'false',
  `id_empresa` smallint(5) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `nombre` (`nombre`),
  KEY `user_ID` (`user_ID`),
  KEY `nivel` (`nivel`),
  KEY `pais` (`pais`)
) ENGINE=MyISAM AUTO_INCREMENT=595 DEFAULT CHARSET=latin1;


-- virtualpol.cuentas_apoderados definition

CREATE TABLE `cuentas_apoderados` (
  `ID` mediumint(8) NOT NULL AUTO_INCREMENT,
  `cuenta_ID` mediumint(8) NOT NULL,
  `user_ID` mediumint(8) NOT NULL,
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ID`),
  KEY `user_ID` (`user_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=593 DEFAULT CHARSET=latin1;


-- virtualpol.docs definition

CREATE TABLE `docs` (
  `ID` smallint(5) NOT NULL AUTO_INCREMENT,
  `pais` varchar(30) DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `title` varchar(255) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `text` longtext CHARACTER SET utf8 NOT NULL,
  `text_backup` longtext CHARACTER SET utf8 NOT NULL,
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `time_last` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `estado` enum('ok','del','borrador') CHARACTER SET utf8 NOT NULL DEFAULT 'ok',
  `cat_ID` tinyint(3) NOT NULL DEFAULT '0',
  `acceso_leer` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT 'anonimos',
  `acceso_escribir` varchar(30) CHARACTER SET utf8 NOT NULL DEFAULT 'privado',
  `acceso_cfg_leer` varchar(800) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `acceso_cfg_escribir` varchar(800) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `version` mediumint(9) unsigned NOT NULL DEFAULT '0',
  `pad_ID` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `estado` (`estado`),
  KEY `cat_ID` (`cat_ID`),
  KEY `url` (`url`),
  KEY `pais` (`pais`),
  KEY `time_last` (`time_last`),
  KEY `time` (`time`)
) ENGINE=MyISAM AUTO_INCREMENT=1681 DEFAULT CHARSET=latin1;


-- virtualpol.empresas definition

CREATE TABLE `empresas` (
  `ID` smallint(5) NOT NULL AUTO_INCREMENT,
  `pais` varchar(30) DEFAULT NULL,
  `url` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `nombre` varchar(40) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `user_ID` mediumint(8) NOT NULL DEFAULT '0',
  `descripcion` text CHARACTER SET utf8 NOT NULL,
  `web` varchar(200) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `cat_ID` smallint(6) NOT NULL DEFAULT '0',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pv` int(10) unsigned NOT NULL DEFAULT '0',
  `precio_suscripcion` float(9,2) DEFAULT NULL,
  `periodicidad_suscripcion` enum('D','S','P','B','U') DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `url` (`url`,`cat_ID`),
  KEY `cat_ID` (`cat_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=824 DEFAULT CHARSET=latin1;


-- virtualpol.empresas_acciones definition

CREATE TABLE `empresas_acciones` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `ID_empresa` mediumint(9) unsigned NOT NULL DEFAULT '0',
  `pais` varchar(30) DEFAULT NULL,
  `nick` varchar(300) CHARACTER SET utf8 COLLATE utf8_spanish_ci NOT NULL,
  `num_acciones` int(11) NOT NULL DEFAULT '100',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


-- virtualpol.empresas_suscriptores definition

CREATE TABLE `empresas_suscriptores` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ID_empresa` int(11) unsigned NOT NULL,
  `ID_usuario` int(11) unsigned NOT NULL,
  `fecha_alta` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `fecha_baja` datetime DEFAULT '0000-00-00 00:00:00',
  `precio_suscripcion` float(9,2) NOT NULL,
  `periodicidad_suscripcion` enum('D','S','P','B','U') NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;


-- virtualpol.examenes definition

CREATE TABLE `examenes` (
  `ID` mediumint(9) unsigned NOT NULL AUTO_INCREMENT,
  `pais` varchar(30) DEFAULT NULL,
  `titulo` varchar(255) DEFAULT NULL,
  `descripcion` text,
  `user_ID` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `cargo_ID` smallint(5) NOT NULL DEFAULT '0',
  `nota` varchar(5) NOT NULL DEFAULT '5',
  `num_preguntas` smallint(5) unsigned NOT NULL DEFAULT '1',
  `ID_old` mediumint(8) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `titulo` (`titulo`),
  KEY `nota` (`nota`),
  KEY `pais` (`pais`),
  KEY `cargo_ID` (`cargo_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=520 DEFAULT CHARSET=utf8;


-- virtualpol.examenes_preg definition

CREATE TABLE `examenes_preg` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pais` varchar(30) DEFAULT NULL,
  `examen_ID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `user_ID` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pregunta` text NOT NULL,
  `respuestas` text NOT NULL,
  `tiempo` varchar(6) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `pais` (`pais`),
  KEY `examen_ID` (`examen_ID`),
  KEY `user_ID` (`user_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=3522 DEFAULT CHARSET=utf8;


-- virtualpol.examenes_profesores definition

CREATE TABLE `examenes_profesores` (
  `ID` mediumint(9) unsigned NOT NULL AUTO_INCREMENT,
  `user_ID` mediumint(8) NOT NULL DEFAULT '0',
  `examen_ID` mediumint(9) unsigned NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=516 DEFAULT CHARSET=utf8;


-- virtualpol.expulsiones definition

CREATE TABLE `expulsiones` (
  `ID` smallint(5) NOT NULL AUTO_INCREMENT,
  `user_ID` mediumint(8) NOT NULL DEFAULT '0',
  `autor` mediumint(8) NOT NULL DEFAULT '0',
  `expire` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `razon` varchar(150) NOT NULL,
  `estado` enum('activo','inactivo','expulsado','cancelado','indultado') NOT NULL DEFAULT 'activo',
  `tiempo` varchar(20) NOT NULL DEFAULT '0',
  `IP` varchar(12) NOT NULL DEFAULT '0',
  `cargo` tinyint(3) unsigned NOT NULL DEFAULT '12',
  `motivo` text NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `user_ID` (`user_ID`),
  KEY `estado` (`estado`),
  KEY `IP` (`IP`),
  KEY `expire` (`expire`)
) ENGINE=MyISAM AUTO_INCREMENT=1514 DEFAULT CHARSET=latin1;


-- virtualpol.foros definition

CREATE TABLE `foros` (
  `ID` smallint(5) NOT NULL AUTO_INCREMENT,
  `subforo_ID` smallint(6) unsigned DEFAULT NULL,
  `url` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(50) NOT NULL DEFAULT '',
  `descripcion` varchar(255) NOT NULL DEFAULT '',
  `acceso` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `time` smallint(3) NOT NULL DEFAULT '1',
  `estado` enum('ok','eliminado') NOT NULL DEFAULT 'ok',
  `acceso_msg` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `acceso_leer` varchar(900) NOT NULL DEFAULT 'anonimos',
  `acceso_escribir` varchar(900) NOT NULL DEFAULT 'ciudadanos',
  `acceso_escribir_msg` varchar(900) NOT NULL DEFAULT 'ciudadanos',
  `acceso_cfg_leer` varchar(900) NOT NULL DEFAULT '',
  `acceso_cfg_escribir` varchar(900) NOT NULL DEFAULT '',
  `acceso_cfg_escribir_msg` varchar(900) NOT NULL DEFAULT '',
  `limite` tinyint(3) unsigned NOT NULL DEFAULT '8',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `url` (`url`),
  KEY `estado` (`estado`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;


-- virtualpol.foros_items definition

CREATE TABLE `foros_items` (
  `item_ID` int(9) unsigned NOT NULL AUTO_INCREMENT,
  `pais` varchar(255) DEFAULT NULL,
  `estado` enum('ok','borrado','cerrado') NOT NULL DEFAULT 'ok',
  `foro_ID` mediumint(9) unsigned DEFAULT NULL,
  `hilo_ID` mediumint(8) DEFAULT NULL,
  `parent_ID` mediumint(8) unsigned DEFAULT NULL,
  `nivel` tinyint(3) unsigned DEFAULT '1',
  `user_ID` mediumint(8) NOT NULL DEFAULT '0',
  `nick` varchar(20) DEFAULT NULL,
  `cargo` tinyint(3) NOT NULL DEFAULT '0',
  `title` varchar(80) NOT NULL DEFAULT '',
  `text` text NOT NULL,
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `time_last` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `num` smallint(5) NOT NULL DEFAULT '0',
  `votos` smallint(6) NOT NULL DEFAULT '0',
  `votos_num` mediumint(9) unsigned NOT NULL DEFAULT '0',
  `url_old` varchar(80) NOT NULL DEFAULT '',
  PRIMARY KEY (`item_ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC;


-- virtualpol.grupos definition

CREATE TABLE `grupos` (
  `grupo_ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pais` varchar(30) DEFAULT NULL,
  `nombre` varchar(255) NOT NULL DEFAULT '',
  `num` mediumint(8) NOT NULL DEFAULT '0',
  PRIMARY KEY (`grupo_ID`),
  KEY `num` (`num`),
  KEY `pais` (`pais`)
) ENGINE=MyISAM AUTO_INCREMENT=351 DEFAULT CHARSET=utf8;


-- virtualpol.hechos definition

CREATE TABLE `hechos` (
  `ID` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `pais` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `time` date NOT NULL,
  `nick` varchar(14) CHARACTER SET utf8 NOT NULL DEFAULT 'GONZO',
  `texto` varchar(2000) CHARACTER SET utf8 NOT NULL,
  `estado` enum('ok','del') CHARACTER SET utf8 NOT NULL DEFAULT 'ok',
  `time2` datetime NOT NULL,
  PRIMARY KEY (`ID`),
  KEY `time` (`time`,`estado`)
) ENGINE=MyISAM AUTO_INCREMENT=346 DEFAULT CHARSET=latin1;


-- virtualpol.kicks definition

CREATE TABLE `kicks` (
  `ID` mediumint(9) unsigned NOT NULL AUTO_INCREMENT,
  `pais` varchar(30) DEFAULT NULL,
  `user_ID` mediumint(9) unsigned NOT NULL DEFAULT '0',
  `autor` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `expire` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `razon` varchar(160) NOT NULL DEFAULT '',
  `estado` enum('activo','inactivo','expulsado','cancelado') NOT NULL DEFAULT 'activo',
  `tiempo` varchar(20) NOT NULL DEFAULT '0',
  `IP` varchar(12) NOT NULL DEFAULT '0',
  `cargo` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `motivo` text NOT NULL,
  `sc` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `pais` (`pais`,`user_ID`,`estado`,`expire`),
  KEY `estado` (`estado`),
  KEY `user_ID` (`user_ID`),
  KEY `IP` (`IP`),
  KEY `expire` (`expire`)
) ENGINE=MyISAM AUTO_INCREMENT=771 DEFAULT CHARSET=utf8;


-- virtualpol.log definition

CREATE TABLE `log` (
  `ID` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `pais` varchar(30) DEFAULT NULL,
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `user_ID` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `nick` varchar(20) NOT NULL DEFAULT '',
  `accion` text NOT NULL,
  `accion_a` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `pais` (`pais`),
  KEY `user_ID` (`user_ID`),
  KEY `time` (`time`)
) ENGINE=MyISAM AUTO_INCREMENT=46075 DEFAULT CHARSET=utf8;


-- virtualpol.mapa definition

CREATE TABLE `mapa` (
  `ID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `pais` varchar(30) CHARACTER SET utf8 DEFAULT NULL,
  `pos_x` tinyint(2) NOT NULL DEFAULT '1',
  `pos_y` tinyint(2) NOT NULL DEFAULT '1',
  `size_x` tinyint(2) NOT NULL DEFAULT '1',
  `size_y` tinyint(2) NOT NULL DEFAULT '1',
  `user_ID` mediumint(8) NOT NULL DEFAULT '1',
  `nick` varchar(255) DEFAULT NULL,
  `link` varchar(90) NOT NULL DEFAULT '',
  `text` varchar(90) NOT NULL DEFAULT '',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pols` mediumint(8) NOT NULL DEFAULT '0',
  `color` char(7) NOT NULL DEFAULT '',
  `estado` enum('p','v','e') NOT NULL DEFAULT 'p',
  `superficie` smallint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=951 DEFAULT CHARSET=latin1;


-- virtualpol.mapa_altura definition

CREATE TABLE `mapa_altura` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `parcela_ID` smallint(5) unsigned NOT NULL,
  `link` varchar(90) NOT NULL DEFAULT '',
  `text` varchar(90) NOT NULL DEFAULT '',
  `color` char(7) NOT NULL DEFAULT '',
  `altura` smallint(5) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=81 DEFAULT CHARSET=utf8;


-- virtualpol.mapa_barrios definition

CREATE TABLE `mapa_barrios` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pos_x` tinyint(2) NOT NULL DEFAULT '1',
  `pos_y` tinyint(2) NOT NULL DEFAULT '1',
  `size_x` tinyint(3) NOT NULL DEFAULT '1',
  `size_y` tinyint(3) NOT NULL DEFAULT '1',
  `nombre` text NOT NULL,
  `multiplicador_impuestos` decimal(5,2) DEFAULT NULL,
  `altura_maxima` smallint(5) DEFAULT NULL,
  `color` char(7) DEFAULT '#FFFFFF',
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;


-- virtualpol.mensajes definition

CREATE TABLE `mensajes` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `envia_ID` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `recibe_ID` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `text` text NOT NULL,
  `leido` enum('0','1') NOT NULL DEFAULT '0',
  `cargo` smallint(5) NOT NULL DEFAULT '0',
  `recibe_masivo` varchar(10) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `envia_ID` (`envia_ID`),
  KEY `recibe_ID` (`recibe_ID`),
  KEY `leido` (`leido`),
  KEY `time` (`time`)
) ENGINE=MyISAM AUTO_INCREMENT=271745 DEFAULT CHARSET=utf8;


-- virtualpol.notificaciones definition

CREATE TABLE `notificaciones` (
  `noti_ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `emisor` varchar(30) NOT NULL DEFAULT 'sistema',
  `visto` enum('true','false') NOT NULL DEFAULT 'false',
  `user_ID` mediumint(8) NOT NULL DEFAULT '0',
  `texto` varchar(60) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`noti_ID`),
  KEY `time` (`time`),
  KEY `visto` (`visto`),
  KEY `user_ID` (`user_ID`),
  KEY `url` (`url`),
  KEY `texto` (`texto`),
  KEY `emisor` (`emisor`)
) ENGINE=MyISAM AUTO_INCREMENT=344199 DEFAULT CHARSET=utf8;


-- virtualpol.partidos definition

CREATE TABLE `partidos` (
  `ID` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `pais` varchar(30) DEFAULT NULL,
  `ID_presidente` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `fecha_creacion` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `siglas` varchar(20) DEFAULT NULL,
  `nombre` varchar(50) DEFAULT NULL,
  `descripcion` text,
  `estado` enum('ok') NOT NULL DEFAULT 'ok',
  `ID_old` smallint(6) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `pais` (`pais`),
  KEY `ID_presidente` (`ID_presidente`),
  KEY `siglas` (`siglas`),
  KEY `estado` (`estado`)
) ENGINE=MyISAM AUTO_INCREMENT=189 DEFAULT CHARSET=utf8;


-- virtualpol.partidos_listas definition

CREATE TABLE `partidos_listas` (
  `ID` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `pais` varchar(30) DEFAULT NULL,
  `ID_partido` mediumint(8) DEFAULT '0',
  `user_ID` mediumint(9) unsigned DEFAULT '0',
  `orden` smallint(5) DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ID_partido` (`ID_partido`),
  KEY `user_ID` (`user_ID`),
  KEY `orden` (`orden`),
  KEY `pais` (`pais`)
) ENGINE=MyISAM AUTO_INCREMENT=181 DEFAULT CHARSET=utf8;


-- virtualpol.plataformas definition

CREATE TABLE `plataformas` (
  `ID` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `estado` enum('pendiente','ok','no') DEFAULT 'pendiente',
  `pais` varchar(255) DEFAULT NULL,
  `asamblea` enum('true','false') DEFAULT 'false',
  `economia` enum('true','false') DEFAULT 'true',
  `user_ID` mediumint(8) unsigned DEFAULT NULL,
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `descripcion` text,
  `participacion` mediumint(8) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=utf8;


-- virtualpol.pol_foros definition

CREATE TABLE `pol_foros` (
  `ID` smallint(5) NOT NULL AUTO_INCREMENT,
  `subforo_ID` varchar(255) DEFAULT NULL,
  `url` varchar(50) NOT NULL DEFAULT '',
  `title` varchar(50) NOT NULL DEFAULT '',
  `descripcion` varchar(255) NOT NULL DEFAULT '',
  `acceso` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `time` smallint(3) NOT NULL DEFAULT '1',
  `estado` enum('ok','eliminado') NOT NULL DEFAULT 'ok',
  `acceso_msg` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `acceso_leer` varchar(255) NOT NULL DEFAULT 'anonimos',
  `acceso_escribir` varchar(255) NOT NULL DEFAULT 'ciudadanos_global',
  `acceso_escribir_msg` varchar(255) DEFAULT 'ciudadanos_global',
  `acceso_cfg_leer` varchar(900) NOT NULL DEFAULT '',
  `acceso_cfg_escribir` varchar(900) NOT NULL DEFAULT '',
  `acceso_cfg_escribir_msg` varchar(255) DEFAULT '',
  `limite` smallint(6) DEFAULT '10',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `url` (`url`),
  KEY `estado` (`estado`)
) ENGINE=MyISAM AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;


-- virtualpol.pol_foros_hilos definition

CREATE TABLE `pol_foros_hilos` (
  `ID` mediumint(8) NOT NULL AUTO_INCREMENT,
  `sub_ID` smallint(5) NOT NULL DEFAULT '0',
  `url` varchar(80) NOT NULL DEFAULT '',
  `user_ID` mediumint(8) NOT NULL DEFAULT '0',
  `title` varchar(80) NOT NULL DEFAULT '',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `time_last` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `text` text NOT NULL,
  `cargo` tinyint(3) NOT NULL DEFAULT '0',
  `num` smallint(5) NOT NULL DEFAULT '0',
  `estado` enum('ok','borrado') NOT NULL DEFAULT 'ok',
  `votos` mediumint(9) NOT NULL DEFAULT '0',
  `votos_num` mediumint(9) DEFAULT '0',
  `fecha_programado` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE KEY `url` (`url`),
  KEY `sub_ID` (`sub_ID`),
  KEY `time_last` (`time_last`),
  KEY `estado` (`estado`)
) ENGINE=MyISAM AUTO_INCREMENT=6556 DEFAULT CHARSET=latin1;


-- virtualpol.pol_foros_msg definition

CREATE TABLE `pol_foros_msg` (
  `ID` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `hilo_ID` mediumint(8) NOT NULL DEFAULT '0',
  `user_ID` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `text` text NOT NULL,
  `cargo` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `estado` enum('ok','borrado') NOT NULL DEFAULT 'ok',
  `time2` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `votos` mediumint(9) NOT NULL DEFAULT '0',
  `votos_num` mediumint(9) DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `foro_ID` (`hilo_ID`),
  KEY `time` (`time`),
  KEY `estado` (`estado`)
) ENGINE=MyISAM AUTO_INCREMENT=59203 DEFAULT CHARSET=latin1;


-- virtualpol.pujas definition

CREATE TABLE `pujas` (
  `ID` mediumint(9) unsigned NOT NULL AUTO_INCREMENT,
  `pais` varchar(30) DEFAULT NULL,
  `mercado_ID` smallint(5) DEFAULT NULL,
  `user_ID` mediumint(9) unsigned DEFAULT NULL,
  `pols` decimal(10,2) DEFAULT NULL,
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ID`),
  KEY `pais` (`pais`),
  KEY `mercado_ID` (`mercado_ID`),
  KEY `user_ID` (`user_ID`),
  KEY `time` (`time`)
) ENGINE=MyISAM AUTO_INCREMENT=866 DEFAULT CHARSET=utf8;


-- virtualpol.referencias definition

CREATE TABLE `referencias` (
  `ID` mediumint(8) NOT NULL AUTO_INCREMENT,
  `user_ID` mediumint(8) NOT NULL DEFAULT '0',
  `IP` varchar(10) NOT NULL DEFAULT '',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `referer` varchar(255) NOT NULL DEFAULT '',
  `pagado` enum('0','1') NOT NULL DEFAULT '0',
  `new_user_ID` mediumint(8) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  UNIQUE KEY `IP` (`IP`),
  KEY `user_ID` (`user_ID`),
  KEY `pagado` (`pagado`)
) ENGINE=MyISAM AUTO_INCREMENT=10061 DEFAULT CHARSET=latin1;


-- virtualpol.socios definition

CREATE TABLE `socios` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `time` datetime DEFAULT NULL,
  `time_last` datetime DEFAULT NULL,
  `estado` varchar(255) DEFAULT 'inscrito',
  `pais` varchar(255) DEFAULT NULL,
  `socio_ID` int(11) unsigned DEFAULT NULL,
  `user_ID` int(11) unsigned DEFAULT NULL,
  `nombre` varchar(255) DEFAULT NULL,
  `NIF` varchar(255) DEFAULT NULL,
  `pais_politico` varchar(255) DEFAULT NULL,
  `localidad` varchar(255) DEFAULT NULL,
  `cp` varchar(255) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `contacto_email` varchar(255) DEFAULT NULL,
  `contacto_telefono` varchar(255) DEFAULT NULL,
  `validador_ID` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `time` (`time`),
  KEY `time_last` (`time_last`),
  KEY `pais` (`pais`),
  KEY `estado` (`estado`),
  KEY `socio_ID` (`socio_ID`),
  KEY `user_ID` (`user_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;


-- virtualpol.stats definition

CREATE TABLE `stats` (
  `stats_ID` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `pais` varchar(30) DEFAULT NULL,
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `ciudadanos` smallint(5) unsigned NOT NULL DEFAULT '0',
  `nuevos` smallint(5) unsigned NOT NULL DEFAULT '0',
  `pols` int(10) NOT NULL DEFAULT '0',
  `pols_cuentas` int(10) NOT NULL DEFAULT '0',
  `transacciones` smallint(5) unsigned NOT NULL DEFAULT '0',
  `hilos_msg` smallint(5) unsigned NOT NULL DEFAULT '0',
  `pols_gobierno` int(10) NOT NULL DEFAULT '0',
  `partidos` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `frase` smallint(5) unsigned NOT NULL DEFAULT '0',
  `empresas` smallint(5) unsigned NOT NULL DEFAULT '0',
  `eliminados` smallint(5) unsigned NOT NULL DEFAULT '0',
  `mapa` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `mapa_vende` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `24h` smallint(5) unsigned NOT NULL DEFAULT '0',
  `confianza` smallint(5) DEFAULT '0',
  `autentificados` mediumint(9) DEFAULT '0',
  PRIMARY KEY (`stats_ID`),
  KEY `time` (`time`),
  KEY `pais` (`pais`)
) ENGINE=MyISAM AUTO_INCREMENT=5912 DEFAULT CHARSET=latin1;


-- virtualpol.transacciones definition

CREATE TABLE `transacciones` (
  `ID` mediumint(8) NOT NULL AUTO_INCREMENT,
  `pais` varchar(30) DEFAULT NULL,
  `pols` decimal(10,2) NOT NULL DEFAULT '0.00',
  `emisor_ID` mediumint(8) NOT NULL DEFAULT '0',
  `receptor_ID` mediumint(8) NOT NULL DEFAULT '0',
  `concepto` varchar(90) CHARACTER SET utf8 NOT NULL DEFAULT '',
  `periodicidad` enum('D','S') DEFAULT NULL,
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`ID`),
  KEY `emisor_ID` (`emisor_ID`),
  KEY `receptor_ID` (`receptor_ID`),
  KEY `time` (`time`)
) ENGINE=MyISAM AUTO_INCREMENT=91900 DEFAULT CHARSET=latin1;


-- virtualpol.users definition

CREATE TABLE `users` (
  `ID` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `nick` varchar(18) NOT NULL DEFAULT '',
  `lang` varchar(5) DEFAULT NULL,
  `pais` varchar(30) DEFAULT NULL,
  `estado` enum('turista','ciudadano','expulsado','validar') NOT NULL DEFAULT 'validar',
  `nivel` tinyint(3) unsigned NOT NULL DEFAULT '1',
  `cargo` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `cargos` varchar(400) NOT NULL DEFAULT '',
  `grupos` varchar(400) NOT NULL DEFAULT '',
  `examenes` varchar(400) NOT NULL DEFAULT '',
  `voto_confianza` smallint(5) NOT NULL DEFAULT '0',
  `confianza_historico` text NOT NULL,
  `partido_afiliado` mediumint(9) unsigned NOT NULL DEFAULT '0',
  `online` int(10) unsigned NOT NULL DEFAULT '0',
  `visitas` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `paginas` int(10) unsigned NOT NULL DEFAULT '0',
  `pols` decimal(10,2) NOT NULL DEFAULT '0.00',
  `email` varchar(255) NOT NULL DEFAULT '',
  `fecha_registro` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `fecha_last` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `fecha_init` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `rechazo_last` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `fecha_legal` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `reset_last` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `nickchange_last` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `pass` varchar(255) NOT NULL DEFAULT '',
  `pass2` varchar(255) NOT NULL DEFAULT '',
  `api_pass` varchar(16) NOT NULL DEFAULT '0',
  `api_num` smallint(5) NOT NULL DEFAULT '0',
  `num_elec` tinyint(3) unsigned NOT NULL DEFAULT '0',
  `SC` enum('true','false') NOT NULL DEFAULT 'false',
  `ser_SC` enum('true','false','block') NOT NULL DEFAULT 'false',
  `nota` decimal(3,1) NOT NULL DEFAULT '0.0',
  `donacion` mediumint(9) unsigned DEFAULT NULL,
  `avatar` enum('true','false') NOT NULL DEFAULT 'false',
  `IP` varchar(12) NOT NULL DEFAULT '0',
  `host` varchar(150) NOT NULL,
  `hosts` text,
  `IP_proxy` varchar(150) NOT NULL,
  `text` varchar(2300) NOT NULL DEFAULT '',
  `nav` varchar(500) NOT NULL,
  `avatar_localdir` varchar(100) NOT NULL,
  `x` decimal(10,2) DEFAULT NULL,
  `y` decimal(10,2) DEFAULT NULL,
  `socio` enum('true','false') NOT NULL DEFAULT 'false',
  `dnie` enum('true','false') DEFAULT 'false',
  `dnie_check` varchar(400) DEFAULT NULL,
  `ref` varchar(25) NOT NULL DEFAULT '',
  `ref_num` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `bando` varchar(255) DEFAULT NULL,
  `nota_SC` varchar(500) NOT NULL DEFAULT '',
  `traza` varchar(600) NOT NULL DEFAULT '',
  `datos` varchar(9999) NOT NULL DEFAULT '',
  `nombre` varchar(255) DEFAULT NULL,
  `temp` int(11) DEFAULT NULL,
  `modo_invisible` enum('true','false') DEFAULT 'false',
  PRIMARY KEY (`ID`),
  KEY `nick` (`nick`),
  KEY `pais` (`pais`),
  KEY `fecha_last` (`fecha_last`),
  KEY `estado` (`estado`),
  KEY `voto_confianza` (`voto_confianza`),
  KEY `IP` (`IP`),
  KEY `pass` (`pass`),
  KEY `cargo` (`cargo`),
  KEY `grupos` (`grupos`(333)),
  KEY `cargos` (`cargos`(333)),
  KEY `examenes` (`examenes`(333)),
  KEY `x` (`x`),
  KEY `y` (`y`),
  KEY `lang` (`lang`),
  KEY `nivel` (`nivel`),
  KEY `fecha_registro` (`fecha_registro`),
  KEY `paginas` (`paginas`),
  KEY `dnie` (`dnie`),
  KEY `temp` (`temp`),
  KEY `socio` (`socio`),
  KEY `SC` (`SC`),
  KEY `nota_SC` (`nota_SC`(333))
) ENGINE=MyISAM AUTO_INCREMENT=221520 DEFAULT CHARSET=utf8;


-- virtualpol.users_con definition

CREATE TABLE `users_con` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `time` datetime DEFAULT NULL,
  `tipo` enum('session','login') DEFAULT 'login',
  `user_ID` mediumint(8) unsigned DEFAULT NULL,
  `IP` int(11) unsigned DEFAULT NULL,
  `IP_rango` varchar(255) DEFAULT NULL,
  `IP_rango3` varchar(20) DEFAULT NULL,
  `IP_pais` varchar(2) DEFAULT NULL,
  `host` varchar(255) DEFAULT NULL,
  `ISP` varchar(255) DEFAULT NULL,
  `proxy` varchar(255) DEFAULT NULL,
  `login_seg` smallint(5) unsigned DEFAULT NULL,
  `login_ms` smallint(5) unsigned DEFAULT NULL,
  `dispositivo` bigint(20) unsigned DEFAULT NULL,
  `nav_resolucion` varchar(255) DEFAULT NULL,
  `nav` varchar(500) DEFAULT NULL,
  `nav_so` varchar(255) DEFAULT NULL,
  `referer` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `user_ID` (`user_ID`),
  KEY `time` (`time`),
  KEY `tipo` (`tipo`),
  KEY `IP` (`IP`),
  KEY `dispositivo` (`dispositivo`),
  KEY `ISP` (`ISP`),
  KEY `host` (`host`),
  KEY `nav_resolucion` (`nav_resolucion`),
  KEY `nav` (`nav`(333)),
  KEY `nav_so` (`nav_so`),
  KEY `IP_pais` (`IP_pais`),
  KEY `IP_rango` (`IP_rango`),
  KEY `proxy` (`proxy`),
  KEY `IP_rango3` (`IP_rango3`)
) ENGINE=MyISAM AUTO_INCREMENT=331118 DEFAULT CHARSET=utf8;


-- virtualpol.votacion definition

CREATE TABLE `votacion` (
  `ID` smallint(5) NOT NULL AUTO_INCREMENT,
  `pais` varchar(30) DEFAULT NULL,
  `estado` enum('ok','end','borrador') NOT NULL DEFAULT 'borrador',
  `pregunta` varchar(255) NOT NULL DEFAULT '',
  `descripcion` text NOT NULL,
  `respuestas` text NOT NULL,
  `num` smallint(5) NOT NULL DEFAULT '0',
  `num_censo` int(11) unsigned DEFAULT NULL,
  `tipo` enum('sondeo','referendum','parlamento','destituir','otorgar','cargo','elecciones') NOT NULL DEFAULT 'sondeo',
  `tipo_voto` enum('estandar','3puntos','5puntos','8puntos','multiple') NOT NULL DEFAULT 'estandar',
  `privacidad` enum('true','false') NOT NULL DEFAULT 'true',
  `aleatorio` enum('true','false') NOT NULL DEFAULT 'false',
  `ejecutar` text NOT NULL,
  `duracion` mediumint(9) unsigned NOT NULL DEFAULT '0',
  `time` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `time_expire` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `acceso_votar` varchar(30) NOT NULL DEFAULT 'ciudadanos_global',
  `acceso_cfg_votar` varchar(900) NOT NULL DEFAULT '',
  `acceso_ver` varchar(255) NOT NULL DEFAULT 'anonimos',
  `acceso_cfg_ver` varchar(900) NOT NULL DEFAULT '',
  `debate_url` varchar(255) NOT NULL DEFAULT '',
  `user_ID` mediumint(8) NOT NULL DEFAULT '0',
  `votos_expire` smallint(5) unsigned NOT NULL DEFAULT '0',
  `respuestas_desc` text NOT NULL,
  `cargo_ID` smallint(6) unsigned DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `pais` (`pais`),
  KEY `time_expire` (`time_expire`),
  KEY `estado` (`estado`),
  KEY `tipo` (`tipo`),
  KEY `num` (`num`),
  KEY `votos_expire` (`votos_expire`),
  KEY `time` (`time`),
  KEY `user_ID` (`user_ID`),
  KEY `pregunta` (`pregunta`),
  KEY `acceso_votar` (`acceso_votar`),
  KEY `acceso_cfg_votar` (`acceso_cfg_votar`(333)),
  KEY `acceso_ver` (`acceso_ver`),
  KEY `acceso_cfg_ver` (`acceso_cfg_ver`(333)),
  KEY `tipo_voto` (`tipo_voto`),
  KEY `privacidad` (`privacidad`),
  KEY `aleatorio` (`aleatorio`),
  KEY `num_censo` (`num_censo`),
  KEY `cargo_ID` (`cargo_ID`)
) ENGINE=MyISAM AUTO_INCREMENT=3698 DEFAULT CHARSET=utf8;


-- virtualpol.votacion_argumentos definition

CREATE TABLE `votacion_argumentos` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ref_ID` mediumint(8) unsigned DEFAULT NULL,
  `user_ID` mediumint(8) unsigned DEFAULT NULL,
  `time` datetime DEFAULT '0000-00-00 00:00:00',
  `sentido` varchar(255) NOT NULL DEFAULT '',
  `texto` varchar(900) NOT NULL DEFAULT '',
  `votos` mediumint(8) DEFAULT '0',
  `votos_num` mediumint(9) DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `ref_ID` (`ref_ID`),
  KEY `user_ID` (`user_ID`),
  KEY `votos` (`votos`),
  KEY `votos_num` (`votos_num`),
  KEY `time` (`time`),
  KEY `texto` (`texto`(333)),
  KEY `sentido` (`sentido`)
) ENGINE=MyISAM AUTO_INCREMENT=841 DEFAULT CHARSET=utf8;


-- virtualpol.votacion_votos definition

CREATE TABLE `votacion_votos` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `ref_ID` smallint(5) unsigned NOT NULL DEFAULT '0',
  `user_ID` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `time` datetime DEFAULT NULL,
  `voto` varchar(300) NOT NULL DEFAULT '0',
  `validez` enum('true','false') NOT NULL DEFAULT 'true',
  `autentificado` enum('true','false') DEFAULT 'false',
  `mensaje` varchar(500) NOT NULL DEFAULT '',
  `comprobante` varchar(600) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ref_ID` (`ref_ID`),
  KEY `user_ID` (`user_ID`),
  KEY `voto` (`voto`),
  KEY `validez` (`validez`),
  KEY `time` (`time`),
  KEY `autentificado` (`autentificado`),
  KEY `mensaje` (`mensaje`)
) ENGINE=MyISAM AUTO_INCREMENT=198714 DEFAULT CHARSET=latin1;


-- virtualpol.votos definition

CREATE TABLE `votos` (
  `voto_ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pais` varchar(30) DEFAULT NULL,
  `item_ID` int(11) unsigned NOT NULL DEFAULT '0',
  `emisor_ID` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `receptor_ID` mediumint(9) unsigned DEFAULT NULL,
  `voto` tinyint(3) NOT NULL,
  `tipo` enum('confianza','hilos','msg','argumentos') NOT NULL DEFAULT 'confianza',
  `time` datetime NOT NULL,
  PRIMARY KEY (`voto_ID`),
  KEY `tipo` (`tipo`),
  KEY `emisor_ID` (`emisor_ID`),
  KEY `item_ID` (`item_ID`),
  KEY `pais` (`pais`),
  KEY `voto` (`voto`)
) ENGINE=MyISAM AUTO_INCREMENT=180149 DEFAULT CHARSET=latin1;