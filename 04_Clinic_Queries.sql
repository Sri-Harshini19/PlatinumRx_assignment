-- Revenue by sales channel
SELECT
    sales_channel,
    SUM(amount) revenue
FROM clinic_sales
WHERE EXTRACT(YEAR FROM datetime)=2021
GROUP BY sales_channel;

-- Top 10 valuable customers
SELECT
    uid,
    SUM(amount) total_spent
FROM clinic_sales
WHERE EXTRACT(YEAR FROM datetime)=2021
GROUP BY uid
ORDER BY total_spent DESC
LIMIT 10;

-- Monthly profit/loss
WITH revenue AS (
    SELECT
        EXTRACT(MONTH FROM datetime) AS month_num,
        SUM(amount) AS revenue
    FROM clinic_sales
    WHERE EXTRACT(YEAR FROM datetime)=2021
    GROUP BY EXTRACT(MONTH FROM datetime)
),
expense AS (
    SELECT
        EXTRACT(MONTH FROM datetime) AS month_num,
        SUM(amount) AS expense
    FROM expenses
    WHERE EXTRACT(YEAR FROM datetime)=2021
    GROUP BY EXTRACT(MONTH FROM datetime)
)

SELECT
    r.month_num,
    r.revenue,
    e.expense,
    (r.revenue - e.expense) AS profit,
    CASE
        WHEN (r.revenue - e.expense) > 0 THEN 'Profitable'
        ELSE 'Not Profitable'
    END AS status
FROM revenue r
JOIN expense e
ON r.month_num = e.month_num;