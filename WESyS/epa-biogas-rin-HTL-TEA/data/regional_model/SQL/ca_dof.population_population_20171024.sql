RESET ROLE;

GRANT SELECT ON TABLE "dhetting"."population" TO "wte-admin";

SET ROLE "wte-admin";

-- raw copy
DROP   TABLE IF EXISTS "ca_dof"."_population_20171024";
CREATE TABLE           "ca_dof"."_population_20171024" AS
SELECT * FROM "dhetting"."population"
;

COMMENT ON TABLE "ca_dof"."_population_20171024" IS 'California population. 20171024.';


-- clean copy
DROP   TABLE IF EXISTS "ca_dof"."population_20171024";
CREATE TABLE           "ca_dof"."population_20171024" (
      "gid"        SERIAL PRIMARY KEY
    , "year"       INT NOT NULL
    , "population" NUMERIC NOT NULL
    , CONSTRAINT "unq_population_20171024_year" UNIQUE ("year")
);
COMMENT ON TABLE "ca_dof"."population_20171024" IS 'California population. 20171024.';

INSERT INTO "ca_dof"."population_20171024" ("year", "population")
SELECT DISTINCT
      REGEXP_REPLACE("Year", '\.0$', '')::INT       AS "year"
    , REGEXP_REPLACE("CA pop", '\.0$', '')::NUMERIC AS "population"
FROM "ca_dof"."_population_20171024"
ORDER BY 1
;

--SELECT * FROM "ca_dof"."population_20171024";

RESET ROLE;
