#D. Inman
#11.21.2017
#pulling EE study results from db for analysis

rm(list=ls())
R_LIBS= ("/home/R/library")
options(scipen=999) #turn scientific notation off

# Set parameters
setwd ("~/wte")

username = "dinman"
pwd = "P0w3r0ff0ur"
study_name = "2000traj_dec"

# Load libraries 
library (dplyr)
library (RPostgreSQL)
library (dbplyr)
library (data.table)
library (rstudioapi)

# Connect to database 
con <- DBI::dbConnect (RPostgreSQL::PostgreSQL(),
                       host = "walter",
                       dbname = "wte",
                       user = username,
                       #password = pwd
                       password = rstudioapi::askForPassword("Database password")
)

# Create string for SQL selection 
  run_config_num = 4
  region = "ca"
  q1 <- ('SELECT "run_id", "factor", "time", "value" FROM "sensitivity_runs"."output_table" WHERE "time" = 2040 AND "run_config" = ')
  q2 <- paste(q1, run_config_num, sep = "")
  
  # Execute SQL and save results 
  outputs <- tbl(con, sql(q2))
  out <- collect (outputs, n = Inf)
  out <- as.data.table (out)
  save (out, file = "ee.ca.2000traj.wesys.results.RDA")
  
 
