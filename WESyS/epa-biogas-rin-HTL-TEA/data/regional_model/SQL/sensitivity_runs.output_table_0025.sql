-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0025" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0025" (CONSTRAINT "output_table_0025_run_config_check" CHECK ("run_config" = 25)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraint
ALTER  TABLE "sensitivity_runs"."output_table_0025" ADD CONSTRAINT "pkey_output_table_0025" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0025_factor_btree" ON "sensitivity_runs"."output_table_0025" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0025_run_id_btree" ON "sensitivity_runs"."output_table_0025" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0025_time_brin"    ON "sensitivity_runs"."output_table_0025" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0025_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0025_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0025"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0025_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0025_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0025" 
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0025_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0025_progress" AS (
	WITH x AS (
        SELECT 1 AS "start_index", 6507 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0025_run_id" WHERE "run_id" >= 1 AND "run_id" < 6508
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
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0025_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0025_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0025_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0025_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0025";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0025_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0025_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0025_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0025_missing_run_ids";
--SELECT COUNT("run_id") AS "invalid_run_ids" FROM "sensitivity_runs"."output_table_0025_invalid_run_id";
--SELECT COUNT("run_id") AS "num_missing_run_ids" FROM "sensitivity_runs"."run_config_0025_missing_run_ids";
--WITH x AS (SELECT "count", COUNT("count") FROM "sensitivity_runs"."output_table_0025_run_id" GROUP BY 1) SELECT * FROM x ORDER BY 1;
--SELECT * FROM "sensitivity_runs"."run_config_0025_progress";