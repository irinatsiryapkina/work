-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0014" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0014" (CONSTRAINT "output_table_0014_run_config_check" CHECK ("run_config" = 14)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraints
ALTER  TABLE "sensitivity_runs"."output_table_0014" ADD CONSTRAINT "pkey_output_table_0014" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0014_factor_btree" ON "sensitivity_runs"."output_table_0014" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0014_run_id_btree" ON "sensitivity_runs"."output_table_0014" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0014_brin_time"    ON "sensitivity_runs"."output_table_0014" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0014_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0014_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0014"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0014_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0014_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0014"
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0014_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0014_progress" AS (
	WITH x AS (
        SELECT 1    AS "start_index", 250  AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0014_run_id" WHERE "run_id" >= 1    AND "run_id" < 251  UNION ALL
        SELECT 251  AS "start_index", 500  AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0014_run_id" WHERE "run_id" >= 251  AND "run_id" < 501  UNION ALL
        SELECT 501  AS "start_index", 750  AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0014_run_id" WHERE "run_id" >= 501  AND "run_id" < 751  UNION ALL
        SELECT 751  AS "start_index", 1000 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0014_run_id" WHERE "run_id" >= 751  AND "run_id" < 1001 UNION ALL
        SELECT 1001 AS "start_index", 1250 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0014_run_id" WHERE "run_id" >= 1001 AND "run_id" < 1251 UNION ALL
        SELECT 1251 AS "start_index", 1500 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0014_run_id" WHERE "run_id" >= 1251 AND "run_id" < 1501 UNION ALL
        SELECT 1501 AS "start_index", 1750 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0014_run_id" WHERE "run_id" >= 1501 AND "run_id" < 1751 UNION ALL
        SELECT 1751 AS "start_index", 2000 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0014_run_id" WHERE "run_id" >= 1751 AND "run_id" < 2001 UNION ALL
        SELECT 2001 AS "start_index", 2250 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0014_run_id" WHERE "run_id" >= 2001 AND "run_id" < 2251 UNION ALL
        SELECT 2251 AS "start_index", 2500 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0014_run_id" WHERE "run_id" >= 2251 AND "run_id" < 2501 UNION ALL
        SELECT 2501 AS "start_index", 2750 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0014_run_id" WHERE "run_id" >= 2501 AND "run_id" < 2751 UNION ALL
        SELECT 2751 AS "start_index", 3000 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0014_run_id" WHERE "run_id" >= 2751 AND "run_id" < 3001 UNION ALL
        SELECT 3001 AS "start_index", 3250 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0014_run_id" WHERE "run_id" >= 3001 AND "run_id" < 3251 UNION ALL
        SELECT 3251 AS "start_index", 3500 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0014_run_id" WHERE "run_id" >= 3251 AND "run_id" < 3501 UNION ALL
        SELECT 3501 AS "start_index", 3750 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0014_run_id" WHERE "run_id" >= 3501 AND "run_id" < 3751 UNION ALL
        SELECT 3751 AS "start_index", 4000 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0014_run_id" WHERE "run_id" >= 3751 AND "run_id" < 4001 UNION ALL
        SELECT 4001 AS "start_index", 4250 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0014_run_id" WHERE "run_id" >= 4001 AND "run_id" < 4251 UNION ALL
        SELECT 4251 AS "start_index", 4500 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0014_run_id" WHERE "run_id" >= 4251 AND "run_id" < 4501 UNION ALL
        SELECT 4501 AS "start_index", 4750 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0014_run_id" WHERE "run_id" >= 4501 AND "run_id" < 4751 UNION ALL
        SELECT 4751 AS "start_index", 5000 AS "end_index", MAX("run_id"), MIN("run_id"), COUNT(DISTINCT "run_id") AS "num_run_ids" FROM "sensitivity_runs"."output_table_0014_run_id" WHERE "run_id" >= 4751 AND "run_id" < 5001
	)
	SELECT x.*
         ,  x."end_index" - x."max"                                                        AS "num_runs_remaining"
         , (x."end_index" - x."max")::NUMERIC / (x."end_index" - x."start_index")::NUMERIC AS "pct_runs_remaining"
	FROM x
    ORDER BY "start_index" ASC
);


-- check for missing runs
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0014_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0014_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0014_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0014_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0014";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0014_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0014_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0014_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0014_missing_run_ids";