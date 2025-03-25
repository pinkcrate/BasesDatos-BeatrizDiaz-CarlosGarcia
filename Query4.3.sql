SELECT 
    usuario_id,
    nombre,
    apellido,
    email,
    hours_spent
FROM 
    usuario
ORDER BY 
    hours_spent DESC
LIMIT 15;