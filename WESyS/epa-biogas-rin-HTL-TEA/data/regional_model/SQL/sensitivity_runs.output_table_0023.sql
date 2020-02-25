-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0023" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0023" (CONSTRAINT "output_table_0023_run_config_check" CHECK ("run_config" = 23)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraint
ALTER  TABLE "sensitivity_runs"."output_table_0023" ADD CONSTRAINT "pkey_output_table_0023" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0023_factor_btree" ON "sensitivity_runs"."output_table_0023" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0023_run_id_btree" ON "sensitivity_runs"."output_table_0023" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0023_time_brin"    ON "sensitivity_runs"."output_table_0023" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0023_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0023_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0023"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0023_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0023_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0023" 
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0023_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0023_progress" AS (
	WITH x AS (
        SELECT      1 AS "start_index",  31500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0023_run_id" WHERE "run_id" >=      1 AND "run_id" <  31501 UNION ALL
        SELECT  31501 AS "start_index",  63000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0023_run_id" WHERE "run_id" >=  31501 AND "run_id" <  63001 UNION ALL
        SELECT  63001 AS "start_index",  94500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0023_run_id" WHERE "run_id" >=  63001 AND "run_id" <  94501 UNION ALL
        SELECT  94501 AS "start_index", 126000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0023_run_id" WHERE "run_id" >=  94501 AND "run_id" < 126001 UNION ALL
        SELECT 126001 AS "start_index", 157500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0023_run_id" WHERE "run_id" >= 126001 AND "run_id" < 157501 UNION ALL
        SELECT 157501 AS "start_index", 189000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0023_run_id" WHERE "run_id" >= 157501 AND "run_id" < 189001 UNION ALL
        SELECT 189001 AS "start_index", 220500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0023_run_id" WHERE "run_id" >= 189001 AND "run_id" < 220501 UNION ALL
        SELECT 220501 AS "start_index", 252000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0023_run_id" WHERE "run_id" >= 220501 AND "run_id" < 252001 UNION ALL
        SELECT 252001 AS "start_index", 283500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0023_run_id" WHERE "run_id" >= 252001 AND "run_id" < 283501 UNION ALL
        SELECT 283501 AS "start_index", 315000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0023_run_id" WHERE "run_id" >= 283501 AND "run_id" < 315001 UNION ALL
        SELECT 315001 AS "start_index", 346500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0023_run_id" WHERE "run_id" >= 315001 AND "run_id" < 346501 UNION ALL
        SELECT 346501 AS "start_index", 378000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0023_run_id" WHERE "run_id" >= 346501 AND "run_id" < 378001 UNION ALL
        SELECT 378001 AS "start_index", 409500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0023_run_id" WHERE "run_id" >= 378001 AND "run_id" < 409501 UNION ALL
        SELECT 409501 AS "start_index", 441000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0023_run_id" WHERE "run_id" >= 409501 AND "run_id" < 441001 UNION ALL
        SELECT 441001 AS "start_index", 472500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0023_run_id" WHERE "run_id" >= 441001 AND "run_id" < 472501 UNION ALL
        SELECT 472501 AS "start_index", 504000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0023_run_id" WHERE "run_id" >= 472501 AND "run_id" < 504001 UNION ALL
        SELECT 504001 AS "start_index", 535500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0023_run_id" WHERE "run_id" >= 504001 AND "run_id" < 535501 UNION ALL
        SELECT 535501 AS "start_index", 567000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0023_run_id" WHERE "run_id" >= 535501 AND "run_id" < 567001 UNION ALL
        SELECT 567001 AS "start_index", 598500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0023_run_id" WHERE "run_id" >= 567001 AND "run_id" < 598501 UNION ALL
        SELECT 598501 AS "start_index", 630000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0023_run_id" WHERE "run_id" >= 598501 AND "run_id" < 630001
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
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0023_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0023_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0023_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0023_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0023";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0023_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0023_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0023_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0023_missing_run_ids";
--SELECT COUNT("run_id") AS "invalid_run_ids" FROM "sensitivity_runs"."output_table_0023_invalid_run_id";
--SELECT COUNT("run_id") AS "num_missing_run_ids" FROM "sensitivity_runs"."run_config_0023_missing_run_ids";
--WITH x AS (SELECT "count", COUNT("count") FROM "sensitivity_runs"."output_table_0023_run_id" GROUP BY 1) SELECT * FROM x ORDER BY 1;
--SELECT * FROM "sensitivity_runs"."run_config_0023_progress";