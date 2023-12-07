INSERT INTO "Country"
SELECT
    "Country_Name" ,
    "Two_Letter_Country_Code" ,
    "Three_Letter_Country_Code" ,
    "Country_Number"
FROM
    cont_count
GROUP BY 
    (
        "Country_Name" ,
        "Two_Letter_Country_Code" ,
        "Three_Letter_Country_Code" ,
        "Country_Number"
    );

INSERT INTO "Continent"
SELECT
    "Continent_Code",
    "Continent_Name" 
FROM
    cont_count
GROUP BY 
    (
        "Continent_Code",
        "Continent_Name"
    );



INSERT INTO "in_Continent"
SELECT
    "Continent_Code" ,
    "Three_Letter_Country_Code" AS "Country_Code"
FROM
    cont_count;



INSERT INTO "setting"
SELECT 
    "CountryCode",
    SUBSTRING(Date, 1, 4) AS "year",
    SUBSTRING(Date, 5, 2) AS "month",
    SUBSTRING(Date, 7, 2) AS "day",
    "ConfirmedCases" ,
    "ConfirmedDeaths" ,
    "MajorityVaccinated",
    "PopulationVaccinated"
FROM 
    OxCGRT;


INSERT INTO "Indicies"
SELECT
    "CountryCode",
    SUBSTRING(Date, 1, 4) AS "year",
    SUBSTRING(Date, 5, 2) AS "month",
    SUBSTRING(Date, 7, 2) AS "day",
    "StringencyIndex_Average" ,
    "StringencyIndex_Average_ForDisplay" ,
    "GovernmentResponseIndex_Average" ,
    "GovernmentResponseIndex_Average_ForDisplay" ,
    "ContainmentHealthIndex_Average" ,
    "ContainmentHealthIndex_Average_ForDisplay" ,
    "EconomicSupportIndex" ,
    "EconomicSupportIndex_ForDisplay" 
FROM
    OxCGRT;



INSERT INTO "ContainmentPolicies"
SELECT
    "CountryCode",
    SUBSTRING(Date, 1, 4) AS "year",
    SUBSTRING(Date, 5, 2) AS "month",
    SUBSTRING(Date, 7, 2) AS "day",
    "C1M_School closing",
    "C1M_Flag" ,
    "C2M_Workplace closing",
    "C2M_Flag" ,
    "C3M_Cancel public events",
    "C3M_Flag" ,
    "C4M_Restrictions on gatherings",
    "C4M_Flag" ,
    "C5M_Close public transport",
    "C5M_Flag" ,
    "C6M_Stay at home requirements",
    "C6M_Flag" ,
    "C7M_Restrictions on internal movement",
    "C7M_Flag" ,
    "C8EV_International travel controls"
FROM
    OxCGRT;



INSERT INTO "HealthSystemPolicies"
SELECT 
    "CountryCode",
    SUBSTRING(Date, 1, 4) AS "year",
    SUBSTRING(Date, 5, 2) AS "month",
    SUBSTRING(Date, 7, 2) AS "day",
    "H1_Public information campaigns" ,
    "H1_Flag" ,
    "H2_Testing policy" ,
    "H3_Contact tracing" ,
    "H4_Emergency investment in healthcare" ,
    "H5_Investment in vaccines" ,
    "H6M_Facial Coverings" ,
    "H6M_Flag" ,
    "H7_Vaccination policy" ,
    "H7_Flag" ,
    "H8M_Protection of elderly people" ,
    "H8M_Flag" 
FROM
    OxCGRT;



INSERT INTO "EconomicPolicies"
SELECT
    "CountryCode",
    SUBSTRING(Date, 1, 4) AS "year",
    SUBSTRING(Date, 5, 2) AS "month",
    SUBSTRING(Date, 7, 2) AS "day",
    "E1_Income support" ,
    "E1_Flag" ,
    "E2_Debt/contract relief" ,
    "E3_Fiscal measures" ,
    "E4_International support" 
FROM
    OxCGRT;



INSERT INTO "VaccinationPolicies"
SELECT
    "CountryCode",
    SUBSTRING(Date, 1, 4) AS "year",
    SUBSTRING(Date, 5, 2) AS "month",
    SUBSTRING(Date, 7, 2) AS "day",
    "V1_Vaccine Prioritisation (summary)" ,
    "V2A_Vaccine Availability (summary)" ,
    "V2B_Vaccine age eligibility/availability(population summary)" ,
    "V2C_Vaccine age eligibility/availability(risk summary)" ,
    "V2D_Medically/ clinically vulnerable (Non-elderly)" ,
    "V2E_Education" ,
    "V2F_Frontline workers (non healthcare)" ,
    "V2G_Frontline workers (healthcare)" ,
    "V3_Vaccine Financial Support (summary)" ,
    "V4_Mandatory Vaccination (summary)" 
FROM
    OxCGRT;



INSERT INTO "MiscellaneousPolicies"
SELECT
    "CountryCode",
    SUBSTRING(Date, 1, 4) AS "year",
    SUBSTRING(Date, 5, 2) AS "month",
    SUBSTRING(Date, 7, 2) AS "day",
    "M1_Wildcard"
FROM
    OxCGRT;