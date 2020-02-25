import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import random 

# brings in input excel values for model run---------------------------------------------------------------------------------------------------------------
sdata=(pd.read_excel('Sludge_Python_Inputs.xlsx','Inputs',skiprows=1))
sdata2=np.array(pd.read_excel('Sludge_Python_Inputs.xlsx','Inputs',skiprows=1))
statelist=np.array(pd.read_excel('Sludge_Python_Inputs.xlsx','Disposal Data',skiprows=1))
lfb=10
ufb=5000

# Input as 'True' for model to compute the respective process as an added cost---------------------------------------------------------------------------------------------------------------
storagescenario='False'
dewaterscenario='False'

# Define which states to model---------------------------------------------------------------------------------------------------------------
stategraphlist=['MT','CA'] # manual input of state abbreviations. ex: 'AK','CA'
stategraphlist=np.array(pd.read_excel('POTW_Python_Inputs.xlsx','Graph List',skiprows=0)) # Runs model and plots results for all states. 

# Disposal alternative functions (expand)---------------------------------------------------------------------------------------------------------------

def land_application(param):
	import math
	# Import model parameters ---------------------------------------------------------------------------------------------------------------
	state=param[3] # State name
	city=param[4] # city name
	lat=param[5] # latitude
	longitude=param[6] # longitude
	dist=50  # param[33] # sludge hauling distance estimate based on proximity to landfill normally, overridden for this one.
	flow=param[7] # plant inflow in MGD
	ss=param[34] # suspended solids content
	coste=param[27] # state level cost of electricity
	costlb=param[24] # state level cost of labor
	costfo=param[26] # state level cost of fuel oil
	costd=param[25] # state level cost of diesel
	tip=param[29] # landfill tipping fee for nearest landfill (determined geospatially) or if zero, state average
	MSECI=param[30] # inflation index
	ENRCCI=param[31] # inflation index
	crf=param[32] 
	sludge=param[19]/0.1 # solids produced per year. 0.1 converts it to wet tons per PNNL data 
	plantps=param[35] # number of POTWs per state
	cpwt=0 # avoid undefined variable error

	ssg=1/(((100-ss)/100)+((ss)/(1.42*100))) #[N/A]-sludge specific gravity
	sv=sludge/8.34*2000/ssg/365 # Back-calculates the gallons of sludge being hauled based on the solids production value 
	phcst=60 #$/acre for lime application
	dpy=120 # days/year of sludge application. This can vary by land area, but is constant right now. 
	hpd=6 #hours per day of sludge application
	fwwab=0.4 #fraction of farmland needed for sludge application (not all areas will be suitable b/c of cropland, drainage, etc.)
	frph=0.5 #fraction of food chain crop area requiring lime addition
	frlg=0.3 #fraction of area requiring light graded earthwork
	tdss=sludge # total dry solids applied to land [tons/year]
	dsar=5 #[tons/acre/year] of sludge land applied. Will change geographically 
	sdar=tdss/dsar # sludge application area required [acres]
	hsv=sv*365/dpy/hpd # hourly sludge application rate [gal/hour]

	# Haul truck size and count determination ---------------------------------------------------------------------------------------------------------------
	if hsv<=3456:
		cap=1600 # vehicle capacity
		nov=1 # number of vehicles
		lt=6 # load time [min]
		ult=8 # unload time [min]
		tt=dist/45/60 # travel time [min]
		dfrcap=3.5 # diesel fuel consumption rate [gal/hour]
		costpv=85000 # cost [$/vehicle]
		mcstcap=4.85 # vehicle maintinence cost [$/hour]

	if 3456<hsv<=4243:
		cap=2200
		nov=1
		lt=7
		ult=9
		tt=dist/45/60
		dfrcap=4
		costpv=95000
		mcstcap=5.31

	if 4243<hsv<=5574:
		cap=3200
		nov=1
		lt=8
		ult=10
		tt=dist/45/60
		dfrcap=5
		costpv=120000
		mcstcap=5.96

	if 5574<hsv<=6545:
		cap=4000
		nov=1
		lt=9
		ult=11
		tt=dist/45/60
		dfrcap=6
		costpv=140000
		mcstcap=7.16

	if 6545<hsv<=8500:
		cap=2200
		nov=2
		lt=7
		ult=9
		tt=dist/45/60
		dfrcap=4
		costpv=95000
		mcstcap=5.31

	if 8500<hsv<=11200:
		cap=3200
		nov=2
		lt=8
		ult=10
		tt=dist/45/60
		dfrcap=5
		costpv=120000
		mcstcap=5.96

	if 11200<hsv<=13100:
		cap=4000
		nov=2
		lt=9
		ult=11
		tt=dist/45/60
		dfrcap=6
		costpv=140000
		mcstcap=7.16

	if 13100<hsv<=19600:
		cap=4000
		nov=3
		lt=9
		ult=11
		tt=dist/45/60
		dfrcap=6
		costpv=140000
		mcstcap=7.16

	if 19600<hsv<=26000:
		cap=4000
		nov=4
		lt=9
		ult=11
		tt=dist/45/60
		dfrcap=6
		costpv=140000
		mcstcap=7.16

	if hsv>26000:
		nov=math.ceil(hsv/6545) # rounds up the number of vehicles
		cap=4000
		lt=9
		ult=11
		tt=dist/45/60
		dfrcap=6
		costpv=140000
		mcstcap=7.16

		ct=(lt+ult+tt)/0.75 # average round trip cycle time for sludge application vehicles [min]
		vhrcap=cap*60*0.9/ct # single vehicle sludge handling rate [gal/hour]

		tlar=(1+fwwab)*sdar # total land area required for food chain application [acres]
		tlaph=frph*sdar # total land area requiring lime addition [acres]
		tlarlg=frlg*sdar # total land area requiring light grading earth work [acres]
		l=8*nov*dpy/0.7 #total labor required [hours/year]
		fu=hsv*hpd*dpy*dfrcap/vhrcap # annual diesel fuel requirement [gal/year]
		costland=0 # this assumes the POTW does not purchase the land it is using for LA
		costpht=tlaph*phcst # cost of lime addition [$]
		lgewcst=1000*(ENRCCI/4006) # cost of light grading earthwork [$/acre]
		costew=tlarlg*lgewcst # cost of light grading earthwork [$]
		costmav=nov*costpv*(MSECI/751) #cost of sludge application vehicles [$]
		costlb=l*costlb # cost of opperating labor [$/year]
		costdsl=fu*costd # cost of diesel fuel [$/year]
		vmc=(hsv*hpd*dpy*mcstcap/vhrcap)*(MSECI/751) # annual cost of vehicle maintinence
		smc=(tlar*12)*(ENRCCI/4006) #testing at LA site
		tbcc=costland+costpht+costew+costmav
		costom=costlb+costdsl+vmc+smc

		acc=tbcc*crf # Amorized capital cost for la. [$/factorear]
		cpwt=((acc+costom)/(sludge)) # cost per wet ton for sludge land application

	return cpwt

def haul_landfill(param):
	import math
	# Parameter import --------------------------------------------------------------------------------------------------------------
	state=param[3] # State name
	city=param[4] # city name
	lat=param[5] # latitude
	longitude=param[6] # longitude
	dist=param[33] # sludge hauling distance to landfill
	flow=param[7] # plant inflow in MGD
	ss_lf=param[34] # suspended solids content
	coste=param[27] # state level cost of electricity
	costlb=param[24] # state level cost of labor
	costfo=param[26] # state level cost of fuel oil
	costd=param[25] # state level cost of diesel
	tip=param[29] # landfill tipping fee for nearest landfill (determined geospatially) or if zero, state average
	MSECI=param[30] # inflation index
	ENRCCI=param[31] # inflation index
	crf=param[32] 
	sludge=param[19]/0.1 # solids produced per year. 0.1 converts it to wet tons per PNNL data 
	plantps=param[35] # number of POTWs per state

	# Cost curves --------------------------------------------------------------------------------------------------------------
	outputs=0
	cpwt=0

	ult=0.4 # Unloading time for landfill disposal [hours] 
	lt=.4 #Loading time [hours]
	spd=35 #Average speed. Assumed to equal 35mph
	hpd=6 #Hours per day of labor for LF disposal
	dpfactor=180 #Days of sludge hauling per year [days/year]
	ssg=1/(((100-ss_lf)/100)+((ss_lf)/(1.42*100))) #[N/A]-sludge specific gravity
	sv_lf=sludge/8.34*2000/ssg/365 # Back-calculates the gallons of sludge being hauled based on sludge produced per year
	rtht=dist/spd # Haul time [hours]
	svcy=sv_lf*365/202 # Sludge hauled per year [yd^3/year]
		
	factor=svcy*(lt+ult+rtht)/(hpd*dpfactor) # Total sludge hauled per day as a function of hauling time [yd^3/day]

	#Loop decides Truck Count and size optimization based on the sludge handled per day at the plant
	if factor<7:
		ntr=1 # number of trucks 
		cap=7 # cubic yards of capacity
	if 7<factor<10:
		ntr=1
		cap=10
	if 10<factor<15:
		ntr=1
		cap=15
	if 15<factor<25:
		ntr=1
		cap=25
	if 25<factor<36:
		ntr=1
		cap=36
	if 36<factor<50:
		ntr=2
		cap=25
	if 50<factor<72:
		ntr=2
		cap=36
	if factor>72:
		ntr=factor/36
		cap=36

	nrt=math.ceil(svcy/cap) # Number of round trips per year [rt/year]
	dt=(lt+ult+rtht)*nrt # Total drive time [hours/year]

	# Fuel Requirement as a function of truck type fc:[mpg]
	if cap==7:
		fc=9
	if cap==10: 
		fc=8
	if cap==15: 
		fc=7
	if cap==25:
		fc=6
	if cap==36:
		fc=5

	fuel=dist*nrt/fc # Fuel needed [gal/factorear]

	# Truck cost as a function of truck size
	if cap==7:
		costrk=65000 # [$]
	if cap==10: 
		costrk=98000
	if cap==15: 
		costrk=130000
	if cap==25:
		costrk=171000
	if cap==36:
		costrk=214000

	tcosttrk=ntr*costrk*(MSECI/751) #total cost for all trucks with inflation adjustment [$]

	#Capital costs for loading facility as a function of sludge volume handled
	if svcy<2500:
		costlab=40000 # [$]
	if 2500<svcy<5000:
		costlab=45000
	if 5000<svcy<10000:
		costlab=50000	
	if 10000<svcy<20000:
		costlab=80000	
	if 20000<svcy<40000:
		costlab=90000
	if 40000<svcy<60000:
		costlab=100000
	if 60000<svcy<80000:
		costlab=150000
	if 80000<svcy<100000:
		costlab=185000
	if 100000<svcy:
		costlab=220000
	costla=costlab*(ENRCCI/4006)

	#Maintinence Cost as a function of truck size
	if cap==7:
		mcm=.26
	if cap==10: 
		mcm=.32
	if cap==15: 
		mcm=.37
	if cap==25:
		mcm=.45
	if cap==36:
		mcm=.53

	vmc=dist*nrt*mcm*(MSECI/751) # Vehicle maintinence cost per year [$/year]

	mcostla=costla*0.05 #maintinence cost for loading facilities [$/year]
	costlabor=dt*costlb*1.2 #[$/year] labor cost
	costdsl=fuel*costd #[$/year] fuel cost
	tbcc= tcosttrk+costla #Total base capital cost [$]
	costom=vmc+mcostla+costlabor+costdsl #total OM costs [$/year]
	acc=tbcc*crf # Amorized capital cost for equipment. [$/year]
	cpwt=((acc+costom)/(sludge))+tip # cost per wet ton for sludge hauling, with landfill tipping fee added

	return cpwt

def storage(param):
	import math
	# parameter import --------------------------------------------------------------------------------------------------------------
	state=param[3] # State name
	city=param[4] # city name
	lat=param[5] # latitude
	longitude=param[6] # longitude
	dist=param[33] # sludge hauling distance to landfill
	flow=param[7] # plant inflow in MGD
	ss_lf=param[34] # suspended solids content
	coste=param[27] # state level cost of electricity
	costlb=param[24] # state level cost of labor
	costfo=param[26] # state level cost of fuel oil
	costd=param[25] # state level cost of diesel
	tip=param[29] # landfill tipping fee for nearest landfill (determined geospatially) or if zero, state average
	MSECI=param[30] # inflation index
	ENRCCI=param[31] # inflation index
	crf=param[32] 
	sludge=param[19]/0.1 # solids produced per year. 0.1 converts it to wet tons per PNNL data 
	plantps=param[35] # number of POTWs per state


	sd=50 # number of days of storage required
	ssg=1/(((100-ss_lf)/100)+((ss_lf)/(1.42*100))) #[N/A]
	sv_lf=sludge/8.34*2000/ssg/365 # gallons per day of sludge being stored [gallons/day]
	me=0.3 # mixing energy [hp/1000ft^3]
	ef=0.7 # mixing pump efficiency [N/A]
	tdh=25 # total dynamic head loss [ft]
	tv=sv_lf*sd # multiplies the gallons/day of sludge by the number of days it is to be stored [gallons]
	mp=tv*me/7.48/1000 # mixing power [hp]
	mc=mp*33000/ef/tdh/8.34 # mixing pump capacity [gal/min]
	e=mp*0.7457*8760 # [kwhr/year] demanded by storage tanks

	# [hours per year] of labor needed to maintain tanks --------------------------------------------------------------------------------------------------------------
	if tv<10:
		l=700 
	if 10<tv<50:
		l=1000
	if 50<tv<100:
		l=1200
	if 100<tv<500:
		l=1800
	if 500<tv:
		l=2000

	# [$] capital costs for above ground storage tanks based on tank size --------------------------------------------------------------------------------------------------------------
	if tv<10:
		ags=35000 
	if 10<tv<50:
		ags=70000
	if 50<tv<100:
		ags=106000
	if 100<tv<500:
		ags=200000
	if 500<tv:
		ags=313000
	costags=ags*(ENRCCI/4006)

	# capital cost of hydraulic pump mixing station as a function of capacity [$] --------------------------------------------------------------------------------------------------------------
	if mc<20: 
		hm=17.3*1000
	if 20<mc<100:
		hm=23.5*1000
	if 100<mc<350:
		hm=31.2*1000
	if 350<mc<500:
		hm=35.5*1000
	if 500<mc<700:
		hm=42.3*1000
	if 700<mc<2000:
		hm=55*1000
	if 2000<mc<3500:
		hm=70.5*1000
	if 3500<mc<5000:
		hm=87*1000
	if 5000<mc<10000:
		hm=125*1000
	if 10000<mc:
		hm=125*1000
	
	# Cost computations --------------------------------------------------------------------------------------------------------------
	costlb=l*costlb # total cost of labor
	costel=e*coste # total cost of electricity 
	costpm=0.3*hm*(MSECI/751) # cost of parts and maintinence
	tbcc=costags+(hm*MSECI/751) # total base capital cost ( cost of storage tanks and mixing pump)
	costom=costlb+costel+costpm # total OM costs
	acc=tbcc*crf # Amorized capital cost. [$/year]
	cpwt=((acc+costom)/(sludge)) # cost per wet ton computation

	return cpwt

def disp_storage(param):
	import math

	# This code should be identical to that in the storage function, just with a different time of sludge storage (sd)

	# parameter import --------------------------------------------------------------------------------------------------------------
	state=param[3] # State name
	city=param[4] # city name
	lat=param[5] # latitude
	longitude=param[6] # longitude
	dist=param[33] # sludge hauling distance to landfill
	flow=param[7] # plant inflow in MGD
	ss_lf=param[34] # suspended solids content
	coste=param[27] # state level cost of electricity
	costlb=param[24] # state level cost of labor
	costfo=param[26] # state level cost of fuel oil
	costd=param[25] # state level cost of diesel
	tip=param[29] # landfill tipping fee for nearest landfill (determined geospatially) or if zero, state average
	MSECI=param[30] # inflation index
	ENRCCI=param[31] # inflation index
	crf=param[32] 
	sludge=param[19]/0.1 # solids produced per year. 0.1 converts it to wet tons per PNNL data 
	plantps=param[35] # number of POTWs per state


	sd=180 # number of days of storage required
	ssg=1/(((100-ss_lf)/100)+((ss_lf)/(1.42*100))) #[N/A]
	sv_lf=sludge/8.34*2000/ssg/365 # gallons per day of sludge being stored [gallons/day]
	me=0.3 # mixing energy [hp/1000ft^3]
	ef=0.7 # mixing pump efficiency [N/A]
	tdh=25 # total dynamic head loss [ft]
	tv=sv_lf*sd # multiplies the gallons/day of sludge by the number of days it is to be stored [gallons]
	mp=tv*me/7.48/1000 # mixing power [hp]
	mc=mp*33000/ef/tdh/8.34 # mixing pump capacity [gal/min]
	e=mp*0.7457*8760 # [kwhr/year] demanded by storage tanks

	# [hours per year] of labor needed to maintain tanks --------------------------------------------------------------------------------------------------------------
	if tv<10:
		l=700 
	if 10<tv<50:
		l=1000
	if 50<tv<100:
		l=1200
	if 100<tv<500:
		l=1800
	if 500<tv:
		l=2000

	# [$] capital costs for above ground storage tanks based on tank size --------------------------------------------------------------------------------------------------------------
	if tv<10:
		ags=35000 
	if 10<tv<50:
		ags=70000
	if 50<tv<100:
		ags=106000
	if 100<tv<500:
		ags=200000
	if 500<tv:
		ags=313000
	costags=ags*(ENRCCI/4006)

	# capital cost of hfactordraulic pump mixing station as a function of capacity [$] --------------------------------------------------------------------------------------------------------------
	if mc<20: 
		hm=17.3*1000
	if 20<mc<100:
		hm=23.5*1000
	if 100<mc<350:
		hm=31.2*1000
	if 350<mc<500:
		hm=35.5*1000
	if 500<mc<700:
		hm=42.3*1000
	if 700<mc<2000:
		hm=55*1000
	if 2000<mc<3500:
		hm=70.5*1000
	if 3500<mc<5000:
		hm=87*1000
	if 5000<mc<10000:
		hm=125*1000
	if 10000<mc:
		hm=125*1000
	
	# Cost computations --------------------------------------------------------------------------------------------------------------
	costlb=l*costlb # total cost of labor
	costel=e*coste # total cost of electricity 
	costpm=0.3*hm*(MSECI/751) # cost of parts and maintinence
	tbcc=costags+(hm*MSECI/751) # total base capital cost ( cost of storage tanks and mixing pump)
	costom=costlb+costel+costpm # total OM costs
	acc=tbcc*crf # Amorized capital cost [$/year]
	cpwt=((acc+costom)/(sludge)) # cost per wet ton computation
	outputs=cpwt,sludge

	return cpwt

def dewater(param):
	import math
	
	# parameter import --------------------------------------------------------------------------------------------------------------
	state=param[3] # State name
	city=param[4] # citfactor name
	lat=param[5] # latitude
	longitude=param[6] # longitude
	dist=param[33] # sludge hauling distance to landfill
	flow=param[7] # plant inflow in MGD
	ss_lf=param[34] # suspended solids content
	coste=param[27] # state level cost of electricity
	costlb=param[24] # state level cost of labor
	costfo=param[26] # state level cost of fuel oil
	costd=param[25] # state level cost of diesel
	tip=param[29] # landfill tipping fee for nearest landfill (determined geospatially) or if zero, state average
	MSECI=param[30] # inflation index
	ENRCCI=param[31] # inflation index
	crf=param[32] 
	sludge=param[19]/0.1 # solids produced per year. 0.1 converts it to wet tons per PNNL data 
	plantps=param[35] # number of POTWs per state

	# This code computes the costs for belt filter presses and centrifuge dewatering technologies, and uses the lowest cost per wet ton between the two

	# Belt Filter Press --------------------------------------------------------------------------------------------------------------
	ss_dw=ss_lf-13 # Changes solids percentage to 5% for realistic cost evaluation
	ssg=1/(((100-ss_dw)/100)+((ss_dw)/(1.42*100))) #[N/A]
	sv_lf=sludge/8.34*2000/ssg/365 # gallons per day of inflow sludge
	bflr=800 # [lb/meter/hour] belt filter loading rate
	hpd=8 # [hours per day operation]
	dpfactor=260 # [dafactors of operation in a year]
	dss=sv_lf*ss_lf*ssg*8.34/100 #[lb/day]
	tbfw=(dss*365)/bflr/hpd/dpfactor # total belt filter width [meters]

	# operational labor l is in [hr/year]--------------------------------------------------------------------------------------------------------------
	if tbfw<=0.5:	
		l=1773*(tbfw/0.5)
	if tbfw>0.5:
		l=(-0.34*tbfw**3+3734*tbfw**2+441.5*tbfw+619)

	# electricity needed [kwh/year]--------------------------------------------------------------------------------------------------------------
	if tbfw<=0.5:
		e=22065*(tbfw/0.5) 
	if tbfw>0.5:
		e=(-5.42*tbfw**3+234.6*tbfw**2+16020*tbfw+13997)

	costlb_bf=l*costlb # cost of labor [$/factorear]
	costel_bf=e*coste # cost of electricitfactor [$/factorear]

	# [$/year] cost of maintinence parts and labor --------------------------------------------------------------------------------------------------------------
	if tbfw<=0.5:
		costpm_bf=1784*(tbfw/0.5)*(MSECI/751)
	if tbfw>0.5:
		costpm_bf=(-0.708*tbfw**3+30.6*tbfw**2+2371*tbfw+1184)*(MSECI/751)

	# total base capital cost --------------------------------------------------------------------------------------------------------------
	if tbfw<=0.5:
		tbcc_bf=243000*(MSECI/751) 
	if tbfw>0.5:
		tbcc_bf=(-158.6*tbfw**3+5496*tbfw**2+98269*tbfw+192630)*(MSECI/751)

	costom_bf=costlb_bf+costel_bf+costpm_bf # [$/year]
	acc_bf=tbcc_bf*crf # Amorized capital cost [$/year]
	cpwt_bf=((acc_bf+costom_bf)/(sludge/.4*365))

	# Centrifuge--------------------------------------------------------------------------------------------------------------
	msv=sv_lf*365/hpd/dpfactor/60 # [gal/min]

	# estimates the number of centrifuges needed to handle the total amount of sludge---------------------------------------------------------------------------------------------------------
	if msv <=500: 
		ncent=1
	if 500<msv<=1000:
		ncent=2
	if 1000<msv<=1500:
		ncent=3
	if 1500<msv<=2000:
		ncent=4
	if 2000<msv<=2500:
		ncent=5
	if 2500<msv<=3500:
		ncent=7
	if 3500<msv<=4500:
		ncent=9
	if 4500<msv:
		ncent=10

	# operational labor [hour/year]---------------------------------------------------------------------------------------------------------
	if msv<=70: 
		l_cf=0.028*msv**2+0.265*msv+744
	if 70<msv<500:
		l_cf=1.75*10**-5*msv**3-0.019*msv**2+8.205*msv+426
	if msv>500:
		l_cf=(2.10*10**-7*msv**3+6.6*10**-4*msv**2+0.035*msv+1686)

	# process electricity needed [kWhr/year]---------------------------------------------------------------------------------------------------------
	if msv<=70: 
		pe=-5.91*msv**2+2695*msv+500
	if 70<msv<500:
		pe=6.671*10**-4*msv**3-0.513*msv**2+7435*msv-1557500
	if msv>=500:
		pe=1.493*10**-3*msv**3-5.313*msv**2+7435*msv-1557500

	# building electricity [kWhr/year]---------------------------------------------------------------------------------------------------------
	if msv<=70:
		be=(-14.015*msv**2+1867*msv+67917)
	if 70<msv<500:
		be=1.748*10**-3*msv**3-1.797*msv**2+675.6*msv+93530
	if msv>500:
		be=(-1.11*10**-5*msv**3+0.033*msv**2+118.4*msv+139140)

	e_cf=be+pe # [kwhr/year] demand of electricity
	costlb_cf=l_cf*costlb # [$/year] cost of labor
	coste_cf=e_cf*coste # [$/year] cost of electricity
	costpm_cf=(1.92*10**-5*msv**3-0.0055*msv**2+13.053*msv+2113)*(MSECI/751) # [$/year] cost of parts and maintinence

	# base capital costs as a function of amount of sludge--------------------------------------------------------------------------------------------------------
	if msv<70: 
		tbcc_cf=(-10.538*msv**2+3023.6*msv+161390)*(MSECI/751)
	if 70<msv<500:
		tbcc_cf=(-9.4*10**-4*msv**3-0.5*msv**2+1653*msv+217840)*(MSECI/751)
	if msv>500:
		tbcc_cf=(6.8*10**-4*msv**3-2.5*msv**2+3803*msv-520470)*(MSECI/751) 

	costom_cf=ncent*(coste_cf+costlb_cf+costpm_cf)# [$/year] cost of O&M
	acc_cf=(tbcc_cf*ncent)*crf # Amorized capital cost for lf. [$/year]
	cpwt_cf=((acc_cf+costom_cf)/(sludge/0.1))

	# Final Calcs- This model calculates both centrifuge and belt filter press dewatering costs and uses the lowest cost option.
	cpwt=min(cpwt_cf,cpwt_bf)

	return cpwt

def incineration(param):
	#multiple hearth incineration--------------------------------------------------------------------------------------------------------------
	import math

	#Parameter input --------------------------------------------------------------------------------------------------------------
	state=param[3] # State name
	city=param[4] # city name
	lat=param[5] # latitude
	longitude=param[6] # longitude
	dist=param[33] # sludge hauling distance
	flow=param[7] # plant inflow in MGD
	ss=param[34] # suspended solids content
	coste=param[27] # state level cost of electricity
	costlb=param[24] # state level cost of labor
	costfo=param[26] # state level cost of fuel oil
	costd=param[25] # state level cost of diesel
	tip=param[29] # landfill tipping fee for nearest landfill (determined geospatially) or if zero, state average
	MSECI=param[30] # inflation index
	ENRCCI=param[31] # inflation index
	crf=param[32] 
	sludge=param[19]/0.1 # solids produced per year. 0.1 converts it to wet tons
	plantps=param[35] # number of POTWs per state

	ssg=1/(((100-ss)/100)+((ss)/(1.42*100))) #[N/A]-sludge specific gravity
	sv=sludge/8.34*2000/ssg/365 # Back-calculates the gallons of sludge being incinerated based on solids produced 
	vss=60 #volatile suspended solids. default value [%]
	hpd=24 #[hours/day] the process is operated
	dpy=360 #[days/year] process is operated
	lr=(sludge*0.1*2000)/dpy/hpd# sludge loading rate [lb/hour]
	# cost curve coefficents 
	a=-9.886*10**-11
	b=1.28*10**-6
	c=0.38
	l=a*sv**3+b*sv**2+c*sv+1708 #annual labor requirement [hr/year]
	hv=lr*vss*10000/100 # sludge heating value [Btu/hour]
	air=hv*7.5*2/10000 # air combustion requirement [lb dry air/hour]
	hair=air*1340*(0.256+0.013*0.5) # heat required to raise ambient temperature to furnace temperature (1400F) [Btu/hour]
	hss=lr*0.25*1340 # heat required to raise sludge solid temperature to 1400F [Btu/hour]
	hw=((sv*ssg*8.34/hpd)-lr)*1716 # heat required to raise sludge moisture content from 60 to 212F, evaporate water, raise water vapor to 1400F [Btu/hr]
	hcw=0.0782*(hair+hss+hw) # heat required to raise temperature of water formed during combustion reaction to 1400F [Btu/hour]
	hl=0.05*(hair+hss+hw+hcw) # heat needed to compensate for radiation losses [Btu/hr]
	sh=(hair+hss+hw+hcw+hl)-hv # supplemental incinerator heat needed [Btu/hr]
	fo=sh*dpy*hpd/144000*2*1.1 # fuel oil required [gal/year]
	e=-(2.68*(10**-8))*sv**3+(1.51*10**-3)*sv**2+25.4*sv+189400 # electrical energy [kWhr/year]
	costlabor=costlb*l #[$/year] labor cost
	costfuel=fo*costfo #[$/year] fuel cost
	costel=e*coste #[$/year] electricity cost
	costmp=(-(1.3*10**-10)*sv**3-(3*10**-6)*sv**2+.87*sv+8166)*(MSECI/751) # [$/year]
	tbcc=(-(2.7*10**-3)*sv**2+231.5*sv+1681000)*(MSECI/751) #[$]
	costom=costlabor+costfuel+costel+costmp #[$/year]
	acc=(tbcc)*crf # Amorized capital cost [$/year]
	cpwt=((acc+costom)/(sludge))
	if cpwt<0: # this manually sets the cost per wet ton for large incineration plants. The EPA cost curves used were not fit for plants this large and begin to increase the price, which isn't realistic
		cpwt=50
	return cpwt

def compost(param):
	import math

	#Parameter input --------------------------------------------------------------------------------------------------------------
	state=param[3] # State name
	city=param[4] # city name
	lat=param[5] # latitude
	longitude=param[6] # longitude
	dist=param[33] # sludge hauling distance
	flow=param[7] # plant inflow in MGD
	ss=param[34] # suspended solids content
	coste=param[27] # state level cost of electricity
	costlabor=param[24] # state level cost of labor
	costfo=param[26] # state level cost of fuel oil
	costfuel=param[25] # state level cost of diesel
	tip=param[29] # landfill tipping fee for nearest landfill (determined geospatially) or if zero, state average
	MSECI=param[30] # inflation index
	ENRCCI=param[31] # inflation index
	crf=param[32] 
	sludge=param[19]/0.1 # solids produced per year. 0.1 converts it to wet tons per PNNL data 
	plantps=param[35] # number of POTWs per state

	ssg=1/(((100-ss)/100)+((ss)/(1.42*100))) #[N/A]-sludge specific gravity
	sv=sludge/8.34*2000/ssg/365 # Back-calculates the gallons of sludge being hauled based on tons produced
	ds=sludge/365 # daily wet weight of dewatered sludge [tons/day]
	vsp=35 # percent volatile solids
	vsc=45 # percent volatile solids destroyed during composting
	csp=65 # compost product percent solids
	sr=1000 # [lb/yd^3] compost product specific weight
	sm=1100 # [lb/yd^3] dewatered sludge and bulking agent specific weight
	ba=2.5 #[yd^3/ton dewatered sludge] bulking agent mixing ratio
	nb=ba*0.25 # [yd^3/ton dewatered sludge] new bulking agent mix ratio
	snb=500 # [lb/yd^3] new bulking agent specific weight
	rb=ba*0.75 #[yd^3/ton] recycled bulking agent mixing ratio
	aum=300 # [ft^2/ton] area required for unloading and mixing
	ac=7000 # composting area [ft^2/ton dry solids/day]
	ad=300 # drying area [ft^2/ton dry solids/day]
	acs=900 #[ft^2/ton dry solids/day] compost storage area
	ab=2000 #[ft^2/ton dry solids/day] bulking agent storage area
	srb=600 # [lb/yd^3] recycled bulking agent mixing ratio
	dss=2000*ss*ds/100 # daily dry solids weight of dewatered sludge to be composted [lb/day]
	bp=nb*srb*dss*100/ss/2000 # [lb/day] bulking agent compost product
	vss=vsp*dss/100 # [lb/day] of volatile solids
	vsd=vsc*vss/100 # [lb/day] sludge volatile solids destroyed during composting
	baw=(nb*snb+rb*srb)/2000*ds # bulking agent weight [tons/day]
	bav=ba*ds # bulking agent volume [yd^3/day]
	mv=((ds+baw)*2000)/sm # volume of mixed sludge and bulking agent to be composted [yd^3/day]
	scv=dss*2.15/sr # volume of screened compost [yd^3/day]
	cpw=(dss-vsd+bp)/csp/20 # compost produced [tons/day]
	cpv=(dss-vsd+bp)*100/csp/sr # compost produced by volume [yd^3/day]
	at=1.5*dss*((aum+ac+ad+acs+ab)/43560/2000) # total area required [acres]
	ha=0.000028735*ds**3-0.029885*ds**2+16.161*ds+1600 # building area [ft^2]
	fu=(-0.1016*ds**2+222.64*ds+7744) # [gal/year] fuel usage
	eu=ds*400 # [kWhr/year] electricity usage
	bau=nb*ds*365 # bulking agent usage [yd^3/year]
	l=((-0.0331)*ds**2+61.03*ds+1959) # labor needed [hours/year]
	costb=15*ENRCCI/4006 # cost of bulking agent [$/yd^3]
	landcst=3000 # cost of land [$/acre]
	bcrcst=1500 # cost to clear brush and trees [$/acre]
	lgecst=1000 # cost of light grading earthwork [$/acre]
	mgecst=2500 # medium grading earthwork
	egecst=5000 # extensive grading earthwork
	costland=at*landcst # $ total land needed for compost
	fwb=0.7 # fraction needing brush clearing
	costcbt=at*fwb*bcrcst # cost to clear brush and trees [$]
	frlg=0.3 # fractions of land area needing light earthwork
	frmg=0.4 # fractions of land area needing medium earthwork
	freg=0.3 # fractions of land area needing heavy earthwork
	costew=at*(frlg*lgecst+frmg*mgecst+freg*egecst) # cost for earthwork [$]
	costcp=(dss*ac*3.15/2000)*ENRCCI/4006 # cost of composting pads [$]
	costeq=(-5.4*ds**2+5855*ds+435000)*MSECI/751 # equipment cost [$]
	costum=(dss*aum*20/2000)*ENRCCI/4006 # cost of unloading/mixing structure [$]
	costd=(dss*ad*20/2000)*ENRCCI/4006 # cost of drying structure [$]
	costh=ha*50*ENRCCI/4006 # cost of operations and maintinence building [$]
	costlb=l*costlabor # [$/year] cost for labor
	costfl=fu*costfuel # [$/year] cost for diesel fuel
	costel=eu*coste # [$/year] cost of electricity
	costba=bau*costb # [$/year] cost of bulking agent
	costpm=0.15*costeq*MSECI/751 # cost of parts and material [$/year]
	tbcc=costland+costcbt+costew+costcp+costeq+costum+costd+costh # total base capital cost [$]
	costom=costlb+costfl+costel+costba+costpm # operations and maintinence cost [$/year]
	acc=(tbcc)*crf # Amorized capital cost [$/year]
	cpwt=((acc+costom)/(sludge))
	return cpwt

# Model Run -----------------------------------------------------------------------------------------------------------------------------------
disp=0
results=[]
for n in statelist:
	qualifier=n[0] # state name
	stateavg=n[27] # state average POTW inflow
	for i in sdata2:
		if i[3]==qualifier:
			flow=i[7] # plant inflow in MGD
			if lfb<flow<ufb:
				statepotws=i[46] # number of potws in the state
				statesludge=i[47] # wet tons/year of sludg produced in the state
				state=i[3] # State name
				city=i[4] # city name
				lat=i[5] # latitude
				longitude=i[6] # longitude
				dist=i[33] # sludge hauling distance
				flow=i[7] # plant inflow in MGD
				sludge=i[19] # solids produced per year. 0.1 converts it to wet tons per PNNL data 
				plantps=i[35] # number of POTWs per state
				lapc=i[41]*statepotws # percent of biosolids land applied in the state
				lfpc=i[42]*statepotws # percent of biosolids landfilled in the state
				ipc=i[43]*statepotws # percent of biosolids incinerated in the state
				classapc=i[44]*statepotws # percent of biosolids treated as Class A in the state
				storagepc=i[45]*statepotws # percent of biosolids treated with long term storage in the state
				lapcpp=i[36]*statesludge # percent of POTWs using land applicaiton in the state
				lfpcpp=i[37]*statesludge # percent of POTWs using landfilling in the state
				ipcpp=i[38]*statesludge # percent of POTWs using incineration in the state
				classapcpp=i[39]*statesludge # percent of POTWs using class a biosolids treatment in the state
				storagepcpp=i[40]*statesludge # percent of POTWs using long term storage in the state
				m2=max(lapc,lfpc,classapc,storagepc) # finds the disposal alternative treating the highest amount of biosolids in the state
				m=max(lapcpp,lfpcpp,classapcpp,storagepcpp) # finds the disposal alternative that the highest % of POTWs in the state use
				plist2=[lapc,lfpc,ipc,classapc,storagepc] # lists % values for biosolids disposal alternatives for the state
				plist=[lapcpp,lfpcpp,ipcpp,classapcpp,storagepcpp] # lists % values for POTWs using a disposal alternative in the state

				# Identifies the disposal alternative treating the most % of biosolids in the state and indexes labels for that alternative along with the # of POTWs using that alternative -----------------------------------------------------------------------------------------------------------------------------------
				if lapc==max(lapc,lfpc,ipc,classapc,storagepc):
					pdisposal='Land Application'
					pdisposalpcpp=lapcpp
				if lfpc==max(lapc,lfpc,ipc,classapc,storagepc):
					pdisposal='Landfill'
					pdisposalpcpp=lfpcpp
				if ipc==max(lapc,lfpc,ipc,classapc,storagepc):
					pdisposal='Incineration'
					pdisposalpcpp=ipcpp
				if classapc==max(lapc,lfpc,ipc,classapc,storagepc):
					pdisposal='Class A'
					pdisposalpcpp=classapcpp
				if storagepc==max(lapc,lfpc,ipc,classapc,storagepc):
					pdisposal='Storage'
					pdisposalpcpp=storagepcpp

				# Identifies the disposal alternative treating the SECOND most % of biosolids in the state and indexes labels for that alternative along with the # of POTWs using that alternative-----------------------------------------------------------------------------------------------------------------------------------
				if lapc==max(n for n in plist2 if n!=m2):
					sdisposal='Land Application'
					sdisposalpcpp=lapcpp
				if lfpc==max(n for n in plist2 if n!=m2):
					sdisposal='Landfill'
					sdisposalpcpp=lfpcpp
				if ipc==max(n for n in plist2 if n!=m2):
					sdisposal='Incineration'
					sdisposalpcpp=ipcpp
				if classapc==max(n for n in plist2 if n!=m2):
					sdisposal='Class A'
					sdisposalpcpp=classapcpp
				if storagepc==max(n for n in plist2 if n!=m2):
					sdisposal='Storage'
					sdisposalpcpp=storagepcpp

				# Identifies if larger or smaller plants use the primary disposal method based on the average wastewate inflow for the state POTWs -----------------------------------------------------------------------------------------------------------------------------------
				if pdisposalpcpp>sdisposalpcpp: # if the primary disposal is used by a higher percent of POTWS: 
					if sludge>stateavg: # if the sludge inflow is GREATER than the state average, assign primary disposal
						disposal=pdisposal #primary disposal
					if sludge<stateavg: #if the sludge inflow is LESS than the state average, assign SECDONDARY disposal
						disposal=sdisposal #secondary disposal

				if pdisposalpcpp<sdisposalpcpp:# if the primary disposal is used by a lower percent of POTWS: 
					if sludge<stateavg: # if the sludge inflow is LESS than the state average, assign PRIMARY disposal
						disposal=pdisposal #primary disposal
					if sludge>stateavg: #if the sludge inflow is GREATER than the state average, assign SECONDARY disposal
						disposal=sdisposal #secondary disposal

				# Computes Cost per wet ton for each disposal alternative based on the matrix inputs above ---------------------------------------------------------------------------------------------------------------
				if disposal=='Land Application':
					cpwt=-land_application(i)
					disp='Land Application'
				if disposal=='Landfill':
					disp='Landfill'
					cpwt=-haul_landfill(i)
				if disposal=='Incineration':
					cpwt=-incineration(i)
					disp='Incineration'
				if disposal=='Class A':
					cpwt=-compost(i)-storage(i)-dewater(i)
					disp='Class A'
				if disposal=='Storage':
					cpwt=-disp_storage(i)
					disp='Storage'

				# Accounts for storage and dewatering scenarios ---------------------------------------------------------------------------------------------------------------
				if storagescenario=='True':
					cpwt=cpwt+storage(i)
				if dewaterscenario=='True':
					cpwt=cpwt+dewater(i)

				# Output array ---------------------------------------------------------------------------------------------------------------
				o=np.array([state,city,lat,longitude,sludge,cpwt,disp])
				results=np.append(results,o)

# Write output to Excel File ---------------------------------------------------------------------------------------------------------------
b=np.reshape(results,(-1,7))
#print(b)
resultsfinal=pd.DataFrame(b,columns=('State','City','lat','longitude','Sludge','CPWT','Disposal Type'))
resultsfinal.to_excel('POTW.xlsx',startcol=0,index=False)

