* Jen Bruner
* Modified by Dylan Rassier
* November 18, 2021
* This file exports data points to recreate plots from Analysis.do

**************************************************
cd "\\Serv01cl\IID2\RESEARCH\PROJECTS\Jensen_mann\cross_border_svcs\Dylan\Paper - Productivity\AER Revision\AER Replication\FDIUS"

foreach yr in 2008 2012 2015 {
capture log close
log using GetFittedValues`yr'.log, replace

	use AltA`yr', clear
	
	twoway lfit NetIncSH WtdShrEmpCompPPE, legend(label(1 "Fitted value")) xtitle(U.S. Share of Worldwide Production) ytitle(U.S. Share of Worldwide Profit) title("`yr'" "Alt A") note("Note: Share of worldwide production based on 50-50 shares of Employee Compensation" "and PP&E." "n= ") lcolor(black) lpattern(longdash) 
	
	reg NetIncSH WtdShrEmpCompPPE
	predict RegFitted if e(sample)
		
	lowess NetIncSH WtdShrEmpCompPPE, generate(LowessFitted) legend(label(2 "Lowess smoothed value"))  lcolor(black) lpattern(solid)
	
	keep year WtdShrEmpCompPPE RegFitted LowessFitted
	
	outsheet using FigureForPaper`yr'.csv, comma replace
	
	}
	
