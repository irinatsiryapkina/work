RESET ROLE;

GRANT SELECT ON TABLE "dhetting"."HTL_TEA_biofuel" TO "wte-admin";

SET ROLE "wte-admin";

-- raw copy
DROP   TABLE IF EXISTS "nrel"."_HTL_TEA_biofuel_20170619";
CREATE TABLE "nrel"."_HTL_TEA_biofuel_20170619" (
      "size"                           TEXT
    , "FCI ($)"                        TEXT
    , "OPEX ($/yr)"                    TEXT
    , "Coproduct sales revenue ($/yr)" TEXT
    , "Yield (mmBTU/dry ton)"          TEXT
    , "Throughput (MGD)"               TEXT
    , "Biofuel (MMBTU/yr)"             TEXT
);
COMMENT ON TABLE "nrel"."_HTL_TEA_biofuel_20170619" IS 'spreadsheet from Ling Tao at NREL. May 19, 2017.';

INSERT INTO "nrel"."_HTL_TEA_biofuel_20170619" SELECT * FROM "dhetting"."HTL_TEA_biofuel";


-- clean copy
DROP   TABLE IF EXISTS "nrel"."HTL_TEA_biofuel_20170619";
CREATE TABLE           "nrel"."HTL_TEA_biofuel_20170619" (
       "gid"                            SERIAL PRIMARY KEY
     , "size"                           TEXT
     , "fci_dol"                        NUMERIC
     , "opex_dol_yr"                    NUMERIC
     , "coproduct_sales_revenue_dol_yr" NUMERIC
     , "yield_mmbtu_dry_ton"            NUMERIC
     , "throughput_mgd"                 NUMERIC
     , "biofuel_mmbtu_yr"               NUMERIC
);
COMMENT ON TABLE "nrel"."HTL_TEA_biofuel_20170619" IS 'spreadsheet from Ling Tao at NREL. May 19, 2017.';

INSERT INTO "nrel"."HTL_TEA_biofuel_20170619" (
     "size"
   , "fci_dol"
   , "opex_dol_yr"
   , "coproduct_sales_revenue_dol_yr"
   , "yield_mmbtu_dry_ton"
   , "throughput_mgd"
   , "biofuel_mmbtu_yr"
)
SELECT DISTINCT
       NULLIF(regexp_replace("size", '^\s+|\s+$|NA|-|\?', '', 'g'), '')
     , NULLIF(regexp_replace("FCI ($)", '^\s+|\s+$|NA|-|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("OPEX ($/yr)", '^\s+|\s+$|NA|-|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Coproduct sales revenue ($/yr)", '^\s+|\s+$|NA|-|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Yield (mmBTU/dry ton)", '^\s+|\s+$|NA|-|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Throughput (MGD)", '^\s+|\s+$|NA|-|\?', '', 'g'), '')::NUMERIC
     , NULLIF(regexp_replace("Biofuel (MMBTU/yr)", '^\s+|\s+$|NA|-|\?', '', 'g'), '')::NUMERIC

FROM "nrel"."_HTL_TEA_biofuel_20170619"
ORDER BY 1, 2
;

--SELECT * FROM "nrel"."HTL_TEA_biofuel_20170619";

RESET ROLE;

