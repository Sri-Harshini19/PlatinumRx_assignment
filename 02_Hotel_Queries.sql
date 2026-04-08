-- Q1. Last booked room for every user
SELECT DISTINCT ON (u.user_id)
    u.user_id,
    b.room_no
FROM users u
JOIN bookings b ON u.user_id = b.user_id
ORDER BY u.user_id, b.booking_date DESC;

-- Q2. Booking billing in Nov 2021
SELECT
    bc.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_billing
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE EXTRACT(MONTH FROM bc.bill_date)=11
AND EXTRACT(YEAR FROM bc.bill_date)=2021
GROUP BY bc.booking_id;

-- Q3. Bills >1000 in Oct 2021
SELECT
    bc.bill_id,
    SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id=i.item_id
WHERE EXTRACT(MONTH FROM bc.bill_date)=10
AND EXTRACT(YEAR FROM bc.bill_date)=2021
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity*i.item_rate)>1000;

-- Q4. Most/Least ordered item monthly
WITH item_orders AS (
    SELECT
        EXTRACT(MONTH FROM bc.bill_date) AS month,
        i.item_name,
        SUM(bc.item_quantity) total_qty,
        RANK() OVER (
            PARTITION BY EXTRACT(MONTH FROM bc.bill_date)
            ORDER BY SUM(bc.item_quantity) DESC
        ) most_rank,
        RANK() OVER (
            PARTITION BY EXTRACT(MONTH FROM bc.bill_date)
            ORDER BY SUM(bc.item_quantity) ASC
        ) least_rank
    FROM booking_commercials bc
    JOIN items i ON bc.item_id=i.item_id
    WHERE EXTRACT(YEAR FROM bc.bill_date)=2021
    GROUP BY month,i.item_name
)
SELECT *
FROM item_orders
WHERE most_rank=1 OR least_rank=1;

-- Q5. Second highest bill monthly

WITH monthly_bills AS (
    SELECT
        u.name,
        EXTRACT(MONTH FROM bc.bill_date) AS month,
        SUM(bc.item_quantity*i.item_rate) total_bill,
        DENSE_RANK() OVER(
            PARTITION BY EXTRACT(MONTH FROM bc.bill_date)
            ORDER BY SUM(bc.item_quantity*i.item_rate) DESC
        ) rank_num
    FROM booking_commercials bc
    JOIN bookings b ON bc.booking_id=b.booking_id
    JOIN users u ON b.user_id=u.user_id
    JOIN items i ON bc.item_id=i.item_id
    WHERE EXTRACT(YEAR FROM bc.bill_date)=2021
    GROUP BY u.name,month
)
SELECT *
FROM monthly_bills
WHERE rank_num=2;