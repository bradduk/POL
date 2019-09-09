ALTER TABLE `cat` CHANGE `tipo` `tipo` ENUM('empresas','docs','cargos','empresas-pro')  CHARACTER SET utf8  COLLATE utf8_general_ci  NOT NULL  DEFAULT 'docs';

ALTER TABLE `cat` ADD `sub_tipo` ENUM('trigo','pan')  NULL  DEFAULT NULL  AFTER `tipo`;

ALTER TABLE `users` ADD `energia` INT(5)  NULL  DEFAULT '100'  AFTER `nick`;

ALTER TABLE `empresas` ADD `cuenta_ID` MEDIUMINT(8)  NULL  DEFAULT NULL  AFTER `nombre`;

INSERT INTO `config` (`ID`, `pais`, `dato`, `valor`, `autoload`) VALUES (NULL, 'POL', 'impuestos_trabajo', '0', 'si');


CREATE TABLE `empresas_trabajos` (
  `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_ID` int(11) DEFAULT NULL,
  `empresa_ID` int(11) DEFAULT NULL,
  `salario_bruto` double(10,2) DEFAULT NULL,
  `salario_neto` double(10,2) DEFAULT NULL,
  `salario_impuesto` double(10,2) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `recursos_generados` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;