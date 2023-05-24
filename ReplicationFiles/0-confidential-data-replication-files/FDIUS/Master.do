* Jen Bruner
* Modified by Dylan Rassier
* November 18, 2021
* This file runs data prep files for
*	 Formulary Apportionment Working Paper by GMRR, 
*	 specifically the figure on foreign-owned MNEs
*****************************************************************************
*****************************************************************************

cd "\\Serv01cl\IID2\RESEARCH\PROJECTS\Jensen_mann\cross_border_svcs\Dylan\Paper - Productivity\AER Revision\AER Replication\FDIUS"

* prep BE 15 data for 2008-2015:

do UsAffsAlsoUsParsPrep.do	// get list of US affs that are also US parents


do PrepBE152015.do			// note: this creates USAffs2015.dta

do PrepBE152012.do			// note: this creates USAffs2012.dta

do PrepBE152008.do			// note: this creates USAffs2008.dta


* refine & expand bridge file;

do Expand_Link_List.do				// creates BEA_BVD_ID_BRIDGE


* prep Orbis data for 2008-2015:

do PrepOrbis.do						// this creates orbisYYYY.dta 

do Orbis_Impute_Panel_Create.do		// this creates Orbis20082015.dta


* next, combine US Aff info with Orbis info:

do CombineFiles.do

****************************************************************
* Replicate the figures on foreign-owned MNEs

do PrepAnalysisData.do			// creates subsamples for base & alt A for 2008, 2012, & 2015

do GetFittedValues.do			// generates csv files of regression output for the figures on foreign-owned MNEs

do Reapportionment.do			// calculates the amount of profits subject to reapportionment and generates output for table on foreign-owned MNEs