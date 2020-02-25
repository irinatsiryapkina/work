DROP   TABLE IF EXISTS "wte"."design_config" CASCADE;
CREATE TABLE           "wte"."design_config" (
    "gid"         SERIAL  NOT NULL PRIMARY KEY
  , "name"        TEXT    NOT NULL UNIQUE
  , "description" TEXT    NOT NULL DEFAULT NOW()
  , "date_added"  DATE    NOT NULL DEFAULT NOW()
);
COMMENT ON TABLE "wte"."design_config" IS 'Available sensitivity study design configurations (collections of design_settings)';

INSERT INTO "wte"."design_config" ("name", "description")
VALUES ('~/src/epa-biogas-rin/studies/FY18/sensitivity/src/ee/designs/rotus.ee.test_rotus_25traj_2jan2017.csv', 'rotus.ee.test_rotus_25traj_2jan2017')
     , ('~/epa-biogas-rin/studies/FY18/sensitivity/src/ee/designs/ca.ee.test_ca_25traj_4jan2017.csv',           'ca.ee.test_ca_25traj_4jan2017')
     , ('~/epa-biogas-rin/studies/FY18/sensitivity/src/vbsa/input.settings/vbsa.sludge.ca.10jan.csv',           'vbsa.sludge.ca.10jan')
     , ('~/Box Sync/WESyS_Project/Study_Designs/FY18/vbsa_design_configs/vbsa.biogas.ca.20jan.csv',             'vbsa.biogas.ca.20jan')
     , ('~/Box Sync/WESyS_Project/Study_Designs/FY18/vbsa_design_configs/vbsa.sludge.rotus.5feb.csv',           'vbsa.sludge.rotus.5feb')
     , ('~/Box Sync/WESyS_Project/Study_Designs/FY18/vbsa_design_configs/vbsa.biogas.rotus.6feb.csv',           'vbsa.biogas.rotus.6feb')
     , ('~/Box Sync/WESyS_Project/Study_Designs/FY18/vbsa_design/vbsa.biogas.ca.test_3dummy_500traj.csv',       'vbsa.biogas.ca.test_3dummy_500traj')
     , ('~/Box Sync/WESyS_Project/Study_Designs/FY18/vbsa_design/vbsa.sludge.ca.test_3dummy_500traj.csv',       'vbsa.sludge.ca.test_3dummy_500traj')
     , ('~/Box Sync/WESyS_Project/Study_Designs/FY18/vbsa_design/vbsa.biogas.rotus.test_3dummy_500traj.csv',    'vbsa.biogas.rotus.test_3dummy_500traj')
     , ('~/Box Sync/WESyS_Project/Study_Designs/FY18/vbsa_design/vbsa.sludge.rotus.test_3dummy_500traj.csv',    'vbsa.sludge.rotus.test_3dummy_500traj')
;

-- @TODO: need early EE design configs
