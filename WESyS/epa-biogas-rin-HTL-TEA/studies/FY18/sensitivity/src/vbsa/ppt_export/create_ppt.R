# Import libraries 
library(officer)
library(magrittr)

# Define file paths
vbsa_working_directory <- "~/GitHub/epa-biogas-rin/studies/FY19/sensitivity/src/vbsa"
figures_folder
ppt_directory <- "~/Documents/WTE/ppt_testing"
ppt_template_filename <- "milestone_template.pptx"
output_ppt_filename <- "q1_fy19_r_auto.pptx"
figures_path <- list()
figures_path['joined'] <- paste(root_data_path, "vbsa", "joined", type, vbsa_study_extension, "figures", sep='/')

#figures_path['ca'] <- paste(root_data_path, "vbsa", "ca", type, vbsa_study_extension, "figures", sep='/')
#figures_path['rotus'] <- paste(root_data_path, "vbsa",  "rotus", type, vbsa_study_extension, "figures", sep='/')

# Create lists for looping through figures
region_list <- list("joined")

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
#energy_type_list <- list('biogas.total', 'WWTP.total energy', 'CAFO.total energy', 'LF.total energy', 'CHP.total', 'CNG.total', 'PNG.total', 'HTL.total', 'Elec.total')

# Read in ppt template
template_file <- paste(ppt_directory, ppt_template_filename, sep='/')
my_pres <- read_pptx(template_file)

# Loop through energy types and regions and add a total effects slide for each
for (energy_type in energy_type_list) {
  for (region in region_list) {
    filename <- paste(region, energy_type, "Sti.png", sep='.')
    img.file <- file.path(paste(file.path(figures_path[region]), filename, sep='/'))
    title <- paste("Total Effects Results for", toupper(region))
    my_pres <- my_pres %>% 
      add_slide(layout = "Simple Slide - Text 2", master = "Office Theme") %>%
      ph_with_text(type = "title", str = title, index=1) %>%
      #ph_with_text(type = "body", str = "body (index 1) is text", index = 2) %>% 
      ph_with_img(type = "body", index = 2, src = img.file)#, height = 3.35, width = 7.71)
  }
}

# Add end slide 
my_pres <- my_pres %>% 
  add_slide(layout = "End Slide", master = "Office Theme") %>%
  ph_with_text(type = "body", str = "Thank you!", index = 4) %>%
  ph_with_text(type = "body", str = "This work was authored by the National Renewable Energy Laboratory, operated by Alliance for Sustainable Energy, LLC, for the U.S. Department of Energy (DOE) under Contract No. DE-AC36-08GO28308. Funding provided by U.S. Department of Energy Office of Energy Efficiency and Renewable Energy Bioenergy Technologies Office. The views expressed in the article do not necessarily represent the views of the DOE or the U.S. Government. The U.S. Government retains and the publisher, by accepting the article for publication, acknowledges that the U.S. Government retains a nonexclusive, paid-up, irrevocable, worldwide license to publish or reproduce the published form of this work, or allow others to do so, for U.S. Government purposes."
               , index = 2) 

# Add transition slide for first-order back-up slides
my_pres <- my_pres %>% 
  add_slide(layout = "Transition Slide - Blue", master = "Office Theme") %>%
  ph_with_text(type = "body", str = "Back-up Slides", index = 3) %>%
  ph_with_text(type = "body", str = "First-Order Indicies", index = 1)

# Loop through energy types and regions and add a first-order effects slide for each
for (energy_type in energy_type_list) {
  for (region in region_list) {
    filename <- paste(region, energy_type, "Si.png", sep='.')
    img.file <- file.path(paste(file.path(figures_path[region]), filename, sep='/'))
    title <- paste("First-Order Effects Results for", toupper(region))
    my_pres <- my_pres %>%
      add_slide(layout = "Simple Slide - Text 2", master = "Office Theme") %>%
      ph_with_text(type = "title", str = title, index=1) %>%
      #ph_with_text(type = "body", str = "body (index 1) is text", index = 2) %>%
      ph_with_img(type = "body", index = 2, src = img.file)#, height = 3.35, width = 7.71)
  }
}

# Add transition slide for second-order back-up slides 
my_pres <- my_pres %>%
  add_slide(layout = "Transition Slide - Blue", master = "Office Theme") %>%
  ph_with_text(type = "body", str = "Back-up Slides", index = 3) %>%
  ph_with_text(type = "body", str = "Second-Order Indicies", index = 1)

# Loop through energy types and regions and add a second-order effects slide for each
# all of these are zero so I've commented this out for now 
# for (energy_type in energy_type_list) {
#   for (region in region_list) {
#     filename <- paste(region, energy_type, "Sij.png", sep='.')
#     img.file <- file.path(paste(file.path(figures_path[region]), filename, sep='/'))
#     title <- paste("Second-Order Effects Results for", toupper(region))
#     my_pres <- my_pres %>%
#       add_slide(layout = "Simple Slide - Text 2", master = "Office Theme") %>%
#       ph_with_text(type = "title", str = title, index=1) %>%
#       #ph_with_text(type = "body", str = "body (index 1) is text", index = 2) %>%
#       ph_with_img(type = "body", index = 2, src = img.file)#, height = 3.35, width = 7.71)
#   }
# }

# # Create slide that describes no second-order effects for aggregated results
# my_pres <- my_pres %>%
#   add_slide(layout = "Simple Slide - Text 2", master = "Office Theme") %>%
#   ph_with_text(type = "title", str = "Second-Order Effects Results", index=1) %>%
#   ph_with_text(type = "body", str = "We did not observe any second-order effects for total energy production across all modules, total energy production by module (e.g., total energy from POTW), or total energy production by type (e.g., total energy production from CHP) in either CA or ROTUS. \rWe did, however, observe some second-order effects for specific module/energy type combinations (e.g., HTL from CAFOs)."
#                , index=2) 
second_order_energy_list <- energy_type_list
# second_order_energy_list <- list("WWTP.CNG", "WWTP.PNG", "WWTP.HTL", "WWTP.CHP", "WWTP.Elec", 
#                                  "LF.CNG", "LF.PNG", "LF.CHP", "LF.Elec", 
#                                  "CAFO.CNG", "CAFO.PNG", "CAFO.HTL", "CAFO.CHP", "CAFO.Elec")
for (energy_type in second_order_energy_list) {
  for (region in region_list) {
    filename <- paste(region, energy_type, "Sij.png", sep='.')
    img.file <- file.path(paste(file.path(figures_path[region]), filename, sep='/'))
    title <- paste("Second-Order Effects Results for", toupper(region))
    my_pres <- my_pres %>%
      add_slide(layout = "Simple Slide - Text 2", master = "Office Theme") %>%
      ph_with_text(type = "title", str = title, index=1) %>%
      ph_with_img(type = "body", index = 2, src = img.file)#, height = 3.35, width = 7.71)
  }
}

# Export presentation to ppt
output_ppt <- paste(ppt_directory, output_ppt_filename, sep='/')
print(my_pres, target = output_ppt) 
