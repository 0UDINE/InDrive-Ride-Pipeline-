DROP TABLE IF EXISTS mart.revenue_by_vehicule_type;

CREATE TABLE mart.revenue_by_vehicule_type AS
SELECT 
    vehicle_type,
    COUNT(*) AS rides,
    ROUND(SUM(fare_amount),2) AS revenue
FROM mart.rides r
JOIN staging.vehicles v
ON r.driver_id = v.driver_id
GROUP BY 
    vehicle_type
ORDER BY revenue DESC;