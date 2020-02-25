-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0042" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0042" (CONSTRAINT "output_table_0042_run_config_check" CHECK ("run_config" = 42)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraints
ALTER  TABLE "sensitivity_runs"."output_table_0042" ADD CONSTRAINT "pkey_output_table_0042" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0042_factor_btree" ON "sensitivity_runs"."output_table_0042" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0042_run_id_btree" ON "sensitivity_runs"."output_table_0042" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0042_brin_time"    ON "sensitivity_runs"."output_table_0042" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0042_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0042_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0042"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0042_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0042_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0042"
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0042_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0042_progress" AS (
	WITH x AS (
        SELECT      1 AS "start_index",  24750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0042_run_id" WHERE "run_id" >=      1 AND "run_id" <  24751 UNION ALL
        SELECT  24751 AS "start_index",  49500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0042_run_id" WHERE "run_id" >=  24751 AND "run_id" <  49501 UNION ALL
        SELECT  49501 AS "start_index",  74250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0042_run_id" WHERE "run_id" >=  49501 AND "run_id" <  74251 UNION ALL
        SELECT  74251 AS "start_index",  99000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0042_run_id" WHERE "run_id" >=  74251 AND "run_id" <  99001 UNION ALL
        SELECT  99001 AS "start_index", 123750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0042_run_id" WHERE "run_id" >=  99001 AND "run_id" < 123751 UNION ALL
        SELECT 123751 AS "start_index", 148500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0042_run_id" WHERE "run_id" >= 123751 AND "run_id" < 148501 UNION ALL
        SELECT 148501 AS "start_index", 173250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0042_run_id" WHERE "run_id" >= 148501 AND "run_id" < 173251 UNION ALL
        SELECT 173251 AS "start_index", 198000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0042_run_id" WHERE "run_id" >= 173251 AND "run_id" < 198001 UNION ALL
        SELECT 198001 AS "start_index", 222750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0042_run_id" WHERE "run_id" >= 198001 AND "run_id" < 222751 UNION ALL
        SELECT 222751 AS "start_index", 247500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0042_run_id" WHERE "run_id" >= 222751 AND "run_id" < 247501 UNION ALL
        SELECT 247501 AS "start_index", 272250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0042_run_id" WHERE "run_id" >= 247501 AND "run_id" < 272251 UNION ALL
        SELECT 272251 AS "start_index", 297000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0042_run_id" WHERE "run_id" >= 272251 AND "run_id" < 297001 UNION ALL
        SELECT 297001 AS "start_index", 321750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0042_run_id" WHERE "run_id" >= 297001 AND "run_id" < 321751 UNION ALL
        SELECT 321751 AS "start_index", 346500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0042_run_id" WHERE "run_id" >= 321751 AND "run_id" < 346501 UNION ALL
        SELECT 346501 AS "start_index", 371250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0042_run_id" WHERE "run_id" >= 346501 AND "run_id" < 371251 UNION ALL
        SELECT 371251 AS "start_index", 396000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0042_run_id" WHERE "run_id" >= 371251 AND "run_id" < 396001 UNION ALL
        SELECT 396001 AS "start_index", 420750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0042_run_id" WHERE "run_id" >= 396001 AND "run_id" < 420751 UNION ALL
        SELECT 420751 AS "start_index", 445500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0042_run_id" WHERE "run_id" >= 420751 AND "run_id" < 445501 UNION ALL
        SELECT 445501 AS "start_index", 470250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0042_run_id" WHERE "run_id" >= 445501 AND "run_id" < 470251 UNION ALL
        SELECT 470251 AS "start_index", 495000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0042_run_id" WHERE "run_id" >= 470251 AND "run_id" < 495001
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
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0042_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0042_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0042_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0042_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0042";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0042_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0042_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0042_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0042_missing_run_ids";

-- 1-pct table
CREATE VIEW "sensitivity_runs"."output_table_0042_1pct" AS SELECT a.* FROM "sensitivity_runs"."output_table_0042" a RIGHT JOIN (SELECT GENERATE_SERIES(0, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0042_progress")) AS "run_id" ORDER BY RANDOM() LIMIT (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0042_progress") / 100.0) b ON a."run_id" = b."run_id";
--\COPY (SELECT * FROM "sensitivity_runs"."output_table_0042_1pct") TO 'sensitivity_runs.output_table_0042_1pct.csv' WITH CSV HEADER DELIMITER ','
--zip -m sensitivity_runs.output_table_0042_1pct.zip sensitivity_runs.output_table_0042_1pct.csv
--scp dhetting@walter.nrel.gov:/srv/data/wte/sensitivity_runs.output_table_0042_1pct.csv.zip ~/Box\ Sync/WESyS_Project/data_wte/sensitivity_runs.output_table_0042_1pct.csv.zip
