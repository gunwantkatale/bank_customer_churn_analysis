USE BANKCHURN;

-- Q2 How does churn rate vary across customer segments within each geography?
WITH MainTbl AS (
SELECT 
    CASE
		WHEN D.Age < 30 THEN 'Under 30'
        WHEN D.Age BETWEEN 30 AND 50 THEN 'Between 30 - 50'
        ELSE 'Above 50'
    END AS AgeGroup,
    D.Churned,
    L.Geography AS Country
FROM
    demographic D
        JOIN
    location L ON L.LocationId = D.LocationId
),

SecondTbl AS (
SELECT 
    Country,
    AgeGroup,
    COUNT(*) AS TotalCustomer,
    AVG(Churned) AS AverageChurnRate,
    AVG(AVG(Churned) ) OVER (PARTITION BY Country) AS AverageChurnCountry
FROM
    MainTbl
GROUP BY Country, AgeGroup
)

 SELECT 
	*,
    AverageChurnCountry - AverageChurnRate AS Diff
 FROM SecondTbl
 ORDER BY Country, AgeGroup;
    