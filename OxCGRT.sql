CREATE TABLE OxCGRT(
    "CountryName"  varchar,
    "CountryCode"  varchar,
    "RegionName"   varchar,
    "RegionCode"   varchar,
    "Jurisdiction" varchar,
    Date  varchar,
    "C1M_School closing" numeric,
    "C1M_Flag" int,
    "C2M_Workplace closing" numeric,
    "C2M_Flag" int,
    "C3M_Cancel public events" numeric,
    "C3M_Flag" int,
    "C4M_Restrictions on gatherings" numeric,
    "C4M_Flag" int,
    "C5M_Close public transport" numeric,
    "C5M_Flag" int,
    "C6M_Stay at home requirements" numeric,
    "C6M_Flag" int,
    "C7M_Restrictions on internal movement" numeric,
    "C7M_Flag" int,
    "C8EV_International travel controls" numeric,
    "E1_Income support" numeric,
    "E1_Flag" int,
    "E2_Debt/contract relief" numeric,
    "E3_Fiscal measures" numeric,
    "E4_International support" numeric,
    "H1_Public information campaigns" numeric,
    "H1_Flag" int,
    "H2_Testing policy" numeric,
    "H3_Contact tracing" numeric,
    "H4_Emergency investment in healthcare" numeric,
    "H5_Investment in vaccines" numeric,
    "H6M_Facial Coverings" numeric,
    "H6M_Flag" int,
    "H7_Vaccination policy" numeric,
    "H7_Flag" int,
    "H8M_Protection of elderly people" numeric,
    "H8M_Flag" int,
    "M1_Wildcard" varchar,
    "V1_Vaccine Prioritisation (summary)" int,
    "V2A_Vaccine Availability (summary)" int,
    "V2B_Vaccine age eligibility/availability(population summary)" varchar,
    "V2C_Vaccine age eligibility/availability(risk summary)" varchar,
    "V2D_Medically/ clinically vulnerable (Non-elderly)" int,
    "V2E_Education" int,
    "V2F_Frontline workers (non healthcare)" int,
    "V2G_Frontline workers (healthcare)" int,
    "V3_Vaccine Financial Support (summary)" int,
    "V4_Mandatory Vaccination (summary)" int,
    "ConfirmedCases" int,
    "ConfirmedDeaths" int,
    "MajorityVaccinated" varchar,
    "PopulationVaccinated" numeric,
    "StringencyIndex_Average" numeric,
    "StringencyIndex_Average_ForDisplay" numeric,
    "GovernmentResponseIndex_Average" numeric,
    "GovernmentResponseIndex_Average_ForDisplay" numeric,
    "ContainmentHealthIndex_Average" numeric,
    "ContainmentHealthIndex_Average_ForDisplay" numeric,
    "EconomicSupportIndex" numeric,
    "EconomicSupportIndex_ForDisplay" numeric
);

 \copy OxCGRT FROM 'C:/Users/DELL/OneDrive/Desktop/NYCU/Database/HW2/OxCGRT_nat_latest.csv' WITH DELIMITER ',' CSV HEADER;

-- COPY OxCGRT
-- FROM 'C:/Users/DELL/OneDrive/Desktop/NYCU/Database/HW2/OxCGRT_nat_latest.csv'
-- DELIMITER ','
-- CSV HEADER;

-- (
--     CountryName  ,
--     CountryCode  ,
--     RegionName   ,
--     RegionCode   ,
--     Jurisdiction ,
--     Date  ,
--     "C1M_School closing" ,
--     C1M_Flag ,
--     "C2M_Workplace closing" ,
--     C2M_Flag ,
--     "C3M_Cancel public events" ,
--     C3M_Flag ,
--     "C4M_Restrictions on gatherings" ,
--     C4M_Flag ,
--     "C5M_Close public transport" ,
--     C5M_Flag ,
--     "C6M_Stay at home requirements" ,
--     C6M_Flag ,
--     "C7M_Restrictions on internal movement" ,
--     C7M_Flag ,
--     "C8EV_International travel controls" ,
--     "E1_Income support" ,
--     E1_Flag ,
--     "E2_Debt/contract relief" ,
--     "E3_Fiscal measures" ,
--     "E4_International support" ,
--     "H1_Public information campaigns" ,
--     H1_Flag ,
--     "H2_Testing policy" ,
--     "H3_Contact tracing" ,
--     "H4_Emergency investment in healthcare" ,
--     "H5_Investment in vaccines" ,
--     "H6M_Facial Coverings" ,
--     H6M_Flag ,
--     "H7_Vaccination policy" ,
--     H7_Flag ,
--     "H8M_Protection of elderly people" ,
--     H8M_Flag ,
--     M1_Wildcard ,
--     "V1_Vaccine Prioritisation (summary)" ,
--     "V2A_Vaccine Availability (summary)" ,
--     "V2B_Vaccine age eligibility/availability age floor (general population summary)" ,
--     "V2C_Vaccine age eligibility/availability age floor (at risk summary)" ,
--     "V2D_Medically/ clinically vulnerable (Non-elderly)" ,
--     V2E_Education ,
--     "V2F_Frontline workers  (non healthcare)" ,
--     "V2G_Frontline workers  (healthcare)" ,
--     "V3_Vaccine Financial Support (summary)" ,
--     "V4_Mandatory Vaccination (summary)" ,
--     ConfirmedCases ,
--     ConfirmedDeaths ,
--     MajorityVaccinated ,
--     PopulationVaccinated ,
--     StringencyIndex_Average ,
--     StringencyIndex_Average_ForDisplay ,
--     GovernmentResponseIndex_Average ,
--     GovernmentResponseIndex_Average_ForDisplay ,
--     ContainmentHealthIndex_Average ,
--     ContainmentHealthIndex_Average_ForDisplay ,
--     EconomicSupportIndex ,
--     EconomicSupportIndex_ForDisplay 
-- )