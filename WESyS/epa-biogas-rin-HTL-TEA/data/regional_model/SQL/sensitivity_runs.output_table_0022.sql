-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0022" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0022" (CONSTRAINT "output_table_0022_run_config_check" CHECK ("run_config" = 22)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraint
ALTER  TABLE "sensitivity_runs"."output_table_0022" ADD CONSTRAINT "pkey_output_table_0022" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0022_factor_btree" ON "sensitivity_runs"."output_table_0022" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0022_run_id_btree" ON "sensitivity_runs"."output_table_0022" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0022_time_brin"    ON "sensitivity_runs"."output_table_0022" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0022_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0022_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0022"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0022_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0022_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0022" 
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0022_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0022_progress" AS (
	WITH x AS (
        SELECT      1 AS "start_index",  24000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0022_run_id" WHERE "run_id" >=      1 AND "run_id" <  24001 UNION ALL
        SELECT  24001 AS "start_index",  48000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0022_run_id" WHERE "run_id" >=  24001 AND "run_id" <  48001 UNION ALL
        SELECT  48001 AS "start_index",  72000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0022_run_id" WHERE "run_id" >=  48001 AND "run_id" <  72001 UNION ALL
        SELECT  72001 AS "start_index",  96000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0022_run_id" WHERE "run_id" >=  72001 AND "run_id" <  96001 UNION ALL
        SELECT  96001 AS "start_index", 120000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0022_run_id" WHERE "run_id" >=  96001 AND "run_id" < 120001 UNION ALL
        SELECT 120001 AS "start_index", 144000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0022_run_id" WHERE "run_id" >= 120001 AND "run_id" < 144001 UNION ALL
        SELECT 144001 AS "start_index", 168000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0022_run_id" WHERE "run_id" >= 144001 AND "run_id" < 168001 UNION ALL
        SELECT 168001 AS "start_index", 192000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0022_run_id" WHERE "run_id" >= 168001 AND "run_id" < 192001 UNION ALL
        SELECT 192001 AS "start_index", 216000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0022_run_id" WHERE "run_id" >= 192001 AND "run_id" < 216001 UNION ALL
        SELECT 216001 AS "start_index", 240000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0022_run_id" WHERE "run_id" >= 216001 AND "run_id" < 240001 UNION ALL
        SELECT 240001 AS "start_index", 264000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0022_run_id" WHERE "run_id" >= 240001 AND "run_id" < 264001 UNION ALL
        SELECT 264001 AS "start_index", 288000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0022_run_id" WHERE "run_id" >= 264001 AND "run_id" < 288001 UNION ALL
        SELECT 288001 AS "start_index", 312000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0022_run_id" WHERE "run_id" >= 288001 AND "run_id" < 312001 UNION ALL
        SELECT 312001 AS "start_index", 336000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0022_run_id" WHERE "run_id" >= 312001 AND "run_id" < 336001 UNION ALL
        SELECT 336001 AS "start_index", 360000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0022_run_id" WHERE "run_id" >= 336001 AND "run_id" < 360001 UNION ALL
        SELECT 360001 AS "start_index", 384000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0022_run_id" WHERE "run_id" >= 360001 AND "run_id" < 384001 UNION ALL
        SELECT 384001 AS "start_index", 408000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0022_run_id" WHERE "run_id" >= 384001 AND "run_id" < 408001 UNION ALL
        SELECT 408001 AS "start_index", 432000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0022_run_id" WHERE "run_id" >= 408001 AND "run_id" < 432001 UNION ALL
        SELECT 432001 AS "start_index", 456000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0022_run_id" WHERE "run_id" >= 432001 AND "run_id" < 456001 UNION ALL
        SELECT 456001 AS "start_index", 480000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0022_run_id" WHERE "run_id" >= 456001 AND "run_id" < 480001
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
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0022_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0022_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0022_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0022_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0022";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0022_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0022_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0022_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0022_missing_run_ids";
--SELECT COUNT("run_id") AS "invalid_run_ids" FROM "sensitivity_runs"."output_table_0022_invalid_run_id";
--SELECT COUNT("run_id") AS "num_missing_run_ids" FROM "sensitivity_runs"."run_config_0022_missing_run_ids";
--WITH x AS (SELECT "count", COUNT("count") FROM "sensitivity_runs"."output_table_0022_run_id" GROUP BY 1) SELECT * FROM x ORDER BY 1;
--SELECT * FROM "sensitivity_runs"."run_config_0022_progress";