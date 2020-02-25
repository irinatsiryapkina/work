-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0038" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0038" (CONSTRAINT "output_table_0038_run_config_check" CHECK ("run_config" = 38)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraints
ALTER  TABLE "sensitivity_runs"."output_table_0038" ADD CONSTRAINT "pkey_output_table_0038" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0038_factor_btree" ON "sensitivity_runs"."output_table_0038" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0038_run_id_btree" ON "sensitivity_runs"."output_table_0038" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0038_brin_time"    ON "sensitivity_runs"."output_table_0038" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0038_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0038_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0038"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0038_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0038_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0038"
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0038_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0038_progress" AS (
	WITH x AS (
        SELECT      1 AS "start_index",  37500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0038_run_id" WHERE "run_id" >=      1 AND "run_id" <  37501 UNION ALL
        SELECT  37501 AS "start_index",  75000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0038_run_id" WHERE "run_id" >=  37501 AND "run_id" <  75001 UNION ALL
        SELECT  75001 AS "start_index", 112500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0038_run_id" WHERE "run_id" >=  75001 AND "run_id" < 112501 UNION ALL
        SELECT 112501 AS "start_index", 150000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0038_run_id" WHERE "run_id" >= 112501 AND "run_id" < 150001 UNION ALL
        SELECT 150001 AS "start_index", 187500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0038_run_id" WHERE "run_id" >= 150001 AND "run_id" < 187501 UNION ALL
        SELECT 187501 AS "start_index", 225000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0038_run_id" WHERE "run_id" >= 187501 AND "run_id" < 225001 UNION ALL
        SELECT 225001 AS "start_index", 262500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0038_run_id" WHERE "run_id" >= 225001 AND "run_id" < 262501 UNION ALL
        SELECT 262501 AS "start_index",  3e+05 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0038_run_id" WHERE "run_id" >= 262501 AND "run_id" < 300001 UNION ALL
        SELECT 300001 AS "start_index", 337500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0038_run_id" WHERE "run_id" >= 300001 AND "run_id" < 337501 UNION ALL
        SELECT 337501 AS "start_index", 375000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0038_run_id" WHERE "run_id" >= 337501 AND "run_id" < 375001 UNION ALL
        SELECT 375001 AS "start_index", 412500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0038_run_id" WHERE "run_id" >= 375001 AND "run_id" < 412501 UNION ALL
        SELECT 412501 AS "start_index", 450000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0038_run_id" WHERE "run_id" >= 412501 AND "run_id" < 450001 UNION ALL
        SELECT 450001 AS "start_index", 487500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0038_run_id" WHERE "run_id" >= 450001 AND "run_id" < 487501 UNION ALL
        SELECT 487501 AS "start_index", 525000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0038_run_id" WHERE "run_id" >= 487501 AND "run_id" < 525001 UNION ALL
        SELECT 525001 AS "start_index", 562500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0038_run_id" WHERE "run_id" >= 525001 AND "run_id" < 562501 UNION ALL
        SELECT 562501 AS "start_index",  6e+05 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0038_run_id" WHERE "run_id" >= 562501 AND "run_id" < 600001 UNION ALL
        SELECT 600001 AS "start_index", 637500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0038_run_id" WHERE "run_id" >= 600001 AND "run_id" < 637501 UNION ALL
        SELECT 637501 AS "start_index", 675000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0038_run_id" WHERE "run_id" >= 637501 AND "run_id" < 675001 UNION ALL
        SELECT 675001 AS "start_index", 712500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0038_run_id" WHERE "run_id" >= 675001 AND "run_id" < 712501 UNION ALL
        SELECT 712501 AS "start_index", 750000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0038_run_id" WHERE "run_id" >= 712501 AND "run_id" < 750001
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
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0038_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0038_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0038_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0038_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0038";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0038_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0038_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0038_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0038_missing_run_ids";

-- 1-pct table
CREATE VIEW "sensitivity_runs"."output_table_0038_1pct" AS SELECT a.* FROM "sensitivity_runs"."output_table_0038" a RIGHT JOIN (SELECT GENERATE_SERIES(0, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0038_progress")) AS "run_id" ORDER BY RANDOM() LIMIT (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0038_progress") / 100.0) b ON a."run_id" = b."run_id";
--\COPY (SELECT * FROM "sensitivity_runs"."output_table_0038_1pct") TO 'sensitivity_runs.output_table_0038_1pct.csv' WITH CSV HEADER DELIMITER ','
--zip -m sensitivity_runs.output_table_0038_1pct.zip sensitivity_runs.output_table_0038_1pct.csv
--scp dhetting@walter.nrel.gov:/srv/data/wte/sensitivity_runs.output_table_0038_1pct.zip ~/Box\ Sync/WESyS_Project/data_wte/sensitivity_runs.output_table_0038_1pct.csv.zip
