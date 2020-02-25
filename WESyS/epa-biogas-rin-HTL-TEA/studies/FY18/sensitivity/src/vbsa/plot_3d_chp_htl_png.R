library(plotly)

load("/Users/aeberle/Box Sync/WESyS_Project/Study_Designs/FY18/vbsa_design/vbsa.sludge.ca.fixedfactor/sobol.design.ca.sludge.vbsa.sludge.ca.fixedfactor.RDA")
load("/Users/aeberle/Box Sync/WESyS_Project/data_wte/vbsa/ca/sludge/fixedfactor/wesys_results/vbsa.ca.sludge.fixedfactor.wesys.results.timeseries.RDA")

wwtp.out <- out[grep('tot', out$factor), ]
wwtp.out <- wwtp.out[grep('WWTP', wwtp.out$factor), ]
wwtp.out.100 <- wwtp.out[which(wwtp.out$run_id < 101), ]

wwtp.100.chp <- wwtp.out.100[grep('CHP', wwtp.out.100$factor), ]
wwtp.100.png <- wwtp.out.100[grep('PNG', wwtp.out.100$factor), ]
wwtp.100.htl <- wwtp.out.100[grep('HTL', wwtp.out.100$factor), ]

wwtp.100.join <- merge(wwtp.100.chp, wwtp.100.png, by="run_id")
wwtp.100.join <- merge(wwtp.100.join, wwtp.100.htl, by="run_id")

plot_ly(x = wwtp.100.join$value.x, y = wwtp.100.join$value.y, z = wwtp.100.join$value, type = 'mesh3d') %>% 
  layout(scene = list(xaxis = list(title = "CHP (GJ)"),
                      yaxis = list(title = "PNG (GJ)"),
                      zaxis = list(title = "HTL (GJ)")))

vbsa.design.100 <- vbsa.design[which(vbsa.design$run < 101), ]
#toMatch <- c("WWTP.frac organics from SB", "WWTP.digester biogas yield", "Global Inputs.conversion efficiencies[PNG]")
#vbsa.SB <- vbsa.design.100[grep(paste(toMatch,collapse="|"), vbsa.design.100$variable, value=TRUE)]
vbsa.SB <- vbsa.design.100[grep("WWTP.frac organics from SB", vbsa.design.100$variable), ]
vbsa.bio_yield <- vbsa.design.100[grep("WWTP.digester biogas yield", vbsa.design.100$variable), ]
vbsa.conv_eff_png <- vbsa.design.100[grep("Global Inputs.conversion efficiencies[PNG]", vbsa.design.100$variable), ]

wwtp.out.100.tot <- aggregate(wwtp.out.100$value, by=list(run_id=wwtp.out.100$run_id), FUN=sum)

vbsa.SB$run_id <- vbsa.SB$run
vbsa.bio_yield$run_id <- vbsa.bio_yield$run

wwtp.variable.tot.100 <- merge(vbsa.SB, wwtp.out.100.tot, by="run_id")
wwtp.variable.tot.100 <- merge(wwtp.variable.tot, vbsa.bio_yield, by="run_id")

plot_ly(x = wwtp.variable.tot.100$value.x, y = wwtp.variable.tot.100$value.y, z = wwtp.variable.tot.100$x, type = 'mesh3d') %>% 
  layout(scene = list(xaxis = list(title = "SB 1383 go to POTW"),
                      yaxis = list(title = "digester biogas yield "),
                      zaxis = list(title = "total energy production sludge (GJ)")))


# get all data not just first 100 results
wwtp.out <- out[grep('tot', out$factor), ]
wwtp.out <- wwtp.out[grep('WWTP', wwtp.out$factor), ]

wwtp.chp <- wwtp.out[grep('CHP', wwtp.out$factor), ]
wwtp.png <- wwtp.out[grep('PNG', wwtp.out$factor), ]
wwtp.htl <- wwtp.out[grep('HTL', wwtp.out$factor), ]

wwtp.join <- merge(wwtp.chp, wwtp.png, by="run_id")
wwtp.join <- merge(wwtp.join, wwtp.htl, by="run_id")

plot_ly(x = wwtp.join$value.x, y = wwtp.join$value.y, z = wwtp.join$value, type = 'mesh3d') %>% 
  layout(scene = list(xaxis = list(title = "CHP (GJ)"),
                      yaxis = list(title = "PNG (GJ)"),
                      zaxis = list(title = "HTL (GJ)")))

vbsa.SB <- vbsa.design[grep("WWTP.frac organics from SB", vbsa.design$variable), ]
vbsa.bio_yield <- vbsa.design[grep("WWTP.digester biogas yield", vbsa.design$variable), ]
vbsa.conv_eff_png <- vbsa.design[grep("Global Inputs.conversion efficiencies[PNG]", vbsa.design$variable), ]



vbsa.SB$run_id <- vbsa.SB$run
vbsa.bio_yield$run_id <- vbsa.bio_yield$run

wwtp.variable.tot <- merge(vbsa.SB, wwtp.out.tot, by="run_id")
wwtp.variable.tot <- merge(wwtp.variable.tot, vbsa.bio_yield, by="run_id")

plot_ly(x = wwtp.variable.tot$value.x, y = wwtp.variable.tot$value.y, z = wwtp.variable.tot$x, type = 'mesh3d') %>% 
  layout(scene = list(xaxis = list(title = "SB 1383 go to POTW"),
                      yaxis = list(title = "digester biogas yield "),
                      zaxis = list(title = "total energy production sludge (GJ)")))



