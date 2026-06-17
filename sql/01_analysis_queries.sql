SELECT * FROM customer LIMIT 20

SELECT "gender",SUM("purchase_amount")
FROM "customer"
GROUP BY "gender"

SELECT "customer_id",
"purchase_amount"
FROM "customer"
WHERE "discount_applied"='Yes' and "purchase_amount">=(SELECT AVG("purchase_amount") FROM "customer")

SELECT "item_purchased",ROUND(AVG("review_rating"::numeric),2) as "avg_product_rating"
FROM "customer"
GROUP BY "item_purchased"
order by "avg_product_rating" DESC
LIMIT 5;

SELECT "shipping_type",ROUND(AVG("purchase_amount"),2)
FROM "customer"
WHERE "shipping_type" in ('Standard','Express')
GROUP by "shipping_type"

SELECT ROUND(AVG("purchase_amount"),2) AS "average_spent",
SUM("purchase_amount") AS "Total_Revenue",
"subscription_status",
COUNT ("customer_id")
FROM "customer"
GROUP  BY "subscription_status"
ORDER BY "average_spent","Total_Revenue"

SELECT "item_purchased","discount_applied"
FROM "customer"
WHERE "discount_applied"='Yes'
GROUP BY "item_purchased"
ORDER BY "discount_rate"

-- Q6. Which 5 products have the highest percentage of purchases with discounts applied?
SELECT item_purchased,
ROUND(100 * SUM(CASE WHEN discount_applied = 'Yes' THEN 1 ELSE 0 END)/COUNT(*),2) as discount_rate
FROM customer
GROUP BY item_purchased
ORDER BY discount_rate DESC
LIMIT 5;

WITH "customer_type" AS(
SELECT "customer_id","previous_purchases",
CASE
	WHEN "previous_purchases"=1 THEN 'New'
	WHEN "previous_purchases" BETWEEN 2 AND 10 THEN 'Returning'
	ELSE 'Loyal'
	END AS "customer_segment"
FROM "customer"
)

SELECT "customer_segment",COUNT(*) AS "new_customers"
FROM "customer_type"
GROUP BY "customer_segment"

WITH item_counts AS (
    SELECT category,
    item_purchased,
    COUNT(customer_id) AS total_orders,
    ROW_NUMBER() OVER(PARTITION BY category ORDER BY COUNT(customer_id) DESC) AS item_rank
    FROM customer
    GROUP BY category, item_purchased
)

SELECT item_rank, category, item_purchased, total_orders
FROM item_counts
WHERE item_rank <= 3;

SELECT "subscription_status",
COUNT("customer_id") AS "repeat_buyers"
FROM "customer"
WHERE "previous_purchases">5
GROUP BY "subscription_status"

SELECT "age_group",
SUM("purchase_amount") AS "total_revenue"
FROM "customer"
GROUP BY "age_group"
ORDER BY "total_revenue" DESC