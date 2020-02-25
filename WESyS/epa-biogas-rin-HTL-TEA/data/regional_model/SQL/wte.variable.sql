DROP   TABLE IF EXISTS "wte"."variable" CASCADE;
CREATE TABLE           "wte"."variable" (
    "gid"    SERIAL NOT NULL PRIMARY KEY
  , "module" TEXT   NOT NULL REFERENCES "wte"."module" ("module")
  , "name"   TEXT   NOT NULL
  , CONSTRAINT "variable_module_name_key" UNIQUE ("module", "name")
);
COMMENT ON TABLE "wte"."variable" IS 'Available model variables';

\COPY "wte"."variable" ("module", "name") FROM 'all_variables_columns.csv' WITH CSV

UPDATE "wte"."variable" SET "name" = TRIM("name");

INSERT INTO "wte"."variable" ("gid", "module", "name")
SELECT -999            AS "gid"
     , "name"          AS "module"
     , 'UNKNOWN'::TEXT AS "name"
FROM "wte"."module"
ORDER BY "name";
