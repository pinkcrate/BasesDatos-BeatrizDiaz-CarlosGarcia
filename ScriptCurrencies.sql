INSERT INTO`paymentassistant`. `currencies`(`currency_id`,`currency_simbol`,`name`, `country_id`)
VALUES 
(1, '₡', 'colon', 1),
(2, '฿', 'balboa',2);

INSERT INTO `paymentassistant`.`exchangeRate` (`exchangeRate_id`, `fromCurrency_id`, `toCurrency_id`, `date`, `changeRate`)
VALUES 
(1, 1, 2, '2023-01-01 00:00:00', 0.001890),  
(2, 2, 1, '2023-01-01 00:00:00', 529.100000); 

INSERT INTO `paymentassistant`.`schedule` (`schedule_id`, `name`, `recurrencyType:`, `repit`, `endType`, `repetitions`, `end_date`)
VALUES
(1, 'Monthly Rent', 'Monthly', 1, 'date', 0, '2024-12-31 23:59:59'),
(2, 'Weekly Meeting', 'Weekly', 1, 'repetitions', 12, '2030-12-31 23:59:59'),
(3, 'Bi-weekly Payroll', 'Weekly', 2, 'date', 0, '2025-12-31 23:59:59'),
(4, 'Quarterly Report', 'Quarterly', 1, 'repetitions', 4, '2030-12-31 23:59:59'),
(5, 'Annual Review', 'Yearly', 1, 'date', 0, '2030-12-31 23:59:59');

INSERT INTO `paymentassistant`.`subscriptions` (`subscriptions_id`, `description`, `logourl`)
VALUES
(1, 'Netflix', 'https://brand.netflix.com/en/assets/logos/'),
(2, 'Spotify', 'https://newsroom.spotify.com/media-kit/logo-and-brand-assets/'),
(3, 'YouTube Premium', 'https://brandlogos.net/youtube-premium-logo-png-vector-format-101373.html'),
(4, 'Disney+ Bundle', 'https://www.logo.wine/logo/Disney%2B'),
(5, 'New York Times Digital', 'https://logos-world.net/new-york-times-logo/');
INSERT INTO `paymentassistant`.`recurrences` 
(`recurrences_id`, `description`, `recurrence_num`)
VALUES
(1, 'Diario', 1),
(2, 'Semanal', 7),
(3, 'Quincenal', 15),
(4, 'Mensual', 30),
(5, 'Bimestral', 60),
(6, 'Trimestral', 90),
(7, 'Semestral', 180),
(8, 'Anual', 365),
(9, 'Cada 3 días', 3);

INSERT INTO `paymentassistant`.`features_plan` 
(`features_id`, `description`, `enabled`, `dataypte`)
VALUES
(1, 'Basic Transactions', 1, 'payment'),
(2, 'Single Currency', 1, 'currency'),
(3, 'Multi-Currency', 0, 'currency'),
(4, 'Recurring Payments', 0, 'automation'),
(5, 'Bulk Payments', 0, 'batch'),
(6, '2FA Authentication', 1, 'security'),
(7, '10 Tx/Month Limit', 1, 'limit');

INSERT INTO `paymentassistant`.`pay_plan_type` 
(`plan_type_id`, `name`, `enable`, `acquisition`, `user_id`)
VALUES
(1, 'Free Plan', 1, CURDATE(), 1),
(2, 'Starter', 1, '2023-01-15', 3),
(3, 'Premium', 1, '2023-02-20', 5),
(4, 'Business Basic', 1, '2023-03-10', 2),
(5, 'Business Pro', 1, '2023-04-05', 8),
(6, 'Student', 1, '2023-05-12', 12),
(7, 'Non-Profit', 1, '2023-06-18', 7),
(8, 'Legacy 2019', 0, '2019-11-30', 1),
(9, 'Trial', 0, '2022-09-01', 1),
(10, 'Enterprise', 1, '2023-07-22', 14);

INSERT INTO `paymentassistant`.`transactionType` 
(`transactionType_id`, `name`)
VALUES
(1, 'Payment'),
(2, 'Transfer'),
(3, 'Deposit'),
(4, 'Withdrawal'),
(5, 'Currency Exchange'),
(6, 'Subscription'),
(7, 'Refund'),
(8, 'Fee'),
(9, 'Interest'),
(10, 'Adjustment');

INSERT INTO `paymentassistant`.`payments` 
(`payments_id`, `user_id`, `available_method`, `price`, `current_price`, `auth`, `changeToken`, `description`, `error`, `date`, `result`, `checksum`, `schedule_id`, `currency_id`)
VALUES
(1001, 5, 1, 49.99, 49.99, 'AUTH12345XYZ', 'TOKEN_ABC123', 'Premium Plan Subscription', 0, '2023-10-15 14:30:22', 'SUCCESS', UNHEX(SHA2('PAY1001', 256)), 1, 1),
(1002, 8, 2, 9.99, 9.99, 'AUTH67890ABC', 'TOKEN_DEF456', 'Monthly Donation', 1, '2023-10-16 09:15:47', 'FAILED', UNHEX(SHA2('PAY1002', 256)), 3, 2),
(1003, 12, 3, 100.00, 95.50, 'AUTH24680XYZ', 'TOKEN_GHI789', 'USD to EUR Conversion', 0, '2023-10-17 16:45:33', 'PENDING', UNHEX(SHA2('PAY1003', 256)), NULL, 2),
(1004, 3, 1, 29.99, 29.99, 'AUTH13579ACD', 'TOKEN_JKL012', 'Service Fee', 0, '2023-10-18 11:20:18', 'SUCCESS', UNHEX(SHA2('PAY1004', 256)), 5, 1),
(1005, 7, 4, 19.99, -19.99, 'AUTH86420FGH', 'TOKEN_MNO345', 'Customer Refund', 0, '2023-10-19 13:10:05', 'FAILED', UNHEX(SHA2('PAY1005', 256)), NULL, 2);

INSERT INTO `paymentassistant`.`transactions` 
(`transaction_id`, `payments_id`, `user_id`, `amount`, `description`, `transaction_date`, `post_time`, `checksum`, `ref_number`, `currency_id`, `transactionType_id`, `exchangeRate_id`)
VALUES
(1, 1001, 5, 49.99, 'Premium Plan Payment', '2023-10-15 14:30:22', '2023-10-15 14:32:45', SHA2('TRX1', 256), 'PAY-1001-001', 1, 1, 0),
(2, 1002, 8, 9.99, 'Monthly Donation', '2023-10-16 09:15:47', '2023-10-16 09:15:47', SHA2('TRX2', 256), 'PAY-1002-001', 2, 1, 0),
(3, 1003, 12, 95.50, 'Currency Conversion EUR', '2023-10-17 16:45:33', '2023-10-17 16:48:12', SHA2('TRX3', 256), 'PAY-1003-001', 3, 5, 1),
(4, 1004, 3, 29.99, 'Service Fee', '2023-10-18 11:20:18', '2023-10-18 11:22:30', SHA2('TRX4', 256), 'PAY-1004-001', 1, 1, 0),
(5, 1005, 7, -19.99, 'Refund to Customer', '2023-10-19 13:10:05', '2023-10-19 13:12:18', SHA2('TRX5', 256), 'PAY-1005-001', 2, 7, 0);

INSERT INTO `paymentassistant`.`plan_per_user` 
(`planuser_id`, `user_id`, `prices_id`, `acquisition`, `enable`)
VALUES
(1, 5, 3, '2023-10-01 09:15:22', 1),
(2, 8, 5, '2023-10-02 14:30:45', 1),
(3, 12, 2, '2023-10-03 11:20:33', 0),
(4, 3, 4, '2023-10-04 16:45:18', 1),
(5, 7, 1, '2023-10-05 10:10:57', 1),
(6, 9, 6, '2023-10-06 13:25:41', 0),
(7, 2, 3, '2023-10-07 08:40:12', 1),
(8, 11, 5, '2023-10-08 17:55:29', 1),
(9, 4, 2, '2023-10-09 12:30:15', 0),
(10, 14, 4, '2023-10-10 09:05:38', 1);

INSERT INTO `paymentassistant`.`user_plan_limit` 
(`limitid`, `limit`, `planuser_id`, `featuresPerPlan_id`)
VALUES
(1, 10, 1, 3),
(2, 20, 2, 5),
(3, 30, 3, 2),
(4, 40, 4, 4),
(5, 50, 5, 1),
(6, 60, 6, 6),
(7, 70, 7, 7),
(8, 80, 8, 8),
(9, 90, 9, 9),
(10, 100, 10, 10);

INSERT INTO `paymentassistant`.`pay_country` (`country_id`, `name`, `contact_id`) VALUES
(1, 'Costa Rica', 1),
(2, 'Panamá', 2);

INSERT INTO `paymentassistant`.`pay_contact_info_type` (`infotype_id`, `name`) VALUES
(1, 'Teléfono móvil'),
(2, 'Teléfono fijo'),
(3, 'Correo electrónico'),
(4, 'Dirección física'),
(5, 'WhatsApp'),
(6, 'Facebook'),
(7, 'LinkedIn'),
(8, 'Twitter'),
(9, 'Instagram'),
(10, 'Skype');

INSERT INTO `paymentassistant`.`pay_contact` (`contact_id`, `user_id`, `value`, `enabled`, `last_update`, `infotype_id`) VALUES
(1, 1, '8888-8888', 1, NOW(), 1),
(2, 1, 'carlos@example.com', 1, NOW(), 3),
(3, 2, '8888-8881', 1, NOW(), 1),
(4, 2, 'maria@example.com', 1, NOW(), 3),
(5, 3, '8888-8882', 1, NOW(), 1),
(6, 3, 'juan@example.com', 1, NOW(), 3),
(7, 4, '8888-8883', 1, NOW(), 1),
(8, 4, 'ana@example.com', 1, NOW(), 3),
(9, 5, '8888-8884', 1, NOW(), 1),
(10, 5, 'luis@example.com', 1, NOW(), 3),
(11, 6, '8888-8885', 1, NOW(), 1),
(12, 6, 'sofia@example.com', 1, NOW(), 3),
(13, 7, '8888-8886', 1, NOW(), 1),
(14, 7, 'diego@example.com', 1, NOW(), 3);

INSERT INTO `paymentassistant`.`pay_culture` (`culture_id`, `currency_id`, `language`, `country_id`) VALUES
(1, 1, 'Español', 1), 
(2, 2, 'Español', 2); 

INSERT INTO `pay_method` (`metodo_id`, `name`, `apiURL`, `secret_key`, `key`, `logoIconURL`, `enabled`, `config`) VALUES
(1, 'Sinpe Móvil', 'https://api.sinpe.cr', UNHEX('73696E706531'), UNHEX('6B657931'), UNHEX('6C6F676F31'), 1, '{"pais":"CR","fee":0.8}'),
(2, 'Yappy', 'https://api.yappy.pa', UNHEX('796170707931'), UNHEX('6B657932'), UNHEX('6C6F676F32'), 1, '{"pais":"PA","fee":1.0}'),
(3, 'Transferencia', NULL, NULL, NULL, NULL, 1, '{"pais":"CR,PA","fee":0}'),
(4, 'Efectivo', NULL, NULL, NULL, NULL, 1, '{"pais":"CR,PA","instructions":"Pagar en local"}'),
(5, 'PayPal', 'https://api.paypal.com', UNHEX('70617970616C'), UNHEX('6B657935'), UNHEX('6C6F676F35'), 1, '{"pais":"CR,PA","fee":2.9}');

INSERT INTO `pay_available_method` (`available_method`, `mask_account`, `token`, `exptokendate`, `name`, `user_id`, `metodo_id`) 
VALUES
(1, '5678-8888', 'tok_sinpe_abc123', DATE_ADD(NOW(), INTERVAL 1 YEAR), 'Sinpe Personal', 1, 1),
(2, 'CR123456789', 'tok_bac_xyz456', DATE_ADD(NOW(), INTERVAL 2 YEAR), 'Cuenta BAC', 1, 3),
(3, '1234-6666', 'tok_yappy_pqr789', DATE_ADD(NOW(), INTERVAL 1 YEAR), 'Yappy Personal', 2, 2),
(4, 'PA987654321', 'tok_bgeneral_uvw321', DATE_ADD(NOW(), INTERVAL 2 YEAR), 'Cuenta Banco General', 2, 3);

INSERT INTO `paymentassistant`.`features_per_plan` 
(`featuresPerPlan_id`, `value`, `enable`, `subscriptions_id`, `plan_features_id`)
VALUES
(1, '10', 1, 1, 1),
(2, '1', 1, 1, 2),
(3, '5', 0, 1, 3),
(4, '2', 1, 1, 4),
(5, '100', 1, 2, 1),
(6, '3', 0, 2, 3),
(7, '1', 1, 2, 4),
(8, '1', 0, 2, 5),
(9, '500', 1, 3, 1),
(10, '5', 1, 3, 3);

INSERT INTO schedule_details (details_id, deleted, baseDate, datepart, LastExecute, NextExecute, plan_id, schedule_id,planner_id) VALUES
(1, 0, '2023-11-01', 'month', '2023-11-01 09:00:00', '2023-12-01 09:00:00', 101, 201, 1),
(2, 0, '2023-11-06', 'week', '2023-11-06 08:30:00', '2023-11-13 08:30:00', 102, 202, 1),
(3, 0, '2023-11-15', 'day', '2023-11-15 10:00:00', '2023-11-16 10:00:00', 103, 203, 2),
(4, 0, '2023-12-25', 'year', '2022-12-25 00:01:00', '2023-12-25 00:01:00', 104, 204, 3),
(5, 1, '2023-10-01', 'month', '2023-10-01 09:00:00', NULL, 105, 205, 2),
(6, 0, '2023-11-15', 'custom', '2023-11-01 14:00:00', '2023-11-15 14:00:00', 106, 206, 4),
(7, 0, CURDATE(), 'day', NOW(), DATE_ADD(CURDATE(), INTERVAL 1 DAY), 107, 207, 3);

INSERT INTO `paymentassistant`.`plan_prices` 
(`prices_id`, `amount`, `post_time`, `endDate`, `current`, `plan_type_id`, `subscriptions_id`, `recurrences_id`)
VALUES
(1, 9.99, '2023-01-01 00:00:00', '2023-12-31 23:59:59', 0, 1, 1, 4),
(2, 12.99, '2024-01-01 00:00:00', '2024-12-31 23:59:59', 1, 1, 1, 4),
(3, 24.99, '2023-01-01 00:00:00', '2023-12-31 23:59:59', 0, 2, 2, 4),
(4, 29.99, '2024-01-01 00:00:00', '2024-12-31 23:59:59', 1, 2, 2, 4),
(5, 199.99, '2024-01-01 00:00:00', '2024-12-31 23:59:59', 1, 3, 3, 8),
(6, 59.99, '2024-01-01 00:00:00', '2024-03-31 23:59:59', 1, 4, 4, 6),
(7, 14.99, '2023-06-01 00:00:00', '2023-11-30 23:59:59', 0, 5, 5, 4),
(8, 99.99, '2024-01-01 00:00:00', '2024-06-30 23:59:59', 1, 6, 6, 7),
(9, 399.99, '2024-01-01 00:00:00', '2024-12-31 23:59:59', 1, 7, 7, 8),
(10, 4.99, '2024-01-01 00:00:00', '2024-12-31 23:59:59', 1, 8, 8, 4);

