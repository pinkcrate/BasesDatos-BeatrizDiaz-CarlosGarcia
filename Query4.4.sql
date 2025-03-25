SELECT
    l.IAlogs_id,
    l.description AS error,
    l.errorDetail AS codigo
FROM
    iA_logs l
WHERE
    l.errorDetail IS NOT NULL
ORDER BY
    l.IAlogs_id DESC;