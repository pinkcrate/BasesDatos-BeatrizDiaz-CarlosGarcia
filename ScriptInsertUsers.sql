INSERT INTO `paymentassistant`.`pay_user` (`user_id`, `name`, `last_name`, `birth`, `password`, `delete`, `last_update`, `active`, `email`, `address_id`, `hours_spent`) 
VALUES
(1, 'Carlos', 'García', '2005-11-14', 'carlos123', 0, NOW(), 1, 'cgarcia@gmail.com', 1, 156),
(2, 'María', 'Rodríguez', '1990-05-21', 'maria456', 0, NOW(), 1, 'mrodriguez@outlook.com', 2, 456),
(3, 'Juan', 'Martínez', '1985-08-15', 'juan789', 0, NOW(), 1, 'jmartinez@yahoo.com', 3, 789),
(4, 'Ana', 'López', '1995-03-30', 'ana123', 0, NOW(), 1, 'alopez@gmail.com', 4, 456),
(5, 'Luis', 'Hernández', '1988-07-12', 'luis456', 0, NOW(), 1, 'lhernandez@hotmail.com', 5, 123),
(6, 'Sofía', 'Gómez', '1992-11-05', 'sofia789', 0, NOW(), 1, 'sgomez@gmail.com', 6, 456),
(7, 'Diego', 'Pérez', '1983-09-18', 'diego123', 0, NOW(), 1, 'dperez@outlook.com', 7, 742),
(8, 'Valeria', 'Sánchez', '1998-04-25', 'valeria456', 0, NOW(), 1, 'vsanchez@yahoo.com', 8, 123),
(9, 'Jorge', 'Ramírez', '1980-12-08', 'jorge789', 0, NOW(), 1, 'jramirez@gmail.com', 9, 456),
(10, 'Fernanda', 'Torres', '1994-06-17', 'fernanda123', 0, NOW(), 1, 'ftorres@hotmail.com', 1, 456),
(11, 'Andrés', 'Díaz', '1987-02-14', 'andres456', 0, NOW(), 1, 'adiaz@outlook.com', 2, 158),
(12, 'Camila', 'Vargas', '1996-10-31', 'camila789', 0, NOW(), 1, 'cvargas@gmail.com', 3, 2354),
(13, 'Ricardo', 'Morales', '1982-01-22', 'ricardo123', 0, NOW(), 1, 'rmorales@yahoo.com', 4, 894),
(14, 'Isabel', 'Castro', '1993-07-09', 'isabel456', 0, NOW(), 1, 'icastro@gmail.com', 5, 654),
(15, 'Gabriel', 'Mendoza', '1989-04-03', 'gabriel789', 0, NOW(), 1, 'gmendoza@hotmail.com', 6, 255),
(16, 'Daniela', 'Rojas', '1997-08-28', 'daniela123', 0, NOW(), 1, 'drojas@outlook.com', 7, 8),
(17, 'Oscar', 'Guerrero', '1984-05-11', 'oscar456', 0, NOW(), 1, 'oguerrero@gmail.com', 8, 798),
(18, 'Lucía', 'Flores', '1991-12-24', 'lucia789', 0, NOW(), 1, 'lflores@yahoo.com', 9, 12),
(19, 'Manuel', 'Silva', '1986-09-07', 'manuel123', 0, NOW(), 1, 'msilva@hotmail.com', 1, 36),
(20, 'Beatriz', 'Diaz', '2006-10-11', 'becca123', 0, NOW(), 1, 'beccaDiaz@gmail.com', 2, 56); 
select * from logs;
delete from pay_user;