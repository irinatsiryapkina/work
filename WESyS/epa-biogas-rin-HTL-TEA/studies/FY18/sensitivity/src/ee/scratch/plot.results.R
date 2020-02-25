#D. Inman
#12.02.2017
#EE analysis

rm(list=ls())
R_LIBS= ("/home/R/library")
options(scipen=999) #turn scientific notation off
options(stringsAsFactors = FALSE)
setwd ("~/GitHub/epa-biogas-rin/studies/FY18/sensitivity/src/ee/")

library (dplyr)
library (data.table)
library (ggplot2)

load ("data/ee.ca.wesys.results.RDA")

setorder (out, run_id, time)

ca.slg <- out [grep ("WWTP", out$factor), ] #grabbing the WWTP runs
ca.slg <- ca.slg [grep ("tot", ca.slg$factor), ] #grabbing the total energy runs
ca.slg <- ca.slg [!grep ("BC", ca.slg$factor), ] #remove BC - no production
ca.slg <- ca.slg [!grep ("CF", ca.slg$factor), ] #remove CF - no production
ca.slg <- ca.slg [!grep ("NoWTE", ca.slg$factor), ] #remove No WTE - no production

#ca.slg <- subset (ca.slg, run_id == 1)

#png (file = "test.ts.png")

#output energy units are in GJ 
#convert to Quads - 1 GJ = 9.47086 E-10 quads

quad <- 9.47086 * 10^-10 #conversion factor

ca.slg$quad <- ca.slg$value * quad

foo <- ggplot (data = ca.slg, aes (x = time, y = quad, group = interaction (run_id, factor), 
                                   color = factor)) + 
  scale_color_brewer(palette = "Set1") +
  
  geom_line (aes (alpha = .5)) + 
  labs(title = "ca.sludge.ee results", 
       x = "Simulation Year", 
       y = "energy production")
foo
#dev.off ()

#plot ca.sludge.elec
df <- subset (ca.slg, factor == "WWTP.Elec tot")

gg <- ggplot (data = df, aes (x = time, y = quad, group = interaction (run_id, factor), 
                              color = factor)) + 
  scale_color_brewer(palette = "Set1") +
  
  geom_line (aes (alpha = .5)) + 
  
  labs(title = "ca sludge Elec results", 
       x = "Simulation Year", 
       y = "energy production in quads")
gg

#plot ca.sludge.cng

df <- subset (ca.slg, factor == "WWTP.CNG tot")

gg <- ggplot (data = df, aes (x = time, y = quad, group = interaction (run_id, factor), 
                              color = factor)) + 
  scale_color_brewer(palette = "Set1") +
  
  geom_line (aes (alpha = .5)) + 
  
  labs(title = "ca sludge CNG results", 
       x = "Simulation Year", 
       y = "energy production in quads")
gg

#plot ca.sludge.png

df <- subset (ca.slg, factor == "WWTP.PNG tot")

gg <- ggplot (data = df, aes (x = time, y = quad, group = interaction (run_id, factor), 
                              color = factor)) + 
  scale_color_brewer(palette = "Set1") +
  
  geom_line (aes (alpha = .5)) + 
  
  labs(title = "ca sludge PNG results", 
       x = "Simulation Year", 
       y = "energy production in quads")
gg

#plot ca.sludge.FT

df <- subset (ca.slg, factor == "WWTP.FT tot")

gg <- ggplot (data = df, aes (x = time, y = quad, group = interaction (run_id, factor), 
                              color = factor)) + 
  scale_color_brewer(palette = "Set1") +
  
  geom_line (aes (alpha = .5)) + 
  
  labs(title = "ca sludge FT results", 
       x = "Simulation Year", 
       y = "energy production in quads")
gg

#plot ca.sludge.htl

df <- subset (ca.slg, factor == "WWTP.HTL tot")

gg <- ggplot (data = df, aes (x = time, y = quad, group = interaction (run_id, factor), 
                              color = factor)) + 
  scale_color_brewer(palette = "Set1") +
  
  geom_line (aes (alpha = .5)) + 
  
  labs(title = "ca sludge HTL results", 
       x = "Simulation Year", 
       y = "energy production in quads")
gg




