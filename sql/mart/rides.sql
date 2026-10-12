-- TODO: build mart.rides = one row per ride, with names instead of ids
-- columns: ride_id, requested_at, driver_id, driver_name, rating,
--          pickup_zone, dropoff_zone, distance_km, fare_amount
-- sources: staging.rides + staging.drivers + staging.zones (TWICE: two aliases)

DROP TABLE IF EXISTS mart.rides;

CREATE TABLE mart.rides AS
SELECT 
    r.ride_id,
    r.requested_at,
    d.driver_id,
    d.driver_name,
    d.rating,
    zpick.zone_name AS pickup_zone,
    zdrop.zone_name AS dropoff_zone,
    r.distance_km,
    r.fare_amount
FROM staging.rides r
JOIN staging.drivers d
ON r.driver_id = d.driver_id
JOIN staging.zones zpick
ON zpick.zone_id = r.pickup_zone_id
JOIN staging.zones zdrop
ON zdrop.zone_id = r.dropoff_zone_id;