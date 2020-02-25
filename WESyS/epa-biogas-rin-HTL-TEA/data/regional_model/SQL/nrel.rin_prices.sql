CREATE OR REPLACE VIEW "nrel"."rin_prices" AS (
  SELECT EXTRACT("YEAR" FROM "date") AS "year"
       , AVG("mean")                 AS "price"
  FROM "nrel"."inman_d3_rin_projected_d3_rin_projected_20171023"
  GROUP BY 1
)
;
