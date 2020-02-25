CREATE OR REPLACE VIEW "bls"."price_index" AS (
  SELECT "year"
       , "jan"
       , "feb"
       , "mar"
       , "apr"
       , "may"
       , "jun"
       , "jul"
       , "aug"
       , "sep"
       , "oct"
       , "nov"
       , "dec"
       , "annual"
       , "half1"
       , "half2"
  FROM "bls"."US_BLS_consumer_price_index_2000_2016_20170629"
  ORDER BY "year"
);

COMMENT ON VIEW "bls"."price_index" IS 'Consumer Price Index, All Urban Consumers, All Items. June 29, 2017. US Bureau of Labor Statistics, http://www.bls.gov/cpi/data.htm.'
;
