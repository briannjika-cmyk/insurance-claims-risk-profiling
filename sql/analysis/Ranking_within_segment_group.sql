-- Rank individual policyholders by claim amount within their age
-- and lifestyle segments to identify high- and low-cost policyholders.

SELECT
    age,
    smoker,
    charges,

    -- Group policyholders into age bands for segment-level comparisons.
    CASE
        WHEN age BETWEEN 18 AND 25 THEN 'Young Adults'
        WHEN age BETWEEN 26 AND 35 THEN 'Early Adults'
        WHEN age BETWEEN 36 AND 45 THEN 'Middle Adults'
        WHEN age BETWEEN 46 AND 55 THEN 'Mature Adults'
        ELSE 'Older Adults'
    END AS age_band,

    -- Use smoking status as the lifestyle factor in each segment.
    CASE
        WHEN smoker = 'yes' THEN 'Smoker'
        WHEN smoker = 'no' THEN 'Non-Smoker'
    END AS lifestyle_segment,

    -- Rank policyholders from the highest to lowest claim amount.
    -- PARTITION BY restarts the ranking for every age and lifestyle segment.
    -- ORDER BY charges DESC places the highest claim amount first.

    RANK() OVER (
        PARTITION BY
            CASE
                WHEN age BETWEEN 18 AND 25 THEN 'Young Adults'
                WHEN age BETWEEN 26 AND 35 THEN 'Early Adults'
                WHEN age BETWEEN 36 AND 45 THEN 'Middle Adults'
                WHEN age BETWEEN 46 AND 55 THEN 'Mature Adults'
                ELSE 'Older Adults'
            END,
            smoker
        ORDER BY charges DESC
    ) AS claim_rank

FROM insurance

-- Display the highest-ranking policyholders first within each segment.
ORDER BY
    age_band,
    lifestyle_segment,
    claim_rank;