INSERT INTO `paymentassistant`.`countries` (`country_id`,`name`) VALUES (1, 'Costa Rica');
INSERT INTO `paymentassistant`.`countries` (`country_id`,`name`) VALUES (2, 'Panama');
INSERT INTO `paymentassistant`.`region` (`region_id`,`name`,`country_id`) VALUES (1, 'San Jose', 1);
INSERT INTO `paymentassistant`.`region` (`region_id`,`name`,`country_id`) VALUES (2, 'Alajuela', 1);
INSERT INTO `paymentassistant`.`region` (`region_id`,`name`,`country_id`) VALUES (3, 'Cartago', 1);
INSERT INTO `paymentassistant`.`region` (`region_id`,`name`,`country_id`) VALUES (4, 'Heredia', 1);
INSERT INTO `paymentassistant`.`region` (`region_id`,`name`,`country_id`) VALUES (5, 'Guanacaste', 1);
INSERT INTO `paymentassistant`.`region` (`region_id`,`name`,`country_id`) VALUES (6, 'Puntarenas', 1);
INSERT INTO `paymentassistant`.`region` (`region_id`,`name`,`country_id`) VALUES (7, 'Limón', 1);
INSERT INTO`paymentassistant`.`region` (`region_id`,`name`,`country_id`)
VALUES 
(8, 'Bocas del Toro', 2),
(9, 'Colon', 2),
(10, 'Panama', 2),
(11, 'Los Santos', 2),
(12, 'Herrera', 2),
(13, 'Panama Oeste', 2),
(14, 'Cocle', 2);
INSERT INTO`paymentassistant`.`city` (`city_id`,`name`,`region_id`)
VALUES 
(1, 'San Pedro', 1),
(2, 'San Ramón', 2),
(3, 'Turrialba', 3),
(4, 'Santo Domingo', 4),
(5, 'Nicoya', 5),
(6, 'Quepos', 6),
(7, 'Limón', 7),
(8, 'Bocas del Toro (Ciudad)', 8),
(9, 'Barrio Norte', 9);

select * from city