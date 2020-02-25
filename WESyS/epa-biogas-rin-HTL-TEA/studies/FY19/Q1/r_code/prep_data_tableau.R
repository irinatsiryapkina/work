
library (data.table)
library (dplyr)
library (bit64)
library(tidyr)

out.data <- data.table::fread ("~/Documents/WTE/WESyS data tableau/sensitivity_runs.output_table_0057_1pct.csv")#faster load for large files ~ RAM
out <- out.data[grep("output_fy19q1", out.data$source), ]
#out <- htl.factors [htl.factors$V1 %like% "HTL", ]

output.factors <- as.data.table (unique (out$factor))
select.factors <-  output.factors[output.factors$V1 %like% "pro", ] #dplr wrapper for grep
prod.out <- subset (out, out$factor %in% select.factors$V1)

sep_factor <- prod.out %>% separate(factor, c("Module", "Variable"), sep="[.]")
sep_module <- sep_factor %>% separate(Module, c("Region", "Energy Type"), sep=" ")
sep_variable <- sep_module %>% separate(Variable, c("var", "type"), sep="\\[")
sep_size <- sep_variable %>% separate(type, c("array1", "array2"), sep=", ")
sep_bracket <- sep_size %>% separate(array2, c("array2", "bracket"), sep="\\]")
sep_bracket <- sep_bracket %>% separate(array1, c("array1", "bracket1"), sep="\\]")

total_energy <- sep_bracket[sep_bracket$var == 'total energy prod', ]
# energy.tot <- aggregate(total_energy$value, 
#                         by=list(run_id=total_energy$run_id, 
#                                 time=total_energy$time, 
#                                 source=total_energy$source,
#                                 run_config=total_energy$run_config
#                                 ), 
#                         FUN=sum)

colnames(total_energy)[colnames(total_energy)=="value"] <- "x"
energy_tot_sub <- subset(total_energy, select=c("run_id", "x", "time"))  
energy.wtot <- merge(sep_bracket, energy_tot_sub, by=c("run_id", "time"))

write.csv(energy.wtot, file = "~/Documents/WTE/WESyS data tableau/output_table_0057_1pct_split_var_fy19output_wtot.csv")
