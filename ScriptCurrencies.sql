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
(1, 'Monthly Rent', 'Monthly', 1, 'date', NULL, '2024-12-31 23:59:59'),
(2, 'Weekly Meeting', 'Weekly', 1, 'repetitions', 12, NULL),
(3, 'Bi-weekly Payroll', 'Weekly', 2, 'date', NULL, '2025-12-31 23:59:59'),
(4, 'Quarterly Report', 'Quarterly', 1, 'repetitions', 4, NULL),
(5, 'Annual Review', 'Yearly', 1, 'date', NULL, '2030-12-31 23:59:59');

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