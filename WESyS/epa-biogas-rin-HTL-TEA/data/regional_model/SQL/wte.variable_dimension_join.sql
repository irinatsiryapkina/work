DROP   VIEW IF EXISTS "wte"."variable_dimension_join" CASCADE;
CREATE VIEW           "wte"."variable_dimension_join" AS
SELECT a."variable_gid"
     , a."dimension_gid"
     , b."module"
     , b."name"    AS "variable_name"
     , c."name"    AS "dimension_name"
     , a."ordinal" AS "dimension_ordinal"
FROM      "wte"."variable_dimension" a
LEFT JOIN "wte"."variable"           b ON a."variable_gid"  = b."gid"
LEFT JOIN "wte"."dimension"          c ON a."dimension_gid" = c."gid"
ORDER BY b."module", a."ordinal"
;
COMMENT ON VIEW "wte"."variable_dimension_join" IS 'Variables with expanded dimension name';
