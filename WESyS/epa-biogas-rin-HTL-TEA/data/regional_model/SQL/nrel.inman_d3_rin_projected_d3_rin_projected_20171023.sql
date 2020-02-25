RESET ROLE;

GRANT SELECT ON TABLE "dhetting"."inman_d3_rin_projected_d3_rin_projected" TO "wte-admin";

SET ROLE "wte-admin";

-- raw copy
DROP   TABLE IF EXISTS "nrel"."_inman_d3_rin_projected_d3_rin_projected_20171023";
CREATE TABLE           "nrel"."_inman_d3_rin_projected_d3_rin_projected_20171023" AS
SELECT * FROM "dhetting"."inman_d3_rin_projected_d3_rin_projected"
;
COMMENT ON TABLE "nrel"."_inman_d3_rin_projected_d3_rin_projected_20171023" IS 'Projects D3 RIN data from 2016 to 2017. Should be used to supplement historical RIN data from OPIS. 20171023.;';


-- clean copy
DROP   TABLE IF EXISTS "nrel"."inman_d3_rin_projected_d3_rin_projected_20171023";
CREATE TABLE           "nrel"."inman_d3_rin_projected_d3_rin_projected_20171023" (
      "gid"          SERIAL PRIMARY KEY
    , "date"         DATE
    , "mean"         NUMERIC
    , "low_80_pct"   NUMERIC
    , "low_95_pct"   NUMERIC
    , "upper_80_pct" NUMERIC
    , "upper_95_pct" NUMERIC
    , CONSTRAINT "unq_inman_d3_rin_projected_d3_rin_projected_20171023" UNIQUE ("date")
);
COMMENT ON TABLE "nrel"."inman_d3_rin_projected_d3_rin_projected_20171023" IS 'Projects D3 RIN data from 2016 to 2017. Should be used to supplement historical RIN data from OPIS. 20171023.';


INSERT INTO "nrel"."inman_d3_rin_projected_d3_rin_projected_20171023" ("date"
                                                                     , "mean"
                                                                     , "low_80_pct"
                                                                     , "low_95_pct"
                                                                     , "upper_80_pct"
                                                                     , "upper_95_pct")
SELECT "date"::DATE
     , "mean"::NUMERIC
     , "low_80_pct"::NUMERIC
     , "low_95_pct"::NUMERIC
     , "upper_80_pct"::NUMERIC
     , "upper_95_pct"::NUMERIC
FROM "nrel"."_inman_d3_rin_projected_d3_rin_projected_20171023"
ORDER BY 1
;

--SELECT * FROM "nrel"."inman_d3_rin_projected_d3_rin_projected_20171023";

RESET ROLE;
