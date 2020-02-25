#biogas 

out <- read.csv("/Users/aeberle/Documents/WTE/WESyS data tableau/ca_biogas_1pct.csv")
#output <- read.csv("/Users/aeberle/Box Sync/WESyS_Project/data_wte/vbsa/ca/biogas/fixedfactornew/results/ca.biogas.total.energy.sampled.csv")
load("/Users/aeberle/Box Sync/WESyS_Project/Study_Designs/FY18/vbsa_design/vbsa.biogas.ca.fixedfactornew/sobol.design.ca.biogas.vbsa.biogas.ca.fixedfactornew.RDA")

#biogas.out <- out[grep('biogas_output', out$source)]
biogas.out <- out[grep('tot', out$factor), ]
biogas.out <- biogas.out[-grep('potential', biogas.out$factor), ]
biogas.out <- biogas.out[grep('CHP', biogas.out$factor), ]
biogas.out <- biogas.out[grep('CNG', biogas.out$factor), ]
biogas.out <- biogas.out[grep('PNG', biogas.out$factor), ]
biogas.out <- biogas.out[grep('Elec', biogas.out$factor), ]
biogas.out <- biogas.out[grep('NoWTE', biogas.out$factor), ]
#biogas.out <- biogas.out[grep(2040, biogas.out$time), ]
biogas.out["total"] <- aggregate(biogas.out$value, by=list(run_id=biogas.out$run_id), FUN=sum)

colnames(out)[which(names(out) == "factor")] <- "type_energy"
colnames(vbsa.design)[which(names(vbsa.design) == "variable")] <- "factor"
colnames(vbsa.design)[which(names(vbsa.design) == "run")] <- "run_id"

out_filtered <- merge(energy.wtot, filtered_design, by="run_id")
length(unique(out_filtered$run_id))

write.csv(x=out_filtered, file="/Users/aeberle/Box Sync/WESyS_Project/data_wte/vbsa/rotus/sludge/htl.4jun/results/design_output_rotus_sludge_2040_all_pathways.csv")


out <- read.csv("/Users/aeberle/Documents/WTE/WESyS data tableau/rotus_biogas_1pct.csv")
#output <- read.csv("/Users/aeberle/Box Sync/WESyS_Project/data_wte/vbsa/ca/biogas/fixedfactornew/results/ca.biogas.total.energy.sampled.csv")
load("/Users/aeberle/Box Sync/WESyS_Project/Study_Designs/FY18/vbsa_design/vbsa.biogas.rotus.fixedfactornew/sobol.design.rotus.biogas.vbsa.biogas.rotus.fixedfactornew.RDA")

#biogas.out <- out[grep('biogas_output', out$source)]
biogas.out <- out[grep('tot', out$factor), ]
biogas.out <- biogas.out[-grep('potential', biogas.out$factor), ]
biogas.out <- biogas.out[grep('CHP', biogas.out$factor), ]
biogas.out <- biogas.out[grep('CNG', biogas.out$factor), ]
biogas.out <- biogas.out[grep('PNG', biogas.out$factor), ]
biogas.out <- biogas.out[grep('Elec', biogas.out$factor), ]
biogas.out <- biogas.out[grep('NoWTE', biogas.out$factor), ]
biogas.out <- biogas.out[grep(2040, biogas.out$time), ]
#biogas.out["total"] <- aggregate(biogas.out$value, by=list(run_id=biogas.out$run_id), FUN=sum)

colnames(out)[which(names(out) == "factor")] <- "type_energy"
colnames(vbsa.design)[which(names(vbsa.design) == "variable")] <- "factor"
colnames(vbsa.design)[which(names(vbsa.design) == "run")] <- "run_id"

out_filtered <- merge(biogas.out, vbsa.design, by="run_id")
length(unique(out_filtered$run_id))

write.csv(x=out_filtered, file="/Users/aeberle/Box Sync/WESyS_Project/data_wte/vbsa/rotus/biogas/fixedfactornew/results/design_output_rotus_biogas_2040_all_pathways.csv")