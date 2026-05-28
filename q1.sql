USE BANKCHURN;

-- Q1: Which customer profiles have the highest churn risk rate based on gender?
WITH MainTbl AS(
    SELECT 
        gender,
        COUNT(*) AS TotalCustomer,
        SUM(Churned) AS TotalChurn
    FROM
        demographic
    GROUP BY gender
)

SELECT 
    *, ROUND((TotalChurn * 100 / TotalCustomer),2) AS ChurnRate
FROM
    MainTbl;