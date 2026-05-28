USE BANKCHURN;

-- Q3 How does churn behavior change when we dynamically slice customers by business parameters?
SET @MinTenure = 9;
SET @MaxBalance = 120000;
SET @MaxProduct = 6;

SELECT 
	A.CustomerId,
	A.Tenure,
    A.Balance,
    A.NumProducts,
    D.Churned
FROM account A
JOIN demographic D ON D.CustomerId = A.CustomerId
WHERE 
Tenure > @MinTenure
AND Balance < @MaxBalance
AND NumProducts < @MaxProduct;