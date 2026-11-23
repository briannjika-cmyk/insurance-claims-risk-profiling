-- Creating customer segments using age, region, lifestyle, BMI and family size
-- These categories will be used in subsequent insurance charge analysis.

SELECT
    age,
    
    CASE
        WHEN age BETWEEN 18 AND 25 THEN 'Young Adults'
        WHEN age BETWEEN 26 AND 35 THEN 'Early Adults'
        WHEN age BETWEEN 36 AND 45 THEN 'Middle Adults'
        WHEN age BETWEEN 46 AND 55 THEN 'Mature Adults'
        ELSE 'Older Adults'
    END AS age_band,

    region AS region_segment,

    CASE
        WHEN smoker = 'yes' THEN 'Smoker'
        ELSE 'Non-Smoker'
    END AS lifestyle_segment,

    bmi,

    CASE
        WHEN bmi < 18.5 THEN 'Underweight'
        WHEN bmi < 25 THEN 'Normal Weight'
        WHEN bmi < 30 THEN 'Overweight'
        ELSE 'Obese'
    END AS bmi_category,

    children,

    CASE
        WHEN children = 0 THEN 'No Children'
        WHEN children BETWEEN 1 AND 2 THEN 'Small Family'
        ELSE 'Large Family'
    END AS family_segment,

    charges

FROM insurance;