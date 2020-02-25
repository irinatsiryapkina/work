-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0011" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0011" (CONSTRAINT "output_table_0011_run_config_check" CHECK ("run_config" = 11)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraint
ALTER  TABLE "sensitivity_runs"."output_table_0011" ADD CONSTRAINT "pkey_output_table_0011" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0011_factor_btree" ON "sensitivity_runs"."output_table_0011" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0011_run_id_btree" ON "sensitivity_runs"."output_table_0011" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0011_time_brin"    ON "sensitivity_runs"."output_table_0011" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0011_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0011_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0011"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0011_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0011_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0011" 
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0011_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0011_progress" AS (
	WITH x AS (
        SELECT 1      AS "start_index", 39750  AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0011_run_id" WHERE "run_id" >= 1      AND "run_id" < 39751  UNION ALL
        SELECT 39751  AS "start_index", 79500  AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0011_run_id" WHERE "run_id" >= 39751  AND "run_id" < 79501  UNION ALL
        SELECT 79501  AS "start_index", 119250 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0011_run_id" WHERE "run_id" >= 79501  AND "run_id" < 119251 UNION ALL
        SELECT 119251 AS "start_index", 159000 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0011_run_id" WHERE "run_id" >= 119251 AND "run_id" < 159001 UNION ALL
        SELECT 159001 AS "start_index", 198750 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0011_run_id" WHERE "run_id" >= 159001 AND "run_id" < 198751 UNION ALL
        SELECT 198751 AS "start_index", 238500 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0011_run_id" WHERE "run_id" >= 198751 AND "run_id" < 238501 UNION ALL
        SELECT 238501 AS "start_index", 278250 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0011_run_id" WHERE "run_id" >= 238501 AND "run_id" < 278251 UNION ALL
        SELECT 278251 AS "start_index", 318000 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0011_run_id" WHERE "run_id" >= 278251 AND "run_id" < 318001 UNION ALL
        SELECT 318001 AS "start_index", 357750 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0011_run_id" WHERE "run_id" >= 318001 AND "run_id" < 357751 UNION ALL
        SELECT 357751 AS "start_index", 397500 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0011_run_id" WHERE "run_id" >= 357751 AND "run_id" < 397501 UNION ALL
        SELECT 397501 AS "start_index", 437250 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0011_run_id" WHERE "run_id" >= 397501 AND "run_id" < 437251 UNION ALL
        SELECT 437251 AS "start_index", 477000 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0011_run_id" WHERE "run_id" >= 437251 AND "run_id" < 477001 UNION ALL
        SELECT 477001 AS "start_index", 516750 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0011_run_id" WHERE "run_id" >= 477001 AND "run_id" < 516751 UNION ALL
        SELECT 516751 AS "start_index", 556500 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0011_run_id" WHERE "run_id" >= 516751 AND "run_id" < 556501 UNION ALL
        SELECT 556501 AS "start_index", 596250 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0011_run_id" WHERE "run_id" >= 556501 AND "run_id" < 596251 UNION ALL
        SELECT 596251 AS "start_index", 636000 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0011_run_id" WHERE "run_id" >= 596251 AND "run_id" < 636001 UNION ALL
        SELECT 636001 AS "start_index", 675750 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0011_run_id" WHERE "run_id" >= 636001 AND "run_id" < 675751 UNION ALL
        SELECT 675751 AS "start_index", 715500 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0011_run_id" WHERE "run_id" >= 675751 AND "run_id" < 715501 UNION ALL
        SELECT 715501 AS "start_index", 755250 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0011_run_id" WHERE "run_id" >= 715501 AND "run_id" < 755251 UNION ALL
        SELECT 755251 AS "start_index", 795000 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0011_run_id" WHERE "run_id" >= 755251 AND "run_id" < 795001
    )
	SELECT x.*
         ,  x."end_index" - x."max"                                      AS "num_runs_remaining"
         , (x."end_index" - x."max") / (x."end_index" - x."start_index") AS "pct_runs_remaining"
	FROM x
    ORDER BY "start_index" ASC
);


-- check for missing runs
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0011_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0011_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, 795000) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0011_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0011";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0011_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0011_invalid_run_id";
--REFRESH MATERIALIZED VIEW  "sensitivity_runs"."run_config_0011_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0011_missing_run_ids";