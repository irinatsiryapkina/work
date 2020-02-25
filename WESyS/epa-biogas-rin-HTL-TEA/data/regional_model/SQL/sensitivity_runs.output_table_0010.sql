-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0010" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0010" (CONSTRAINT "output_table_0010_run_config_check" CHECK ("run_config" = 10)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraint
ALTER  TABLE "sensitivity_runs"."output_table_0010" ADD CONSTRAINT "pkey_output_table_0010" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0010_factor_btree" ON "sensitivity_runs"."output_table_0010" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0010_run_id_btree" ON "sensitivity_runs"."output_table_0010" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0010_time_brin"    ON "sensitivity_runs"."output_table_0010" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0010_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0010_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0010"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0010_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0010_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0010" 
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0010_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0010_progress" AS (
	WITH x AS (
        SELECT 1      AS "start_index", 37500  AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0010_run_id" WHERE "run_id" >= 1      AND "run_id" < 37501  UNION ALL
        SELECT 37501  AS "start_index", 75000  AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0010_run_id" WHERE "run_id" >= 37501  AND "run_id" < 75001  UNION ALL
        SELECT 75001  AS "start_index", 112500 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0010_run_id" WHERE "run_id" >= 75001  AND "run_id" < 112501 UNION ALL
        SELECT 112501 AS "start_index", 150000 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0010_run_id" WHERE "run_id" >= 112501 AND "run_id" < 150001 UNION ALL
        SELECT 150001 AS "start_index", 187500 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0010_run_id" WHERE "run_id" >= 150001 AND "run_id" < 187501 UNION ALL
        SELECT 187501 AS "start_index", 225000 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0010_run_id" WHERE "run_id" >= 187501 AND "run_id" < 225001 UNION ALL
        SELECT 225001 AS "start_index", 262500 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0010_run_id" WHERE "run_id" >= 225001 AND "run_id" < 262501 UNION ALL
        SELECT 262501 AS "start_index", 300000 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0010_run_id" WHERE "run_id" >= 262501 AND "run_id" < 300001 UNION ALL
        SELECT 300001 AS "start_index", 337500 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0010_run_id" WHERE "run_id" >= 300001 AND "run_id" < 337501 UNION ALL
        SELECT 337501 AS "start_index", 375000 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0010_run_id" WHERE "run_id" >= 337501 AND "run_id" < 375001 UNION ALL
        SELECT 375001 AS "start_index", 412500 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0010_run_id" WHERE "run_id" >= 375001 AND "run_id" < 412501 UNION ALL
        SELECT 412501 AS "start_index", 450000 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0010_run_id" WHERE "run_id" >= 412501 AND "run_id" < 450001 UNION ALL
        SELECT 450001 AS "start_index", 487500 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0010_run_id" WHERE "run_id" >= 450001 AND "run_id" < 487501 UNION ALL
        SELECT 487501 AS "start_index", 525000 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0010_run_id" WHERE "run_id" >= 487501 AND "run_id" < 525001 UNION ALL
        SELECT 525001 AS "start_index", 562500 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0010_run_id" WHERE "run_id" >= 525001 AND "run_id" < 562501 UNION ALL
        SELECT 562501 AS "start_index", 600000 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0010_run_id" WHERE "run_id" >= 562501 AND "run_id" < 600001 UNION ALL
        SELECT 600001 AS "start_index", 637500 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0010_run_id" WHERE "run_id" >= 600001 AND "run_id" < 637501 UNION ALL
        SELECT 637501 AS "start_index", 675000 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0010_run_id" WHERE "run_id" >= 637501 AND "run_id" < 675001 UNION ALL
        SELECT 675001 AS "start_index", 712500 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0010_run_id" WHERE "run_id" >= 675001 AND "run_id" < 712501 UNION ALL
        SELECT 712501 AS "start_index", 750000 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0010_run_id" WHERE "run_id" >= 712501 AND "run_id" < 750001
    )
	SELECT x.*
         ,  x."end_index" - x."max"                                      AS "num_runs_remaining"
         , (x."end_index" - x."max") / (x."end_index" - x."start_index") AS "pct_runs_remaining"
	FROM x
    ORDER BY "start_index" ASC
);


-- check for missing runs
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0010_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0010_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, 750000) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0010_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0010";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0010_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0010_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0010_missing_run_ids";