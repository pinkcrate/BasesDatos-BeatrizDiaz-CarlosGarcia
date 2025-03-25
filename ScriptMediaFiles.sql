INSERT INTO `paymentassistant`.`mediaFile_type` 
(`mediaFileType_id`, `name`)
VALUES
(1, 'Profile Picture'),
(2, 'Document Scan'),
(3, 'Receipt Photo'),
(4, 'Signature Image'),
(5, 'ID Front'),
(6, 'ID Back'),
(7, 'Invoice PDF'),
(8, 'Contract PDF'),
(9, 'Payment Proof'),
(10, 'Audio Note');

INSERT INTO `paymentassistant`.`media_files` 
(`file_id`, `mediaFileType_id`, `user_id`, `size`)
VALUES
(1, 1, 3, 102400),
(2, 2, 7, 512000),
(3, 3, 12, 256000),
(4, 4, 5, 128000),
(5, 5, 19, 768000),
(6, 6, 2, 384000),
(7, 7, 8, 1536000),
(8, 8, 15, 2048000),
(9, 9, 11, 896000),
(10, 10, 4, 640000);

INSERT INTO `paymentassistant`.`payment_notifications` 
(`notificationid`, `payments_id`, `description`, `enable`, `message`, `details_id`, `sendDate`, `success`)
VALUES
(1, 1001, 'Payment completed', 1, 'Payment of $49.99 processed', 1, '2023-10-15 14:31:22', 1),
(2, 1002, 'Payment failed', 1, '$9.99 payment declined', 2, '2023-10-16 09:16:05', 0),
(3, 1003, 'Conversion receipt', 1, 'EUR conversion completed', 3, '2023-10-17 16:46:18', 1),
(4, 1004, 'Service fee paid', 1, '$29.99 service fee charged', 4, '2023-10-18 11:21:00', 1),
(5, 1005, 'Refund issued', 1, '$19.99 refund processed', 5, '2023-10-19 13:11:45', 1),
(6, 1001, 'Receipt sent', 1, 'Receipt for payment #1001', 6, '2023-10-15 14:35:00', 1),
(7, 1002, 'Retry reminder', 1, 'Please update payment method', 7, '2023-10-16 10:00:00', 0),
(8, 1003, 'Rate confirmation', 1, 'Exchange rate confirmation', 1, '2023-10-17 16:50:00', 1),
(9, 1004, 'Payment reminder', 1, 'Upcoming payment notice', 2, '2023-10-17 09:00:00', 1),
(10, 1005, 'Refund completed', 1, 'Refund successfully issued', 3, '2023-10-19 13:15:00', 1);