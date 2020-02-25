DROP   TABLE IF EXISTS "wte"."output_table" CASCADE;
CREATE TABLE           "wte"."output_table" (
    "gid"    SERIAL NOT NULL PRIMARY KEY
  , "schema" TEXT   NOT NULL
  , "table"  TEXT   NOT NULL
);
COMMENT ON TABLE "wte"."output_table" IS 'Available outout tables';

INSERT INTO "wte"."output_table" ("schema", "table")
VALUES ('sensitivity_runs', 'output_table_0006')
     , ('sensitivity_runs', 'output_table_0007')
     , ('sensitivity_runs', 'output_table_0008')
     , ('sensitivity_runs', 'output_table_0009')
     , ('sensitivity_runs', 'output_table_0010')
;
