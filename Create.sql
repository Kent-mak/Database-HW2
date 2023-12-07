CREATE TABLE "setting" (
  "CountryCode" varchar,
  "year" varchar,
  "month" varchar,
  "day" varchar,
  "ConfirmedCases" int,
  "ConfirmedDeaths" int,
  "MajorityVaccinated" varchar,
  "PopulationVaccinated" numeric,
  PRIMARY KEY ("CountryCode", "year", "month", "day")
);

CREATE TABLE "Indicies" (
  "CountryCode" varchar,
  "year" varchar,
  "month" varchar,
  "day" varchar,
  "StringencyIndex_Average" numeric,
  "StringencyIndex_Average_ForDisplay" numeric,
  "GovernmentResponseIndex_Average" numeric,
  "GovernmentResponseIndex_Average_ForDisplay" numeric,
  "ContainmentHealthIndex_Average" numeric,
  "ContainmentHealthIndex_Average_ForDisplay" numeric,
  "EconomicSupportIndex" numeric,
  "EconomicSupportIndex_ForDisplay" numeric,
  PRIMARY KEY ("CountryCode", "year", "month", "day")
);

CREATE TABLE "ContainmentPolicies" (
  "CountryCode" varchar,
  "year" varchar,
  "month" varchar,
  "day" varchar,
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
  PRIMARY KEY ("CountryCode", "year", "month", "day")
);

CREATE TABLE "HealthSystemPolicies" (
  "CountryCode" varchar,
  "year" varchar,
  "month" varchar,
  "day" varchar,
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
  PRIMARY KEY ("CountryCode", "year", "month", "day")
);

CREATE TABLE "EconomicPolicies" (
  "CountryCode" varchar,
  "year" varchar,
  "month" varchar,
  "day" varchar,
  "E1_Income support" numeric,
  "E1_Flag" int,
  "E2_Debt/contract relief" numeric,
  "E3_Fiscal measures" numeric,
  "E4_International support" numeric,
  PRIMARY KEY ("CountryCode", "year", "month", "day")
);

CREATE TABLE "VaccinationPolicies" (
  "CountryCode" varchar,
  "year" varchar,
  "month" varchar,
  "day" varchar,
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
  PRIMARY KEY ("CountryCode", "year", "month", "day")
);

CREATE TABLE "MiscellaneousPolicies" (
  "CountryCode" varchar,
  "year" varchar,
  "month" varchar,
  "day" varchar,
  "M1_Wildcard" varchar,
  PRIMARY KEY ("CountryCode", "year", "month", "day")
);

CREATE TABLE "Country" (
  "Country_Name" varchar ,
  "Two_Letter_Country_Code" varchar,
  "Three_Letter_Country_Code" varchar PRIMARY KEY,
  "Country_Number" int
);

CREATE TABLE "Continent" (
  "Continent_Code" varchar PRIMARY KEY,
  "Continent_Name" varchar
);

CREATE TABLE "in_Continent" (
  "Continent_Code" varchar,
  "Country_Code" varchar,
  PRIMARY KEY ("Continent_Code", "Country_Code")
);

ALTER TABLE "setting" ADD FOREIGN KEY ("CountryCode") REFERENCES "Country" ("Three_Letter_Country_Code");

ALTER TABLE "EconomicPolicies" ADD FOREIGN KEY ("CountryCode", "year", "month", "day") REFERENCES "setting" ("CountryCode", "year", "month", "day");

ALTER TABLE "Indicies" ADD FOREIGN KEY ("CountryCode", "year", "month", "day") REFERENCES "setting" ("CountryCode", "year", "month", "day");

ALTER TABLE "ContainmentPolicies" ADD FOREIGN KEY ("CountryCode", "year", "month", "day") REFERENCES "setting" ("CountryCode", "year", "month", "day");

ALTER TABLE "HealthSystemPolicies" ADD FOREIGN KEY ("CountryCode", "year", "month", "day") REFERENCES "setting" ("CountryCode", "year", "month", "day");

ALTER TABLE "VaccinationPolicies" ADD FOREIGN KEY ("CountryCode", "year", "month", "day") REFERENCES "setting" ("CountryCode", "year", "month", "day");

ALTER TABLE "MiscellaneousPolicies" ADD FOREIGN KEY ("CountryCode", "year", "month", "day") REFERENCES "setting" ("CountryCode", "year", "month", "day");

ALTER TABLE "in_Continent" ADD FOREIGN KEY ("Continent_Code") REFERENCES "Continent" ("Continent_Code");

ALTER TABLE "in_Continent" ADD FOREIGN KEY ("Country_Code") REFERENCES "Country" ("Three_Letter_Country_Code");
