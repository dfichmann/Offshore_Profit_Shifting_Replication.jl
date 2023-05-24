* Jen Bruner
* Modified by Dylan Rassier
* November 18, 2021
* This file prepares the 2015 BE15 data on US affiliates,
* specifically the figure on foreign-owned MNEs
*****************************************************************************
*****************************************************************************

cd "\\Serv01cl\IID2\RESEARCH\PROJECTS\Jensen_mann\cross_border_svcs\Dylan\Paper - Productivity\AER Revision\AER Replication\FDIUS"

odbc load, clear table("U_BE15EntityData") connectionstring("Driver={SQL Server};Server={DidProdB17};Trusted_Connection={Yes};Database={Ue_Result};UID=oddgr1")
destring(*), replace
keep if PrdName==2015  & Vintage=="p"

tab Vintage

keep UsId PrdName Vintage CtryParent CtryUbo EntityName IndAff IndUbo TypeOwnership
sort UsId PrdName Vintage
save temp, replace

odbc load if PrdName=="2015", clear table("U_BE15FormData") connectionstring("Driver={SQL Server};Server={DidProdB17};Trusted_Connection={Yes};Database={Ue_Result};UID=oddgr1")
destring(*), replace
keep if PrdName==2015  & Vintage=="p"
tab Vintage

* variables needed only:
keep if Metric=="EmployeeCompensation"|Metric=="Employment"|Metric=="Sales"|Metric=="NetIncome"|Metric=="NbvPpe"|Metric=="RD"|Metric=="CapitalGainsLosses"|Metric=="IncomeEquityInvestments"|Metric=="NetInterestPaid"|Metric=="Depletion"		//|Metric=="GrossPPE"|Metric="AccumulatedDepreciation"

drop CtryTransaction IndustryOfSales State IsReported IsProtected DataOriginId DataStatusId ForeignId

list in 1/50, clean noobs
reshape wide Amount, i( UeFormId PrdName Vintage UsId) j(Metric) string

list in 1/50, clean noobs

ren AmountEmployeeCompensation emp_comp
ren AmountEmployment emp
ren AmountNetIncome net_inc
ren AmountNbvPpe ppe
ren AmountSales sales
ren AmountRD rd
gen rd_ratio=rd/sales

list in 1/50, clean noobs
count

sort UsId PrdName Vintage
save temp2, replace

merge UsId PrdName Vintage using temp
tab _merge
keep if _merge==3
drop _merge

list in 1/50, clean noobs str(30)

* save file of 2015 US Aff data

ren PrdName year
sort UsId year
save USAffs2015, replace


 


