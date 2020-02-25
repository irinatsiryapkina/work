-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0024" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0024" (CONSTRAINT "output_table_0024_run_config_check" CHECK ("run_config" = 24)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraint
ALTER  TABLE "sensitivity_runs"."output_table_0024" ADD CONSTRAINT "pkey_output_table_0024" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0024_factor_btree" ON "sensitivity_runs"."output_table_0024" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0024_run_id_btree" ON "sensitivity_runs"."output_table_0024" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0024_time_brin"    ON "sensitivity_runs"."output_table_0024" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0024_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0024_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0024"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0024_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0024_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0024" 
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0024_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0024_progress" AS (
	WITH x AS (
        SELECT      1 AS "start_index",  32250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0024_run_id" WHERE "run_id" >=      1 AND "run_id" <  32251 UNION ALL
        SELECT  32251 AS "start_index",  64500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0024_run_id" WHERE "run_id" >=  32251 AND "run_id" <  64501 UNION ALL
        SELECT  64501 AS "start_index",  96750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0024_run_id" WHERE "run_id" >=  64501 AND "run_id" <  96751 UNION ALL
        SELECT  96751 AS "start_index", 129000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0024_run_id" WHERE "run_id" >=  96751 AND "run_id" < 129001 UNION ALL
        SELECT 129001 AS "start_index", 161250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0024_run_id" WHERE "run_id" >= 129001 AND "run_id" < 161251 UNION ALL
        SELECT 161251 AS "start_index", 193500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0024_run_id" WHERE "run_id" >= 161251 AND "run_id" < 193501 UNION ALL
        SELECT 193501 AS "start_index", 225750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0024_run_id" WHERE "run_id" >= 193501 AND "run_id" < 225751 UNION ALL
        SELECT 225751 AS "start_index", 258000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0024_run_id" WHERE "run_id" >= 225751 AND "run_id" < 258001 UNION ALL
        SELECT 258001 AS "start_index", 290250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0024_run_id" WHERE "run_id" >= 258001 AND "run_id" < 290251 UNION ALL
        SELECT 290251 AS "start_index", 322500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0024_run_id" WHERE "run_id" >= 290251 AND "run_id" < 322501 UNION ALL
        SELECT 322501 AS "start_index", 354750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0024_run_id" WHERE "run_id" >= 322501 AND "run_id" < 354751 UNION ALL
        SELECT 354751 AS "start_index", 387000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0024_run_id" WHERE "run_id" >= 354751 AND "run_id" < 387001 UNION ALL
        SELECT 387001 AS "start_index", 419250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0024_run_id" WHERE "run_id" >= 387001 AND "run_id" < 419251 UNION ALL
        SELECT 419251 AS "start_index", 451500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0024_run_id" WHERE "run_id" >= 419251 AND "run_id" < 451501 UNION ALL
        SELECT 451501 AS "start_index", 483750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0024_run_id" WHERE "run_id" >= 451501 AND "run_id" < 483751 UNION ALL
        SELECT 483751 AS "start_index", 516000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0024_run_id" WHERE "run_id" >= 483751 AND "run_id" < 516001 UNION ALL
        SELECT 516001 AS "start_index", 548250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0024_run_id" WHERE "run_id" >= 516001 AND "run_id" < 548251 UNION ALL
        SELECT 548251 AS "start_index", 580500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0024_run_id" WHERE "run_id" >= 548251 AND "run_id" < 580501 UNION ALL
        SELECT 580501 AS "start_index", 612750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0024_run_id" WHERE "run_id" >= 580501 AND "run_id" < 612751 UNION ALL
        SELECT 612751 AS "start_index", 645000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0024_run_id" WHERE "run_id" >= 612751 AND "run_id" < 645001
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
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0024_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0024_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0024_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0024_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0024";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0024_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0024_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0024_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0024_missing_run_ids";
--SELECT COUNT("run_id") AS "invalid_run_ids" FROM "sensitivity_runs"."output_table_0024_invalid_run_id";
--SELECT COUNT("run_id") AS "num_missing_run_ids" FROM "sensitivity_runs"."run_config_0024_missing_run_ids";
--WITH x AS (SELECT "count", COUNT("count") FROM "sensitivity_runs"."output_table_0024_run_id" GROUP BY 1) SELECT * FROM x ORDER BY 1;
--SELECT * FROM "sensitivity_runs"."run_config_0024_progress";