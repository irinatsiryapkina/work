RESET ROLE;

GRANT SELECT ON "dhetting"."ice_natgas-2017" TO "wte-admin";

SET ROLE "wte-admin";

-- raw copy
DROP   TABLE IF EXISTS "eia"."_ice_natgas_2017_20170510";
CREATE TABLE           "eia"."_ice_natgas_2017_20170510" (
       "Price hub"                TEXT
     , "Trade date"               TEXT
     , "Delivery start date"      TEXT
     , "Delivery end date"        TEXT
     , "High price $/MMBtu"       TEXT
     , "Low price $/MMBtu"        TEXT
     , "Wtd avg price $/MMBtu"    TEXT
     , "Change"                   TEXT
     , "Daily volume MMBtu"       TEXT
     , "Number of trades"         TEXT
     , "Number of counterparties" TEXT
);
COMMENT ON TABLE "eia"."_ice_natgas_2017_20170510" IS 'EIA wholesale electricity price. May 10, 2017. https://www.eia.gov/electricity/wholesale/#history.';

INSERT INTO "eia"."_ice_natgas_2017_20170510" SELECT * FROM "dhetting"."ice_natgas-2017";


-- clean copy
DROP   TABLE IF EXISTS "eia"."ice_natgas_2017_20170510";
CREATE TABLE           "eia"."ice_natgas_2017_20170510" (
       "gid"                      SERIAL PRIMARY KEY
     , "price_hub"                TEXT
     , "trade_date"               DATE
     , "delivery_start_date"      DATE
     , "delivery_end_date"        DATE
     , "high_price_dol_mmbtu"     NUMERIC
     , "low_price_dol_mmbtu"      NUMERIC
     , "wtd_avg_price_dol_mmbtu"  NUMERIC
     , "change"                   NUMERIC
     , "daily_volume_mmbtu"       NUMERIC
     , "number_of_trades"         NUMERIC
     , "number_of_counterparties" NUMERIC
     , CONSTRAINT "unq_ice_natgas_2017_20170510" UNIQUE ("price_hub", "trade_date", "delivery_start_date", "delivery_end_date", "high_price_dol_mmbtu", "low_price_dol_mmbtu", "wtd_avg_price_dol_mmbtu", "change", "daily_volume_mmbtu", "number_of_trades", "number_of_counterparties")
);
COMMENT ON TABLE "eia"."ice_natgas_2017_20170510" IS 'EIA wholesale electricity price. May 10, 2017. https://www.eia.gov/electricity/wholesale/#history.';

INSERT INTO "eia"."ice_natgas_2017_20170510" ("price_hub", "trade_date", "delivery_start_date", "delivery_end_date", "high_price_dol_mmbtu", "low_price_dol_mmbtu", "wtd_avg_price_dol_mmbtu", "change", "daily_volume_mmbtu", "number_of_trades", "number_of_counterparties")
WITH "raw" AS (SELECT DISTINCT
                     SUBSTRING("Price hub", '\S(?:.*\S)*')                     AS "Price hub"
                   , NULLIF(REPLACE("Trade date", '.0', ''), '')               AS "Trade date"
                   , NULLIF(REPLACE("Delivery start date", '.0', ''), '')      AS "Delivery start date"
                   , NULLIF(REPLACE("Delivery end date", '.0', ''), '')        AS "Delivery end date"
                   , NULLIF("High price $/MMBtu", '')                          AS "High price $/MMBtu"
                   , NULLIF("Low price $/MMBtu", '')                           AS "Low price $/MMBtu"
                   , NULLIF("Wtd avg price $/MMBtu", '')                       AS "Wtd avg price $/MMBtu"
                   , NULLIF("Change", '')                                      AS "Change"
                   , NULLIF(REPLACE("Daily volume MMBtu", '.0', ''), '')       AS "Daily volume MMBtu"
                   , NULLIF(REPLACE("Number of trades", '.0', ''), '')         AS "Number of trades"
                   , NULLIF(REPLACE("Number of counterparties", '.0', ''), '') AS "Number of counterparties"
                FROM "eia"."_ice_natgas_2017_20170510"
)
SELECT "Price hub"
     , CASE WHEN "Trade date" IN ('?', 'unknown', 'yes', 'true', 'no', 'false', 'not yet') THEN NULL
            ELSE "Trade date"::DATE
       END AS "Trade date"
     , CASE WHEN "Delivery start date" IN ('?', 'unknown', 'yes', 'true', 'no', 'false', 'not yet') THEN NULL
            ELSE "Delivery start date"::DATE
       END AS "Delivery start date"
     , CASE WHEN "Delivery end date" IN ('?', 'unknown', 'yes', 'true', 'no', 'false', 'not yet') THEN NULL
            ELSE "Delivery end date"::DATE
       END AS "Delivery end date"
     , ROUND("High price $/MMBtu"::NUMERIC, 2)
     , ROUND("Low price $/MMBtu"::NUMERIC, 2)
     , ROUND("Wtd avg price $/MMBtu"::NUMERIC, 2)
     , ROUND("Change"::NUMERIC, 2)
     , "Daily volume MMBtu"::INT
     , "Number of trades"::INT
     , "Number of counterparties"::INT
FROM "raw"
ORDER BY 1 ASC, 2 ASC, 3 ASC, 4 ASC, 9 DESC;

--SELECT * FROM "eia"."ice_natgas_2017_20170510";

RESET ROLE;
