CREATE OR REPLACE VIEW "Global Inputs"."per_tonne_tipping_fee" AS (
WITH "us_ton_per_metric_ton" AS (SELECT "factor"
                                 FROM "admin"."conversions"
                                 WHERE "from_unit" = 'metric ton'
                                   AND "to_unit"   = 'US ton'
)
SELECT 'Global Inputs.per tonne tipping fee' AS "variable", ROUND(AVG(a."dol_ton" * b."factor"), 2) AS "val_2015", NULL::NUMERIC AS "val_2016", NULL::NUMERIC AS "val_2017", NULL::NUMERIC AS "val_2018", NULL::NUMERIC AS "val_2019", NULL::NUMERIC AS "val_2020", NULL::NUMERIC AS "val_2021", NULL::NUMERIC AS "val_2022", NULL::NUMERIC AS "val_2023", NULL::NUMERIC AS "val_2024", NULL::NUMERIC AS "val_2025", NULL::NUMERIC AS "val_2026", NULL::NUMERIC AS "val_2027", NULL::NUMERIC AS "val_2028", NULL::NUMERIC AS "val_2029", NULL::NUMERIC AS "val_2030", NULL::NUMERIC AS "val_2031", NULL::NUMERIC AS "val_2032", NULL::NUMERIC AS "val_2033", NULL::NUMERIC AS "val_2034", NULL::NUMERIC AS "val_2035", NULL::NUMERIC AS "val_2036", NULL::NUMERIC AS "val_2037", NULL::NUMERIC AS "val_2038", NULL::NUMERIC AS "val_2039", NULL::NUMERIC AS "val_2040"
FROM "wbj"."waste_processing_and_disposal_sites" a
   , "us_ton_per_metric_ton" b
WHERE "state" = 'CA'
  AND "type"  = 'LF'
  AND "group" = 'LF'
);
