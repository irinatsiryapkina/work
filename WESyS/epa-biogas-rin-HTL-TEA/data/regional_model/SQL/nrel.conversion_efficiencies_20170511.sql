RESET ROLE;

GRANT SELECT ON TABLE "dhetting"."conversion_efficiencies" TO "wte-admin";

SET ROLE "wte-admin";

DROP   TABLE IF EXISTS "nrel"."_conversion_efficiencies_20170511";
CREATE TABLE           "nrel"."_conversion_efficiencies_20170511" AS
SELECT * FROM "dhetting"."conversion_efficiencies"
;
COMMENT ON TABLE "nrel"."_conversion_efficiencies_20170511" IS 'spreadsheet from Ling Tao. May 11, 2017.';

DROP   TABLE IF EXISTS "nrel"."conversion_efficiencies_20170511";
CREATE TABLE           "nrel"."conversion_efficiencies_20170511" (
      "gid"                       SERIAL PRIMARY KEY
    , "technology"                TEXT
    , "conversion_efficiency_min" NUMERIC
    , "conversion_efficiency_max" NUMERIC
    , "conversion_efficiency"     NUMERIC
    , "energy_yield_min"          NUMERIC
    , "energy_yield_max"          NUMERIC
    , "energy_yield"              NUMERIC
    , CONSTRAINT "unq_conversion_efficiencies_20170511" UNIQUE ("technology")
);
COMMENT ON TABLE "nrel"."conversion_efficiencies_20170511" IS 'spreadsheet from Ling Tao. May 11, 2017.';


INSERT INTO "nrel"."conversion_efficiencies_20170511" ("technology", "conversion_efficiency_min", "conversion_efficiency_max", "conversion_efficiency", "energy_yield_min", "energy_yield_max", "energy_yield")
SELECT DISTINCT
      "technology"
    , "min conv eff"::NUMERIC
    , "max con eff"::NUMERIC
    , "conversion efficiency"::NUMERIC
    , "min energy yld"::NUMERIC
    , "max energy yld"::NUMERIC
    , "energy yield"::NUMERIC
FROM "nrel"."_conversion_efficiencies_20170511"
ORDER BY 1
;

--SELECT * FROM "nrel"."conversion_efficiencies_20170511";

RESET ROLE;
