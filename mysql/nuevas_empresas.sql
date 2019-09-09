ALTER TABLE `cat` CHANGE `tipo` `tipo` ENUM('empresas','docs','cargos','empresas-pro')  CHARACTER SET utf8  COLLATE utf8_general_ci  NOT NULL  DEFAULT 'docs';

ALTER TABLE `cat` ADD `sub_tipo` ENUM('trigo','pan')  NULL  DEFAULT NULL  AFTER `tipo`;

ALTER TABLE `users` ADD `energia` INT(5)  NULL  DEFAULT '100'  AFTER `nick`;
