* Jen Bruner
* Modified by Dylan Rassier
* November 18, 2021
* This file combines files from Orbis and BE15
*	 affiliates' parent companies, specifically the figure on foreign-owned MNEs
*****************************************************************************
*****************************************************************************
* open file that contains BvD ID-US aff id bridge
capture log close

log using CombineFiles.log, replace 

foreach yr in 2015 2012 2008{

import delimited using BEA_BVD_ID_BRIDGE.csv, clear  	// us_id is BE15 id
ren usid UsId
sort UsId

merge 1:1 UsId using USAffs`yr'			// link bridge file with 2015 US aff info
drop if _merge==1
drop _merge

sort bvd_id year
merge m:1 bvd_id year using Orbis20082015			// link to orbis data panel via bvd_id from bridge file

tab _merge
drop if _merge==2

gen marker=1
list year in 1/1
tabstat rd emp emp_comp ppe sales net_inc marker, s(sum) by(_merge) format(%12.0f)

* compute US shares of WW emp comp, sls, ppe & NI:
gen EmpCompSH= emp_comp/EmpCompWW
gen SalesSH= sales/SalesWW
gen NetIncSH= net_inc/ NetIncWW
gen PPESH= ppe/PPEWW
gen EmpSH=emp/EmpWW
gen RDSH=rd/RDWW


* look more closely at those with strange looking shares (ex >1 or more than 100% of WW ops)
foreach var in SalesSH NetIncSH PPESH EmpSH RDSH EmpCompSH {
count if (`var'>1 & `var'~=.)
list year UsId bvd_id EntityName companyname CtryUbo SalesSH NetIncSH PPESH EmpSH RDSH EmpCompSH if (`var'>1 & `var'~=.), clean noobs str(20)
}

* after looking at shares for matched/unmatched, limit sample to just matched affs
keep  if _merge==3
drop _merge

* Make marker for R&D intensity of industry
gen HiRdInt=0
replace HiRdInt=1 if IndAff>=3250 & IndAff<3260
replace HiRdInt=1 if IndAff>=3340 & IndAff<3350
replace HiRdInt=1 if IndAff>=3360 & IndAff<3370
replace HiRdInt=1 if IndAff==5112
replace HiRdInt=1 if IndAff==5415

tab HiRdInt

* compute Aff's R&D intensity
gen RdSlsRatio=.
replace RdSlsRatio=0 if rd==0
replace RdSlsRatio=rd/sales if rd>0 & rd~=.
egen rd75=pctile(RdSlsRatio), p(75) 
gen RDIntAff=0
replace RDIntAff=1 if RdSlsRatio>rd75 & RdSlsRatio~=.

save Combined`yr'.dta, replace
count

}





