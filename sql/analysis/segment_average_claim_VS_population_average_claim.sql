-- Compare average insurance charges across customer segments
-- against the average charges for the entire population.

WITH overall_average AS (

    -- Calculate the average claim amount across all customers.
    -- This provides a baseline for comparing individual segments.

    SELECT
        AVG(charges) AS population_average
    FROM insurance

),

segment_averages AS (

    -- Divide customers into age groups to examine differences
    -- in average claim amounts across different stages of life.

    SELECT
        CASE
            WHEN age BETWEEN 18 AND 25 THEN 'Young Adults'
            WHEN age BETWEEN 26 AND 35 THEN 'Early Adults'
            WHEN age BETWEEN 36 AND 45 THEN 'Middle Adults'
            WHEN age BETWEEN 46 AND 55 THEN 'Mature Adults'
            ELSE 'Older Adults'
        END AS age_band,

        -- Include smoking status to compare lifestyle differences
        -- within each age group.

        CASE
            WHEN smoker = 'yes' THEN 'Smoker'
            WHEN smoker = 'no' THEN 'Non-Smoker'
        END AS lifestyle_segment,

        COUNT(*) AS total_customers,

        -- Calculate the average claim amount for each segment.

        AVG(charges) AS segment_average

    FROM insurance

    GROUP BY
        age_band,
        lifestyle_segment

)

-- Bring the segment averages and overall population average together
-- to determine how each segment compares with the entire population.

SELECT
    s.age_band,
    s.lifestyle_segment,
    s.total_customers,

    ROUND(s.segment_average, 2) AS segment_average_claim,

    ROUND(o.population_average, 2) AS overall_population_average




FROM segment_averages s

CROSS JOIN overall_average o

-- Rank segments from the highest average claim amount to the lowest.

ORDER BY
    s.segment_average DESC;