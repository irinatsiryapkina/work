ROLLBACK;
BEGIN;

GRANT SELECT ON TABLE "dhetting"."<table>" TO "wte-admin";

SET ROLE "wte-admin";

-- raw copy
DROP   TABLE IF EXISTS "<schema>"."_<table>_<date>";
CREATE TABLE           "<schema>"."_<table>_<date>" AS
SELECT * FROM "dhetting"."<table>"
;
COMMENT ON TABLE "<schema>"."_<table>_<date>" IS '<date>';
ANALYZE          "<schema>"."_<table>_<date>";

-- clean copy
DROP   TABLE IF EXISTS "<schema>"."<table>_<date>";
CREATE TABLE           "<schema>"."<table>_<date>" (
	  "gid" SERIAL PRIMARY KEY
	, CONSTRAINT "unq_<table>_<date>" UNIQUE ()
);
COMMENT ON TABLE "<schema>"."<table>_<date>" IS '<date>';

-- ALTER TABLE "<schema>"."<table>_<date>" ADD CONSTRAINT "unq_<table>_<date>" UNIQUE ();

INSERT INTO "<schema>"."<table>_<date>" (
)
SELECT DISTINCT

-- FROM "dhetting"."<table>"
FROM "<schema>"."_<table>_<date>"
ORDER BY 1
;

-- CREATE INDEX "idx_<table>_<date>_<col>_<type>" ON "<schema>"."<table>_<date>" USING <type> ("<col>");
-- ALTER TABLE <table>_<date>_<col>

-- ALTER TABLE "<schema>"."<table>_<date>" CLUSTER ON "idx_<table>_<date>_<col>_<type>";

ANALYZE "<schema>"."<table>_<date>";

COMMIT;

RESET ROLE;


-- -- all values
-- SELECT * FROM "dhetting"."<table>";
-- SELECT * FROM "<schema>"."_<table>_<date>";
-- SELECT * FROM "<schema>"."<table>_<date>";


-- column manipulation
WITH "col" AS (SELECT "column_name" AS "raw_column"
                    , REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER("column_name"), ' ', '_'), '/', '_'), '$', 'dol'), '(', ''), ')', ''), '-', '_') AS "clean_column"
                    , "ordinal_position"
               FROM "information_schema"."columns"
               WHERE "table_catalog" = 'wte'
                 AND "table_schema"  = 'dhetting'
                 AND "table_name"    = '<table>'
)
SELECT "raw_column" AS "raw_column"
     , "clean_column"
     , '     , "' || "clean_column" || '" NUMERIC'                                                                AS "create_clean_table_column"
     , '   , "' || "clean_column" || '"'                                                                          AS "insert_clean_column"
     , '     , NULLIF(regexp_replace("' || "raw_column" || '", ''^\s+|\s+$|NA|\?'', '''', ''g''), '''')::NUMERIC' AS "insert_raw_column"

FROM "col"
ORDER BY "ordinal_position"
;
