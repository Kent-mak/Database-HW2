
WITH maxStringencyIndex("Continent_Code", "year", "month", "day", "StringencyIndex") AS
(
    SELECT
        "Continent_Code"
        "year",
        "month",
        "day", 
        MAX("StringencyIndex_Average_ForDisplay") AS "StringencyIndex"
    FROM
        "Indicies" JOIN "in_Continent" ON "Indicies"."CountryCode" = "in_Continent"."Country_Code"
    WHERE
        ("year" = '2022' and "month" = '12' and "day" = '01') OR
        ("year" = '2022' and "month" = '04' and "day" = '01') OR
        ("year" = '2021' and "month" = '04' and "day" = '01') OR
        ("year" = '2021' and "month" = '04' and "day" = '01')
    GROUP BY 
        "Continent_Code", "year", "month", "day";
    
),  minStringencyIndex("Continent_Code", "year", "month", "day", "StringencyIndex") AS
(
    SELECT
        "Continent_Code",
        "year",
        "month",
        "day", 
        MIN("StringencyIndex_Average_ForDisplay") AS "StringencyIndex"
    FROM
        "Indicies" JOIN "in_Continent" ON "Indicies"."CountryCode" = "in_Continent"."Country_Code"
    WHERE
        ("year" = '2022' and "month" = '12' and "day" = '01') OR
        ("year" = '2022' and "month" = '04' and "day" = '01') OR
        ("year" = '2021' and "month" = '04' and "day" = '01') OR
        ("year" = '2021' and "month" = '04' and "day" = '01')
    GROUP BY 
        "Continent_Code", "year", "month", "day"
        
), maxWithCountry("Continent_Code", "CountryCode" ,"year", "month", "day") AS 
(
    SELECT 
        "Continent"."Continent_Name" AS "Continent_Name",
        "Country"."Country_Name" AS "CountryName",
        maxStringencyIndex."year" AS "year", 
        maxStringencyIndex."month" AS ."month", 
        maxStringencyIndex."day" AS "day"
    FROM
        maxStringencyIndex, 
        ("Indicies" JOIN "in_Continent" ON "Indicies"."CountryCode" = "in_Continent"."Country_Code") AS WithContinent,
        "Country",
        "Continent"
    WHERE
        maxStringencyIndex."Continent_Code" = WithContinent."Continent_Code" AND
        maxStringencyIndex."year" = WithContinent."year" AND
        maxStringencyIndex."month" = WithContinent."month" AND
        maxStringencyIndex."day" = WithContinent."day" AND
        maxStringencyIndex."StringencyIndex" = WithContinent."StringencyIndex" AND
        WithContinent."CountryCode" = "Country"."Three_Letter_Country_Code" AND
        WithContinent."Continent_Code" = "Continent"."Continent_Code"

), minWithCountry("Continent_Code", "CountryCode" ,"year", "month", "day") AS
(
    
    SELECT 
        "Continent"."Continent_Name" AS "Continent_Name",
        "Country"."Country_Name" AS "CountryName",
        minStringencyIndex."year" AS "year", 
        minStringencyIndex."month" AS ."month", 
        minStringencyIndex."day" AS "day"
    FROM
        minStringencyIndex, 
        ("Indicies" JOIN "in_Continent" ON "Indicies"."CountryCode" = "in_Continent"."Country_Code") AS WithContinent,
        "Country",
        "Continent"
    WHERE
        minStringencyIndex."Continent_Code" = WithContinent."Continent_Code" AND
        minStringencyIndex."year" = WithContinent."year" AND
        minStringencyIndex."month" = WithContinent."month" AND
        minStringencyIndex."day" = WithContinent."day" AND
        minStringencyIndex."StringencyIndex" = WithContinent."StringencyIndex" AND
        WithContinent."CountryCode" = "Country"."Three_Letter_Country_Code" AND
        WithContinent."Continent_Code" = "Continent"."Continent_Code"
);

SELECT 
    minWithCountry."Continent_Name" AS "Continent_Name",
    maxWithCountry."CountryName" AS "CountryName with highest StringencyIndex" ,
    minWithCountry."CountryName" AS "CountryName with lowest StringencyIndex" ,
    "year", 
    "month", 
    "day"
FROM
    minWithCountry JOIN maxWithCountry 
    ON (
        minWithCountry."Continent_Name" = maxWithCountry."Continent_Name" AND
        minWithCountry."year" =maxWithCountry."year" AND
        minWithCountry."month" =maxWithCountry."month" AND
        minWithCountry."day" =maxWithCountry."day" AND
    )






