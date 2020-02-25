-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0017" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0017" (CONSTRAINT "output_table_0017_run_config_check" CHECK ("run_config" = 17)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraint
ALTER  TABLE "sensitivity_runs"."output_table_0017" ADD CONSTRAINT "pkey_output_table_0017" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0017_factor_btree" ON "sensitivity_runs"."output_table_0017" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0017_run_id_btree" ON "sensitivity_runs"."output_table_0017" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0017_time_brin"    ON "sensitivity_runs"."output_table_0017" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0017_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0017_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0017"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0017_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0017_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0017" 
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0017_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0017_progress" AS (
	WITH x AS (
        SELECT 1      AS "start_index", 29250  AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0017_run_id" WHERE "run_id" >= 1      AND "run_id" < 29251  UNION ALL
        SELECT 29251  AS "start_index", 58500  AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0017_run_id" WHERE "run_id" >= 29251  AND "run_id" < 58501  UNION ALL
        SELECT 58501  AS "start_index", 87750  AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0017_run_id" WHERE "run_id" >= 58501  AND "run_id" < 87751  UNION ALL
        SELECT 87751  AS "start_index", 117000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0017_run_id" WHERE "run_id" >= 87751  AND "run_id" < 117001 UNION ALL
        SELECT 117001 AS "start_index", 146250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0017_run_id" WHERE "run_id" >= 117001 AND "run_id" < 146251 UNION ALL
        SELECT 146251 AS "start_index", 175500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0017_run_id" WHERE "run_id" >= 146251 AND "run_id" < 175501 UNION ALL
        SELECT 175501 AS "start_index", 204750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0017_run_id" WHERE "run_id" >= 175501 AND "run_id" < 204751 UNION ALL
        SELECT 204751 AS "start_index", 234000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0017_run_id" WHERE "run_id" >= 204751 AND "run_id" < 234001 UNION ALL
        SELECT 234001 AS "start_index", 263250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0017_run_id" WHERE "run_id" >= 234001 AND "run_id" < 263251 UNION ALL
        SELECT 263251 AS "start_index", 292500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0017_run_id" WHERE "run_id" >= 263251 AND "run_id" < 292501 UNION ALL
        SELECT 292501 AS "start_index", 321750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0017_run_id" WHERE "run_id" >= 292501 AND "run_id" < 321751 UNION ALL
        SELECT 321751 AS "start_index", 351000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0017_run_id" WHERE "run_id" >= 321751 AND "run_id" < 351001 UNION ALL
        SELECT 351001 AS "start_index", 380250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0017_run_id" WHERE "run_id" >= 351001 AND "run_id" < 380251 UNION ALL
        SELECT 380251 AS "start_index", 409500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0017_run_id" WHERE "run_id" >= 380251 AND "run_id" < 409501 UNION ALL
        SELECT 409501 AS "start_index", 438750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0017_run_id" WHERE "run_id" >= 409501 AND "run_id" < 438751 UNION ALL
        SELECT 438751 AS "start_index", 468000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0017_run_id" WHERE "run_id" >= 438751 AND "run_id" < 468001 UNION ALL
        SELECT 468001 AS "start_index", 497250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0017_run_id" WHERE "run_id" >= 468001 AND "run_id" < 497251 UNION ALL
        SELECT 497251 AS "start_index", 526500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0017_run_id" WHERE "run_id" >= 497251 AND "run_id" < 526501 UNION ALL
        SELECT 526501 AS "start_index", 555750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0017_run_id" WHERE "run_id" >= 526501 AND "run_id" < 555751 UNION ALL
        SELECT 555751 AS "start_index", 585000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0017_run_id" WHERE "run_id" >= 555751 AND "run_id" < 585001
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
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0017_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0017_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0017_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0017_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0017";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0017_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0017_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0017_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0017_missing_run_ids";
--SELECT COUNT("run_id") AS "invalid_run_ids" FROM "sensitivity_runs"."output_table_0017_invalid_run_id";
--SELECT COUNT("run_id") AS "num_missing_run_ids" FROM "sensitivity_runs"."run_config_0017_missing_run_ids";
--WITH x AS (SELECT "count", COUNT("count") FROM "sensitivity_runs"."output_table_0017_run_id" GROUP BY 1) SELECT * FROM x ORDER BY 1;
--SELECT * FROM "sensitivity_runs"."run_config_0017_progress";
