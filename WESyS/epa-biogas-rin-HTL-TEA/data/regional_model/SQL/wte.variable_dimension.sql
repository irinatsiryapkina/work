DROP   TABLE IF EXISTS "wte"."variable_dimension" CASCADE;
CREATE TABLE           "wte"."variable_dimension" (
    "variable_gid"  INT NOT NULL REFERENCES "wte"."variable"  ("gid")
  , "dimension_gid" INT NOT NULL REFERENCES "wte"."dimension" ("gid")
  , "ordinal"       INT NOT NULL
  , CONSTRAINT "variable_dimension_pkey" PRIMARY KEY ("variable_gid", "dimension_gid")
);
COMMENT ON TABLE "wte"."variable_dimension" IS 'Variables with dimension name';
