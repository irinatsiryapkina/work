DROP   TABLE IF EXISTS "wte"."scenario_vignette" CASCADE;
CREATE TABLE           "wte"."scenario_vignette" (
    "gid"          SERIAL NOT NULL PRIMARY KEY
  , "scenario_gid" INT    NOT NULL REFERENCES "wte"."scenario" ("gid")
  , "vignette_gid" INT    NOT NULL REFERENCES "wte"."vignette" ("gid")
  , "ordinal"      INT    NOT NULL DEFAULT 0
);
COMMENT ON TABLE "wte"."scenario_vignette" IS 'Vignettes assigned to scenarios';

INSERT INTO "wte"."scenario_vignette" ("scenario_gid", "vignette_gid")
SELECT (SELECT "gid" FROM "wte"."scenario" WHERE "name" = 'no_vignette_ca')                                AS "scenario_gid"
     , (SELECT "gid" FROM "wte"."vignette" WHERE "schema" = 'pre_vignettes' AND "table" = 'pre_vignettes') AS "vignette_gid"
UNION
SELECT (SELECT "gid" FROM "wte"."scenario" WHERE "name" = 'no_vignette_rotus')                             AS "scenario_gid"
     , (SELECT "gid" FROM "wte"."vignette" WHERE "schema" = 'pre_vignettes' AND "table" = 'pre_vignettes') AS "vignette_gid"
;