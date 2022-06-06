SELECT 
    request_at AS Day, 
    ROUND(SUM(CASE 
                WHEN t.status IN ('cancelled_by_driver','cancelled_by_client') THEN 1 
                ELSE 0 
              END) / COUNT(*), 2) AS 'Cancellation Rate' 
FROM 
    trips t 
LEFT JOIN 
    users u1 
ON 
    t.client_id = u1.users_id 
LEFT JOIN 
    users u2 
ON 
    t.driver_id = u2.users_id 
WHERE 
    u1.banned = 'No' AND u2.banned = 'No' AND request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY 
    request_at
