DROP   VIEW IF EXISTS "wte"."dimension_dimension_value_join" CASCADE;
CREATE VIEW           "wte"."dimension_dimension_value_join" AS
SELECT a."name" AS "dimension_name"
     , b."name" AS "value_name"
FROM "wte"."dimension_dimension_value" x
LEFT JOIN "wte"."dimension" a ON x."dimension_gid" = a."gid"
LEFT JOIN "wte"."dimension_value" b ON x."dimension_value_gid" = b."gid"
ORDER BY a."name", b."name"
;
COMMENT ON VIEW "wte"."dimension_dimension_value_join" IS 'Expanded description of dimensions and their values';
