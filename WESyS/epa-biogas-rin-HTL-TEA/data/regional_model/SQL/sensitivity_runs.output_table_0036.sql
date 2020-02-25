-- create table
DROP   TABLE IF EXISTS "sensitivity_runs"."output_table_0036" CASCADE;
CREATE TABLE           "sensitivity_runs"."output_table_0036" (CONSTRAINT "output_table_0036_run_config_check" CHECK ("run_config" = 36)) INHERITS ("sensitivity_runs"."output_table");

-- add primary key constraints
ALTER  TABLE "sensitivity_runs"."output_table_0036" ADD CONSTRAINT "pkey_output_table_0036" PRIMARY KEY ("gid");

-- add indices
CREATE INDEX "idx_output_table_0036_factor_btree" ON "sensitivity_runs"."output_table_0036" USING BTREE ("factor");
CREATE INDEX "idx_output_table_0036_run_id_btree" ON "sensitivity_runs"."output_table_0036" USING BTREE ("run_id");
CREATE INDEX "idx_output_table_0036_brin_time"    ON "sensitivity_runs"."output_table_0036" USING BRIN  ("time");


-- check for records where run_id != factor 'run_id'
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0036_invalid_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0036_invalid_run_id" AS (
	SELECT DISTINCT "run_id"
	FROM "sensitivity_runs"."output_table_0036"
	WHERE "run_id" != "value"::INT
	  AND "factor" = 'run_id'
);


-- gather run_id counts
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."output_table_0036_run_id" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."output_table_0036_run_id" AS (
	SELECT "run_id"
    	 , COUNT("run_id") AS "count"
	FROM "sensitivity_runs"."output_table_0036"
	GROUP BY "run_id"
);


-- check counts by subset
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0036_progress" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0036_progress" AS (
	WITH x AS (
        SELECT      1 AS "start_index",  36750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0036_run_id" WHERE "run_id" >=      1 AND "run_id" <  36751 UNION ALL
        SELECT  36751 AS "start_index",  73500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0036_run_id" WHERE "run_id" >=  36751 AND "run_id" <  73501 UNION ALL
        SELECT  73501 AS "start_index", 110250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0036_run_id" WHERE "run_id" >=  73501 AND "run_id" < 110251 UNION ALL
        SELECT 110251 AS "start_index", 147000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0036_run_id" WHERE "run_id" >= 110251 AND "run_id" < 147001 UNION ALL
        SELECT 147001 AS "start_index", 183750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0036_run_id" WHERE "run_id" >= 147001 AND "run_id" < 183751 UNION ALL
        SELECT 183751 AS "start_index", 220500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0036_run_id" WHERE "run_id" >= 183751 AND "run_id" < 220501 UNION ALL
        SELECT 220501 AS "start_index", 257250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0036_run_id" WHERE "run_id" >= 220501 AND "run_id" < 257251 UNION ALL
        SELECT 257251 AS "start_index", 294000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0036_run_id" WHERE "run_id" >= 257251 AND "run_id" < 294001 UNION ALL
        SELECT 294001 AS "start_index", 330750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0036_run_id" WHERE "run_id" >= 294001 AND "run_id" < 330751 UNION ALL
        SELECT 330751 AS "start_index", 367500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0036_run_id" WHERE "run_id" >= 330751 AND "run_id" < 367501 UNION ALL
        SELECT 367501 AS "start_index", 404250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0036_run_id" WHERE "run_id" >= 367501 AND "run_id" < 404251 UNION ALL
        SELECT 404251 AS "start_index", 441000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0036_run_id" WHERE "run_id" >= 404251 AND "run_id" < 441001 UNION ALL
        SELECT 441001 AS "start_index", 477750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0036_run_id" WHERE "run_id" >= 441001 AND "run_id" < 477751 UNION ALL
        SELECT 477751 AS "start_index", 514500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0036_run_id" WHERE "run_id" >= 477751 AND "run_id" < 514501 UNION ALL
        SELECT 514501 AS "start_index", 551250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0036_run_id" WHERE "run_id" >= 514501 AND "run_id" < 551251 UNION ALL
        SELECT 551251 AS "start_index", 588000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0036_run_id" WHERE "run_id" >= 551251 AND "run_id" < 588001 UNION ALL
        SELECT 588001 AS "start_index", 624750 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0036_run_id" WHERE "run_id" >= 588001 AND "run_id" < 624751 UNION ALL
        SELECT 624751 AS "start_index", 661500 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0036_run_id" WHERE "run_id" >= 624751 AND "run_id" < 661501 UNION ALL
        SELECT 661501 AS "start_index", 698250 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0036_run_id" WHERE "run_id" >= 661501 AND "run_id" < 698251 UNION ALL
        SELECT 698251 AS "start_index", 735000 AS "end_index", MIN("run_id") AS "min_run_id", MAX("run_id") AS "max_run_id", COUNT(DISTINCT "run_id") AS "num_runs_completed" FROM "sensitivity_runs"."output_table_0036_run_id" WHERE "run_id" >= 698251 AND "run_id" < 735001
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
DROP   MATERIALIZED VIEW IF EXISTS "sensitivity_runs"."run_config_0036_missing_run_ids" CASCADE;
CREATE MATERIALIZED VIEW           "sensitivity_runs"."run_config_0036_missing_run_ids" AS (
	WITH "expected" AS (SELECT GENERATE_SERIES(1, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0036_progress")) AS "run_id")
	SELECT a."run_id"
	FROM "expected" a
	FULL JOIN "sensitivity_runs"."output_table_0036_run_id" b ON a."run_id" = b."run_id"
	WHERE b."run_id" IS NULL
	ORDER BY a."run_id"
);


-- polish table
--VACUUM FULL ANALYZE "sensitivity_runs"."output_table_0036";

--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0036_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."output_table_0036_invalid_run_id";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0036_progress";
--REFRESH MATERIALIZED VIEW "sensitivity_runs"."run_config_0036_missing_run_ids";

-- 1-pct table
CREATE VIEW "sensitivity_runs"."output_table_0036_1pct" AS SELECT a.* FROM "sensitivity_runs"."output_table_0036" a RIGHT JOIN (SELECT GENERATE_SERIES(0, (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0036_progress")) AS "run_id" ORDER BY RANDOM() LIMIT (SELECT MAX("end_index") FROM "sensitivity_runs"."run_config_0036_progress") / 100.0) b ON a."run_id" = b."run_id";
--\COPY (SELECT * FROM "sensitivity_runs"."output_table_0036_1pct") TO 'sensitivity_runs.output_table_0036_1pct.csv' WITH CSV HEADER DELIMITER ','
--zip -m sensitivity_runs.output_table_0036_1pct.zip sensitivity_runs.output_table_0036_1pct.csv
--scp dhetting@walter.nrel.gov:/srv/data/wte/sensitivity_runs.output_table_0036_1pct.zip ~/Box\ Sync/WESyS_Project/data_wte/sensitivity_runs.output_table_0036_1pct.csv.zip
