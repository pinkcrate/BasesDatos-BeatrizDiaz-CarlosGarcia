SELECT 
    u.nombre,
    u.apellido,
    u.email
FROM 
    usuario u
JOIN 
    plan_per_user ppu ON u.usuario_id = ppu.usuario_id
JOIN 
    plan_prices pp ON ppu.prices_id = pp.prices_id
WHERE 
    pp.endDate BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 15 DAY);