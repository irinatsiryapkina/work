-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0019" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0019" (CONSTRAINT "output_table_0019_run_config_check" CHECK ("run_config" = 19)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraint
ALTER  TABLE "sensitivity_runs"."output_table_0019" ADD CONSTRAINT "pkey_output_table_0019" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0019_factor_btree" ON "sensitivity_runs"."output_table_0019" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0019_run_id_btree" ON "sensitivity_runs"."output_table_0019" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0019_time_brin"    ON "sensitivity_runs"."output_table_0019" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0019_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0019_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0019"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0019_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0019_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0019" 
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0019_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0019_progress" AS (
	WITH x AS (
SELECT 1      AS "start_index", 33750  AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0019_run_id" WHERE "run_id" >= 1      AND "run_id" < 33751  UNION ALL
SELECT 33751  AS "start_index", 67500  AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0019_run_id" WHERE "run_id" >= 33751  AND "run_id" < 67501  UNION ALL
SELECT 67501  AS "start_index", 101250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0019_run_id" WHERE "run_id" >= 67501  AND "run_id" < 101251 UNION ALL
SELECT 101251 AS "start_index", 135000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0019_run_id" WHERE "run_id" >= 101251 AND "run_id" < 135001 UNION ALL
SELECT 135001 AS "start_index", 168750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0019_run_id" WHERE "run_id" >= 135001 AND "run_id" < 168751 UNION ALL
SELECT 168751 AS "start_index", 202500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0019_run_id" WHERE "run_id" >= 168751 AND "run_id" < 202501 UNION ALL
SELECT 202501 AS "start_index", 236250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0019_run_id" WHERE "run_id" >= 202501 AND "run_id" < 236251 UNION ALL
SELECT 236251 AS "start_index", 270000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0019_run_id" WHERE "run_id" >= 236251 AND "run_id" < 270001 UNION ALL
SELECT 270001 AS "start_index", 303750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0019_run_id" WHERE "run_id" >= 270001 AND "run_id" < 303751 UNION ALL
SELECT 303751 AS "start_index", 337500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0019_run_id" WHERE "run_id" >= 303751 AND "run_id" < 337501 UNION ALL
SELECT 337501 AS "start_index", 371250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0019_run_id" WHERE "run_id" >= 337501 AND "run_id" < 371251 UNION ALL
SELECT 371251 AS "start_index", 405000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0019_run_id" WHERE "run_id" >= 371251 AND "run_id" < 405001 UNION ALL
SELECT 405001 AS "start_index", 438750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0019_run_id" WHERE "run_id" >= 405001 AND "run_id" < 438751 UNION ALL
SELECT 438751 AS "start_index", 472500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0019_run_id" WHERE "run_id" >= 438751 AND "run_id" < 472501 UNION ALL
SELECT 472501 AS "start_index", 506250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0019_run_id" WHERE "run_id" >= 472501 AND "run_id" < 506251 UNION ALL
SELECT 506251 AS "start_index", 540000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0019_run_id" WHERE "run_id" >= 506251 AND "run_id" < 540001 UNION ALL
SELECT 540001 AS "start_index", 573750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0019_run_id" WHERE "run_id" >= 540001 AND "run_id" < 573751 UNION ALL
SELECT 573751 AS "start_index", 607500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0019_run_id" WHERE "run_id" >= 573751 AND "run_id" < 607501 UNION ALL
SELECT 607501 AS "start_index", 641250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0019_run_id" WHERE "run_id" >= 607501 AND "run_id" < 641251 UNION ALL
SELECT 641251 AS "start_index", 675000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0019_run_id" WHERE "run_id" >= 641251 AND "run_id" < 675001
    )
	SELECT x.*
         ,  x."end_index" - x."start_index" - x."num_runs_completed" + 1 AS "num_runs_remaining"
         ,  ROUND((x."end_index"
                 - x."start_index"
                 - x."num_runs_completed"
                 + 1)::NUMERIC
                 / (x."end_index"
                  - x."start_index"
                  + 1)
                , 2) * 100                                               AS "pct_runs_remaining"
	FROM x
    ORDER BY "start_index" ASC
);


-- check for missing runs
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0019_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0019_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0019_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0019_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0019";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0019_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0019_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0019_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0019_missing_run_ids";
--SELECT COUNT("run_id") AS "invalid_run_ids" FROM "sensitivity_runs"."output_table_0019_invalid_run_id";
--SELECT COUNT("run_id") AS "num_missing_run_ids" FROM "sensitivity_runs"."run_config_0019_missing_run_ids";
--WITH x AS (SELECT "count", COUNT("count") FROM "sensitivity_runs"."output_table_0019_run_id" GROUP BY 1) SELECT * FROM x ORDER BY 1;
--SELECT * FROM "sensitivity_runs"."run_config_0019_progress";