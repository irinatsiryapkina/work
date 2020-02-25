# Warning messages:
#   1: In `[<-.data.table`(x, j = name, value = value) :
#   Supplied 32760000 items to be assigned to 1170000 items of column 'value' (31590000 unused)
# 2: In `[<-.data.table`(x, j = name, value = value) :
#   Coerced 'integer' RHS to 'double' to match the column's type. Either change the target column ['value'] to 'integer' first (by creating a new 'integer' vector length 1170000 (nrows of entire table) and assign that; i.e. 'replace' column), or coerce RHS to 'double' (e.g. 1L, NA_[real|integer]_, as.*, etc) to make your intent clear and for speed. Or, set the column type correctly up front when you create the table and stick to it, please.

rm(list=ls())
R_LIBS = ("/home/R/library") # set path for R libraries 
options(scipen=999) # turn scientific notation off
options(stringsAsFactors = FALSE) # turn off representing strings as factors

library(RColorBrewer)
library(ggplot2)

# Source R script config file and define variables from file 
config_file = "~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/ee/ee_vbsa_config.R"
source(config_file)
define.variables()

# Set working directory for EE and source EE scripts 
setwd(vbsa_working_directory)
source(paste(vbsa_working_directory, "load.R",  sep="/"))
source(paste(vbsa_working_directory, "1.sobol.design.R", sep="/"))
source(paste(vbsa_working_directory, "1.fast.design.R", sep="/"))
source(paste(vbsa_working_directory, "2.get.data.R", sep="/"))
source(paste(vbsa_working_directory, "3.define.sets.R", sep="/"))
source(paste(vbsa_working_directory, "4.vbsa.R", sep="/"))
vbsa_run_config_num <- 56 #54 # 8 = ca sludge vbsa; 9 = ca biogas vbsa; 6 = rotus ee; 7 = ca ee; 10 = rotus sludge vbsa; 11 = rotus biogas vbsa; 17 = ca.sludge.fixedfactor
# 22 = vbsa.biogas.ca.fixedfactornew; 21 = vbsa.sludge.ca.fixedfactornew; 24 = vbsa.biogas.rotus.fixedfactornew; 23 = vbsa.sludge.rotus.fixedfactornew
# 25 = fast.biogas.ca.fixedfactornew; 26 = fast.sludge.ca.fixedfactornew; 27 = fast.biogas.rotus.fixedfactornew; 28 = fast.sludge.rotus.fixedfactornew
# 53 = 25sept2018 CA
# 54 = 25sept2018 ROTUS
num_boot <- 5000

#energy_type_list <- list("CNG", "PNG", "HTL", "CHP", "Elec", "NoWTE", "total") # sludge
#"WWTP.CNG", "WWTP.PNG", "WWTP.HTL", "WWTP.CHP", "WWTP.Elec", "WWTP.NoWTE", 
#"LF.CNG", "LF.PNG", "LF.CHP", "LF.Elec", "LF.NoWTE",
#"CAFO.CNG", "CAFO.PNG", "CAFO.HTL", "CAFO.CHP", "CAFO.Elec", "CAFO.NoWTE",
energy_type_list <- list( 'CA WWTP.total energy', 'CA CAFO.total energy', 'CA LF.total energy',
                          'ROTUS WWTP.total energy', 'ROTUS CAFO.total energy', 'ROTUS LF.total energy', 
                          'Global Outputs.global total energy prod by config\\[HTL\\]',
                          'Global Outputs.global total energy prod by config\\[PNG\\]',
                          'Global Outputs.global total energy prod by config\\[CNG\\]',
                          'Global Outputs.global total energy prod by config\\[CHP\\]',
                          'Global Outputs.global total energy prod by config\\[Elec\\]',
                          'CA WWTP.yrly energy prodn by config\\[HTL\\]',
                          'CA CAFO.yrly energy prodn by config\\[HTL\\]',
                          'ROTUS WWTP.yrly energy prodn by config\\[HTL\\]',
                          'ROTUS CAFO.yrly energy prodn by config\\[HTL\\]'
                          )

                         # 'CA WWTP.yrly energy prodn by config[HTL]',
                         # 'CA CAFO.yrly energy production by config[HTL]',
                         # 'CA LF.yrly energy production by config[HTL]',                         
                         # 'ROTUS WWTP.yrly energy production by config[HTL]',
                         # 'ROTUS CAFO.yrly energy production by config[HTL]',
                         # 'ROTUS LF.yrly energy production by config[HTL]')

                         # 
                         # 'CHP.total', 'CNG.total', 'PNG.total', 'HTL.total', 'Elec.total',
                         # 'biogas.total',
                         # "WWTP.CNG", "WWTP.PNG", "WWTP.HTL", "WWTP.CHP", "WWTP.Elec",
                         # "LF.CNG", "LF.PNG", "LF.CHP", "LF.Elec",
                         # "CAFO.CNG", "CAFO.PNG", "CAFO.HTL", "CAFO.CHP", "CAFO.Elec")

#source(paste(vbsa_working_directory, "color_scale_vbsa.R", sep="/"))
load("/Users/aeberle/Box Sync/WESyS_Project/data_wte/vbsa/plotting/colorscale_joined.RDA")

for (region in region_list){
  
  for (type in type_list) {
    print(region)
    print(type)
    #
    # These sections are commented because they've already been run for the two CA VBSA studies and the data should be stored in Box
    # Uncomment if you need to create the design, pull the data from the database or define the sets 
    #
    # Design VBSA study 
    #design.vbsa.study(region, type, vbsa_study_extension, config_file)
    #design.fast.study(region, type, vbsa_study_extension, config_file)
    
    # Get WESyS simulation results from database
    vbsa_output_filename = paste("vbsa", region, type, vbsa_study_extension, "wesys.results.timeseries.RDA", sep=".")
    vbsa_output_filepath = paste(root_data_path, "vbsa", region, type, vbsa_study_extension, wesys_results_folder, vbsa_output_filename, sep="/")
    #get.data(region, type, vbsa_study_extension, vbsa_run_config_num, config_file, vbsa_output_filepath)

    # Select metrics of interest for VBSA study
    #define.sets(vbsa_output_filepath, energy_type_list)

    # Compute sensitivity indices and bootstrap results
    for (energy_type in energy_type_list) {
     print(energy_type)
     get.sensi.indices(region, type, config_file, num_boot, energy_type, colScale)
    }

  }
}

source(paste(vbsa_working_directory, 'ppt_export', 'create_ppt.R', sep='/'))



