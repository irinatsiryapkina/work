-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0034" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0034" (CONSTRAINT "output_table_0034_run_config_check" CHECK ("run_config" = 34)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraints
ALTER  TABLE "sensitivity_runs"."output_table_0034" ADD CONSTRAINT "pkey_output_table_0034" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0034_factor_btree" ON "sensitivity_runs"."output_table_0034" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0034_run_id_btree" ON "sensitivity_runs"."output_table_0034" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0034_brin_time"    ON "sensitivity_runs"."output_table_0034" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0034_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0034_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0034"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0034_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0034_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0034"
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0034_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0034_progress" AS (
	WITH x AS (
        SELECT      1 AS "start_index",  33000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0034_run_id" WHERE "run_id" >=      1 AND "run_id" <  33001 UNION ALL
        SELECT  33001 AS "start_index",  66000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0034_run_id" WHERE "run_id" >=  33001 AND "run_id" <  66001 UNION ALL
        SELECT  66001 AS "start_index",  99000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0034_run_id" WHERE "run_id" >=  66001 AND "run_id" <  99001 UNION ALL
        SELECT  99001 AS "start_index", 132000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0034_run_id" WHERE "run_id" >=  99001 AND "run_id" < 132001 UNION ALL
        SELECT 132001 AS "start_index", 165000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0034_run_id" WHERE "run_id" >= 132001 AND "run_id" < 165001 UNION ALL
        SELECT 165001 AS "start_index", 198000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0034_run_id" WHERE "run_id" >= 165001 AND "run_id" < 198001 UNION ALL
        SELECT 198001 AS "start_index", 231000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0034_run_id" WHERE "run_id" >= 198001 AND "run_id" < 231001 UNION ALL
        SELECT 231001 AS "start_index", 264000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0034_run_id" WHERE "run_id" >= 231001 AND "run_id" < 264001 UNION ALL
        SELECT 264001 AS "start_index", 297000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0034_run_id" WHERE "run_id" >= 264001 AND "run_id" < 297001 UNION ALL
        SELECT 297001 AS "start_index", 330000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0034_run_id" WHERE "run_id" >= 297001 AND "run_id" < 330001 UNION ALL
        SELECT 330001 AS "start_index", 363000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0034_run_id" WHERE "run_id" >= 330001 AND "run_id" < 363001 UNION ALL
        SELECT 363001 AS "start_index", 396000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0034_run_id" WHERE "run_id" >= 363001 AND "run_id" < 396001 UNION ALL
        SELECT 396001 AS "start_index", 429000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0034_run_id" WHERE "run_id" >= 396001 AND "run_id" < 429001 UNION ALL
        SELECT 429001 AS "start_index", 462000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0034_run_id" WHERE "run_id" >= 429001 AND "run_id" < 462001 UNION ALL
        SELECT 462001 AS "start_index", 495000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0034_run_id" WHERE "run_id" >= 462001 AND "run_id" < 495001 UNION ALL
        SELECT 495001 AS "start_index", 528000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0034_run_id" WHERE "run_id" >= 495001 AND "run_id" < 528001 UNION ALL
        SELECT 528001 AS "start_index", 561000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0034_run_id" WHERE "run_id" >= 528001 AND "run_id" < 561001 UNION ALL
        SELECT 561001 AS "start_index", 594000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0034_run_id" WHERE "run_id" >= 561001 AND "run_id" < 594001 UNION ALL
        SELECT 594001 AS "start_index", 627000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0034_run_id" WHERE "run_id" >= 594001 AND "run_id" < 627001 UNION ALL
        SELECT 627001 AS "start_index", 660000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0034_run_id" WHERE "run_id" >= 627001 AND "run_id" < 660001
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
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0034_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0034_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0034_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0034_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0034";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0034_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0034_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0034_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0034_missing_run_ids";

-- 1-pct table
CREATE VIEW "sensitivity_runs"."output_table_0034_1pct" AS SELECT a.* FROM "sensitivity_runs"."output_table_0034" a RIGHT JOIN (SELECT GENERATE_SERIES(0, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0034_progress")) AS "run_id" ORDER BY RANDOM() LIMIT (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0034_progress") / 100.0) b ON a."run_id" = b."run_id";
--\COPY (SELECT * FROM "sensitivity_runs"."output_table_0034_1pct") TO 'sensitivity_runs.output_table_0034_1pct.csv' WITH CSV HEADER DELIMITER ','
--zip -m sensitivity_runs.output_table_0029_1pct.zip sensitivity_runs.output_table_0029_1pct.csv
--scp dhetting@walter.nrel.gov:/srv/data/wte/sensitivity_runs.output_table_0029_1pct.zip ~/Box\ Sync/WESyS_Project/data_wte/sensitivity_runs.output_table_0029_1pct.csv.zip
