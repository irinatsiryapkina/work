CREATE OR REPLACE VIEW "ROTUS LF"."Initial_Potential_Distribution" AS (
 WITH "LF_Dist_Stella" AS (
         SELECT SUM("number_landfills") AS number_landfills,
                CASE
                    WHEN "landfill_current_status" = 'closed'::text THEN 'Inactive'::text
                    WHEN "landfill_current_status" = 'open'::text 	THEN 'Active'::text
                    ELSE NULL::text
                END AS "LFStatus",
                CASE
                    WHEN "landfill_design_size_category" = 'large'::text THEN 'LFLarge'::text
                    WHEN "landfill_design_size_category" = 'small'::text THEN 'LFSmall'::text
                    ELSE NULL::text
                END AS "LFSize"
           FROM "rotus"."landfill_distribution"
          WHERE "project_current_status" = 'potential_dist'::text
          GROUP BY (
                CASE
                    WHEN "landfill_design_size_category" = 'large'::text THEN 'LFLarge'::text
                    WHEN "landfill_design_size_category" = 'small'::text THEN 'LFSmall'::text
                    ELSE NULL::text
                END), (
                CASE
                    WHEN "landfill_current_status" = 'closed'::text THEN 'Inactive'::text
                    WHEN "landfill_current_status" = 'open'::text THEN 'Active'::text
                    ELSE NULL::text
                END)
        )
  SELECT 'ROTUS LF.Initial_Potential_Distribution[Active, LFLarge]'   AS "variable", COALESCE((SELECT "number_landfills" AS "val" FROM "LF_Dist_Stella" WHERE "LFSize" = 'LFLarge' AND "LFStatus" = 'Active'),   0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL
  SELECT 'ROTUS LF.Initial_Potential_Distribution[Active, LFSmall]'   AS "variable", COALESCE((SELECT "number_landfills" AS "val" FROM "LF_Dist_Stella" WHERE "LFSize" = 'LFSmall' AND "LFStatus" = 'Active'),   0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL
  SELECT 'ROTUS LF.Initial_Potential_Distribution[Inactive, LFLarge]' AS "variable", COALESCE((SELECT "number_landfills" AS "val" FROM "LF_Dist_Stella" WHERE "LFSize" = 'LFLarge' AND "LFStatus" = 'Inactive'), 0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040" UNION ALL
  SELECT 'ROTUS LF.Initial_Potential_Distribution[Inactive, LFSmall]' AS "variable", COALESCE((SELECT "number_landfills" AS "val" FROM "LF_Dist_Stella" WHERE "LFSize" = 'LFSmall' AND "LFStatus" = 'Inactive'), 0) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040"
);
