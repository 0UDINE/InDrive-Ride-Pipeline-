-- TODO: build mart.driver_leaderboard from mart.rides + staging.vehicles
-- columns: driver_name, vehicle_type, rating, rides (count), revenue (sum of fare_amount, rounded to 2)
-- biggest revenue first

DROP TABLE IF EXISTS mart.driver_leaderboard;

CREATE TABLE mart.driver_leaderboard AS
SELECT 
    driver_name,
    vehicle_type,
    rating,
    COUNT(*) AS rides,
    ROUND(SUM(fare_amount),2) AS revenue
FROM mart.rides r
JOIN staging.vehicles v
ON r.driver_id = v.driver_id
GROUP BY 
    driver_name,
    vehicle_type,
    rating
ORDER BY revenue DESC;