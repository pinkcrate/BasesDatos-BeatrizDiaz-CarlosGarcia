INSERT INTO `ia_session` (`session_id`, `user_id`, `session_token`, `started_at`, `ended_at`, `status`, `api_url`, `config`, `audiouRL`) VALUES
(1, 1, 'tok_abc123', '2023-11-15 09:00:00', '2023-11-15 09:05:23', 'completed', 'https://api.payassistant.com/session/1', '{"language":"es","timeout":300}', 'https://storage.payassistant.com/audio/1.wav'),
(2, 1, 'tok_def456', '2023-11-15 14:30:00', NULL, 'active', 'https://api.payassistant.com/session/2', '{"language":"es","timeout":300}', NULL),
(3, 2, 'tok_ghi789', '2023-11-15 10:15:00', '2023-11-15 10:20:45', 'failed', 'https://api.payassistant.com/session/3', '{"language":"en","timeout":300}', 'https://storage.payassistant.com/audio/3.wav'),
(4, 3, 'tok_jkl012', '2023-11-15 11:00:00', '2023-11-15 11:03:17', 'completed', 'https://api.payassistant.com/session/4', '{"language":"es","timeout":300}', 'https://storage.payassistant.com/audio/4.wav');

INSERT INTO `ia_type` (`type_id`, `name`) VALUES
(1, 'Pago a contacto'),
(2, 'Transferencia bancaria'),
(3, 'Pago de servicio'),
(4, 'Consulta de saldo'),
(5, 'Configuración');

INSERT INTO `ia_interactions` (`interactions_id`, `session_id`, `type_id`, `audio_transcription`, `date`, `result`, `detectedBank`, `detectedRecipient`, `detectedAmount`, `amountAccuracy`, `recipientAccuracy`, `bankAccuracy`) VALUES
(1, 101, 1, 'Quiero transferir 150 mil colones a María Rodríguez en el BAC','2023-11-15 09:30:45', 'CONFIRMED', 'BAC', 'María Rodríguez', 150000.00, 0.98, 0.95, 0.99),
(2, 101, 1, 'Transferir 75 mil a Jorge López en Banco Nacional... no, cancela','2023-11-15 09:35:12', 'CANCELLED', 'Banco Nacional', 'Jorge López', 75000.00, 0.92, 0.88, 0.97),
(3, 102, 2, 'Enviar 50 dólares a Carlos por Paypal... no, es Paypal','2023-11-15 10:15:33', 'ERROR', 'Paypal', 'Carlos', 50.00, 0.85, 0.60, 0.75),
(4, 103, 1, 'Repetir el último pago a Andrea en el BCR','2023-11-15 11:20:18', 'REPEAT', 'BCR', 'Andrea', 100000.00, 0.99, 0.97, 0.98),
(5, 104, 3, 'Pagar el préstamo del carro en Scotiabank 325 mil colones','2023-11-15 14:45:22', 'CONFIRMED', 'Scotiabank', 'Scotiabank Créditos', 325000.00, 0.97, 0.99, 0.96);

INSERT INTO `ia_proccessing` (`procces_id`, `description`, `trigger`, `result`) VALUES
(1, 'Procesamiento de voz', 'audio_input', 'transcription'),
(2, 'Validación de destinatario', 'recipient_input', 'validation'),
(3, 'Confirmación de monto', 'amount_input', 'confirmation'),
(4, 'Ejecución de pago', 'payment_execution', 'completed'),
(5, 'Error en validación', 'validation', 'failed');

INSERT INTO `iA_logs` (`IAlogs_id`, `description`, `interactions_id`, `user_id`, `procces_id`, `userTaps`, `errorDetail`, `userCorrections`) VALUES
(1, 'Transcripción exitosa', 1, 1, 1, 0, NULL, NULL),
(2, 'Validación fallida', 4, 2, 2, 2, 102, '2023-11-15 10:17:15'),
(3, 'Pago completado', 2, 1, 4, 1, NULL, NULL),
(4, 'Reconocimiento de banco', 3, 1, 1, 0, NULL, NULL);