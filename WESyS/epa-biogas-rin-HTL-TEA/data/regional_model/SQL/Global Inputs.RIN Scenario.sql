CREATE OR REPLACE VIEW "Global Inputs"."RIN Scenario" AS (
  SELECT 'Global Inputs.RIN Scenario' AS "variable", (SELECT "price"               FROM "opis"."rin_prices" WHERE "year" = 2015) AS "val_2015"
                                                   , (SELECT "price"               FROM "opis"."rin_prices" WHERE "year" = 2016) AS "val_2016"
                                                   , (SELECT "price"               FROM "nrel"."rin_prices" WHERE "year" = 2017) AS "val_2017"
                                                   , (SELECT "price"               FROM "nrel"."rin_prices" WHERE "year" = 2017) AS "val_2018"
                                                   , (SELECT "price"               FROM "nrel"."rin_prices" WHERE "year" = 2017) AS "val_2019"
                                                   , (SELECT "price"               FROM "nrel"."rin_prices" WHERE "year" = 2017) AS "val_2020"
                                                   , (SELECT "price"               FROM "nrel"."rin_prices" WHERE "year" = 2017) AS "val_2021"
                                                   , (SELECT "price"               FROM "nrel"."rin_prices" WHERE "year" = 2017) AS "val_2022"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2023"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2024"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2025"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2026"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2027"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2028"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2029"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2030"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2031"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2032"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2033"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2034"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2035"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2036"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2037"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2038"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2039"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2040"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2041"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2042"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2043"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2044"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2045"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2046"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2047"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2048"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2049"
                                                   , (SELECT 0::NUMERIC AS "price" FROM "nrel"."rin_prices"                    ) AS "val_2050"
)
;