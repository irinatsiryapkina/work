CREATE OR REPLACE VIEW "opis"."rin_prices" AS (
  WITH x AS (
    SELECT "vintage"
         , "price"
    FROM "opis"."PROPRIETARY_RIN_prices_2010_to_2014_20181207"
    WHERE "product_name" = 'Advanced Biofuel RIN'
      AND "price_type"   = 'average'
    UNION ALL
    SELECT "vintage"
         , "price"
    FROM "opis"."PROPRIETARY_RIN_prices_2014_to_2016_20181207"
    WHERE "product_name" = 'Cellulosic RIN'
      AND "price_type"   = 'Average'
  )
  SELECT "vintage"    AS "year"
       , AVG("price") AS "price"
  FROM x
  GROUP BY "vintage"
)
;
