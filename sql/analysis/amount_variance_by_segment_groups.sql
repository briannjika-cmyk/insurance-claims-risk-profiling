-- Compare claim amount variations across different age and lifestyle groups
-- to identify which customer segment has the most unpredictable insurance costs.

SELECT

    -- Divide customers into age groups to make risk comparisons easier.
    CASE
        WHEN age BETWEEN 18 AND 25 THEN 'Young Adults'
        WHEN age BETWEEN 26 AND 35 THEN 'Early Adults'
        WHEN age BETWEEN 36 AND 45 THEN 'Middle Adults'
        WHEN age BETWEEN 46 AND 55 THEN 'Mature Adults'
        ELSE 'Older Adults'
    END AS age_band,

    -- Use smoking status as a lifestyle factor because it may be associated
    -- with differences in insurance claim amounts.
    CASE
        WHEN smoker = 'yes' THEN 'Smoker'
        WHEN smoker = 'no' THEN 'Non-Smoker'
    END AS lifestyle_segment,

    -- Count customers in each segment to understand the size of each group.
    COUNT(*) AS total_customers,

    -- Calculate the average charges to compare typical claim amounts.
    ROUND(AVG(charges), 2) AS average_claim_amount,

    -- Measure how widely claim amounts differ from their segment average.
    -- A higher variance indicates greater unpredictability in claim amounts.
    ROUND(VARIANCE(charges), 2) AS claim_amount_variance

FROM insurance

-- Compare customers who share the same age group and smoking status.
GROUP BY
    age_band,
    lifestyle_segment

-- Rank the groups by variance so the most unpredictable segment appears first.
ORDER BY
    claim_amount_variance DESC;