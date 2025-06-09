-- 1. Display passengers who traveled on routes 1 to 25
SELECT * FROM passengers_on_flights WHERE route_id BETWEEN 1 AND 25;

-- 2. Total passengers and revenue in Business class
SELECT SUM(no_of_tickets) AS total_passengers, SUM(no_of_tickets * price_per_ticket) AS total_revenue FROM ticket_details WHERE class_id = 'Business';

-- 3. Display full names of customers
SELECT customer_id, CONCAT(first_name, ' ', last_name) AS full_name FROM customer;

-- 4. Customers who registered and booked tickets
SELECT DISTINCT c.customer_id, c.first_name, c.last_name FROM customer c INNER JOIN ticket_details t ON c.customer_id = t.customer_id;

-- 5. Customers who booked tickets with brand 'Emirates'
SELECT DISTINCT c.first_name, c.last_name FROM customer c INNER JOIN ticket_details t ON c.customer_id = t.customer_id WHERE t.brand = 'Emirates';

-- 6. Customers who traveled in Economy Plus
SELECT customer_id FROM passengers_on_flights WHERE class_id = (SELECT class_id FROM passengers_on_flights WHERE class_id = 'Economy Plus' LIMIT 1);

-- 7. Revenue threshold analysis
SELECT IF(SUM(no_of_tickets * price_per_ticket) > 10000, 'Revenue Crossed 10000', 'Revenue Not Crossed') AS revenue_status FROM ticket_details;

-- 8. Create a new database user
CREATE USER 'new_user'@'localhost' IDENTIFIED BY 'password123';
GRANT ALL PRIVILEGES ON AirCargo.* TO 'new_user'@'localhost';
FLUSH PRIVILEGES;

-- 9. Max ticket price per class using window function
SELECT class_id, price_per_ticket, MAX(price_per_ticket) OVER (PARTITION BY class_id) AS max_ticket_price_per_class FROM ticket_details;

-- 10. Create index on route_id
CREATE INDEX idx_route_id ON passengers_on_flights(route_id);

-- 11. Execution plan for route_id = 4
EXPLAIN SELECT * FROM passengers_on_flights WHERE route_id = 4;

-- 12. Total spent per customer and aircraft
SELECT customer_id, aircraft_id, SUM(no_of_tickets * price_per_ticket) AS total_spent FROM ticket_details GROUP BY customer_id, aircraft_id WITH ROLLUP;

-- 13. Create a view for business class customers
CREATE VIEW business_class_customers AS SELECT customer_id, brand FROM ticket_details WHERE class_id = 'Business';

-- 14. Stored procedure for long routes
DELIMITER $$
CREATE PROCEDURE GetLongRoutes()
BEGIN
    SELECT * FROM routes WHERE distance_miles > 2000;
END $$
DELIMITER ;

-- 15. Total tickets and price per customer
SELECT customer_id, SUM(no_of_tickets) AS total_tickets, SUM(no_of_tickets * price_per_ticket) AS total_price FROM ticket_details GROUP BY customer_id;

-- 16. Average distance and passengers per aircraft
SELECT r.aircraft_id, AVG(r.distance_miles) AS avg_distance, AVG(passenger_counts.total_passengers) AS avg_passengers
FROM routes r
JOIN (
    SELECT aircraft_id, COUNT(DISTINCT travel_date) AS total_departures, COUNT(customer_id) AS total_passengers
    FROM passengers_on_flights
    GROUP BY aircraft_id
    HAVING total_departures > 1
) AS passenger_counts
ON r.aircraft_id = passenger_counts.aircraft_id
GROUP BY r.aircraft_id;
