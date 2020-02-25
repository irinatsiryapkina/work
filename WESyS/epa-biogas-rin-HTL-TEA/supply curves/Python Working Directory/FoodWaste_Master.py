import pandas as pd 
import numpy as np 
import matplotlib.pyplot as plt
from random import randint
import math

fdata = pd.DataFrame(pd.read_excel('FoodWaste_Python_Input.xlsx','Python_Inputs',skiprows = 1))
fdata.set_index(['ObjectID','County_Name','State_Name','FIPS',\
	'Food_Waste_Wet_Tons','Number_Waste_Facilities','Daysperyear_Operation','Average_tipping','Labor_Rate',\
	'Diesel_Cost','Electricity_Cost','Tip_Fee_Output','Organic_Ban',\
	'Daysperyear_Operation_Output','State_Tip_Avg','Depackaging_Cost'])

def mrf(row):
	'''
	This section pulls in the input variables from the row of the pandas dataframe and re-defines them for
	use in the function. 
	'''

	# state name the county is in
	state = row.State_Name 


	# Average labor_rate by state for refuse and recylcable material collectors from BLS, 2017
	# [$/hour]
	labor_rate = row.Labor_Rate 


	#cost per gallon of diesel fuel from EIA, 2017
	# [$/gallon]
	fuel_cost = row.Diesel_Cost


	# cost per kWh of electricity_costtricity for the state, from EIA, 2017
	# [$/kWhr]
	electricity_cost  = row.Electricity_Cost


	'''
	This value is the landfill tipping fee for the county, or in other wordisc_screen,
	it is the cost per ton to dispose of materials at a waste facility.
	There are several different inputs to this value: 

	-If the waste treatment facilities in the county have tipping fees listed
	in our database, the tip fees are averaged between all of the facilities 
	in the county. 

	-If the tipping fees either equal zero or are not available for the county, or no 
	waste facilities exist in the county, we substitute the state average landfill tipping
	fee in. [$/ton]

	Please note that all of this work has been done outside of this program in GIS and excel. 
	'''
	landfill_tipping_fee  = row.Tip_Fee_Output


	'''
	Food waste production for the county, in wet tons. For this model we convert it to MG,
	since the cost curves we adopted are for estimating costs in MG's, hence the conversion factor.
	[MG]
	'''
	foodwaste = row.Food_Waste_Wet_Tons / 0.907185 


	'''
	Some states and counties across the US have implemented bans on disposing of organics in
	landfills. I have manually went in and inputted 1's for these states and counties that have bans,
	setting all other areas equal to zero. [N/A] 1=true organic ban 0=false organic ban
	'''
	organics_ban = row.Organic_Ban


	'''
	This value is the days per year that organics facilities in the county are operated. 
	Similarly to what we did for the tipping fees, if these values are given in our dataset of waste
	facilities, the model averages those available. Otherwise a value of 220 days/year is assumed.
	Please note that all of this work has been done outside of this program in GIS and excel. 
	[days/year]
	'''
	days_per_year_of_operation  = row.Daysperyear_Operation


	'''
	This is the count of qualifying waste facilities in the county. We define a qualifying facility as
	one of the following:

	-Material Recovery Facility (MRF) used to sort and recover recylable materials

	-Transfer Station (TS) transfers food waste from collection trucks to longer haul trucks for 
		transport to a landfill or MRF

	-Landfill (LF) site accepting Municipal Solid Waste for disposal
	[facilities/county]
	'''
	waste_facilities_per_county = row.Number_Waste_Facilities



	# Capital Recovery Factor. [1 / years]
	CRF = 0.130



	'''
	This is the estimated cost per wet ton to depackage food waste and
	create a slurry with the material. These operations are considered
	necessary in order to use food waste as a WTE feedisc_screentock.
	Our values used here are generated from state to state.
	[$/wet ton]
	'''
	depackaging_cost = row.Depackaging_Cost



	# county FIPS identification number for GIS mapping
	fips = row.FIPS

	# The number of hours worked in a shift at a waste management facility.
	hours_per_shift = 8.

	# The number of shifts per day at a waste management facility. 
	shifts_per_day = 2.


	if waste_facilities_per_county == 0:
		waste_facilities_per_county = 1.
	'''
	This if loop ensures that the number of waste management facilities in the county = 1,
	even if no facilities exist. This allows for computation of the amount of food waste that would be 
	treated at the theoretical waste management facility. 
	'''


	foodwaste_tons_per_year = foodwaste / waste_facilities_per_county # tons per year per facility
	foodwaste_tons_per_day = foodwaste_tons_per_year / days_per_year_of_operation # tons per day per facility
	foodwaste_tons_per_hour = foodwaste_tons_per_day / (shifts_per_day * hours_per_shift) # tons per hour
	

	if landfill_tipping_fee  == 0:
		landfill_tipping_fee  = row.State_Tip_Avg  
	''' 
	Some of the mapped waste facilities do not charge tipping fees for disposal of waste. I am 
	currently overriding any zero values for counties and substituting in the state average
	tipping fee rather than use the zero value. I am presuming that even if the site does not
	charge any tipping fees, it is more likely to charge fees for disposing of food waste 
	comingled with municipal solid waste.
	'''


	'''
	The following section develops costs for sorting and processing components of a 
	Material Recovery Facility (MRF), considering the following components:

	-Rolling stock (trucks)
	-Manual sorters
	-Magnet sorting
	-Disc screen sorting
	-Trommel sorting

	We use functions developed in Combs, 2012 and supported by 
	Pressley et al, 2015 for finding these costs. We 
	have adopted costs for a Mixed waste MRF. Full cites:

	Combs, Anthony Rush. “Life Cycle Analysis of Recycling Facilities in a Carbon Constrained World.” 
	North Carolina State University, 2012. 
	htthroughput_capacitys://repository.lib.ncsu.edu/bitstream/handle/1840.16/7808/etd.pdf?sequence=2&isAllowed=y.

	Pressley, Phillip, James Levis, Anders Damgaard, Morton A Barlaz, and Joseph F DeCarolis. 
	“Analysis of Material Recovery Facilities for Use in Life-Cycle Assessment.” 
	Waste Management 35 (2015): 307–17. doi:htthroughput_capacitys://doi.org/10.1016/j.wasman.2014.09.012.

	All of the component cost functions operate similarly to each other. They 
	define costs as a function of plant throughput capacity, defined
	by the authors as MG/day. They scale costs as a function of the amount of
	waste being sorted. I have defined an example cost component section below
	to give some background on what each of the functions are doing. the prefix 
	'tech' is used to represent the technology being considered.

	tech_capital_cost = number 
		THis is the capital cost for the equipment. [$]

	tech_throughput_capacity = number 
		When applicable, this is the throughput 
		capacity of the technology. Units can vary between 
		[MG/hour] or [MG/day]

	tech_operations_maint_cost = number
		A fixed Operations and Maintinence (O&M) cost for the technology
		per year. 

	num_tech_units = number/function
		Some cases require purchase of multiple units of the tech (e.g. trucks)
		We are assuming some of the numbers of itemanual_sorting used, while some are dependent
		on throughput capacity. 

	tech_cost_per_MG = function
		This function findisc_screen the cost per MG for the technology. We first sum the 
		costs in units of [$/year] (capital cost amortized), then divide it by the tons of food 
		waste per hour estimated for the county in the functions above. We use the 
		hours per shift, shifts per day and days per year of plant operation to put the food
		waste processed in MG/year. 

	tech_kW = number
		This is the value in kW of energy consumption of the machinery, provided by the authors.

	tech_fractional_utilization = number
		Fractional utilization of the equipment in question. In other wordisc_screen, it is a value from 
		zero to one expressing the fraction of operating hours that the equipment is used. 

	tech_electricity_cost = function
		This function brings the tech_fractional_utilization value in and relates it to the MG/hour being processed.
		Multiplying by the fractional utilization of the equipment gives the amount of electricity_costtricity 
		needed for operation in kWhr.

	tech_sorters_required = number
		number of supplemental sorter workers required for operation of that 
		particular technology. Used as an input for the operation below. 

	tech_sorters_required_per_ton= function
		number of sorter workers needed to operate the equipment in question. 
		This is a different metric from that used to estimate the additional sorters_required_per_tonneeded to operate 
		the equipment. This is the fraction of sorters_required_per_tonneeded, expressed as a function of the tons per
		hour processed by the plant. The outhroughput_capacityut units of this function are [sorters/throughput_capacityh]

	tech_fuel = number 
		This operation is specific to rolling stock cost computations. We are estimating the fuel needed to 
		operate the trucks in the sorthing facility. There are several numberical values used in these 
		calculations. The 10 is a metric relating fuel use to tons of waste [liters/MG]. The 0.264172 
		converts the liters into gallons, which is the units that our fuel cost are in. The 
		outhroughput_capacityut units of this calculation are in [$/MG].


	Also of note in this section are the two possible scenarios we have defined within the model,
	which are discussed individually below. These two scenarios attempt to capture the existing 
	waste management process within the county. We have mapped every Landfill, Material Recovery
	Facility, and Transfer Station in the country from a Waste Business Journal (2016) dataset, 
	and each county has the number of those failities within it mapped as waste_facilities_per_county. 
	
	If the number of waste_facilities_per_county equals zero, the model switches to the capital cost 
	scenario. If the number is greater than zero, it runs the add-on scenario. 

	capital cost scenario
		This scenario determines the cost of constructing a new and complete materials recovery
		facility, with all of the associated costs as such, and listed below:

		-Capital costs of land acquisition, site construction, etc. 
		-Capital costs and O&M costs of the following components:
			-Rolling Stock
			-Manual sorting
			-magnet sorting
			-disc screen sorting
			-trommel sorting
		-Full labor costs of each component

		We run this scenario to capture the higher costs that some counties are likely to face 
		if they do not have any existing waste management facility to develop on. They are faced 
		with the additional costs of purchasing and constructing a standalone sorting facility. 


	Add-on cost scenario
	The add on cost scenario works to capture the ability to develop food waste recovery facilities
	at sites that already exist to process waste materials. 
	'''
	
	area = 24.376 #[m^2 / foodwaste_tons_per_day]
	'''
	Combs surveyed 5 different MRFs and related their operating area in square meters to the amount 
	of food waste each processed. 24.376 is the ratio he came up with to relate the two.  '''




	# Rolling Stock Cost

	#[$]
	rolling_stock_capital_cost = 350000.


	#throughput capacity [mg / h]
	rolling_stock_throughput_capacity = 24.


	#[$ / year]
	rolling_stock_operations_maint_cost = 5000. 


	# number of rolling stock operations 
	num_rolling_stock_units = ((foodwaste_tons_per_hour / rolling_stock_throughput_capacity))


	# [$ / mg] cost for manual sorting
	rolling_stock_cost_per_MG = ((rolling_stock_capital_cost * CRF + rolling_stock_operations_maint_cost)\
	* num_rolling_stock_units / foodwaste_tons_per_hour / hours_per_shift / \
	shifts_per_day / days_per_year_of_operation )  


	#[kW]
	rolling_stock_kw = 0. 


	# fractional utilization of equipment
	rolling_stock_fractional_utilization = 0.85 


	# [kWh / mg]
	rolling_stock_electricity_cost = (rolling_stock_kw / rolling_stock_throughput_capacity / \
	rolling_stock_fractional_utilization)


	# number of supplemental sorters required for a technology
	rolling_stock_sorters_required = 1. 


	#[sorter / foodwaste_tons_per_hour]
	rolling_stock_sorters_required_per_ton= rolling_stock_sorters_required / \
	rolling_stock_throughput_capacity 


	# [$/MG]
	rolling_stock_fuel = 10. * 0.264172 * num_rolling_stock_units * fuel_cost 




	#Manual Sorting Cost

	#[$]
	manual_sorting_capital_cost = 50000.


	#[$ / year]
	manual_sorting_operations_maint_cost = 10000. 



	num_manual_sorting_units = 2.


	# [$ / mg] cost for manual sorting
	manual_sorting_cost_per_MG = ((manual_sorting_capital_cost * CRF + \
		manual_sorting_operations_maint_cost) * num_manual_sorting_units / foodwaste_tons_per_hour\
		 / hours_per_shift / shifts_per_day / days_per_year_of_operation )  


	#[kW]
	manual_sorting_kw = 5. 


	#throughput capacity [mg / h]
	manual_sorting_throughput_capacity = 2.


	# fractional utilization of equipment
	manual_sorting_fractional_utilization = 0.85 


 	# [kWh / mg]
	manual_sorting_electricity_cost = (manual_sorting_kw / manual_sorting_throughput_capacity / \
		manual_sorting_fractional_utilization)


	# number of supplemental sorting required for a technology
	manual_sorting_sorters_required = 0. 


	#[sorter / foodwaste_tons_per_hour]
	manual_sorting_sorters_required_per_ton= manual_sorting_sorters_required / manual_sorting_throughput_capacity 




	# Magnet Sorting Cost

	#[$]
	magnet_capital_cost = 35000 


	#[$ / year]
	magnet_operations_maint_cost = 5000 


	# [$ / mg] cost for magnet
	magnet_cost_per_MG = (magnet_capital_cost * CRF + magnet_operations_maint_cost) / \
	foodwaste_tons_per_hour / hours_per_shift / shifts_per_day / days_per_year_of_operation 


	#[kW]
	magnet_kw = 4 


	#throughput capacity [mg / h]
	magnet_throughput_capacity = 2.25 


	# fractional utilization of equipment
	magnet_fractional_utilization = 0.85 


	# [kWh / mg]
	magnet_electricity_cost = magnet_kw / magnet_throughput_capacity / magnet_fractional_utilization


	# number of supplemental sorting required for a technology
	magnet_sorters_required = 0 


	#[sorter / foodwaste_tons_per_hour]
	magnet_sorters_required_per_ton= magnet_sorters_required / magnet_throughput_capacity 




	# Disc Screen Sorting Cost

	#[$]
	disc_screen_capital_cost = 400000 


	#[$ / year]
	disc_screen_operations_maint_cost = 130000 


	# [$ / mg] cost for disc screen
	disc_screen_cost_per_MG = (disc_screen_capital_cost * CRF + disc_screen_operations_maint_cost)\
	 / foodwaste_tons_per_hour / hours_per_shift / shifts_per_day / days_per_year_of_operation  


	#[kW]
	disc_screen_kw = 8.5


	#throughput capacity [mg / h]
	disc_screen_throughput_capacity = 21


	# fractional utilization of equipment
	disc_screen_fractional_utilization = 0.85 


	# [kWh / mg]
	disc_screen_electricity_cost = disc_screen_kw / disc_screen_throughput_capacity / \
	disc_screen_fractional_utilization 


	# number of supplemental sorting required for a technology
	disc_screen_sorters_required = 6 
	

	#[sorter / foodwaste_tons_per_hour]
	disc_screen_sorters_required_per_ton= disc_screen_sorters_required / disc_screen_throughput_capacity 





	#Trommel Sorting Cost

	#[$]
	trommel_capital_cost = 125000.


	#[$ / year]
	trommel_operations_maint_cost = 10000. 


	#number of units required
	num_trommel_units = 3.


	# [$ / mg] cost for trommel
	trommel_cost_per_MG = ((trommel_capital_cost * CRF + trommel_operations_maint_cost) * num_trommel_units \
	/ foodwaste_tons_per_hour / hours_per_shift / shifts_per_day / days_per_year_of_operation )  


	#[kW]
	trommel_kw = 62.


	#throughput capacity [mg / h]
	trommel_throughput_capacity = 42.


	# fractional utilization of equipment
	trommel_fractional_utilization = 0.85 


	# [kWh / mg]
	trommel_electricity_cost = trommel_kw / trommel_throughput_capacity / trommel_fractional_utilization 


	# number of supplemental sorting required for a technology
	trommel_sorters_required = 0. 


	#[sorter / foodwaste_tons_per_hour]
	trommel_sorters_required_per_ton= trommel_sorters_required / trommel_throughput_capacity 




	# Cost Scenario adjustment 
	if costscenario == 'Add-on':
		num_rolling_stock_units = 0 # sets the number of rolling stock units equal to zero
		rolling_stock_fuel = 0 # rolling stock fuel to zero
		rolling_stock_cost_per_MG = 0 # rolling stock cost to zero
		disc_screen_cost_per_MG = 0 # sets disc screen cost to zero
		disc_screen_electricity_cost = 0 # sets disc screen electricity_costtricity cost to zero
		disc_screen_sorters_required_per_ton = 0 # sets number of employees for disc screen sorting to zero
		magnet_cost_per_MG = 0 # sets magnet cost to zero
		magnet_electricity_cost = 0 # sets magnet electricity_costtricity requirements to zero
		magnet_sorters_required_per_ton = 0 # sets number of employees for magnet sorting to zero 
		'''
		The following if statement overrides the costs being added into the model under the add-on scenario. 
		we neglect a series of capital and O&M costs for different component technologies that may 
		be operable at the MRF. The neglected costs are listed below in the respecitve order as above:

		num_tech_units
			Sets the number equal to zero to omit the costs of rolling stock used at the facility. 

		tech_fuel/electricity
			sets the fuel or electricity needed for the technology component equal to zero

		tech_cost_per_mg
			sets cost per metric ton for the technology equal to zero

		'''


	# sum equipment costs [$ / mg]
	total_equipment_cost = disc_screen_cost_per_MG + magnet_cost_per_MG + manual_sorting_cost_per_MG \
	+ rolling_stock_cost_per_MG + trommel_cost_per_MG 

	# Labor costs 

	#fraction of labor labor_rate paid again as employee overhead
	fringe_rate = 0.34 


	# fraction of labor labor_rate paid again for administrative and management overhead
	mgmt_rate = .25


	# number of sorters_required_per_tonrequired [sorters_required_per_ton/ foodwaste_tons_per_hour]
	sorters_req = disc_screen_sorters_required_per_ton+ magnet_sorters_required_per_ton+ \
	manual_sorting_sorters_required_per_ton+ trommel_sorters_required_per_ton+ rolling_stock_sorters_required_per_ton


	# number of drivers required [drivers / foodwaste_tons_per_hour]
	drivers_req = num_rolling_stock_units 


	#[$ / mg]
	total_labor_cost = (1. + fringe_rate) * (1. + mgmt_rate) * ((sorters_req + drivers_req) * labor_rate) 


	#structure construction costs per unit area [$ / m^2]
	building_const_rate = 1051.74 


	#engineering cost factor [%]
	eng_cost_factor = .316 


	#factor of indoor floor area to represent required land [%]
	land_req_factor = 2.83 

	#$ / m^2 cost to acquire land
	land_acq_rate = 2.5 


	#[$ / mg]
	construction_cost_rate = area * ((1 + building_const_rate) * (1 + eng_cost_factor) + \
	(land_req_factor * land_acq_rate)) * CRF / days_per_year_of_operation  

	# Cost Scenario adjustment 
	# assumes that there is no construction of a new sorting facility
	if costscenario == 'Add-on':
		construction_cost_rate = 0 




	# Operating electricity_cost 

	#office electricity [kWh / m^2 / day]
	office_electricity_cost = 1.607 


	#percent of area used as office space [%]
	percent_office = 0.04 


	#warehouse electricity rate [kWhr / m^2 / day]
	warehouse_electricity_cost = .706 


	#[kWhr / mg]
	equip_electricity_cost = disc_screen_electricity_cost + magnet_electricity_cost + \
	manual_sorting_electricity_cost + trommel_electricity_cost 


	#[kWh / mg]
	electricity_cost_comanual_sortingumption_rate = equip_electricity_cost + office_electricity_cost * \
	area * percent_office + warehouse_electricity_cost * area * (1-percent_office) 


	# [$ / mg]
	electricity_cost_cost_rate = electricity_cost_comanual_sortingumption_rate * electricity_cost  

	# cost per wet ton determination 
	# note that the cost per ton is in metric tons until multiplied by 0.907185, converting it to tons. 
	cpwt = ((total_equipment_cost + total_labor_cost + electricity_cost_cost_rate + rolling_stock_fuel + \
	construction_cost_rate) * 0.907185) + depackaging_cost 

	# Organic waste ban cost alteration function 
	if organics_ban == 1:
		cpwt = depackaging_cost

	'''
	Some US states have developed bans on disposing of organic waste in landfills. In these states we
	presume that the sorting cost of food waste will equal zero, since it cannot legally be collected
	while mixed with other waste. This code changes the cost per wet ton of food waste in those states to 
	equal just the cost of depackaging and slurr-ifying the food waste. 
	'''

	# subtracts landfill landfill_tipping_fee ping free from sorting cost 
	lessort = cpwt-landfill_tipping_fee 

	outhroughput_capacityut = fips,cpwt,state,foodwaste,waste_facilities_per_county,foodwaste_tons_per_day,lessort 
	return outhroughput_capacityut

# compute costs and outhroughput_capacityut to excel file 
vals = []
mrf_results = []
for index, row in fdata.iterrows():
	costscenario = 'Add-on'
	#if there are no existing LF, TS, or MRF in the county, then model assigns capital cost scenario. If one or more does exist, then it defaults to add-on
	if row.Number_Waste_Facilities == 0:
		costscenario = 'Capital'
	vals = mrf(row)
	mrf_results = np.append(mrf_results,vals)
mrf_results = np.reshape(mrf_results,(-1,7))
mrfres = pd.DataFrame(mrf_results,columns = ['County FIPS','Sorting CPWT','State','Food Waste in Wet Tons / year','Number of Facilties','Tons / day / Facility','Sort-landfill_tipping_fee '])
writer = pd.ExcelWriter('MRF.xlsx')
mrfres.to_excel(writer,startcol = 0,index = False)
writer.save()
