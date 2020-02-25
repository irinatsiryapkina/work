DROP   TABLE IF EXISTS "wte"."log" CASCADE;
CREATE TABLE           "wte"."log" (
    "gid"    SERIAL NOT NULL PRIMARY KEY
  , "fpath"  TEXT       NULL
  , "schema" TEXT       NULL
  , "table"  TEXT       NULL
);
COMMENT ON TABLE "wte"."log" IS 'Available log tables';
