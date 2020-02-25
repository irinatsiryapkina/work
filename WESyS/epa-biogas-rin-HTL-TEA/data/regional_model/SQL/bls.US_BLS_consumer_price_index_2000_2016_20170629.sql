RESET ROLE;

GRANT SELECT ON TABLE "dhetting"."US_BLS_consumer_price_index_2000_2016" TO "wte-admin";

SET ROLE "wte-admin";

-- raw copy
DROP   TABLE IF EXISTS "bls"."_US_BLS_consumer_price_index_2000_2016_20170629";
CREATE TABLE           "bls"."_US_BLS_consumer_price_index_2000_2016_20170629" AS
SELECT * FROM "dhetting"."US_BLS_consumer_price_index_2000_2016";
COMMENT ON TABLE "bls"."_US_BLS_consumer_price_index_2000_2016_20170629" IS 'Consumer Price Index, All Urban Consumers, All Items. June 29, 2017. US Bureau of Labor Statistics, http://www.bls.gov/cpi/data.htm.';


-- clean copy
DROP   TABLE IF EXISTS "bls"."US_BLS_consumer_price_index_2000_2016_20170629";
CREATE TABLE           "bls"."US_BLS_consumer_price_index_2000_2016_20170629" (
       "gid" SERIAL PRIMARY KEY
     , "year"   INT
     , "jan"    NUMERIC
     , "feb"    NUMERIC
     , "mar"    NUMERIC
     , "apr"    NUMERIC
     , "may"    NUMERIC
     , "jun"    NUMERIC
     , "jul"    NUMERIC
     , "aug"    NUMERIC
     , "sep"    NUMERIC
     , "oct"    NUMERIC
     , "nov"    NUMERIC
     , "dec"    NUMERIC
     , "annual" NUMERIC
     , "half1"  NUMERIC
     , "half2"  NUMERIC
  , CONSTRAINT "unq_US_BLS_consumer_price_index_2000_2016_20170629" UNIQUE ("year")
);
COMMENT ON TABLE "bls"."US_BLS_consumer_price_index_2000_2016_20170629" IS 'Consumer Price Index, All Urban Consumers, All Items. June 29, 2017. US Bureau of Labor Statistics, http://www.bls.gov/cpi/data.htm.';

INSERT INTO "bls"."US_BLS_consumer_price_index_2000_2016_20170629" (
     "year"
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
)
SELECT DISTINCT
       NULLIF(REPLACE("Year", '.0', ''), '')::INT
     , NULLIF(regexp_replace("Jan", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Feb", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Mar", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Apr", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("May", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Jun", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Jul", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Aug", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Sep", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Oct", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Nov", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Dec", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Annual", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("HALF1", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("HALF2", '^\s+|\s+$|NA|\?', '', 'g'), '')::NUMERIC
 FROM "bls"."_US_BLS_consumer_price_index_2000_2016_20170629"
ORDER BY 1
;

CREATE INDEX "idx_US_BLS_consumer_price_index_2000_2016_20170629_year_btree" ON "bls"."US_BLS_consumer_price_index_2000_2016_20170629" USING BTREE ("year");
ALTER TABLE "bls"."US_BLS_consumer_price_index_2000_2016_20170629" CLUSTER ON "idx_US_BLS_consumer_price_index_2000_2016_20170629_year_btree";

--SELECT * FROM VACUUM "bls"."US_BLS_consumer_price_index_2000_2016_20170629";

RESET ROLE;
