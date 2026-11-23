-- Compare average claim amounts across age and lifestyle segments

SELECT
    CASE
        WHEN age BETWEEN 18 AND 25 THEN 'Young Adults'
        WHEN age BETWEEN 26 AND 35 THEN 'Early Adults'
        WHEN age BETWEEN 36 AND 45 THEN 'Middle Adults'
        WHEN age BETWEEN 46 AND 55 THEN 'Mature Adults'
        ELSE 'Older Adults'
    END AS age_band,

    CASE
        WHEN smoker = 'yes' THEN 'Smoker'
        WHEN smoker = 'no' THEN 'Non-Smoker'
    END AS lifestyle_segment,

    COUNT(*) AS number_of_claims,
    ROUND(AVG(charges), 2) AS average_claim_amount

FROM insurance

GROUP BY
    age_band,
    lifestyle_segment

ORDER BY
    MIN(age),
    lifestyle_segment;