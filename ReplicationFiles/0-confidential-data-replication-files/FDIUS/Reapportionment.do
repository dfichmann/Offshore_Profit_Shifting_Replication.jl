* Jen Bruner
* Modified by Dylan Rassier
* November 18, 2021
* This file runs the reapportionment for US affiliates and generates aggregates for table in paper

cd "\\Serv01cl\IID2\RESEARCH\PROJECTS\Jensen_mann\cross_border_svcs\Dylan\Paper - Productivity\AER Revision\AER Replication\FDIUS"

*************************************************
*************************************************
capture log close
log using Reapportionment.log, replace

* 2008
use AltA2008, clear

gen ProfitFA=WtdShrEmpCompPPE*NetIncWW // profits under formulary apportionment
gen AdjFA=ProfitFA-net_inc	// formulary adjustment

putexcel set TabStat.xlsx, replace
putexcel A1 = "Year"
putexcel B1 = "N"
putexcel C1 = "RD"
putexcel D1 = "Employees"
putexcel E1 = "AdjFA"
putexcel A2 = 2008
summarize marker
putexcel B2 = `r(sum)'
summarize rd
putexcel C2 = `r(sum)'
summarize emp
putexcel D2 = `r(sum)'
summarize AdjFA
putexcel E2 = `r(sum)'

* 2012
use AltA2012, clear

gen ProfitFA=WtdShrEmpCompPPE*NetIncWW // profits under formulary apportionment
gen AdjFA=ProfitFA-net_inc	// formulary adjustment

putexcel set TabStat.xlsx, modify
putexcel A3 = 2012
summarize marker
putexcel B3 = `r(sum)'
summarize rd
putexcel C3 = `r(sum)'
summarize emp
putexcel D3 = `r(sum)'
summarize AdjFA
putexcel E3 = `r(sum)'

* 2015
use AltA2015, clear

gen ProfitFA=WtdShrEmpCompPPE*NetIncWW // profits under formulary apportionment
gen AdjFA=ProfitFA-net_inc	// formulary adjustment

putexcel set TabStat.xlsx, modify
putexcel A4 = 2015
summarize marker
putexcel B4 = `r(sum)'
summarize rd
putexcel C4 = `r(sum)'
summarize emp
putexcel D4 = `r(sum)'
summarize AdjFA
putexcel E4 = `r(sum)'


