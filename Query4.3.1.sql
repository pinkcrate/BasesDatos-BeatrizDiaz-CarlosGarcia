SELECT 
    user_id,
    name,
    last_name,
    email,
    hours_spent
FROM 
    pay_user
ORDER BY 
    hours_spent DESC
LIMIT 15;


