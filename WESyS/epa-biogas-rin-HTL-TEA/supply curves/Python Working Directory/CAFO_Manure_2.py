import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

''' 

This program is designed to evaluate the economics of manure produced on 
Concentrated Animal Feeding Operations, or CAFOs. These farms produce large amounts of 
animal manure over a relatively small footprint. To manage the manure,
farmers commonly apply it to agricultural lands as a fertilizer. 
However, agricultural lands can only handle so much manure before its application
becomes detrimental to crops or poses a runoff/environmental risk. 
This model identifies the amount of animal manure produced from CAFOs in a county,
and the amount of manure that can be applied to agricultural lands within the county. 
The model assigns a cost for manure based on if the county agricultural lands are able to
incorporate it as a fertilizer or not. For manure that can be used as a fertilizer, it determines a cost per ton
based on the nutrient value of the manure. For the excess portion, it estimates cost based on the 
cost of transporting and land-applying it to another site, presumably outside of the county in question.

'''

#mdata = np.array(pd.read_excel('CAFO_Python_Inputs.xlsx','Inputs',skiprows = 1))

mdata = pd.DataFrame((pd.read_excel('CAFO_Python_Inputs.xlsx','Inputs',skiprows = 1)))
mdata.set_index=(['State','County_ID_Input','County_Name','County_Name_Caps','County_Area',\
'County_Acres','Entity','Beef_Count','Dairy_Count','Swine_Count','Beef_Manure_Dry',\
'Dairy_Manure_Dry','Swine_Manure_Dry','Manure_Sum_Dry','CAFO_Count','County_ID',\
'Pasture_Acres','corngrain','cornsilage','soybeans','sorghumgrain','sorghumsilage',\
'cotton','barley','winterwheat','durumwheat','springwheat','oats','rye','rice','peanuts',\
'sugarbeets','tobacco','alfalfahay','smallgrainhay','tamehay','wildhay',\
'CRF','Labor_Rate','Fuel_Cost','Pasture_LA_Rate','Nitrogen_Cost',\
'Phosphorous_Cost','Potash_Cost','Ad_demand','Beef_Manure','Dairy_Manure',\
'Swine_Manure','Gamma1','Gamma2','Gamma_Max'])

def manure_cost(row):

	#Parameter definition from excel import

	# county ID number for GIS mapping of results
	cid = row.County_ID

	#State name
	states = row.State

	# farms per county per Milbrandt et al 2017
	number_of_farms = row.CAFO_Count

	# [$ / hour] wage from BLS OES for agricultural equipment operators
	labor = row.Labor_Rate

	#[$ / gallon] from EIA, 2017 for diesel fuel
	costfuel = row.Fuel_Cost

	#USDA NASS: ag land, cropland, pastured only [acres]
	pasture = row.Pasture_Acres

	# [bushels] production of corn for grain by county in bushels
	corngrain = row.corngrain

	# [tons] Production of corn for silage by county in tons
	cornsilage = row.cornsilage

	# [bushels] Production of soybeans by county in bushels
	soybeans = row.soybeans 

	# sorghumn grain production by county in [bushels]
	sorghumgrain = row.sorghumgrain

	# Production of sorghum by county in [tons]
	sorghumsilage = row.sorghumsilage 

	# Production of cotton by county in [500 lbs bales]
	cotton = row.cotton 

	# Production of barley by county in [bushels]
	barley = row.barley

	#Production of winter wheat by county in [bushels]
	winterwheat = row.winterwheat  

	# Production of durhum wheat by county in [bushels]
	durumwheat = row.durumwheat  

	# Production of spring wheat by county in [bushels]
	springwheat = row.springwheat 

	# Production of oats by county in [bushels]
	oats = row.oats 

	# Production of rye by county in [bushels]
	rye = row.rye  

	# Production of rice by county in [100 lbs bags]
	rice = row.rice  

	# Production of peanuts by county in [lbs]
	peanuts = row.peanuts  

	# Production of sugar beets by county in [tons]
	sugarbeets = row.sugarbeets 

	# Production of tobacco by county in [lbs]
	tobacco = row.tobacco  

	# Production of alfalfa hay by county in [tons]
	alfalfahay = row.alfalfahay

	# Production of small grain hay by county in [tons]
	smallgrainhay = row.smallgrainhay

	# Production of tame hay by county in [tons]
	tamehay = row.tamehay  

	# Production of wild hay by county in [tons]
	wildhay = row.wildhay  

	# Capital Recovery Factor. [1 / years], asssumes 5% interest rate over 10 years
	crf = 0.129

	#Cost of nitrogen fertilizers by state [$/ton] 
	nitrogen_cost = row.Nitrogen_Cost 

	# Cost of phosphorous fertilizer by state [$/ton]
	phosphorous_cost = row.Phosphorous_Cost


	
 	# % of farms in county using manure fertilizer
	gamma1 = row.Gamma1

	# Percentage of cropland using manure as fertilizer
	gamma2 = row.Gamma2

	# Average of the two gamma metrics
	gamma = np.mean([gamma1,gamma2])

	# Ensure gamma is not > 1. 
	if gamma>1:
		gamma = 1.
	''' 
	Combined metric for farm willingness to accept manure and cropland available to accept
	manure. Currently computed as the average of percentage of farms in the county accepting 
	manure fertilizer and the percentage of cropland incorporating manure fertilizer 
	gamma1 and gamma2, respectively. Some of these values imported from the USDA give values 
	greater than 1, which is currently overridden via the if loop below.
	'''


	#[tons / farm] manure demand from operating anaerobic digestion systems. From AgSTAR. 
	ad_demand = row.Ad_demand

	# wet tons of beef manure produced per Milbrandt et al, 2017
	beefmanure = row.Beef_Manure 

	# wet tons of dairy manure produced per Milbrandt et al, 2017
	dairymanure = row.Dairy_Manure 

	# wet tons of swine manure produced per Milbrandt et al, 2017
	swinemanure = row.Swine_Manure

	# These are set equal to one because they are already accounted for in Anelia's production values.
	beefrecoverability = 1.
	dairyrecoverability = 1. 
	swinerecoverability = 1. 

	#Density of dairy manure, [lb / ft^3], from Barker, 2002. 
	dairydensity = 62.5 

	# Density of swine manure, [lb/ft^3], from Barker, 2002
	swinedensity = 61.5 

	# Density of beef manure, [lb/ft^3], from Barker, 2002
	beefdensity = 61.4

	# [gallon / ft^3] conversion factor
	lbga = 7.48052 


	


	# Gallons of beef manure by county.
	beefgallons = beefmanure * 2000. / beefdensity * lbga 

	# Gallons of dairy manure by county
	dairygallons = dairymanure * 2000. / dairydensity * lbga 

	# Gallons of swine manure by county
	swinegallons = swinemanure * 2000. / swinedensity * lbga
	''' 
	Gallons of beef manure produced by county, using variables defined as above.
	Unit computations as follows:
	[gallons] = [wet tons]*[lbs/ton]/[lb/ft^3]*[gals/ft^3]
	'''



	# [lb of N/bushel] of corn for grain produced in county
	corngrain_nitrogen = 0.84 

	# [lb of P/bushel] of corn for grain produced in county
	corngrain_phosphorous = 0.18 

	# [lb of N/ton] of corn for silage produced in county
	cornsilage_nitrogen = 8.43

	# [lb of P/ton] of corn for silage produced in county
	cornsilage_phosphorous = 1.60 

	# [lb of N/bushel] of soybeans produced in county
	soybeans_nitrogen = 3.60

	# [lb of P/bushel] of soybeans produced in county
	soybeans_phosphorous = 0.31

	# [lb of N/bushel] of sorghum for grain produced in county
	sorghumgrain_nitrogen = 0.84

	# [lb of P/bushel] of sorghum for grain produced in county
	sorghumgrain_phosphorous = 0.18

	# [lb of N/ton] of sorghum for silage produced in county
	sorghumsilage_nitrogen = 9.00

	# [lb of P/ton] of sorghum for silage produced in county
	sorghumsilage_phosphorous = 1.57

	# [lb of N/500lb bale] of cotton produced in county
	cotton_nitrogen = 12.31

	# [lb of P/500lb bale] of cotton produced in county
	cotton_phosphorous = 2.42

	# [lb of N/bushel] of barley produced in county
	barley_nitrogen = 0.94

	# [lb of P/bushel] of barley produced in county
	barley_phosphorous = 0.18

	# [lb of N/bushel] of winter wheat produced in county
	winterwheat_nitrogen = 1.10

	# [lb of P/bushel] of winter wheat produced in county
	winterwheat_phosphorous = 0.22

	# [lb of N/bushel] of durum wheat produced in county
	durumwheat_nitrogen = 1.50

	# [lb of P/bushel] of durum wheat produced in county
	durumwheat_phosphorous = 0.22

	# [lb of N/bushel] of spring wheat produced in county
	springwheat_nitrogen = 1.50

	# [lb of P/bushel] of spring wheat produced in county
	springwheat_phosphorous = 0.22

	# [lb of N/bushel] of oats produced in county
	oats_nitrogen = 0.70

	# [lb of P/bushel] of oats produced in county
	oats_phosphorous = 0.15

	# [lb of N/bushel] of rye produced in county
	rye_nitrogen = 1.20

	# [lb of P/bushel] of rye produced in county
	rye_phosphorous = 0.18

	# [lb of N/100lb bag] of rice produced in county
	rice_nitrogen = 1.27

	# [lb of P/100lb bag] of rice produced in county
	rice_phosphorous = 0.29

	# [lb of N/lb] of peanuts produced in county
	peanuts_nitrogen = 0.040

	# [lb of P/lb] of peanuts produced in county
	peanuts_phosphorous = 0.003

	# [lb of N/ton] of sugar beets produced in county
	sugarbeets_nitrogen = 3.32

	# [lb of P/ton] of sugar beets produced in county
	sugarbeets_phosphorous = 0.69

	# [lb of N/lb] of tobacco produced in county
	tobacco_nitrogen = 0.040

	# [lb of P/lb] of tobacco produced in county
	tobacco_phosphorous = 0.004

	# [lb of N/ton] of alfalfa hay produced in county
	alfalfahay_nitrogen = 52.31

	# [lb of P/ton] of alfalfa hay produced in county
	alfalfahay_phosphorous = 5.45

	# [lb of N/ton] of small grain hay produced in county
	smallgrainhay_nitrogen = 25.60

	# [lb of P/ton] of small grain hay produced in county
	smallgrainhay_phosphorous = 4.48

	# [lb of N/ton] of tame hay produced in county
	tamehay_nitrogen = 37.53

	# [lb of P/ton] of tame hay produced in county
	tamehay_phosphorous = 6.44

	# [lb of N/ton] of wild hay produced in county
	wildhay_nitrogen = 36.

	# [lb of P/ton] of wild hay produced in county
	wildhay_phosphorous = 5.24
	'''
	Nutrient content per yield unit for crop types

	This section defines the nutrient demands of Nitrogen and Phosphorous for all 
	crop types considered in this analysis as a function of their yield. So essentially, 
	each value shown is giving the lb of nutrient (N/P) 
	required to produce one yield unit (e.g. bushel, ton, lb, etc.) Each crop type has two demand types, 
	one for nitrogen and one for phosphorous.
	'''


	'''
	 pounds of nutrient (n & p) per ton of manure for beef, dairy, and swine, respectively 
	'''
	# [lb N / ton manure] for beef cattle
	beef_nitrogen = 4.39 

	# [lb P / ton manure] for beef cattle
	beef_phosphorous = 2.86  

	# [lb N / ton manure] for dairy cattle
	dairy_nitrogen = 4.3 

	# [lb P / ton manure] for dairy cattle
	dairy_phosphorous = 1.65 

	# [lb N / ton manure] for swine
	swine_nitrogen = 2.82 

	# [lb P / ton manure] for swine
	swine_phosphorous = 2.8 

	# average [lb N / ton manure]
	average_nitrogen_content = np.mean([beef_nitrogen,dairy_nitrogen,swine_nitrogen]) 

	# average [lb P / ton manure]
	average_phosphorous_content = np.mean([beef_phosphorous,dairy_phosphorous,swine_phosphorous]) 




	beta = 1. 
	'''
	proportion of cropland that is suitable for receiving manure. From USDA / NRCS, 2007 
	This metric is currently accounted for in the combined gamma value, so I have it set 
	to equal one. 
	'''



	alpha = 1. 
	'''
	Alpha serves as an input to the searchable area function defined later in the code.
	It is the proportion of land surrounding a farm that is cropland or pasture land. 
	'''



	corngrain_nitrogen_demand = gamma * beta * corngrain_nitrogen * corngrain
	corngrain_phosphorous_demand = gamma * beta * corngrain_phosphorous * corngrain
	cornsilage_nitrogen_demand = gamma * beta * cornsilage_nitrogen * cornsilage
	cornsilage_phosphorous_demand = gamma * beta * cornsilage_phosphorous * cornsilage
	soybeans_nitrogen_demand = gamma * beta * soybeans_nitrogen * soybeans
	soybeans_phosphorous_demand = gamma * beta * soybeans_phosphorous * soybeans
	sorghumgrain_nitrogen_demand = gamma * beta * sorghumgrain_nitrogen * sorghumgrain
	sorghumgrain_phosphorous_demand = gamma * beta * sorghumgrain_phosphorous * sorghumgrain
	sorghumsilage_nitrogen_demand = gamma * beta * sorghumsilage_nitrogen * sorghumsilage
	sorghumsilage_phosphorous_demand = gamma * beta * sorghumsilage_phosphorous * sorghumsilage
	cotton_nitrogen_demand = gamma * beta * cotton_nitrogen * cotton
	cotton_phosphorous_demand = gamma * beta * cotton_phosphorous * cotton
	barley_nitrogen_demand = gamma * beta * barley_nitrogen * barley
	barley_phosphorous_demand = gamma * beta * barley_phosphorous * barley
	winterwheat_nitrogen_demand = gamma * beta * winterwheat_nitrogen * winterwheat
	winterwheat_phosphorous_demand = gamma * beta * winterwheat_phosphorous * winterwheat
	durumwheat_nitrogen_demand = gamma * beta * durumwheat_nitrogen * durumwheat
	durumwheat_phosphorous_demand = gamma * beta * durumwheat_phosphorous * durumwheat
	springwheat_nitrogen_demand = gamma * beta * springwheat_nitrogen * springwheat
	springwheat_phosphorous_demand = gamma * beta * springwheat_phosphorous * springwheat
	oats_nitrogen_demand = gamma * beta * oats_nitrogen * oats
	oats_phosphorous_demand = gamma * beta * oats_phosphorous * oats 
	rye_nitrogen_demand = gamma * beta * rye_nitrogen * rye
	rye_phosphorous_demand = gamma * beta * rye_phosphorous * rye 
	rice_nitrogen_demand = gamma * beta * rice_nitrogen * rice
	rice_phosphorous_demand = gamma * beta * rice_phosphorous * rice 
	peanuts_nitrogen_demand = gamma * beta * peanuts_nitrogen * peanuts
	peanuts_phosphorous_demand = gamma * beta * peanuts_phosphorous * peanuts 
	sugarbeets_nitrogen_demand = gamma * beta * sugarbeets_nitrogen * sugarbeets
	sugarbeets_phosphorous_demand = gamma * beta * sugarbeets_phosphorous * sugarbeets
	tobacco_nitrogen_demand = gamma * beta * tobacco_nitrogen * tobacco
	tobacco_phosphorous_demand = gamma * beta * tobacco_phosphorous * tobacco
	alfalfahay_nitrogen_demand = gamma * beta * alfalfahay_nitrogen * alfalfahay
	alfalfahay_phosphorous_demand = gamma * beta * alfalfahay_phosphorous * alfalfahay
	smallgrainhay_nitrogen_demand = gamma * beta * smallgrainhay_nitrogen * smallgrainhay
	smallgrainhay_phosphorous_demand = gamma * beta * smallgrainhay_phosphorous * smallgrainhay 
	tamehay_nitrogen_demand = gamma * beta * tamehay_nitrogen * tamehay 
	tamehay_phosphorous_demand = gamma * beta * tamehay_phosphorous * tamehay 
	wildhay_nitrogen_demand = gamma * beta * wildhay_nitrogen * wildhay
	wildhay_phosphorous_demand = gamma * beta * wildhay_phosphorous * wildhay

	'''Determines the manure demand per county for each crop type considered and multiply it by 
	average nutrient demand, then by beta, which is the proportion of cropland that can 
	accept manure as a fertilizer. These operations output the pounds of nutrient needed 
	for each crop type in terms of pounds of nitrogen and phosphorous.
	Respective units of each value shown are as follows:
	
	croptype_nitrogen/phosphorous_demand=[lbs of the particular nutrient needed by the crops in the county]

	gamma=[%] proportion of farmers willing to accept the manure on their land and 
		proportion of crops that may use manure

	beta=[%] set to = 1, since it is already accounted for in the gamma values for the county

	croptype_nitrogen/phosphorous=[lb of nutrient per yield unit of the crop]

	croptype=[yield of the crop type per county]

	'''


	# Sums the demand of nitrogen for each crop and pasture lands.
	# Units are lb of nitrogen
	nitrogen_demand = \
	(corngrain_nitrogen_demand + cornsilage_nitrogen_demand + \
	soybeans_nitrogen_demand + sorghumgrain_nitrogen_demand
	+ sorghumsilage_nitrogen_demand + cotton_nitrogen_demand + barley_nitrogen_demand + \
	winterwheat_nitrogen_demand + durumwheat_nitrogen_demand + springwheat_nitrogen_demand \
	+ oats_nitrogen_demand + rye_nitrogen_demand + rice_nitrogen_demand + peanuts_nitrogen_demand \
	+ sugarbeets_nitrogen_demand + tobacco_nitrogen_demand + alfalfahay_nitrogen_demand + \
	smallgrainhay_nitrogen_demand + tamehay_nitrogen_demand + wildhay_nitrogen_demand)



	# Sums the demand of phosphorous for each crop type and pasture lands
	# Units are lb of phosphorous
	phosphorous_demand = \
	(corngrain_phosphorous_demand + cornsilage_phosphorous_demand + \
	soybeans_phosphorous_demand + sorghumgrain_phosphorous_demand + sorghumsilage_phosphorous_demand \
	+ cotton_phosphorous_demand + barley_phosphorous_demand + winterwheat_phosphorous_demand + \
	durumwheat_phosphorous_demand + springwheat_phosphorous_demand + oats_phosphorous_demand + \
	rye_phosphorous_demand + rice_phosphorous_demand + peanuts_phosphorous_demand + \
	sugarbeets_phosphorous_demand + tobacco_phosphorous_demand + alfalfahay_phosphorous_demand \
	+ smallgrainhay_phosphorous_demand + tamehay_phosphorous_demand + wildhay_phosphorous_demand)



	# Add all of the different types of manure ---------------------------------------
	manure_supply_tons = beefmanure + swinemanure + dairymanure # [wet tons]




	manuredemand = max(nitrogen_demand,phosphorous_demand) 

	nitrogensupply = \
	(beefmanure * beefrecoverability * beef_nitrogen + dairymanure * dairyrecoverability \
	* dairy_nitrogen + swinemanure * swinerecoverability * swine_nitrogen) # [lbs of Nitrogen]

	phosphoroussupply = \
	(beefmanure * beefrecoverability + dairymanure * dairyrecoverability + \
	swinemanure * swinerecoverability) * average_phosphorous_content # [lbs of Phosphorous]
	
	if manuredemand == nitrogen_demand:
		nutrient_content=average_nitrogen_content
		manuresupply=nitrogensupply

	if manuredemand == phosphorous_demand:
		nutrient_content=average_phosphorous_content
		manuresupply=phosphoroussupply
	'''
	Manure Demand and Supply Computation section

	This section takes the maunure production values and crop demand metrics defined above
	and uses them to estimate the relative demand and supply of animal manure in the county. 
	Manure is usually applied by either a Nitrogen or Phosphorous rate standard. 
	In this instance we assume the manure will be applied by whichever nutrient is demanded by more cropland in the area. 
	Hence the max fuction in the manure demand variable definition. 
	After this the relative nitrogen supply and phosphorous supply are determined based on the 
	manure production from dairy, beef and swine, with a recoverability factor (set to =1).
	Since from this point the manure tonnage is summed from all three types, we have to find an average 
	nutrient_content [lb/ton] to base later calculations on, which is what the 
	first line of the if loop does. The second line puts the manure supply equal to either the nitrogen or 
	phosphorous available within the county, depending on which the manure demand is set equal to.

	'''




	# [wet tons] Tons of manure demanded by cropland and anaerobic digesters in county.
	manuredemand_tons = (manuredemand / nutrient_content) + ad_demand
	'''
	This function puts the manure demand from lb to tons for estimation of $/wet ton costs.
	It then adds in the demand of anaerobic digestion systems in the county, the 
	units of which are already in tons. 
	Unit definition as follows:

	manuredemand_tons=[wet tons] manure demanded by ag lands and anaerobic digesters in county

	manuredemand=[lbs] lb of either N or P demanded by ag lands, as defined in code above

	nutrient_content=[lb/ton] pounds of the given nutrient per wet ton of manure

	ad_demand=[wet tons] manure demanded by anaerobic digester systems in the county. 
		From EPA AgSTAR.
	'''



	# default values to avoid variable referenced but not defined in output array. 
	excess_cost_per_hour = 0.
	excessperfarm = 0.
	excess_manure_tons = 0.
	excess_manure_cpt = 0.
	excess_manure = 0.
	commoditized_manure_excess_scenario = 0.
	commoditized_manure_excess_scenario_cpt = 0.
	commoditized_manure_fertilizer_scenario_cpt = 0.
	commoditized_manure_fertilizer_scenario = 0.
	hrs = 0.
	output = 0.
	ratio = 0.
	excess_cost_per_acre = 0.
	farmdist = 0.
	excess_cost_per_gallon = 0.
	excess_nitrogen = 0.



	''' Scenario Evaluations

	This section of code takes the manure supply and demand computed above and relates them 
	to find if there is excess animal manure for the county. Within this section, three separate
	scenarios are defined, and they are discussed below:

	Scenario 1: The county supply of manure is less than that demanded by agricultural lands and AD 
		systems within the county. Since all of the manure can be applied to agricultural lands 
		without a risk to the environment or crop stability, we presume that it will be. 
		In Scenario 1 the cost assigned to the manure is equal to the nutrient content it is 
		providing to the land. In simple terms, we find the lbs of Nitrogen and Phosphorous
		per ton of manure, and relate that to the cost per ton of Nitrogen and Phosphorous
		based fertilizers for the state. This allows for approximation of the value of the
		fertilizer content of the manure. Under this scenario, anyone choosing to use 
		manure as a WTE feedstock would have to pay the farmers a price equal to the 
		manure fertilizer content, as the farmers are losing out on the nutrients within the manure.

	Scenario 2: Through conversations with USDA economists studying manure, we have come to 
		the understanding that several areas of the country have functioning markets for animal manure. 
		These markets are often facilitated by manure brokers, individuals who match manure buyers with sellers. 
		Many of the markets considered in literature are centered around poultry feed operations, 
		which we do not consider in this work. Significantly less examples exist for beef, dairy, and swine
		manure markets. This appears to predominantly result from the high moisture contents of these manures 
		relative to poultry. A more liquid material is more difficult to transport, and more expensive. 
		Markets for swine, dairy, and beef manure are therefore more informal and localized than others. 
		Only two states considered here exhibited signs of operating manure markets: 
		Pennsylvania and Nebraska. The applicable parameters for these states are adjusted in the 
		sections below.

	Scenario 3: This scenario results when the manure produced within the county is greater than
		what the model estimates may be applied on agricultural lands. When this occurs, the model partitions 
		manure into two categories: excess, and commoditized. 

		Commoditized manure in the county is set equal to the amount demanded by cropland, as it is assumed
			that farmers will use all the manure they can as a fertilizer until the land cannot accept any more.
			The price of commoditized manure is evaluated on its nutrient content in the same way as in
			Scenario 1. 

		Excess manure is equal to the amount of manure in the county less that demanded by the county 
			ag lands. We compute the cost of this feedstock by estimating costs associated with 
			transporting the manure to a theoretical site and land applying it to the site. 
			Components of this cost include capital costs for hauling system, labor, fuel, and maintinence costs.
			We presume that this cost is a negative cost to WTE users of manure. In other words, farmers 
			may be willing to pay a WTE plant some dollar amount to take the manure off of their farm 
			so they are not burdened with it's disposal. Through discussions with USDA experts, we have come to
			believe that farmers are not likely to pay someone to take the manure-they are more
			likely to overapply the manure to their own lands to avoid the costs incurred by managing
			it per regulatory standards. So the negative costs assigned in this scenario are 
			presumed only to apply when farmers are forced to apply manure per EPA or local 
			environmental standards. It is likely that WTE plants would be able to take 
			excess manure from farmers at no cost however. 
	'''



	# This directs model to only consider counties with CAFOs. 
	if number_of_farms>0:
		



		if states == 'Pennsylvania':
			manuredemand = manuresupply + .001 # ensures that model cant select scenario 3
		'''
		Scenario 2 adjustment for PA
		Pennsylvania has developed a rather extensive program aimed at facilitating 
		manure market development through brokerage programs. We assign the scenario 1 
		situation to PA to ensure all of the manure in the state is commoditized.
		'''



		if states == 'Nebraska': 
			commoditized_manure_excess_scenario = excess_manure * 0.5 + manuredemand_tons 
			excess_manure = (manure_supply_tons-manuredemand_tons) * 0.5
		'''
		Scenario 2 adjustment for Nebraska 
		We have identified that 50% of manure produced in Nebraska is sold to farmers as a 
		fertilizer per several journal articles. This operation assigns 50% of manure in the state
		to be equal to fertilizer manure. 
		'''


		# Scenario 3 Operations. See background above.

		# Checks to see if manure supply is greater than demand.
		if manuresupply>manuredemand:

			# Scenario 3(continued)


			commoditized_manure_excess_scenario = manuredemand_tons # [wet tons]
			'''
			This is the portion of manure that is used as a fertilizer in the excess scenario. 
			we are setting this amount equal to the amount of manure demanded by cropland in the county.
			'''



			excess_manure_tons = (manuresupply-manuredemand) / nutrient_content # [wet tons]
			'''
			This is the amount of manure that is considered 'Excess' under the scenario. 
			This amount is used in cost computations later in this loop.
			'''


			#Finds the pounds of excess nitrogen in the county. 
			excess_nitrogen = manuresupply-manuredemand # [lb of N]




			excessperfarm = excess_manure_tons / number_of_farms #[wet tons/farm]
			'''
			This function divides the [tons] of excess manure by the [# of farms] to 
			estimate the amount of excess manure produced by each farm.
			This is one of the issues with the model operations, as it isn't
			likely that excess manure is split evenly between farms. It's more
			likely that excess manure is produced by several of the larger operations in the county.
			As we are not operating this model at a point by point basis, we cannot 
			compute the number of farms that are responsible for the excess manure.
			'''


			# Costs for hauling and land applying excess manure

			# Fuel efficiency of tractor spreader system.
			mpg = 5. # [miles/gallon]

			# Speed of spreader on ag lands. From Hadrich et al.
			spreadspeed = 4.65 #[mph] 




			t_beta_0 = -32582. # [N / A] factor for a tractor to purchase
			t_beta_1 = 884. # factor for tractor purchase
			t_x_1 = 0.0004 * excessperfarm + 74.996 # [PTO-hp] scaled for pto power for manure cost
			tractorcost = t_beta_0 + t_beta_1 * t_x_1 # [$]
			'''
			This section estimates the size and cost of a tractor suitable for land application 
			of hauling a spreader system for land application of animal manure. It is essentially
			a linear fit relating manure amount to tractor size, then puts that into a cost 
			function (tractorcost). 

			Variable Definitions:

			t_beta_0 = y-intercept of tractor size vs manure amount curve

			t_beta_1 = slope of fit relating tractor size to manure amount

			t_x_1 = linear fit equation relating tractor size to manure amount
				X Input Units: Wet Tons of manure
				Y Output Units: Tractor PTO-horsepower

			tractorcost = function for estimating tractor cost based on tractor size
				X Input Units: Tractor PTO-horsepower
				Y Output Units: Tractor cost in [$]

			Reference: Hadrich et al, 2010
			'''



			s_beta_0 = -3786.
			s_beta_1 = 11.
			s_x_1 = 0.0156 * excessperfarm + 1798.6 # gallons. Linear approximation.
			spreadercost = s_beta_0 + s_beta_1 * s_x_1 # [$]
			'''
			This section estimates costs and necessary capacity of a manure slurry
			tank spreader system. The first function relates the tons of manure to gallons 
			of hauling capacity of the tank system. 

			Variable Definitions:

			s_beta_0 = y-int of function relating spreader size to manure volumes

			s_beta_1 = slope of function relating spreader size to manure volume

			s_x_1 = function to estimate spreader size based on manure volume
				X Input Units: Wet Tons of Maure
				Y Output Units: Manure spreader capacity in gallons

			spreadercost = function used for estimating spreader cost based on size
				X Input Units: Gallons of spreader capacity
				Y Output Units: Spreader cost, [$]
			'''



			# Cost of the spreader and tractor are both considered capital costs and summed
			capex = spreadercost + tractorcost #[$]

			# Capital cost is amortized based on a capital recovery factor to units of [$/year]
			acc = capex * crf # [$ / year]

			# This is the average rate in tons of manure application on farmland from ARMS data.
			average_application_rate = 11.3 # [tons/acre] 

			# Assumed rate of nitrogen land application on ag lands in [lbs/acre]
			nitrogen_application_rate = average_application_rate*average_nitrogen_content

			# Assumed rate of phosphorous land application on ag lands in [lbs/acre]
			phosphorous_application_rate = average_application_rate*average_phosphorous_content





			if manuredemand == nitrogen_demand:

				N_m = average_nitrogen_content
				N_c = nitrogen_application_rate

			if manuredemand == phosphorous_demand:

				N_m = average_phosphorous_content
				N_c = phosphorous_application_rate

			# Searchable area function
			searchable_area = (N_m * excess_manure_tons / 640. / alpha / beta / gamma / N_c) ** 0.5 # [miles]

			# acres needed to land apply excess manure
			acresneeded = ((excess_manure_tons*N_m) / N_c) 

			# Variable re-definition
			farmdist = searchable_area
			'''
			The following function seeks to quantify the 'searchable area' on which 
			farm manure will be land applied. It is a metric used by the USDA to find
			"the average distance traveled to spread manure", in Ribaudo et al, 2003.
			We first make the model identify if manure is being applied by nitrogen
			or phosphorous standards, then define the manure nutrient content and 
			land application rates as such. 

			The explanation behind this function is rather complicated, and the 
			reader is directed to Ribaudo et al, 2003, page 34 for more reference. 

			'''



			'''
			Determination of operating costs associated with manure transport and land application
			These functions estimate the costs for land applying and transporting manure 
			by several units, including: [$/wet ton], [$/hour],[$/acre], etc.

			We are assuming in this case that the manure will be hauled to a suitable location and
			spread on land at that location. Therefore we consider the following costs:

			-tractor and spreader amortized capital costs
			-equipment fuel consumption during operation
			-labor required to operate equipment
			-tilling cost per acre to incorporate manure into the soil

			'''
			# This is the cost of tilling to implement manure into the soil.
			# Tilling rate is estimated at $11/acre from Hadrich et al
			tillingcost = acresneeded * 11. # [$] 



			'''
			This estimates the hours needed for equipment operation by 
			asuming an average tractor and spreader hauling speed 
			and dividing the farmdist calculated with the searchable
			area function by that. We can then base the labor costs off of this 
			value, since the labor costs are in [$/hour]
			'''
			hrs = farmdist / spreadspeed # [hours]
			laborcost = hrs * labor #[$]



			'''
			This function operates similarly to the hours estimation function above, 
			but with respect to fuel amounts and costs. We assume a 5 mpg efficiency of 
			the tractor and spreader setup, and relate the fuel costs back to the miles
			traveled estimated by the searchable area function.
			'''
			fuelcost = farmdist / mpg * costfuel # [$]



			'''
			The following block takes the costs computed prior and sums them, then divides them by
			whatever particular metric desired (i.e. tons, gallons, hours, etc.)
			this allows us to evaluate the cost of transporting and land applying manure 
			by several different metrics. The literature on these costs is 
			varied to non-existent, so it is useful to compute costs with respect 
			to these values, as we can benchmark it with experts and with literature.
			'''
			# cost per wet ton for transporting and land applying excess amount of manure
			excess_manure_cpt = (laborcost + fuelcost + acc + tillingcost) / (-excessperfarm) 

			# cost per hour for transporting and land applying excess amount of manure
			excess_cost_per_hour = (laborcost + fuelcost + acc + tillingcost) / hrs 

			# cost per acre for transporting and land applying excess amount of manure
			excess_cost_per_acre = (laborcost + fuelcost + acc + tillingcost) / acresneeded 

			# cost per gallon for transporting and land applying excess amount of manure
			excess_cost_per_gallon = (laborcost + fuelcost + acc + tillingcost) / (excessperfarm * 2000. / 62.5 * lbga) 

			# Finds the ratio of demand to supply manure for the county, if demand>0
			if manuredemand_tons > 0: # ratio of supplied manure to demanded manure
				ratio = manure_supply_tons / manuredemand_tons




			commoditized_manure_excess_scenario_cpt = \
			((commoditized_manure_excess_scenario * average_nitrogen_content / 2000. * nitrogen_cost)\
			 + (commoditized_manure_excess_scenario * average_phosphorous_content * phosphorous_cost\
			  / 2000.)) / (commoditized_manure_excess_scenario) 
			'''
			This is the cost per wet ton for the portion of manure that is used on-farm as a fertilizer.
			We are currently finding the cost by evaluating both the nitrogen and phosphorous content
			in manure. These nutrients may not always be wanted by the farmer using the manure,
			however this seems to be the driver of the market value of manure in most cases. 
			'''
			


		'''
		This code evaluates scenario 1

		This scenario occurs when the amount of manure produced in the county is less than that 
		demanded by ag lands in the county. We evaluate the cost of manure with respect 
		to the nutrient content, and do not consider the costs of transporting 
		or land applying the manure. We disregard these costs under the presumption that 
		farmers are likely to incur these costs whether spreading chemical or manure
		fertilizers on their lands. They will use manure fertilizers to avoid having to store or
		dispose of the manure, which incurs additional operational costs.
		'''
		if manuresupply<manuredemand:

			# Sets commoditized manure amount equal to entire supply
			commoditized_manure_fertilizer_scenario = manure_supply_tons

			# Estimates the amount of manure produced per farm in county
			fertperfarm = (manure_supply_tons) / number_of_farms

			'''
			The following two functions estimate the value of nitrogen and phosphorous in manure 
			based on chemical fertilizer prices and average contents of the two 
			fertilizers in animal manure.

			Variables:

			commoditized_manure_fertilizer_scenario = [wet tons] of manure in county

			average_nitrogen_content = [lb N/ton] of Nitrogen contained in animal manure

			average_phosphorous_content = [lb P/ton] of Phosphorous contained in animal manure

			nitrogen_cost = [$/ton] of nitrogen fertilizer

			phosphorous_cost = [$/ton] of phosphorous fertilizer
			'''

			# Nitrogen nutrient value of manure
			nfert = commoditized_manure_fertilizer_scenario * average_nitrogen_content * nitrogen_cost / 2000.

			# Phosphorous nutrient value of manure
			pfert = commoditized_manure_fertilizer_scenario * average_phosphorous_content * phosphorous_cost / 2000.

			'''
			This function sums the values of nitrogen and phosphorous in the manure and divides it by 
			tons to find the cost per wet ton for the nutrients in the manure.
			'''
			commoditized_manure_fertilizer_scenario_cpt = (nfert + pfert) / commoditized_manure_fertilizer_scenario

	#Outputs array generation
	output = (cid,states,excess_manure_cpt,commoditized_manure_excess_scenario_cpt,excess_manure_tons,\
		commoditized_manure_excess_scenario_cpt,commoditized_manure_fertilizer_scenario_cpt,\
		commoditized_manure_fertilizer_scenario,number_of_farms,ratio,excess_cost_per_hour,farmdist,\
		excess_cost_per_acre,excess_cost_per_gallon,excessperfarm,excess_nitrogen,gamma) 

	return output

# place results in excel file
vals=[]
results=[]
for index, row in mdata.iterrows():
	vals = manure_cost(row) # apply function to inputs from Excel file
	results = np.append(results,vals)# append to output matrix
b = np.reshape(results,(-1, 17)) # reshape outputs
m_res = pd.DataFrame(b, columns = ['County ID','State','Excess Manure CPT','Excess Scenario Fertilizer Manure CPT'\
	,'Excess Manure [Tons]','Fertilizer Manure, Excess Scenario [Tons]','Fertilizer Manure CPT',\
	'Fertilizer Manure [Tons]','Farms / County','Ratio of Excess / Demanded Manure','$ / hour','Hauling Distance'\
	,'[$ / acre]','$ / gallon','Excess Manure Per CAFO','Excess Nitrogen','WTAM'])
m_res = m_res.convert_objects(convert_numeric = True)
m_res.to_excel('Manure_Results.xlsx', startcol = 0) # save outputs to excel file

