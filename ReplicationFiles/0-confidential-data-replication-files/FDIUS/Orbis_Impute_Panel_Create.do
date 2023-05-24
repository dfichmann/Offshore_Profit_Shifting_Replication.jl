* Jen Bruner
* Modified by Dylan Rassier
* November 18, 2021
* This file looks at missing values in the Orbis data 
* and makes some imputations for some of the missing values

*******************************************************************************
*******************************************************************************
cd "\\Serv01cl\IID2\RESEARCH\PROJECTS\Jensen_mann\cross_border_svcs\Dylan\Paper - Productivity\AER Revision\AER Replication\FDIUS"

capture log close
log using Orbis_Impute_Panel_Create.log, replace

*******************************************************************************
*******************************************************************************

* FIRST COMBINE EACH YEAR OF ORBIS DATA INTO A SINGLE PANEL
use BvdData/Orbis2015, clear
append using BvdData/Orbis2014
append using BvdData/Orbis2013
append using BvdData/Orbis2012
append using BvdData/Orbis2011
append using BvdData/Orbis2010
append using BvdData/Orbis2009
append using BvdData/Orbis2008
tab year

bysort bvd_id: egen NYearMiss=sum(anymiss)
*******************************************************************************
* LINEAR interpolation/extrapolation
bysort bvd_id: ipolate empcomp_ww year, gen(iempcomp_ww )
bysort bvd_id: ipolate empcomp_ww year, gen(i2empcomp_ww ) epolate
replace i2empcomp_ww=. if empcomp_ww==. & i2empcomp<0

*******************************************************************************

* Avg comp per employee
gen CompPerEmp=(empcomp_ww*1000)/emp_ww
gen counter=.
replace counter=1 if CompPerEmp~=.
bysort bvd_id: egen NoNMEmp=sum(counter)
bysort bvd_id: egen tempsum=sum(CompPerEmp)
replace CompPerEmp=. if CompPerEmp<0

gen AvgCompPerEmp=tempsum/NoNMEmp

list companyname bvd_id country empcomp_ww iempcomp_ww i2empcomp_ww emp_ww CompPerEmp NoNMEmp AvgCompPerEmp year tempsum in 1/100, clean noobs str(25)

* use avg comp per emp and emp where avail to impute values of empcomp_ww
gen i3empcomp_ww=empcomp_ww
replace i3empcomp_ww=(emp_ww*AvgCompPerEmp)/1000 if AvgCompPerEmp~=. & empcomp_ww==.

list companyname bvd_id country empcomp_ww iempcomp_ww i2empcomp_ww i3empcomp_ww emp_ww AvgCompPerEmp year  in 1/100, clean noobs str(25) header(100)

gen n=1
tabstat emp_ww empcomp_ww iempcomp_ww i2empcomp_ww i3empcomp_ww n, s(n)

*******************************************************************************
* Using avg emp comp as 1st try, ipolate/epolate as 2nd

gen i4empcomp_ww=empcomp_ww
replace i4empcomp_ww=i3empcomp_ww if i3empcomp_ww~=. & empcomp_ww==.
replace i4empcomp_ww=i2empcomp_ww if i2empcomp_ww~=. & i3empcomp_ww==.

tabstat emp_ww empcomp_ww iempcomp_ww i2empcomp_ww i3empcomp_ww i4empcomp_ww n, s(n)

list companyname bvd_id country *empcomp*  AvgCompPerEmp emp_ww year in 1/100, clean noobs str(25) header(100)

* summary of key variables availability by year
tabstat emp_ww empcomp_ww i4empcomp_ww n, s(n) by(year)

******************************************************************************
* do linear interpolation/ extrapolation for R&D also
bysort bvd_id: ipolate rd_ww year, gen(ird_ww ) epolate

list companyname bvd_id country *rd* sales_ww in 1/100, clean noobs str(25) header(100)

* note a handful have R&D ratio but no R&D amount:
list companyname bvd_id country *rd*  sales_ww year if rd_ww ==. & rdratio_ww ~=. in 1/100, clean noobs str(25) header(100)

gen i2rd_ww=rd_ww
replace i2rd_ww=(rdratio_ww/100)*sales_ww if rd_ww==. & rdratio_ww~=.
replace i2rd_ww=ird_ww if rd_ww==. & ird_ww~=. & rdratio_ww==.

list companyname bvd_id country *rd* sales_ww in 1/100, clean noobs str(25) header(100)
* note there are lots of 0s in rd; wondering if all our true 0 and not . but since there are some . present, leave as is

* summary of key variables availability by year
tabstat *rd* n, s(n) by(year)

* pick up a few (5-6 on average) per year with imputed series

******************************************************************************
* do linear interpolation/ extrapolation for R&D also
tabstat ppe_ww NetPropPlEq* n, s(n) by(year)

* missing values seem to be more spotty than for empcomp, try to fill in gaps with linear interpolation/extrapolation
bysort bvd_id: ipolate ppe_ww year, gen(ippe_ww ) epolate

tabstat *ppe_ww NetPropPlEq* n, s(n) by(year)
* picked up a few extra obs, not many 

* can't really use NetPropPlEq to impute ppe_ww because ppe_ww much better reported
	count if ppe_ww==. & NetPropPlEquip~=.
	count if ppe_ww~=. & NetPropPlEquip==.
	
list companyname bvd_id country ppe_ww NetPropPlEq* in 1/100, clean noobs str(25) header(100)

******************************************************************************
* do linear interpolation/ extrapolation for sales & net income; only a few missing from those variables

bysort bvd_id: ipolate sales_ww year, gen(isales_ww) epolate
bysort bvd_id: ipolate netinc_ww year, gen(inetinc_ww) epolate

tabstat *netinc_ww *sales_ww n, s(n) by(year)
* this gets to nearly 100% coverage on these 2 variables

bysort bvd_id: ipolate emp_ww year, gen(iemp_ww) epolate

tabstat emp_ww iemp_ww n, s(n) by(year)


******************************************************************************
******************************************************************************
* PREP FILE FOR USE/ LINKING WITH BEA DATA

* create markers for imputed data
gen ImpS=0
replace ImpS=1 if sales_ww~=isales_ww

gen ImpNI=0
replace ImpNI=1 if netinc_ww~=inetinc_ww

gen ImpEC=0
replace ImpEC=1 if empcomp_ww~=i4empcomp_ww

gen ImpRD=0
replace ImpRD=1 if rd_ww~=i2rd_ww

gen ImpPPE=0
replace ImpPPE=1 if ppe_ww~=ippe_ww

gen ImpE=0
replace ImpE=1 if emp_ww~=iemp_ww

ren iemp_ww EmpWW
ren isales_ww SalesWW
ren inetinc_ww NetIncWW
ren i4empcomp_ww EmpCompWW
ren i2rd_ww RDWW
ren ippe_ww PPEWW
keep *WW country companyname bvd_id year Imp*

count
* limit to sample with no missing needed variables
* didn't drop due to missing R&D or emp since those are not directly used in the analysis

foreach var in PPEWW SalesWW NetIncWW {		// try not to drop out by emp comp for now--- there is a lot missing for major companies...
drop if `var'==.
}

drop if EmpCompWW==. & EmpWW==.

count	

order year bvd_id companyname country EmpWW RDWW

sort bvd_id year
save Orbis20082015.dta, replace

tabstat *WW, by(year) s(n)

