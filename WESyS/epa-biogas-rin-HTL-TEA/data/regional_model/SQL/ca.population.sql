CREATE OR REPLACE VIEW "ca"."population" AS (
 SELECT "year", "population"
 FROM "ca_dof"."population_20171024"
);
