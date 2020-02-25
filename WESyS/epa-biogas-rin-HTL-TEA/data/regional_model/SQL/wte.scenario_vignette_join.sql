DROP   VIEW IF EXISTS "wte"."scenario_vignette_join" CASCADE;
CREATE VIEW           "wte"."scenario_vignette_join" AS
SELECT b."gid"         AS "scenario_gid"
     , b."description" AS "scenario_description"
     , c."gid"         AS "vignette_gid"
     , c."schema"
     , c."table"
     , a."ordinal"
     , c."description" AS "vignette_description"
FROM "wte"."scenario_vignette" a
LEFT JOIN "wte"."scenario" b ON a."scenario_gid" = b."gid"
LEFT JOIN "wte"."vignette" c ON a."vignette_gid" = c."gid"
ORDER BY b."gid", a."ordinal"
;
COMMENT ON VIEW "wte"."scenario_vignette_join" IS 'Vignettes for each scenario';
