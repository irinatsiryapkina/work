RESET ROLE;
ROLLBACK;

BEGIN;
SET ROLE "wte-admin";

-- @TODO: populate tables

--\ir wte.log.sql
--\ir wte.model.sql
--\ir wte.scenario.sql
--\ir wte.vignette.sql
--\ir wte.scenario_vignette.sql
--\ir wte.scenario_vignette_join.sql
--\ir wte.dimension.sql
--\ir wte.dimension_value.sql
--\ir wte.dimension_dimension_value.sql
--\ir wte.dimension_dimension_value_join.sql
--\ir wte.module.sql
--\ir wte.variable.sql
--\ir wte.variable_dimension.sql
--\ir wte.variable_dimension_join.sql
--\ir wte.design_config.sql
\ir wte.design_setting.sql  -- # @TODO: stuck on what looks like missing variable names in the design_setting files (missing there, or missing in the current version of .STMX I'm working with)
\ir wte.design_config_design_setting.sql
\ir wte.design_value.sql
\ir wte.design.sql
\ir wte.design_config_summary.sql
\ir wte.design_check.sql
\ir wte.config.sql
\ir wte.run_config.sql
\ir wte.output_table.sql
\ir wte.model_run.sql
\ir wte.sensitivity_run.sql
\ir wte.sensitivity_run_model_run.sql

COMMIT;

RESET ROLE;
