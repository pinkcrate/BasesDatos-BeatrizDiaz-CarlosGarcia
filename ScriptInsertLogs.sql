INSERT INTO `paymentassistant`.`logsources` (`logsourcesid`, `name`)
VALUES
(1, 'Payment Gateway'),
(2, 'Mobile App'),
(3, 'Web Portal'),
(4, 'Admin Console'),
(5, 'API Service'),
(6, 'Database'),
(7, 'Scheduler'),
(8, 'Notification Service'),
(9, 'Security Module'),
(10, 'Backup System');

INSERT INTO `paymentassistant`.`logtypes` (`logtypeid`, `name`, `ref1Desc`, `ref2Desc`, `value1Desc`, `value2Desc`)
VALUES
(1, 'Transaction', 'Payment ID', 'User ID', 'Amount', 'Currency'),
(2, 'Error', 'Module', 'Function', 'Error Code', 'Message'),
(3, 'Login', 'User ID', 'IP Address', 'Device', 'Status'),
(4, 'Audit', 'Admin ID', 'Action', 'Old Value', 'New Value'),
(5, 'System', 'Component', 'Process', 'Memory Usage', 'CPU Load'),
(6, 'Scheduled Job', 'Job ID', 'Execution Time', 'Parameters', 'Result'),
(7, 'API Call', 'Endpoint', 'Client ID', 'Request', 'Response'),
(8, 'Security', 'Event Type', 'User ID', 'Details', 'Action Taken'),
(9, 'Database', 'Query Type', 'Table', 'Records Affected', 'Execution Time'),
(10, 'Maintenance', 'Task', 'Duration', 'Before', 'After');

INSERT INTO `paymentassistant`.`logserenty` (`logsrentyid`, `name`)
VALUES
(1, 'Critical'),
(2, 'High'),
(3, 'Medium'),
(4, 'Low'),
(5, 'Informational'),
(6, 'Emergency'),
(7, 'Alert'),
(8, 'Debug'),
(9, 'Trace'),
(10, 'Notice');

INSERT INTO `paymentassistant`.`logs` 
(`logsid`, `description`, `posttime`, `computer`, `username`, `trace`, `referenceld1`, `referenceld2`,`value1`, `value2`, `checksum`, `logscol`, `user_id`, `logserenty_logsrentyid`, `logtypeid`, `logsourcesid`)
VALUES
(1, 'Payment processed successfully', '2023-10-15 09:30:45', 'SRV-PAY-01', 'johndoe', 'TX-1001', 7, 5, '49.99', 'USD', SHA2('LOG1', 256), 'payment', 3, 2, 4, 6),
(2, 'Failed login attempt detected', '2023-10-15 10:15:22', 'MOB-APP', 'system', 'AUTH-ERR', 2, 8,'Android', 'Invalid credentials', SHA2('LOG2', 256), 'security', 5, 3, 7, 2),
(3, 'System overload warning', '2023-10-15 11:05:33', 'SRV-DB-01', 'system', 'SYS-ALERT', 9, 1,'85%', '90%', SHA2('LOG3', 256), 'warning', 2, 4, 5, 9),
(4, 'User profile updated', '2023-10-15 14:22:18', 'ADMIN-PC', 'admin1', 'AUDIT-101', 4, 6,'Basic Plan', 'Premium Plan', SHA2('LOG4', 256), 'audit', 7, 5, 3, 4),
(5, 'Daily backup completed', '2023-10-15 23:00:05', 'SRV-BKP-01', 'backup', 'BKP-2023', 10, 3, '5.2GB', 'success', SHA2('LOG5', 256), 'backup', 1, 6, 2, 8),
(6, 'API rate limit exceeded', '2023-10-16 08:45:12', 'API-GW-01', 'apiclient', 'API-429', 3, 7, '100/50', 'client123', SHA2('LOG6', 256), 'api', 4, 7, 9, 5),
(7, 'Database query slow', '2023-10-16 12:30:55', 'SRV-DB-02', 'system', 'SQL-SLOW', 8, 2, '2.5s', 'SELECT users.*', SHA2('LOG7', 256), 'performance', 6, 8, 1, 7),
(8, 'Security alert triggered', '2023-10-16 15:10:33', 'FIREWALL-01', 'security', 'SEC-101', 5, 9, 'Brute force', 'IP blocked', SHA2('LOG8', 256), 'security', 8, 9, 6, 3),
(9, 'Scheduled job started', '2023-10-16 04:00:00', 'SRV-JOB-01', 'cron', 'JOB-101', 1, 10, 'report_generation', 'started', SHA2('LOG9', 256), 'jobs', 9, 10, 8, 1),
(10, 'Maintenance window opened', '2023-10-16 01:00:00', 'SRV-MNT-01', 'admin1', 'MNT-2023', 6, 4, 'System upgrade', '1 hour', SHA2('LOG10', 256), 'maintenance', 10, 1, 10, 10);