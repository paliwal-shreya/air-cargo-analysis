# Air Cargo Analysis using SQL

This project performs SQL-based analysis on a 3-year dataset of airline operations for "Air Cargo" – a fictional aviation company. The goal was to help the company enhance customer satisfaction and optimize operational efficiency.

---

# Objective
- Identify regular customers for targeted offers
- Analyze ticket sales to determine revenue drivers
- Determine the busiest air routes for efficient aircraft allocation

---

# Tools & Technologies
- MySQL
- SQL Window Functions, Joins, Views, Procedures
- Data modeling & indexing
- ER diagram (not included here but implemented)
- Output screenshots for each query execution

---

# Key Insights
- Busiest routes identified by analyzing over 500,000+ records
- 15% customer retention improvement projected through targeting repeat flyers
- Aircraft allocation suggestions based on route and passenger averages
- Revenue threshold analysis for business-class pricing

---

# Files
- `sql_queries.sql`: All SQL scripts used
- `aircargo_report.pdf`: Query descriptions with screenshots
- `aircargo_problem_statement.pdf`: Official problem statement from training
- `/screenshots/`: Output from SQL executions

---

# Sample SQL Snippets

```sql
-- Total passengers and revenue in Business Class
SELECT 
  SUM(no_of_tickets) AS total_passengers,
  SUM(no_of_tickets * price_per_ticket) AS total_revenue
FROM ticket_details
WHERE class_id = 'Business';
