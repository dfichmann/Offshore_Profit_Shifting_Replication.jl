* Jen Bruner
* Modified by Dylan Rassier
* November 18, 2021
* This file prepares the Orbis data on worlwide operations of US
*	 affiliates' parent companies, specifically the figure on foreign-owned MNEs
*****************************************************************************
*****************************************************************************

cd "\\Serv01cl\IID2\RESEARCH\PROJECTS\Jensen_mann\cross_border_svcs\Dylan\Paper - Productivity\AER Revision\AER Replication\FDIUS"

capture log close
log using PrepOrbis.log, replace

* Prep data downloaded from Orbis
* See CSV files in BvdData subfolder 
* Note: to minimize missing values, OpRevTurnover used rather than Sales, and TangFixedAssets used rather than NetPropPlant&Equip
* Note: from BE15 form: "Net income (loss) after provision for U.S. Federal, state, and local income taxes"

foreach file in BvdData/Orbis2015 BvdData/Orbis2014 BvdData/Orbis2013 BvdData/Orbis2012 BvdData/Orbis2011 BvdData/Orbis2010 BvdData/Orbis2009 BvdData/Orbis2008 {
import delimited using `file'.csv, clear varnames(1) delim(",") colr(2:16)
ren bvdidnumber bvd_id
ren numberofemployees emp_ww
ren v6 sales_ww
ren v7 NetPropPlEquip
ren v8 ppe_ww
ren v9 Sales
ren v10 ProfitLoss
ren v11 netinc_ww
ren v12 empcomp_ww
ren v13 NoSubs
ren v14 rd_ww
ren v15 rdratio_ww
drop if bvd_id==""

gen file="`file'"
gen year=file
replace year=subinstr(year, "BvdData/Orbis", "",10)
destring(year), replace

foreach var in emp_ww sales_ww  ppe_ww netinc_ww empcomp_ww rd_ww NetPropPlEquip Sales ProfitLoss NoSubs rdratio_ww {
	replace `var'=subinstr(`var', ",","", 10)
	replace `var'=subinstr(`var', "n.a.","", 10)
	replace `var'=subinstr(`var', "n.s.","", 10)
	destring(`var'), replace
}

drop file lastavailyear

*drop out obs if all vars are missing
drop if emp_ww ==.& sales_ww==.& ppe_ww==.& netinc_ww==.& empcomp_ww==.& rd_ww==.

* marker for any missing data:
gen anymiss=0
replace anymiss=1 if (emp_ww+sales_ww+ppe_ww+netinc_ww+empcomp_ww+rd_ww)==.

replace rd_ww=rd_ww*-1	// reported as a (-) value (expense) in BvD, make positive values for consistency with BEA data

sort bvd_id
count
save `file'.dta, replace

sort companyname
list year companyname bvd_id sales_ww netinc_ww empcomp_ww ppe_ww emp_ww rd_ww NetPropPlEquip Sales ProfitLoss NoSubs in 1/20, clean
de

* look at missing data:
count
gen counter=1
tabstat emp_ww sales_ww ppe_ww netinc_ww empcomp_ww rd_ww counter, s(n)

}

log close
