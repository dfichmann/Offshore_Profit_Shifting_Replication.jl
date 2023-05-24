* Jen Bruner
* Modified by Dylan Rassier
* November 18, 2021
* This file creates standardized code for prepping analysis subsets of the data for each year YYYY
* Note, all affiliates in main data files combinedYYYY are majority owned

capture log close
log using PrepAnalysisData.log, replace

*****************************************************************************************

* this replicates what was done in original files

foreach yr in 2008 2012 2015 {
use Combined`yr'.dta, clear
count
keep if TypeOwnership=="Majority"
count

* Note: did not find code that computes the weighted share of employee comp & ppe, so create it here

gen WtdShrEmpCompPPE=(0.5*EmpCompSH)+(0.5*PPESH)

* Results with employment and net ppe as apportionment factors ;
count if WtdShrEmpCompPPE>1& WtdShrEmpCompPPE<1.1
list if WtdShrEmpCompPPE>1& WtdShrEmpCompPPE<1.1

* See if there are any records with wgtd_shr_emp just over 100 percent ;
drop if WtdShrEmpCompPPE>1| WtdShrEmpCompPPE==.	// this leaves 194 obs
count

* Drop records where neti_us_shr is blank ;
drop if NetIncSH==. 

* Drop two-percent positive and negative outliers on net income share ;
egen pos_outlier_neti=pctile(NetIncSH), p(98) 
drop if NetIncSH>pos_outlier_neti 
egen neg_outlier_neti=pctile(NetIncSH), p(2) 
drop if NetIncSH<neg_outlier_neti 

count

save Base`yr', replace
save temp, replace


}

* ALT A- ALternative outlier removal

foreach yr in 2008 2012 2015 {

count
keep if TypeOwnership=="Majority"
count
* remove missing, remove > 1 shares of any key variables - consider out of range
* THEN, do removal of outliers as above 
use Combined`yr'.dta, clear

count
drop if EmpCompSH==.
drop if PPESH==.
drop if NetIncSH==.
count

drop if EmpCompSH>1
drop if PPESH>1
drop if NetIncSH>1
drop if NetIncSH<0
count

gen WtdShrEmpCompPPE=(0.5*EmpCompSH)+(0.5*PPESH)
drop if WtdShrEmpCompPPE>1| WtdShrEmpCompPPE==.	
count

* look at tabulations & counts for firms with usable data (before removal of outliers, top and bottom 2%)

* Drop two-percent positive and negative outliers on net income share ;
egen pos_outlier_neti=pctile(NetIncSH), p(98) 
drop if NetIncSH>pos_outlier_neti 
egen neg_outlier_neti=pctile(NetIncSH), p(2) 
drop if NetIncSH<neg_outlier_neti 
count

save AltA`yr', replace
save temp, replace

* disk cleanup of intermediate step files:
erase temp.dta
}
