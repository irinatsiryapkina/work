CREATE OR REPLACE VIEW "nrel"."conversion_efficiencies" AS (
  SELECT * FROM "nrel"."conversion_efficiencies_20170511"
);

COMMENT ON VIEW "nrel"."conversion_efficiencies" IS '';
