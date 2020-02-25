-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0020" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0020" (CONSTRAINT "output_table_0020_run_config_check" CHECK ("run_config" = 20)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraint
ALTER  TABLE "sensitivity_runs"."output_table_0020" ADD CONSTRAINT "pkey_output_table_0020" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0020_factor_btree" ON "sensitivity_runs"."output_table_0020" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0020_run_id_btree" ON "sensitivity_runs"."output_table_0020" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0020_time_brin"    ON "sensitivity_runs"."output_table_0020" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0020_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0020_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0020"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0020_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0020_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0020" 
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0020_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0020_progress" AS (
	WITH x AS (
        SELECT 1      AS "start_index", 30750  AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0020_run_id" WHERE "run_id" >= 1      AND "run_id" < 30751  UNION ALL
        SELECT 30751  AS "start_index", 61500  AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0020_run_id" WHERE "run_id" >= 30751  AND "run_id" < 61501  UNION ALL
        SELECT 61501  AS "start_index", 92250  AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0020_run_id" WHERE "run_id" >= 61501  AND "run_id" < 92251  UNION ALL
        SELECT 92251  AS "start_index", 123000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0020_run_id" WHERE "run_id" >= 92251  AND "run_id" < 123001 UNION ALL
        SELECT 123001 AS "start_index", 153750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0020_run_id" WHERE "run_id" >= 123001 AND "run_id" < 153751 UNION ALL
        SELECT 153751 AS "start_index", 184500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0020_run_id" WHERE "run_id" >= 153751 AND "run_id" < 184501 UNION ALL
        SELECT 184501 AS "start_index", 215250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0020_run_id" WHERE "run_id" >= 184501 AND "run_id" < 215251 UNION ALL
        SELECT 215251 AS "start_index", 246000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0020_run_id" WHERE "run_id" >= 215251 AND "run_id" < 246001 UNION ALL
        SELECT 246001 AS "start_index", 276750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0020_run_id" WHERE "run_id" >= 246001 AND "run_id" < 276751 UNION ALL
        SELECT 276751 AS "start_index", 307500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0020_run_id" WHERE "run_id" >= 276751 AND "run_id" < 307501 UNION ALL
        SELECT 307501 AS "start_index", 338250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0020_run_id" WHERE "run_id" >= 307501 AND "run_id" < 338251 UNION ALL
        SELECT 338251 AS "start_index", 369000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0020_run_id" WHERE "run_id" >= 338251 AND "run_id" < 369001 UNION ALL
        SELECT 369001 AS "start_index", 399750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0020_run_id" WHERE "run_id" >= 369001 AND "run_id" < 399751 UNION ALL
        SELECT 399751 AS "start_index", 430500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0020_run_id" WHERE "run_id" >= 399751 AND "run_id" < 430501 UNION ALL
        SELECT 430501 AS "start_index", 461250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0020_run_id" WHERE "run_id" >= 430501 AND "run_id" < 461251 UNION ALL
        SELECT 461251 AS "start_index", 492000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0020_run_id" WHERE "run_id" >= 461251 AND "run_id" < 492001 UNION ALL
        SELECT 492001 AS "start_index", 522750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0020_run_id" WHERE "run_id" >= 492001 AND "run_id" < 522751 UNION ALL
        SELECT 522751 AS "start_index", 553500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0020_run_id" WHERE "run_id" >= 522751 AND "run_id" < 553501 UNION ALL
        SELECT 553501 AS "start_index", 584250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0020_run_id" WHERE "run_id" >= 553501 AND "run_id" < 584251 UNION ALL
        SELECT 584251 AS "start_index", 615000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0020_run_id" WHERE "run_id" >= 584251 AND "run_id" < 615001
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
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0020_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0020_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0020_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0020_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0020";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0020_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0020_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0020_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0020_missing_run_ids";
--SELECT COUNT("run_id") AS "invalid_run_ids" FROM "sensitivity_runs"."output_table_0020_invalid_run_id";
--SELECT COUNT("run_id") AS "num_missing_run_ids" FROM "sensitivity_runs"."run_config_0020_missing_run_ids";
--WITH x AS (SELECT "count", COUNT("count") FROM "sensitivity_runs"."output_table_0020_run_id" GROUP BY 1) SELECT * FROM x ORDER BY 1;
--SELECT * FROM "sensitivity_runs"."run_config_0020_progress";