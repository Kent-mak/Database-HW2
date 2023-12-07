CREATE TABLE cont_count(
    "Continent_Name" VARCHAR,
    "Continent_Code" VARCHAR,
    "Country_Name" VARCHAR,
    "Two_Letter_Country_Code" VARCHAR,
    "Three_Letter_Country_Code" VARCHAR,
    "Country_Number" INT
);

\encoding UTF-8

\copy cont_count FROM 'C:/Users/DELL/OneDrive/Desktop/NYCU/Database/HW2/country-and-continent-codes-list-csv.csv' WITH DELIMITER ',' CSV HEADER;

UPDATE cont_count
SET
    "Country_Name" = sub."CountryName"
FROM
    (
        SELECT
            *
        FROM 
            cont_count JOIN OxCGRT ON (cont_count."Three_Letter_Country_Code" = OxCGRT."CountryCode") 
    ) AS sub
WHERE
    cont_count."Three_Letter_Country_Code" = sub."CountryCode";
    



-- COPY cont_count(Continent_Name,Continent_Code,Country_Name,Two_Letter_Country_Code,Three_Letter_Country_Code,Country_Number)
-- FROM 'C:\Users\DELL\OneDrive\Desktop\NYCU\Database\HW2\country-and-continent-codes-list-csv.csv'
-- DELIMITER ','
-- CSV HEADER;
