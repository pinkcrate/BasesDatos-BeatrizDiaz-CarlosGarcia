SELECT 
    u.name,
    u.last_name,
    u.email
FROM 
    pay_user u
JOIN 
    plan_per_user ppu ON u.user_id = ppu.user_id
JOIN 
    plan_prices pp ON ppu.prices_id = pp.prices_id
WHERE 
    pp.endDate BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 15 DAY);