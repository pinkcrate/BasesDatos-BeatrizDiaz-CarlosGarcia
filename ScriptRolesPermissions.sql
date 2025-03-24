INSERT INTO `paymentassistant`.`pay_modules` (`moduleid`, `name`) VALUES
(1, 'Dashboard'),
(2, 'Usuarios'),
(3, 'Roles'),
(4, 'Permisos'),
(5, 'Transacciones'),
(6, 'Reportes'),
(7, 'Configuración');

INSERT INTO `paymentassistant`.`pay_permissions` (`permissions_id`, `moduleid`, `description`, `code`, `last_update`) VALUES
(1, 1, 'Ver Dashboard', 'DASH_V', NOW()),
(2, 1, 'Personalizar Dashboard', 'DASH_P', NOW()),
(3, 2, 'Ver Usuarios', 'USR_V', NOW()),
(4, 2, 'Crear Usuarios', 'USR_C', NOW()),
(5, 2, 'Editar Usuarios', 'USR_E', NOW()),
(6, 2, 'Eliminar Usuarios', 'USR_D', NOW()),
(7, 3, 'Ver Roles', 'ROL_V', NOW()),
(8, 3, 'Crear Roles', 'ROL_C', NOW()),
(9, 3, 'Editar Roles', 'ROL_E', NOW()),
(10, 3, 'Eliminar Roles', 'ROL_D', NOW()),
(11, 4, 'Ver Permisos', 'PER_V', NOW()),
(12, 4, 'Asignar Permisos', 'PER_A', NOW()),
(13, 5, 'Ver Transacciones', 'TRA_V', NOW()),
(14, 5, 'Crear Transacciones', 'TRA_C', NOW()),
(15, 5, 'Aprobar Transacciones', 'TRA_A', NOW()),
(16, 6, 'Generar Reportes', 'REP_G', NOW()),
(17, 6, 'Exportar Reportes', 'REP_E', NOW()),
(18, 7, 'Ver Configuración', 'CFG_V', NOW()),
(19, 7, 'Editar Configuración', 'CFG_E', NOW());


INSERT INTO `paymentassistant`.`pay_roles` (`roleid`, `name_role`, `description`, `last_update`) VALUES
(1, 'Administrador', 'Acceso completo al sistema', NOW()),
(2, 'Gerente', 'Puede gestionar transacciones y reportes', NOW()),
(3, 'Analista', 'Puede ver reportes y transacciones', NOW()),
(4, 'Asistente', 'Acceso limitado a funciones básicas', NOW()),
(5, 'Auditor', 'Solo acceso de lectura a todos los módulos', NOW());


INSERT INTO `paymentassistant`.`pay_rolespermissions` (`rolespermissions_id`, `permissions_id`, `roleid`, `enabled`, `deleted`, `last_update`) VALUES
(1, 1, 1, 1, 0, NOW()),
(2, 2, 1, 1, 0, NOW()),
(3, 3, 1, 1, 0, NOW()),
(4, 4, 1, 1, 0, NOW()),
(5, 5, 1, 1, 0, NOW()),
(6, 6, 1, 1, 0, NOW()),
(7, 7, 1, 1, 0, NOW()),
(8, 8, 1, 1, 0, NOW()),
(9, 9, 1, 1, 0, NOW()),
(10, 10, 1, 1, 0, NOW()),
(11, 11, 1, 1, 0, NOW()),
(12, 12, 1, 1, 0, NOW()),
(13, 13, 1, 1, 0, NOW()),
(14, 14, 1, 1, 0, NOW());

INSERT INTO `pay_user_roles` (`userrolesid`, `roleid`, `user_id`, `last_update`, `checksum`, `enabled`) VALUES
(1, 1, 1, NOW(), UNHEX(SHA1(CONCAT(1,1,NOW()))), 1), 
(2, 2, 2, NOW(), UNHEX(SHA1(CONCAT(2,2,NOW()))), 1),  
(3, 3, 3, NOW(), UNHEX(SHA1(CONCAT(3,3,NOW()))), 1),  
(4, 4, 4, NOW(), UNHEX(SHA1(CONCAT(4,4,NOW()))), 1), 
(5, 5, 5, NOW(), UNHEX(SHA1(CONCAT(5,5,NOW()))), 1),  
(6, 2, 6, NOW(), UNHEX(SHA1(CONCAT(6,2,NOW()))), 1),
(7, 3, 7, NOW(), UNHEX(SHA1(CONCAT(7,3,NOW()))), 1),  
(8, 4, 8, NOW(), UNHEX(SHA1(CONCAT(8,4,NOW()))), 1),  
(9, 3, 9, NOW(), UNHEX(SHA1(CONCAT(9,3,NOW()))), 1),  
(10, 4, 10, NOW(), UNHEX(SHA1(CONCAT(10,4,NOW()))), 1);  

INSERT INTO `pay_user_permissions` (`rolepermissionsid`, `user_id`, `permissions_id`, `enabled`, `last_update`, `checksum`) VALUES
(1, 1, 1, 1, NOW(), UNHEX(SHA1(CONCAT(1,1,NOW()))) ),
(2, 2, 19, 1, NOW(), UNHEX(SHA1(CONCAT(2,19,NOW())))),  
(3, 3, 14, 1, NOW(), UNHEX(SHA1(CONCAT(3,14,NOW())))),
(4, 5, 16, 1, NOW(), UNHEX(SHA1(CONCAT(5,16,NOW())))), 
(5, 5, 17, 1, NOW(), UNHEX(SHA1(CONCAT(5,17,NOW()))));  
