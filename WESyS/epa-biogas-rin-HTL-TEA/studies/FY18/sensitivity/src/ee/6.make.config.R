#D. Inman
#12.12.2017
#EE analysis

rm(list=ls())
R_LIBS= ("/home/R/library")
options(scipen=999) #turn scientific notation off
options(stringsAsFactors = FALSE)
setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/ee/")
#dir.create ("for.vbsa")

library (dplyr)
library (data.table)


rda_results_folder = "~/Box Sync/WESyS Project/RDA_result_files"

#load ("results/ca.sludge.sig.factors.RDA") #load the significant factors from ee
#biogas

load (paste0 (rda_results_folder, "/2000traj/ee_results_from_step4/sig.ee.results.rotus.biogas.2000traj.RDA")) #load the significant factors from ee

wb <- read.csv ("designs/rotus.2000traj.ee.study.design.csv")
vars <- wb

sig.factors <- subset (sig.factors[[1]], std.errors < .25)

setorder (sig.factors, -mu.star)

write.csv (sig.factors[1:50, ], file = "sig.factors.25.rotus.biogas.csv")

ee.config <- data.table (factor = vars$factor, model.value = vars$value, 
                         min = vars$min, max = vars$max)

new.config <- merge (sig.factors, ee.config)

save (new.config, file = "for.vbsa/vbsa.rotus.biogas.config.RDA")
write.csv (new.config, file = "for.vbsa/vbsa.rotus.biogas.config.csv")


#sludge

load (paste0 (rda_results_folder, "/2000traj/ee_results_from_step4/sig.ee.results.rotus.sludge.2000traj.RDA")) #load the significant factors from ee

wb <- read.csv ("designs/rotus.2000traj.ee.study.design.csv")
vars <- wb

sig.factors <- as.data.table (subset (sig.factors[[8]], std.errors < .5))

sig.factors <- setorder (sig.factors, -mu.star)

sig.factors <- data.table (factor = sig.factors$factor)

sig.factors <- sig.factors [!grep ("CAFO", sig.factors$factor), ] 

sig.factors <- sig.factors [!grep ("LF", sig.factors$factor), ] 

write.csv (sig.factors[1:50, ], file = "sig.factors.25.rotus.sludge.csv")


ee.config <- data.table (factor = vars$factor, model.value = vars$value, 
                         min = vars$min, max = vars$max)

new.config <- merge (sig.factors, ee.config)

save (new.config, file = "for.vbsa/vbsa.rotus.sludge.config.RDA")
write.csv (new.config, file = "for.vbsa/vbsa.rotus.sludge.config.csv")
