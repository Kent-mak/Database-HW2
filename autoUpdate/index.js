const fetch = require('node-fetch');
const { Client } = require('pg');
const { pipeline } = require('stream');
const {from } = require('pg-copy-streams');
const fs = require('fs');
const d3 = require('d3');

exports.handler = async (event) => {
    try{
        await updatedb();
    }
    catch(error){

    }

    const response = {
        statusCode: 200,
        body: "Ok",
    };

    return response;
};

const updatedb = async() =>{

    try
    {
        const client = new Client({
            user: process.env.DB_USER,
            host: process.env.DB_HOST,
            database: process.env.DB_DATABASE,
            password: process.env.DB_PASSWORD,
            port: 5432,
        });
        await client.connect();

        const filepath = getData();
        const sourceStream = fs.createReadStream(filepath);
        const ingestStream = client.query(from('COPY oxcgrt FROM STDIN'));
        await pipeline(sourceStream, ingestStream);


        await client.query(
            `UPDATE "Country"
            SET
                "Country_Name" = sub."Country_Name" ,
                "Two_Letter_Country_Code"= sub."Two_Letter_Country_Code" ,
                "Three_Letter_Country_Code" = sub."Three_Letter_Country_Code" ,
                "Country_Number" = sub."Country_Number"
            FROM
                (
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
                        )
                ) AS sub;`
        )
        await client.query(
            `UPDATE "Continent"
            SET 
                "Continent_Code" = sub."Continent_Code",
                "Continent_Name" = sub."Continent_Name"
            FROM
                (
                    SELECT
                        "Continent_Code",
                        "Continent_Name" 
                    FROM
                        cont_count
                    GROUP BY 
                        (
                            "Continent_Code",
                            "Continent_Name"
                        )
                ) AS sub;`
        )

        await client.query(
            `UPDATE "in_Continent"
            SET
                "Continent_Code" = sub."Continent_Code" ,
                "Country_Code" = sub."Country_Code"
            FROM
                (
                    SELECT
                        "Continent_Code" ,
                        "Three_Letter_Country_Code" AS "Country_Code"
                    FROM
                        cont_count
                ) AS sub;`
        )   
            
        await client.query(
            `UPDATE "setting"
            SET
                "CountryCode" = sub."CountryCode",
                "year" = sub."year",
                "month" = sub."month",
                "day" = sub."day",
                "ConfirmedCases" = sub."ConfirmedCases",
                "ConfirmedDeaths" = sub."ConfirmedDeaths" ,
                "MajorityVaccinated" = sub."MajorityVaccinated",
                "PopulationVaccinated" = sub."PopulationVaccinated"
            FROM
                (
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
                        OxCGRT
                )AS sub;`
        )

        await client.query(
            `UPDATE "Indicies"
            SET
                "CountryCode" = sub."CountryCode",
                "year" = sub."year",
                "month" = sub."month",
                "day" = sub."day",
                "StringencyIndex_Average" = sub."StringencyIndex_Average" ,
                "StringencyIndex_Average_ForDisplay" = sub."StringencyIndex_Average_ForDisplay",
                "GovernmentResponseIndex_Average" = sub."GovernmentResponseIndex_Average",
                "GovernmentResponseIndex_Average_ForDisplay" = sub."GovernmentResponseIndex_Average_ForDisplay" ,
                "ContainmentHealthIndex_Average" = sub."ContainmentHealthIndex_Average",
                "ContainmentHealthIndex_Average_ForDisplay" = sub."ContainmentHealthIndex_Average_ForDisplay" ,
                "EconomicSupportIndex" = sub."EconomicSupportIndex" ,
                "EconomicSupportIndex_ForDisplay" =  sub."EconomicSupportIndex_ForDisplay"
            FROM
                (
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
                        OxCGRT
                ) AS sub;`
        )
            
        await client.query(
            `UPDATE "ContainmentPolicies"
            SET
                "CountryCode" = sub."CountryCode",
                "year" = sub."year",
                "month" = sub."month",
                "day" = sub."day",
                "C1M_School closing" = sub."C1M_School closing",
                "C1M_Flag" = sub."C1M_Flag" ,
                "C2M_Workplace closing" = sub."C2M_Workplace closing",
                "C2M_Flag" = sub."C2M_Flag",
                "C3M_Cancel public events" = sub."C3M_Cancel public events",
                "C3M_Flag" = sub."C3M_Flag",
                "C4M_Restrictions on gatherings" = sub."C4M_Restrictions on gatherings",
                "C4M_Flag" = sub."C4M_Flag" ,
                "C5M_Close public transport" = sub."C5M_Close public transport",
                "C5M_Flag" = sub."C5M_Flag",
                "C6M_Stay at home requirements" = sub."C6M_Stay at home requirements",
                "C6M_Flag" = sub."C6M_Flag",
                "C7M_Restrictions on internal movement" = sub."C7M_Restrictions on internal movement",
                "C7M_Flag" = sub."C7M_Flag" ,
                "C8EV_International travel controls" = sub."C8EV_International travel controls"
            FROM
                (
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
                        OxCGRT
                ) AS sub;`
        )
            
        await client.query(
            `UPDATE "HealthSystemPolicies"
            SET
                "CountryCode" = sub."CountryCode",
                "year" = sub."year",
                "month" = sub."month",
                "day" = sub."day",
                "H1_Public information campaigns" = sub."H1_Public information campaigns" ,
                "H1_Flag" = sub."H1_Flag" ,
                "H2_Testing policy" = sub."H2_Testing policy" ,
                "H3_Contact tracing" = sub."H3_Contact tracing" ,
                "H4_Emergency investment in healthcare" = sub."H4_Emergency investment in healthcare" ,
                "H5_Investment in vaccines" = sub."H5_Investment in vaccines" ,
                "H6M_Facial Coverings" = sub."H6M_Facial Coverings" ,
                "H6M_Flag" = sub."H6M_Flag" ,
                "H7_Vaccination policy" = sub."H7_Vaccination policy" ,
                "H7_Flag" = sub."H7_Flag" ,
                "H8M_Protection of elderly people" = sub."H8M_Protection of elderly people" ,
                "H8M_Flag" = sub."H8M_Flag"
            FROM
                (
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
                        OxCGRT
                )AS sub;`
        )
            
        await client.query(
            `UPDATE "EconomicPolicies"
            SET
                "CountryCode" = sub."CountryCode",
                "year" = sub."year",
                "month" = sub."month",
                "day" = sub."day",
                "E1_Income support" = sub."E1_Income support" ,
                "E1_Flag" = sub."E1_Flag" ,
                "E2_Debt/contract relief" = sub."E2_Debt/contract relief" ,
                "E3_Fiscal measures" = sub."E3_Fiscal measures" ,
                "E4_International support" = sub."E4_International support"
            FROM
                (
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
                        OxCGRT
                ) AS sub;`
            
        )  
            
            
        await client.query(
            `UPDATE "VaccinationPolicies"
            SET
                "CountryCode" = sub."CountryCode",
                "year" = sub."year",
                "month" = sub."month",
                "day" = sub."day",
                "V1_Vaccine Prioritisation (summary)" = sub."V1_Vaccine Prioritisation (summary)" ,
                "V2A_Vaccine Availability (summary)" = sub."V2A_Vaccine Availability (summary)" ,
                "V2B_Vaccine age eligibility/availability(population summary)" = sub."V2B_Vaccine age eligibility/availability(population summary)" ,
                "V2C_Vaccine age eligibility/availability(risk summary)" = sub."V2C_Vaccine age eligibility/availability(risk summary)" ,
                "V2D_Medically/ clinically vulnerable (Non-elderly)" = sub."V2D_Medically/ clinically vulnerable (Non-elderly)" ,
                "V2E_Education" = sub."V2E_Education" ,
                "V2F_Frontline workers (non healthcare)" = sub."V2F_Frontline workers (non healthcare)" ,
                "V2G_Frontline workers (healthcare)" = sub."V2G_Frontline workers (healthcare)" ,
                "V3_Vaccine Financial Support (summary)" = sub."V3_Vaccine Financial Support (summary)" ,
                "V4_Mandatory Vaccination (summary)" = sub."V4_Mandatory Vaccination (summary)"

            FROM
                (
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
                        OxCGRT
                ) AS sub ;`
        )
        
        await client.query(
            `UPDATE "MiscellaneousPolicies"
            SET
                "CountryCode" = sub."CountryCode",
                "year" = sub."year",
                "month" = sub."month",
                "day" = sub."day",
                "M1_Wildcard" = sub."M1_Wildcard"
            FROM
                (
                    SELECT
                        "CountryCode",
                        SUBSTRING(Date, 1, 4) AS "year",
                        SUBSTRING(Date, 5, 2) AS "month",
                        SUBSTRING(Date, 7, 2) AS "day",
                        "M1_Wildcard"
                    FROM
                        OxCGRT
                ) AS sub;`
        )

    }
    catch(error)
    {
        console.log(error)
    }
    finally
    {
        await client.end();
    }
}


const getData = async() => {

    const url = "https://github.com/OxCGRT/covid-policy-tracker/blob/master/data/OxCGRT_nat_latest.csv";
    
    const params = {
        method: "GET",
        headers: {'content-type': 'text/csv;charset=UTF-8'},
    };

    const response =  await fetch(url, params);

    let filepath = '/tmp/data.csv';
    if (response.status === 200) {

        let data = await response.text();

        let parsed_data = d3.csvParse(data);
        parsed_data.columns.forEach((value, index) => {
            if(value === "V2B_Vaccine age eligibility/availability age floor (general population summary)")
            {
                parsed_data.columns[index] = "V2B_Vaccine age eligibility/availability(population summary)";
            }
            else if(value === "V2C_Vaccine age eligibility/availability age floor (at risk summary)")
            {
                parsed_data.columns[index] = "V2C_Vaccine age eligibility/availability(risk summary)"
            }
            else if(value === "V2F_Frontline workers  (non healthcare)")
            {
                parsed_data.columns[index] = "V2F_Frontline workers (non healthcare)"
            }
            else if(value === "V2G_Frontline workers  (healthcare)")
            {
                parsed_data.columns[index] = "V2G_Frontline workers (healthcare)"
            }
        });
        
        let modified_data = d3.csvFormat(parsed_data);

        fs.writeFile(filepath, modified_data, (err) => {
            if (err)
            {
                console.log(err); 
            }     
            else { 
                console.log("File written successfully\n"); 
            } 
        })
        
    } else {
        console.log(`Error code ${res.status}`);
    }

    return filepath
}

