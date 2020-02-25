#pull default input data for CA and ROTUS modules
rm (list = ls()) 

library (data.table)
library (dplyr)
library (RPostgreSQL)
library (dbplyr)
library (rstudioapi)

options (stringsAsFacors = FALSE)
options (scipen = 999)

setwd ("~/GitHub/epa-biogas-rin/studies/FY19/Q1/src/")

username = "dinman"

# Connect to database 
con <- DBI::dbConnect (RPostgreSQL::PostgreSQL(),
                         host = "walter",
                         dbname = "wte",
                         schema = "ca/rotus",
                         user = username,
                         #password = pwd
                         password = rstudioapi::askForPassword("Database password")
)
  
db_list_tables(con)

dbGetQuery(con, "SELECT nspname FROM pg_catalog.pg_namespace")

# Create string for SQL selection 
  q1 <- ('SELECT "run_id", "factor", "time", "value" FROM "sensitivity_runs"."output_table" WHERE "time" = 2040 AND "run_config" = ')
  q2 <- paste(q1, run_config_num, sep = "")
  
  # Execute SQL and save results 
  outputs <- tbl(con, sql(q2))
  print("Collecting results from database using the following query:")
  print(q2)
  out <- collect (outputs, n = Inf)
  out <- as.data.table (out)
  save (out, file = output_filepath)
  
  rm (out, outputs)
  
  dbDisconnect(con)
}
