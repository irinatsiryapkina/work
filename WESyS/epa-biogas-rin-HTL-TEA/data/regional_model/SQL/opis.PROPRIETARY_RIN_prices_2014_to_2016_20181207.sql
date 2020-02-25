RESET ROLE;

GRANT SELECT ON "dhetting"."PROPRIETARY_RIN_prices_2014_to_2016" TO "wte-admin";

SET ROLE "wte-admin";

-- raw copy
DROP   TABLE IF EXISTS "opis"."_PROPRIETARY_RIN_prices_2014_to_2016_20181207";
CREATE TABLE           "opis"."_PROPRIETARY_RIN_prices_2014_to_2016_20181207" AS
SELECT * FROM "dhetting"."PROPRIETARY_RIN_prices_2014_to_2016";

COMMENT ON TABLE "opis"."_PROPRIETARY_RIN_prices_2014_to_2016_20181207" IS '';


-- clean copy
DROP   TABLE IF EXISTS "opis"."PROPRIETARY_RIN_prices_2014_to_2016_20181207";
CREATE TABLE           "opis"."PROPRIETARY_RIN_prices_2014_to_2016_20181207" (
      "product_name"       TEXT    NOT NULL
    , "period"             TEXT    NOT NULL
    , "vintage"            INT     NOT NULL
    , "publication_date"   DATE    NOT NULL
    , "price_type"         TEXT    NOT NULL
    , "price"              NUMERIC NOT NULL
    , "yearID"             INT     NOT NULL
    , "monthID"            INT     NOT NULL
    , "dayID"              INT     NOT NULL
    , CONSTRAINT "PROPRIETARY_RIN_prices_2014_to_2016_20181207_pkey" PRIMARY KEY ("product_name", "period", "vintage", "publication_date", "price_type")
);

COMMENT ON TABLE "opis"."PROPRIETARY_RIN_prices_2014_to_2016_20181207" IS '';

INSERT INTO "opis"."PROPRIETARY_RIN_prices_2014_to_2016_20181207" ("product_name"
                                                                 , "period"
                                                                 , "vintage"
                                                                 , "publication_date"
                                                                 , "price_type"
                                                                 , "price"
                                                                 , "yearID"
                                                                 , "monthID"
                                                                 , "dayID")
SELECT "product_name"::TEXT
     , "period"::TEXT
     , "vintage"::INT
     , "publication_date"::DATE
     , "price_type"::TEXT
     , "price"::NUMERIC
     , "yearID"::INT
     , "monthID"::INT
     , "dayID"::INT
FROM "opis"."_PROPRIETARY_RIN_prices_2014_to_2016_20181207"
ORDER BY "product_name"
       , "period"
       , "vintage"
       , "publication_date"
       , "price_type"
;

-- SELECT * FROM "opis"."PROPRIETARY_RIN_prices_2014_to_2016_20181207";

RESET ROLE;
