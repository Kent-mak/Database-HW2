\o 'C:/Users/DELL/OneDrive/Desktop/NYCU/Database/HW2/result/a.txt'


WITH  Indices_of_dates AS
(
    SELECT * FROM "Indicies"
    WHERE
        ("year" = '2022' and "month" = '12' and "day" = '01') OR
        ("year" = '2022' and "month" = '04' and "day" = '01') OR
        ("year" = '2021' and "month" = '04' and "day" = '01') OR
        ("year" = '2020' and "month" = '04' and "day" = '01')
),
T_complete ("Continent_Name","Continent_Code","Country_Name","year","month","day","stringencyIndex")AS
(
    SELECT 
        "Continent"."Continent_Name",
        "Continent"."Continent_Code",
        "Country"."Country_Name",
        T."year",
        T."month",
        T."day",
        T."StringencyIndex_Average_ForDisplay"
    FROM
        (
            SELECT
                 * 
            FROM
                Indices_of_dates 
                JOIN 
                "in_Continent" 
                ON Indices_of_dates."CountryCode" = "in_Continent"."Country_Code"
        ) AS T ,
        "Country" ,
        "Continent"
    WHERE
        T."Country_Code" = "Country"."Three_Letter_Country_Code" AND
        T."Continent_Code" = "Continent"."Continent_Code"
),
maxStringencyIndex("Continent_Name", "Country_Name", "year", "month", "day") AS
(
    SELECT
        "Continent_Name", "Country_Name", "year", "month", "day"
    FROM
        (
            SELECT
                "Continent_Name", "Country_Name", "year", "month", "day"
                RANK() OVER (
                    PARTITION BY 
                        "Continent_Code",
                        "year", 
                        "month",
                        "day",
                        "stringencyIndex" IS NOT NULL
                    ORDER BY "stringencyIndex" DESC
                )

            FROM
                T_complete
        ) grouped

    WHERE 
        rank = 1 AND "stringencyIndex" IS NOT NULL

), 
minStringencyIndex("Continent_Name", "Country_Name", "year", "month", "day") AS
(
SELECT
    "Continent_Name", "Country_Name", "year", "month", "day"
FROM
    (
        SELECT
            "Continent_Name", "Country_Name", "year", "month", "day"
            RANK() OVER (
                PARTITION BY 
                    "Continent_Code",
                    "year", 
                    "month",
                    "day",
                    "stringencyIndex" IS NOT NULL
                ORDER BY "stringencyIndex" ASC
            )

        FROM
            T_complete
    ) grouped

WHERE 
    rank = 1 AND "stringencyIndex" IS NOT NULL

)

SELECT 
    maxStringencyIndex."Continent_Name" AS "Continent Name",
    maxStringencyIndex."Country_Name" AS "Country higjest StringencyIndex",
    minStringencyIndex."Country_Name" AS "Country lowest StringencyIndex",
    maxStringencyIndex."year",
    maxStringencyIndex."month",
    maxStringencyIndex."day"
FROM
    maxStringencyIndex JOIN minStringencyIndex
    ON (
        maxStringencyIndex."Continent_Name" = minStringencyIndex."Continent_Name" AND
        maxStringencyIndex."year" = minStringencyIndex."year" AND
        maxStringencyIndex."month" = minStringencyIndex."month" AND
        maxStringencyIndex."day" = minStringencyIndex."day"
    )
ORDER BY 
    maxStringencyIndex."Continent_Name";








