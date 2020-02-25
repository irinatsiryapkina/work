-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0043" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0043" (CONSTRAINT "output_table_0043_run_config_check" CHECK ("run_config" = 43)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraints
ALTER  TABLE "sensitivity_runs"."output_table_0043" ADD CONSTRAINT "pkey_output_table_0043" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0043_factor_btree" ON "sensitivity_runs"."output_table_0043" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0043_run_id_btree" ON "sensitivity_runs"."output_table_0043" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0043_brin_time"    ON "sensitivity_runs"."output_table_0043" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0043_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0043_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0043"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0043_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0043_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0043"
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0043_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0043_progress" AS (
	WITH x AS (
        SELECT 1                        AS "start_index"
             , 9550                     AS "end_index"
             , MIN("run_id")            AS "min_run_id"
             , MAX("run_id")            AS "max_run_id"
             , COUNT(DISTINCT "run_id") AS "num_runs_completed"
         FROM "sensitivity_runs"."output_table_0043_run_id"
         WHERE "run_id" >= 1
           AND "run_id" <  9550
	)
	SELECT x.*
         , x."end_index" - x."start_index" - x."num_runs_completed" + 1 AS "num_runs_remaining"
         , ROUND((x."end_index"
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
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0043_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0043_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0043_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0043_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0043";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0043_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0043_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0043_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0043_missing_run_ids";

-- 1-pct table
CREATE VIEW "sensitivity_runs"."output_table_0043_1pct" AS SELECT a.* FROM "sensitivity_runs"."output_table_0043" a RIGHT JOIN (SELECT GENERATE_SERIES(0, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0043_progress")) AS "run_id" ORDER BY RANDOM() LIMIT (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0043_progress") / 100.0) b ON a."run_id" = b."run_id";
--\COPY (SELECT * FROM "sensitivity_runs"."output_table_0043_1pct") TO 'sensitivity_runs.output_table_0043_1pct.csv' WITH CSV HEADER DELIMITER ','
--zip -m sensitivity_runs.output_table_0043_1pct.zip sensitivity_runs.output_table_0043_1pct.csv
--scp dhetting@walter.nrel.gov:/srv/data/wte/sensitivity_runs.output_table_0043_1pct.csv.zip ~/Box\ Sync/WESyS_Project/data_wte/sensitivity_runs.output_table_0043_1pct.csv.zip
