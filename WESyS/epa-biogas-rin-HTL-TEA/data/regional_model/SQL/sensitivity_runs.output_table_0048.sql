-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0048" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0048" (CONSTRAINT "output_table_0048_run_config_check" CHECK ("run_config" = 48)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraints
ALTER  TABLE "sensitivity_runs"."output_table_0048" ADD CONSTRAINT "pkey_output_table_0048" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0048_factor_btree" ON "sensitivity_runs"."output_table_0048" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0048_run_id_btree" ON "sensitivity_runs"."output_table_0048" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0048_brin_time"    ON "sensitivity_runs"."output_table_0048" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0048_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0048_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0048"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0048_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0048_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0048"
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0048_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0048_progress" AS (
	WITH x AS (
        SELECT      1 AS "start_index",  48000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0048_run_id" WHERE "run_id" >=      1 AND "run_id" <  48001 UNION ALL
        SELECT  48001 AS "start_index",  96000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0048_run_id" WHERE "run_id" >=  48001 AND "run_id" <  96001 UNION ALL
        SELECT  96001 AS "start_index", 144000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0048_run_id" WHERE "run_id" >=  96001 AND "run_id" < 144001 UNION ALL
        SELECT 144001 AS "start_index", 192000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0048_run_id" WHERE "run_id" >= 144001 AND "run_id" < 192001 UNION ALL
        SELECT 192001 AS "start_index", 240000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0048_run_id" WHERE "run_id" >= 192001 AND "run_id" < 240001 UNION ALL
        SELECT 240001 AS "start_index", 288000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0048_run_id" WHERE "run_id" >= 240001 AND "run_id" < 288001 UNION ALL
        SELECT 288001 AS "start_index", 336000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0048_run_id" WHERE "run_id" >= 288001 AND "run_id" < 336001 UNION ALL
        SELECT 336001 AS "start_index", 384000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0048_run_id" WHERE "run_id" >= 336001 AND "run_id" < 384001 UNION ALL
        SELECT 384001 AS "start_index", 432000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0048_run_id" WHERE "run_id" >= 384001 AND "run_id" < 432001 UNION ALL
        SELECT 432001 AS "start_index", 480000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0048_run_id" WHERE "run_id" >= 432001 AND "run_id" < 480001 UNION ALL
        SELECT 480001 AS "start_index", 528000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0048_run_id" WHERE "run_id" >= 480001 AND "run_id" < 528001 UNION ALL
        SELECT 528001 AS "start_index", 576000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0048_run_id" WHERE "run_id" >= 528001 AND "run_id" < 576001 UNION ALL
        SELECT 576001 AS "start_index", 624000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0048_run_id" WHERE "run_id" >= 576001 AND "run_id" < 624001 UNION ALL
        SELECT 624001 AS "start_index", 672000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0048_run_id" WHERE "run_id" >= 624001 AND "run_id" < 672001 UNION ALL
        SELECT 672001 AS "start_index", 720000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0048_run_id" WHERE "run_id" >= 672001 AND "run_id" < 720001 UNION ALL
        SELECT 720001 AS "start_index", 768000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0048_run_id" WHERE "run_id" >= 720001 AND "run_id" < 768001 UNION ALL
        SELECT 768001 AS "start_index", 816000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0048_run_id" WHERE "run_id" >= 768001 AND "run_id" < 816001 UNION ALL
        SELECT 816001 AS "start_index", 864000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0048_run_id" WHERE "run_id" >= 816001 AND "run_id" < 864001 UNION ALL
        SELECT 864001 AS "start_index", 912000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0048_run_id" WHERE "run_id" >= 864001 AND "run_id" < 912001 UNION ALL
        SELECT 912001 AS "start_index", 960000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0048_run_id" WHERE "run_id" >= 912001 AND "run_id" < 960001
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
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0048_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0048_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0048_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0048_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0048";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0048_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0048_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0048_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0048_missing_run_ids";

-- 1-pct table
CREATE VIEW "sensitivity_runs"."output_table_0048_1pct" AS SELECT a.* FROM "sensitivity_runs"."output_table_0048" a RIGHT JOIN (SELECT GENERATE_SERIES(0, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0048_progress")) AS "run_id" ORDER BY RANDOM() LIMIT (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0048_progress") / 100.0) b ON a."run_id" = b."run_id";
--\COPY (SELECT * FROM "sensitivity_runs"."output_table_0048_1pct") TO 'sensitivity_runs.output_table_0048_1pct.csv' WITH CSV HEADER DELIMITER ','
--zip -m sensitivity_runs.output_table_0048_1pct.zip sensitivity_runs.output_table_0048_1pct.csv
--scp dhetting@walter.nrel.gov:/srv/data/wte/sensitivity_runs.output_table_0048_1pct.csv.zip ~/Box\ Sync/WESyS_Project/data_wte/sensitivity_runs.output_table_0048_1pct.csv.zip
