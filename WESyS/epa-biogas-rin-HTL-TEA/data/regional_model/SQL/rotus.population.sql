CREATE OR REPLACE VIEW "rotus"."population" AS (
 SELECT a."year"
      , a."total_pop" - b."population" AS "population"
 FROM      "boc"."np2014_d1_2014" a
 LEFT JOIN "ca"."population" b ON a."year" = b."year"
 WHERE a."origin" = 0 AND a."race" = 0 AND a."sex" = 0
);
