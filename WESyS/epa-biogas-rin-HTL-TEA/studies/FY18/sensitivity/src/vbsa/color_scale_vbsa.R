# Create custom color scale for plotting

rotus_sludge_design <- read.csv("/Users/aeberle/Box Sync/WESyS_Project/Study_Designs/FY19/vbsa_design_configs/vbsa.all.joined.q1_12factors_31oct.csv")#read.csv("/Users/aeberle/Box Sync/WESyS_Project/Study_Designs/FY18/vbsa_design_configs/vbsa.biogas.rotus.9aug2018.csv")
ca_sludge_design <- read.csv("/Users/aeberle/Box Sync/WESyS_Project/Study_Designs/FY19/vbsa_design_configs/vbsa.all.joined.q1_12factors_31oct.csv")#read.csv("/Users/aeberle/Box Sync/WESyS_Project/Study_Designs/FY18/vbsa_design_configs/vbsa.biogas.ca.9aug2018.csv")
#rotus_htl_sludge_design <-read.csv("/Users/aeberle/Box Sync/WESyS_Project/Study_Designs/FY18/vbsa_design_configs/vbsa.sludge.rotus.htl.4jun.csv")

variable_list <- unique(rotus_sludge_design$factor)
variable_list <- append(variable_list, unique(ca_sludge_design$factor))
#variable_list <- append(variable_list, unique(rotus_htl_sludge_design$factor))

unique_factors <- as.factor(unique(variable_list))
unique_factors <- as.data.frame(unique_factors)

#http://www.stat.columbia.edu/~tzheng/files/Rcolor.pdf
color <- grDevices::colors()[grep('gr(a|e)y', grDevices::colors(), invert = T)]
color2 <- color[grep('light', color, invert=T)]
color3 <- color2[grep('snow', color2, invert=T)]
color3 <- color3[grep('honeydew', color3, invert=T)]
color3 <- color3[grep('blanched', color3, invert=T)]
color3 <- color3[grep('ivory', color3, invert=T)]
color3 <- color3[grep('beige', color3, invert=T)]
color3 <- color3[grep('white', color3, invert=T)]
color3 <- color3[grep('cornsilk', color3, invert=T)]
color3 <- color3[grep('lavender', color3, invert=T)]
color3 <- color3[grep('brown', color3, invert=T)]
color3 <- color3[grep('khaki', color3, invert=T)]
color3 <- color3[grep('gold', color3, invert=T)]
color3 <- color3[grep('azure', color3, invert=T)]
color3 <- color3[grep('linen', color3, invert=T)]
color3 <- color3[grep('lace', color3, invert=T)]
color3 <- color3[grep('mint', color3, invert=T)]
color3 <- color3[grep('alice', color3, invert=T)]
color3 <- color3[grep('misty', color3, invert=T)]
color3 <- color3[grep('whip', color3, invert=T)]
color3 <- color3[grep('puff', color3, invert=T)]
color3 <- color3[grep('wheat', color3, invert=T)]
color3 <- color3[grep('seashell', color3, invert=T)]
color3 <- color3[grep('bisque', color3, invert=T)]
color3 <- color3[grep('moccasin', color3, invert=T)]
color3 <- color3[grep('navyblue', color3, invert=T)]
color3 <- color3[grep('mediumblue', color3, invert=T)]
color3 <- color3[grep('blue3', color3, invert=T)]
color3 <- color3[grep('blue4', color3, invert=T)]
color3 <- color3[grep('lemonchiffon', color3, invert=T)]
color3 <- color3[grep('gainsboro', color3, invert=T)]
color3 <- color3[grep('lawngreen', color3, invert=T)]
color3 <- color3[grep('darkolivegreen', color3, invert=T)]
color3 <- color3[grep('greenyellow', color3, invert=T)]
color3 <- color3[grep('lightgreen', color3, invert=T)]
color3 <- color3[grep('darkorchid', color3, invert=T)]
color3 <- color3[grep('1', color3, invert=T)]
color3 <- color3[grep('2', color3, invert=T)]

myColors <- sample(color3, nrow(unique_factors))  #topo.colors(nrow(unique_factors))
names(myColors) <- levels(unique_factors$unique_factors)
colScale <- scale_colour_manual(name="variable", values=myColors)
save(myColors, colScale, file="/Users/aeberle/Box Sync/WESyS_Project/data_wte/vbsa/plotting/colorscale_joined.RDA")
