SELECT 
    p.description AS problema,
    COUNT(*) AS cantidad_ocurrencias
FROM 
    iA_logs l
JOIN 
    ia_proccessing p ON l.procces_id = p.procces_id
WHERE 
    l.errorDetail IS NOT NULL AND l.userCorrections IS NOT NULL
GROUP BY 
    p.description
ORDER BY 
    cantidad_ocurrencias DESC;