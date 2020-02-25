#D.Inman
#12/21/2017


rm(list=ls())
R_LIBS= ("/home/R/library")
options(scipen=999) #turn scientific notation off

# Set parameters
setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/ee/")
#setwd ("~/ws/src/epa-biogas-rin/studies/FY18/sensitivity/src/ee/")
#run_config_list = list(3, 4)
#region_list = list("rotus", "ca") 
study_name = "2000traj_dec"

# Load libraries 
library (dplyr)
library (RPostgreSQL)
library (dbplyr)
library (data.table)

# Connect to database 
con <- DBI::dbConnect (RPostgreSQL::PostgreSQL(),
                       host = "walter",
                       dbname = "wte",
                       user = "dinman",
                       password = rstudioapi::askForPassword("Database password")
)

# Create string for SQL selection 
  q1 <- ('SELECT "run_id", "factor", "time", "value" FROM "sensitivity_runs"."output_table" WHERE "run_config" = 3
         AND "time" = 2040')
  
  
  # Execute SQL and save results 
  outputs <- tbl(con, sql(q1))
  out <- collect (outputs, n = Inf)
  out <- as.data.table (out)
  save (out, file = "data_wte/ee.rotus.2000traj_dec.wesys.results.RDA")
  
  
dbDisconnect(con)