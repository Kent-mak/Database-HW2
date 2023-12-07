\o 'C:/Users/DELL/OneDrive/Desktop/NYCU/Database/HW2/result/b.txt'

WITH  present("CountryCode","year", "month", "day", "ConfirmedCases") AS
(
    SELECT 
        "CountryCode",
        "year",
        "month",
        "day",
        "ConfirmedCases"
    FROM
        "setting"
    WHERE
        ("year" = '2022' and "month" = '12' and "day" = '01') OR
        ("year" = '2022' and "month" = '04' and "day" = '01') OR
        ("year" = '2021' and "month" = '04' and "day" = '01') OR
        ("year" = '2020' and "month" = '04' and "day" = '01')
        
),
past("CountryCode","year", "month", "day", "ConfirmedCases") AS
(
    SELECT 
        "CountryCode",
        "year",
        "month",
        "day",
        "ConfirmedCases"
    FROM
        "setting"
    WHERE
        ("year" = '2022' and "month" = '11' and "day" = '24') OR
        ("year" = '2022' and "month" = '03' and "day" = '24') OR
        ("year" = '2021' and "month" = '03' and "day" = '24') OR
        ("year" = '2020' and "month" = '03' and "day" = '24')
),

seven_day_moving_avg ("CountryCode","year", "month", "day", avg_new_cases) AS
(
    SELECT 
        present."CountryCode",
        present."year",
        present."month",
        present."day",
        ((present."ConfirmedCases" - past."ConfirmedCases") / 7) AS avg_new_cases
    FROM
        present , past

    WHERE
        present."CountryCode" = past."CountryCode" AND
        present."year" = past."year" AND
        (
            (present."month" = '12' AND past."month" = '11') OR
            (present."month" = '04' AND past."month" = '03')
        )
),
Over_Stringency_Index("Continent_Name","Country_Name","year", "month", "day", overStringencyIndex) AS
(
    SELECT 
        "Continent_Name", "Country_Name","year", "month", "day", overStringencyIndex
    FROM
        "in_Continent",
        (
            SELECT
                seven_day_moving_avg."CountryCode",
                seven_day_moving_avg."year",
                seven_day_moving_avg."month",
                seven_day_moving_avg."day", 
                
                (
                    CASE
                    WHEN avg_new_cases = 0 THEN "StringencyIndex_Average_ForDisplay"/0.1
                    ELSE "StringencyIndex_Average_ForDisplay"/avg_new_cases
                    END
                ) AS overStringencyIndex
            FROM 
                "Indicies" JOIN seven_day_moving_avg 
                ON (
                    "Indicies"."CountryCode" = seven_day_moving_avg."CountryCode" AND
                    "Indicies"."year" = seven_day_moving_avg."year" AND
                    "Indicies"."month" = seven_day_moving_avg."month" AND
                    "Indicies"."day" = seven_day_moving_avg."day"
                )
        ) AS T,
        "Country",
        "Continent"
    WHERE 
        "in_Continent"."Country_Code" =  T."CountryCode" AND
         T."CountryCode" = "Country"."Three_Letter_Country_Code" AND
         "in_Continent"."Continent_Code" = "Continent"."Continent_Code"
    
),
max_Over_Stringency_Index("Continent_Name", "Country_Name","year", "month", "day", overStringencyIndex) AS
(
    SELECT
        "Continent_Name", "Country_Name","year", "month", "day", overStringencyIndex
    FROM
        (
            SELECT
                "Continent_Name", "Country_Name","year", "month", "day", overStringencyIndex,
                RANK() OVER(
                    PARTITION BY(
                        "Continent_Name", "year", "month", "day", overStringencyIndex IS NOT NULL
                    )
                    ORDER BY overStringencyIndex DESC
                )
            FROM
                Over_Stringency_Index
        ) AS T
    WHERE
        overStringencyIndex IS NOT NULL AND rank = 1

),
min_Over_Stringency_Index("Continent_Name", "Country_Name","year", "month", "day", overStringencyIndex) AS
(
    SELECT
        "Continent_Name", "Country_Name","year", "month", "day", overStringencyIndex
    FROM
        (
            SELECT
                "Continent_Name", "Country_Name","year", "month", "day", overStringencyIndex,
                RANK() OVER(
                    PARTITION BY(
                        "Continent_Name", "year", "month", "day", overStringencyIndex IS NOT NULL
                    )
                    ORDER BY overStringencyIndex ASC
                )
            FROM
                Over_Stringency_Index
        ) AS T
    WHERE
        overStringencyIndex IS NOT NULL AND rank = 1

)

SELECT
    max_Over_Stringency_Index."Continent_Name",
    max_Over_Stringency_Index."Country_Name" AS "Country with highest Over Stringency Index",
    max_Over_Stringency_Index.overStringencyIndex AS "Max over Stringency Index",
    min_Over_Stringency_Index."Country_Name" AS "Country with lowest Over Stringency Index",
    min_Over_Stringency_Index.overStringencyIndex AS "Min over Stringency Index",
    max_Over_Stringency_Index."year", 
    max_Over_Stringency_Index."month", 
    max_Over_Stringency_Index."day"
    
FROM
    max_Over_Stringency_Index, min_Over_Stringency_Index
WHERE
    max_Over_Stringency_Index."Continent_Name" = min_Over_Stringency_Index."Continent_Name" AND
    max_Over_Stringency_Index."year" = min_Over_Stringency_Index."year" AND
    max_Over_Stringency_Index."month" = min_Over_Stringency_Index."month" AND
    max_Over_Stringency_Index."day" = min_Over_Stringency_Index."day"