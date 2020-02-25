-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0056" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0056" (CONSTRAINT "output_table_0056_run_config_check" CHECK ("run_config" = 56)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraints
ALTER  TABLE "sensitivity_runs"."output_table_0056" ADD CONSTRAINT "pkey_output_table_0056" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0056_factor_btree" ON "sensitivity_runs"."output_table_0056" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0056_run_id_btree" ON "sensitivity_runs"."output_table_0056" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0056_brin_time"    ON "sensitivity_runs"."output_table_0056" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0056_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0056_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0056"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0056_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0056_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0056"
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0056_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0056_progress" AS (
	WITH x AS (
        SELECT      1 AS "start_index",   9750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0056_run_id" WHERE "run_id" >=      1 AND "run_id" <   9751 UNION ALL
        SELECT   9751 AS "start_index",  19500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0056_run_id" WHERE "run_id" >=   9751 AND "run_id" <  19501 UNION ALL
        SELECT  19501 AS "start_index",  29250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0056_run_id" WHERE "run_id" >=  19501 AND "run_id" <  29251 UNION ALL
        SELECT  29251 AS "start_index",  39000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0056_run_id" WHERE "run_id" >=  29251 AND "run_id" <  39001 UNION ALL
        SELECT  39001 AS "start_index",  48750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0056_run_id" WHERE "run_id" >=  39001 AND "run_id" <  48751 UNION ALL
        SELECT  48751 AS "start_index",  58500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0056_run_id" WHERE "run_id" >=  48751 AND "run_id" <  58501 UNION ALL
        SELECT  58501 AS "start_index",  68250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0056_run_id" WHERE "run_id" >=  58501 AND "run_id" <  68251 UNION ALL
        SELECT  68251 AS "start_index",  78000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0056_run_id" WHERE "run_id" >=  68251 AND "run_id" <  78001 UNION ALL
        SELECT  78001 AS "start_index",  87750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0056_run_id" WHERE "run_id" >=  78001 AND "run_id" <  87751 UNION ALL
        SELECT  87751 AS "start_index",  97500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0056_run_id" WHERE "run_id" >=  87751 AND "run_id" <  97501 UNION ALL
        SELECT  97501 AS "start_index", 107250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0056_run_id" WHERE "run_id" >=  97501 AND "run_id" < 107251 UNION ALL
        SELECT 107251 AS "start_index", 117000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0056_run_id" WHERE "run_id" >= 107251 AND "run_id" < 117001 UNION ALL
        SELECT 117001 AS "start_index", 126750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0056_run_id" WHERE "run_id" >= 117001 AND "run_id" < 126751 UNION ALL
        SELECT 126751 AS "start_index", 136500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0056_run_id" WHERE "run_id" >= 126751 AND "run_id" < 136501 UNION ALL
        SELECT 136501 AS "start_index", 146250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0056_run_id" WHERE "run_id" >= 136501 AND "run_id" < 146251 UNION ALL
        SELECT 146251 AS "start_index", 156000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0056_run_id" WHERE "run_id" >= 146251 AND "run_id" < 156001 UNION ALL
        SELECT 156001 AS "start_index", 165750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0056_run_id" WHERE "run_id" >= 156001 AND "run_id" < 165751 UNION ALL
        SELECT 165751 AS "start_index", 175500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0056_run_id" WHERE "run_id" >= 165751 AND "run_id" < 175501 UNION ALL
        SELECT 175501 AS "start_index", 185250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0056_run_id" WHERE "run_id" >= 175501 AND "run_id" < 185251 UNION ALL
        SELECT 185251 AS "start_index", 195000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0056_run_id" WHERE "run_id" >= 185251 AND "run_id" < 195001
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
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0056_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0056_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0056_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0056_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0056";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0056_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0056_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0056_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0056_missing_run_ids";

-- 1-pct table
CREATE VIEW "sensitivity_runs"."output_table_0056_1pct" AS SELECT a.* FROM "sensitivity_runs"."output_table_0056" a RIGHT JOIN (SELECT GENERATE_SERIES(0, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0056_progress")) AS "run_id" ORDER BY RANDOM() LIMIT (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0056_progress") / 100.0) b ON a."run_id" = b."run_id";
--\COPY (SELECT * FROM "sensitivity_runs"."output_table_0056_1pct") TO 'sensitivity_runs.output_table_0056_1pct.csv' WITH CSV HEADER DELIMITER ','
--zip -m sensitivity_runs.output_table_0056_1pct.zip sensitivity_runs.output_table_0056_1pct.csv
--scp dhetting@walter.nrel.gov:/srv/data/wte/sensitivity_runs.output_table_0056_1pct.csv.zip ~/Box\ Sync/WESyS_Project/data_wte/sensitivity_runs.output_table_0056_1pct.csv.zip
