SELECT 
    u.name, 
    u.last_name, 
    u.email, 
    c.name AS country, 
    SUM(p.price * cur.exchange_rate) AS total_paid_colones
FROM 
    pay_user u
JOIN 
    address a ON u.address_id = a.address_id
JOIN 
    city ci ON a.city_id = ci.city_id
JOIN 
    region r ON ci.region_id = r.region_id
JOIN 
    countries c ON r.country_id = c.country_id
JOIN 
    payments p ON u.user_id = p.user_id
JOIN 
    currency cur ON p.currency_id = cur.currency_id
WHERE 
    u.active = 1 AND p.date >= '2024-01-01'
GROUP BY 
    u.user_id, c.country_id;