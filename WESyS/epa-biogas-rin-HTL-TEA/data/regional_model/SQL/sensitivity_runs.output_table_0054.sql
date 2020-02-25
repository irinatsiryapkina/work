-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0054" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0054" (CONSTRAINT "output_table_0054_run_config_check" CHECK ("run_config" = 54)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraints
ALTER  TABLE "sensitivity_runs"."output_table_0054" ADD CONSTRAINT "pkey_output_table_0054" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0054_factor_btree" ON "sensitivity_runs"."output_table_0054" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0054_run_id_btree" ON "sensitivity_runs"."output_table_0054" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0054_brin_time"    ON "sensitivity_runs"."output_table_0054" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0054_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0054_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0054"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0054_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0054_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0054"
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0054_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0054_progress" AS (
	WITH x AS (
        SELECT      1 AS "start_index",  44250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0054_run_id" WHERE "run_id" >=      1 AND "run_id" <  44251 UNION ALL
        SELECT  44251 AS "start_index",  88500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0054_run_id" WHERE "run_id" >=  44251 AND "run_id" <  88501 UNION ALL
        SELECT  88501 AS "start_index", 132750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0054_run_id" WHERE "run_id" >=  88501 AND "run_id" < 132751 UNION ALL
        SELECT 132751 AS "start_index", 177000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0054_run_id" WHERE "run_id" >= 132751 AND "run_id" < 177001 UNION ALL
        SELECT 177001 AS "start_index", 221250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0054_run_id" WHERE "run_id" >= 177001 AND "run_id" < 221251 UNION ALL
        SELECT 221251 AS "start_index", 265500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0054_run_id" WHERE "run_id" >= 221251 AND "run_id" < 265501 UNION ALL
        SELECT 265501 AS "start_index", 309750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0054_run_id" WHERE "run_id" >= 265501 AND "run_id" < 309751 UNION ALL
        SELECT 309751 AS "start_index", 354000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0054_run_id" WHERE "run_id" >= 309751 AND "run_id" < 354001 UNION ALL
        SELECT 354001 AS "start_index", 398250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0054_run_id" WHERE "run_id" >= 354001 AND "run_id" < 398251 UNION ALL
        SELECT 398251 AS "start_index", 442500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0054_run_id" WHERE "run_id" >= 398251 AND "run_id" < 442501 UNION ALL
        SELECT 442501 AS "start_index", 486750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0054_run_id" WHERE "run_id" >= 442501 AND "run_id" < 486751 UNION ALL
        SELECT 486751 AS "start_index", 531000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0054_run_id" WHERE "run_id" >= 486751 AND "run_id" < 531001 UNION ALL
        SELECT 531001 AS "start_index", 575250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0054_run_id" WHERE "run_id" >= 531001 AND "run_id" < 575251 UNION ALL
        SELECT 575251 AS "start_index", 619500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0054_run_id" WHERE "run_id" >= 575251 AND "run_id" < 619501 UNION ALL
        SELECT 619501 AS "start_index", 663750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0054_run_id" WHERE "run_id" >= 619501 AND "run_id" < 663751 UNION ALL
        SELECT 663751 AS "start_index", 708000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0054_run_id" WHERE "run_id" >= 663751 AND "run_id" < 708001 UNION ALL
        SELECT 708001 AS "start_index", 752250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0054_run_id" WHERE "run_id" >= 708001 AND "run_id" < 752251 UNION ALL
        SELECT 752251 AS "start_index", 796500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0054_run_id" WHERE "run_id" >= 752251 AND "run_id" < 796501 UNION ALL
        SELECT 796501 AS "start_index", 840750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0054_run_id" WHERE "run_id" >= 796501 AND "run_id" < 840751 UNION ALL
        SELECT 840751 AS "start_index", 885000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0054_run_id" WHERE "run_id" >= 840751 AND "run_id" < 885001
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
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0054_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0054_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0054_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0054_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0054";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0054_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0054_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0054_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0054_missing_run_ids";

-- 1-pct table
CREATE VIEW "sensitivity_runs"."output_table_0054_1pct" AS SELECT a.* FROM "sensitivity_runs"."output_table_0054" a RIGHT JOIN (SELECT GENERATE_SERIES(0, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0054_progress")) AS "run_id" ORDER BY RANDOM() LIMIT (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0054_progress") / 100.0) b ON a."run_id" = b."run_id";
--\COPY (SELECT * FROM "sensitivity_runs"."output_table_0054_1pct") TO 'sensitivity_runs.output_table_0054_1pct.csv' WITH CSV HEADER DELIMITER ','
--zip -m sensitivity_runs.output_table_0054_1pct.zip sensitivity_runs.output_table_0054_1pct.csv
--scp dhetting@walter.nrel.gov:/srv/data/wte/sensitivity_runs.output_table_0054_1pct.csv.zip ~/Box\ Sync/WESyS_Project/data_wte/sensitivity_runs.output_table_0054_1pct.csv.zip
