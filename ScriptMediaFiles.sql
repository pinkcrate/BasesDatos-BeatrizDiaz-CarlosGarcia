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