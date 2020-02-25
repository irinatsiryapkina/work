CREATE OR REPLACE VIEW "ROTUS WWTP"."daily_facility_influx" AS (
    WITH "wwtp_resource" AS (SELECT "WWTPSize"
                                  , "avg_flow_mgd_avg"
                             FROM "rotus"."wwtp_resource"
    )
    SELECT 'ROTUS WWTP.daily_facility_influx[WWTP0to1]'    AS "variable", COALESCE((SELECT "avg_flow_mgd_avg" AS "val" FROM "wwtp_resource" WHERE "WWTPSize" = 'WWTP0to1'),    0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL
    SELECT 'ROTUS WWTP.daily_facility_influx[WWTP100Up]'   AS "variable", COALESCE((SELECT "avg_flow_mgd_avg" AS "val" FROM "wwtp_resource" WHERE "WWTPSize" = 'WWTP100Up'),   0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL
    SELECT 'ROTUS WWTP.daily_facility_influx[WWTP10to100]' AS "variable", COALESCE((SELECT "avg_flow_mgd_avg" AS "val" FROM "wwtp_resource" WHERE "WWTPSize" = 'WWTP10to100'), 0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL
    SELECT 'ROTUS WWTP.daily_facility_influx[WWTP1to10]'   AS "variable", COALESCE((SELECT "avg_flow_mgd_avg" AS "val" FROM "wwtp_resource" WHERE "WWTPSize" = 'WWTP1to10'),   0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040"
);
