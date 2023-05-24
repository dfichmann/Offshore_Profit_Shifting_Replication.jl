/* Program date:  November 4, 2021 */
/* Program name:  '(2) USDIA Financial and Operating Data 1993-2016 AER Replication.sas' */
/* Program description:  This program reformats BEA research data files for BE-10, BE-11, 
and BE-15 to generate consistent variable names and field characteristics.  The resulting 
dataset is a panel of financial and operating data on U.S. reporters and their foreign 
affiliates for 1993-2016:  aer.usdiafo93to16.
/* The output dataset from this program is used in
L:\Dylan\Paper - Productivity\AER Revision\AER Replication\'(3) RD Stock 1982-2016 AER Replication.sas'
L:\Dylan\Paper - Productivity\AER Revision\AER Replication\'(5) Working Data Sets 1982-2016 AER Replication.sas' */

libname aer 'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\Data Sets';
run;

/****************************************************************************************/
/****************************************************************************************/
/* Macro to import data */
/****************************************************************************************/
/****************************************************************************************/
%macro import (table,out,db);
	proc import table = &table 
		out = &out replace
		dbms = access;
		database = &db;
	run;
%mend import;

/****************************************************************************************/
/****************************************************************************************/
/* Import U.S. affiliate data from BE-15 to attach data on foreign ownership of U.S. parents */
/****************************************************************************************/
/****************************************************************************************/
%import ('Be15_2016_entity_form_r',di16own,'S:\BE15\Access2000\2016r.accdb'); * Contains 
U.S. affiliate data from BE-15 for 2016;
%import ('Be15_2015_entity_form_r',di15own,'S:\BE15\Access2000\2015r.accdb'); * Contains 
U.S. affiliate data from BE-15 for 2015;
%import ('Be15_2014_entity_form_r',di14own,'S:\BE15\Access2000\2014r.accdb'); * Contains 
U.S. affiliate data from BE-15 for 2014;
%import ('Be15_2013r',di13own,'S:\BE15\Access2000\2013r.accdb'); * Contains 
U.S. affiliate data from BE-15 for 2013;
%import ('Be15_2012r',di12own,'S:\BE15\Access2000\2012r.accdb'); * Contains 
U.S. affiliate data from BE-15 for 2012;
%import ('Be15_2011r',di11own,'S:\BE15\Access2000\2011r.accdb'); * Contains 
U.S. affiliate data from BE-15 for 2011;
%import ('Be15_2010',di10own,'S:\BE15\Access2000\2010r.accdb'); * Contains 
U.S. affiliate data from BE-15 for 2010;
%import ('Be15_2009',di09own,'S:\BE15\Access2000\2009r.accdb'); * Contains 
U.S. affiliate data from BE-15 for 2009;
%import ('2008RF_MOUSA_ID',di08own,'S:\BE15\Access2000\2008r.mdb'); * Contains 
U.S. affiliate data from BE-15 for 2008;
%import ('2007RF_MOUSA_ID',di07own,'S:\BE15\Access2000\2007r.mdb'); * Contains 
U.S. affiliate data from BE-15 for 2007;
%import ('2006RF_MOUSA_ID',di06own,'S:\BE15\Access2000\2006r.mdb'); * Contains 
U.S. affiliate data from BE-15 for 2006;
%import ('2005RF_MOUSA_ID',di05own,'S:\BE15\Access2000\2005r.mdb'); * Contains 
U.S. affiliate data from BE-15 for 2005;
%import ('2004RF_MOUSA_ID',di04own,'S:\BE15\Access2000\2004r.mdb'); * Contains 
U.S. affiliate data from BE-15 for 2004;
%import ('2003RF_MOUSA_ID',di03own,'S:\BE15\Access2000\2003r.mdb'); * Contains 
U.S. affiliate data from BE-15 for 2003;
%import ('2002RF_ALL_MOUSA_ID',di02own,'S:\BE15\Access2000\2002r.mdb'); * Contains 
U.S. affiliate data from BE-15 for 2002;
%import ('2001RF_MOUSA_ID',di01own,'S:\BE15\Access2000\2001r.mdb'); * Contains 
U.S. affiliate data from BE-15 for 2001;
%import ('2000RF_MOUSA_ID',di00own,'S:\BE15\Access2000\2000r.mdb'); * Contains 
U.S. affiliate data from BE-15 for 2000;
%import ('99RF_MOUSA_ID',di99own,'S:\BE15\Access2000\1999r.mdb'); * Contains 
U.S. affiliate data from BE-15 for 1999;
%import ('98RF_MOUSA_ID',di98own,'S:\BE15\Access2000\1998r.mdb'); * Contains 
U.S. affiliate data from BE-15 for 1998;
%import ('97RFKEY',di97own,'S:\BE15\Access2000\1997r.mdb'); * Contains 
U.S. affiliate data from BE-15 for 1997;
%import ('96RFKEY',di96own,'S:\BE15\Access2000\1996r.mdb'); * Contains 
U.S. affiliate data from BE-15 for 1996;
%import ('95RFKEY',di95own,'S:\BE15\Access2000\1995r.mdb'); * Contains 
U.S. affiliate data from BE-15 for 1995;
%import ('94RFKEY',di94own,'S:\BE15\Access2000\1994r.mdb'); * Contains 
U.S. affiliate data from BE-15 for 1994;
%import ('93RFKEY',di93own,'S:\BE15\Access2000\1993r.mdb'); * Contains 
U.S. affiliate data from BE-15 for 1993;

/****************************************************************************************/
/****************************************************************************************/
/* Reformat U.S. affiliate data from BE-15 for 1993-2016 to be consistent with other years */
/****************************************************************************************/
/****************************************************************************************/
* Reformat U.S. affiliate data to be consistent across all years;
%macro usaffrev (x1,x2,x3,x4,x5,x6,x7);
	data &x1; 
		set &x2;
		length BE15ID 8.;
		Year = &x3; 
		BE15ID = &x4;
		if year in (2009,2010,2011,2012,2013,2014,2015,2016) then do;
			if &x5 = 'Majority' then MajForOwned = 1; else MajForOwned = 0;
		end;
		if year in (1998,1999,2000,2001,2002,2003,2004,2005,2006,2007,2008) then do;
			MajForOwned = 1;
		end;
		if year in (1993,1994,1995,1996,1997) then do;
			if sum(&x6,&x7) gt 500 then MajForOwned = 1; else MajForOwned = 0;
		end;
		USaffiliate = 1;
		keep year be15id majforowned usaffiliate;
	run;
%mend usaffrev;

%usaffrev (di16usaff,di16own,2016,usid,typeownership,.,.);
%usaffrev (di15usaff,di15own,2015,usid,typeownership,.,.);
%usaffrev (di14usaff,di14own,2014,usid,typeownership,.,.);
%usaffrev (di13usaff,di13own,2013,usid,typeownership,.,.);
%usaffrev (di12usaff,di12own,2012,usid,typeownership,.,.);
%usaffrev (di11usaff,di11own,2011,id,typeownership,.,.);
%usaffrev (di10usaff,di10own,2010,id,typeownership,.,.);
%usaffrev (di09usaff,di09own,2009,id,typeownership,.,.);
%usaffrev (di08usaff,di08own,2008,us_id,'',.,.);
%usaffrev (di07usaff,di07own,2007,us_id,'',.,.);
%usaffrev (di06usaff,di06own,2006,us_id,'',.,.);
%usaffrev (di05usaff,di05own,2005,us_id,'',.,.);
%usaffrev (di04usaff,di04own,2004,us_id,'',.,.);
%usaffrev (di03usaff,di03own,2003,us_id,'',.,.);
%usaffrev (di02usaff,di02own,2002,us_id,'',.,.);
%usaffrev (di01usaff,di01own,2001,us_id,'',.,.);
%usaffrev (di00usaff,di00own,2000,us_id,'',.,.);
%usaffrev (di99usaff,di99own,1999,us_id,'',.,.);
%usaffrev (di98usaff,di98own,1998,us_id,'',.,.);
%usaffrev (di97usaff,di97own,1997,us_id,'',own_fp_vote,own_indir);
%usaffrev (di96usaff,di96own,1996,id_96,'',for_par___own_96,us_affil___owned_96);
%usaffrev (di95usaff,di95own,1995,id_95,'',for_par___own_95,us_affil___owned_95);
%usaffrev (di94usaff,di94own,1994,id_94,'',fp___own_94,us_aff___own_94);
%usaffrev (di93usaff,di93own,1993,id_93,'',for_par___own_93,us_affil___owned_93);

* Stack U.S. affiliate data for 1993-2016;
data usaffstack;
	set di16usaff di15usaff di14usaff di13usaff di12usaff di11usaff di10usaff di09usaff 
	di08usaff di07usaff di06usaff di05usaff di04usaff di03usaff di02usaff di01usaff 
	di00usaff di99usaff di98usaff di97usaff di96usaff di95usaff di94usaff di93usaff;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Import affiliate identifying data from BE-10 or BE-11 for 1993-2016 */
/****************************************************************************************/
/****************************************************************************************/
%import (dbo_be11_ident,di16ident,'S:\BE11\Access2000\2016p.accdb'); * Contains 
affiliate identifying data from BE-10 for 2016;
%import (dbo_be11_ident,di15ident,'S:\BE11\Access2000\2015r.accdb'); * Contains 
affiliate identifying data from BE-10 for 2015;
%import (dbo_be10_ident,di14ident,'S:\BE11\Access2000\2014r.accdb'); * Contains 
affiliate identifying data from BE-10 for 2014;
%import (dbo_be11_ident,di13ident,'S:\BE11\Access2000\2013r.accdb'); * Contains 
affiliate identifying data from BE-11 for 2013;
%import (dbo_be11_ident,di12ident,'S:\BE11\Access2000\2012r.accdb'); * Contains 
affiliate identifying data from BE-11 for 2012;
%import (dbo_be11_ident,di11ident,'S:\BE11\Access2000\2011r.accdb'); * Contains 
affiliate identifying data from BE-11 for 2011;
%import (dbo_be11_ident,di10ident,'S:\BE11\Access2000\2010r.accdb'); * Contains 
affiliate identifying data from BE-11 for 2010;
%import (dbo_be10_ident,di09ident,'S:\BE11\Access2000\2009r.accdb'); * Contains 
affiliate identifying data from BE-10 for 2009;
%import (dbo_be11_ident,di08ident,'S:\BE11\Access2000\2008r.accdb'); * Contains 
affiliate identifying data from BE-11 for 2008;
%import (dbo_be11_ident,di07ident,'S:\BE11\Access2000\2007r.mdb'); * Contains 
affiliate identifying data from BE-11 for 2007;
%import (dbo_be11_ident,di06ident,'S:\BE11\Access2000\2006r.mdb'); * Contains 
affiliate identifying data from BE-11 for 2006;
%import (dbo_be11_ident,di05ident,'S:\BE11\Access2000\2005r.mdb'); * Contains 
affiliate identifying data from BE-11 for 2005;
%import (dbo_be10_ident,di04ident,'S:\BE11\Access2000\2004r.mdb'); * Contains 
affiliate identifying data from BE-10 for 2004;
%import (dbo_be11_ident,di03ident,'S:\BE11\Access2000\2003r.mdb'); * Contains 
affiliate identifying data from BE-11 for 2003;
%import (dbo_be11_ident,di02ident,'S:\BE11\Access2000\2002r.mdb'); * Contains 
affiliate identifying data from BE-11 for 2002;
%import (dbo_be11_ident,di01ident,'S:\BE11\Access2000\2001r.mdb'); * Contains 
affiliate identifying data from BE-11 for 2001;
%import (dbo_be11_ident,di00ident,'S:\BE11\Access2000\2000r.mdb'); * Contains 
affiliate identifying data from BE-11 for 2000;
%import (dbo_be10_ident,di99ident,'S:\BE11\Access2000\1999r.mdb'); * Contains 
affiliate identifying data from BE-10 for 1999;
%import (dbo_be11_ident,di98ident,'S:\BE11\Access2000\1998r.mdb'); * Contains 
affiliate identifying data from BE-11 for 1998;
%import (dbo_be11_ident,di97ident,'S:\BE11\Access2000\1997r.mdb'); * Contains 
affiliate identifying data from BE-11 for 1997;
%import (dbo_be11_ident,di96ident,'S:\BE11\Access2000\1996r.mdb'); * Contains 
affiliate identifying data from BE-11 for 1996;
%import (dbo_be11_ident,di95ident,'S:\BE11\Access2000\1995r.mdb'); * Contains 
affiliate identifying data from BE-11 for 1995;
%import (dbo_be10_aff_ident,di94ident,'S:\BE11\Access2000\1994r.mdb'); * Contains 
affiliate identifying data from BE-10 for 1994;
%import (dbo_be11_ident,di93ident,'S:\BE11\Access2000\1993r.mdb'); * Contains 
affiliate identifying data from BE-11 for 1993;

/****************************************************************************************/
/****************************************************************************************/
/* Reformat affiliate identifying data from BE-10 or BE-11 for 1993-2016 to be consistent 
across all years */
/****************************************************************************************/
/****************************************************************************************/
* Reformat affiliate identifying non-benchmark data to be consistent across all years;
%macro revident (x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11);
	data &x1;
		set &x2;
		length BE11ID $12. ForeignID $12. MOFA $1.;
		Year = &x3;
		BE11ID = &x4;
		ForeignID = &x5;
		Industry = &x6;
		Country = &x7;
		MOFA = &x8;
		DocType = &x9;
		USVoting = &x10;
		Indirect = &x11;
		keep year be11id foreignid industry country mofa doctype usvoting indirect;
	run;
%mend revident;

%revident (di16identr,di16ident,2016,us_id,foreign_id,naics_id,ctry,b_or_c,doc_type,own_dir,own_indir);
%revident (di15identr,di15ident,2015,us_id,foreign_id,naics_id,ctry,b_or_c,doc_type,own_dir,own_indir);
%revident (di13identr,di13ident,2013,us_id,foreign_id,naics_id,ctry,b_or_c,doc_type,own_dir,own_indir);
%revident (di12identr,di12ident,2012,us_id,foreign_id,naics_id,ctry,b_or_c,doc_type,own_dir,own_indir);
%revident (di11identr,di11ident,2011,us_id,foreign_id,naics_id,ctry,b_or_c,doc_type,own_dir,own_indir);
%revident (di10identr,di10ident,2010,us_id,foreign_id,naics_id,ctry,b_or_c,doc_type,own_dir,own_indir);
%revident (di08identr,di08ident,2008,us_id,foreign_id,naics_id,ctry,b_or_c,doc_type,own_dir,own_indir);
%revident (di07identr,di07ident,2007,us_id,foreign_id,naics_id,ctry,b_or_c,doc_type,own_dir,own_indir);
%revident (di06identr,di06ident,2006,us_id,foreign_id,naics_id,ctry,b_or_c,doc_type,own_dir,own_indir);
%revident (di05identr,di05ident,2005,us_id,foreign_id,naics_id,ctry,b_or_c,doc_type,own_dir,own_indir);
%revident (di03identr,di03ident,2003,us_id,foreign_id,naics_id,ctry,b_or_c,doc_type,own_dir,own_indir);
%revident (di02identr,di02ident,2002,us_id,foreign_id,naics_id,ctry,b_or_c,doc_type,own_dir,own_indir);
%revident (di01identr,di01ident,2001,us_id,foreign_id,naics_id,ctry,b_or_c,doc_type,own_dir,own_indir);
%revident (di00identr,di00ident,2000,us_id,foreign_id,naics_id,ctry,b_or_c,doc_type,own_dir,own_indir);
%revident (di98identr,di98ident,1998,us_id,foreign_id,sic_ind,ctry,b_or_c,doc_type,own_dir,own_indir);
%revident (di97identr,di97ident,1997,us_id,foreign_id,sic_ind,ctry,b_or_c,doc_type,own_dir,own_indir);
%revident (di96identr,di96ident,1996,us_id,foreign_id,sic_ind,ctry,b_or_c,doc_type,own_dir,own_indir);
%revident (di95identr,di95ident,1995,us_id,foreign_id,sic_ind,ctry,b_or_c,doc_type,own_dir,own_indir);
%revident (di93identr,di93ident,1993,us_id,foreign_id,sic_ind,ctry,b_or_c,doc_type,own_dir,own_indir);

* Reformat affiliate identifying benchmark data to be consistent across all years;
%macro revidentb (x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11);
	data &x1;
		set &x2;
		length BE11ID $12. ForeignID $12. MOFA $1.;
		Year = &x3;
		BE11ID = &x4;
		ForeignID = &x5;
		Industry = &x6;
		Country = &x7;
		if year in (1994,1999,2004,2009) then do;
			if &x8 = 1 then MOFA = 'B'; else MOFA = 'C';
		end;
		if year in (2014) then do;
			if &x8 = '1' then MOFA = 'B'; else MOFA = 'C';
		end;
		DocType = &x9;
		USVoting = &x10;
		Indirect = &x11;
		keep year be11id foreignid industry country mofa doctype usvoting indirect;
	run;
%mend revidentb;

%revidentb (di14identr,di14ident,2014,us_id,foreign_id,naics_id,ctry,maj_min_code,doc_type,own_cy_us_rep,own_cy_indir);
%revidentb (di09identr,di09ident,2009,us_id,foreign_id,naics_id,ctry,maj_min_code,doc_type,own_cy_us_rep,own_cy_indir);
%revidentb (di04identr,di04ident,2004,us_id,foreign_id,naics_id,ctry,maj_min_code,doc_type,own_cy_us_rep,own_cy_indir);
%revidentb (di99identr,di99ident,1999,us_id,foreign_id,naics_id,ctry,maj_min_code,doc_type,own_cy_us_rep,own_cy_indir);
%revidentb (di94identr,di94ident,1994,us_id,foreign_id,ind,ctry,maj_min_code,doc_type,own_94_us_rep,own_94_indir);

* Stack affiliate identifying data for 1993-2016;
data affidentstack;
	set di16identr di15identr di14identr di13identr di12identr di11identr di10identr 
	di09identr di08identr di07identr di06identr di05identr di04identr di03identr 
	di02identr di01identr di00identr di99identr di98identr di97identr di96identr 
	di95identr di94identr di93identr;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Import affiliate balance sheet and income statement data from BE-10 or BE-11 for 1993-2016 */
/****************************************************************************************/
/****************************************************************************************/
%import (dbo_be11_bal_inc,di16bsis,'S:\BE11\Access2000\2016p.accdb'); * Contains 
BS and IS data from BE-11 for 2016;
%import (dbo_be11_bal_inc,di15bsis,'S:\BE11\Access2000\2015r.accdb'); * Contains 
BS and IS data from BE-11 for 2015;
%import (dbo_be10_bal_sheet,di14bs,'S:\BE11\Access2000\2014r.accdb'); * Contains 
BS data from BE-10 for 2014;
%import (dbo_be10_inc_stmt,di14is,'S:\BE11\Access2000\2014r.accdb'); * Contains 
IS data from BE-10 for 2014;
%import (dbo_be11_bal_inc,di13bsis,'S:\BE11\Access2000\2013r.accdb'); * Contains 
BS and IS data from BE-11 for 2013;
%import (dbo_be11_bal_inc,di12bsis,'S:\BE11\Access2000\2012r.accdb'); * Contains 
BS and IS data from BE-11 for 2012;
%import (dbo_be11_bal_inc,di11bsis,'S:\BE11\Access2000\2011r.accdb'); * Contains 
BS and IS data from BE-11 for 2011;
%import (dbo_be11_bal_inc,di10bsis,'S:\BE11\Access2000\2010r.accdb'); * Contains 
BS and IS data from BE-11 for 2010;
%import (dbo_be10_bal_sheet,di09bs,'S:\BE11\Access2000\2009r.accdb'); * Contains 
BS data from BE-10 for 2009;
%import (dbo_be10_inc_stmt,di09is,'S:\BE11\Access2000\2009r.accdb'); * Contains 
IS data from BE-10 for 2009;
%import (dbo_be11_bal_inc,di08bsis,'S:\BE11\Access2000\2008r.accdb'); * Contains 
BS and IS data from BE-11 for 2008;
%import (dbo_be11_bal_inc,di07bsis,'S:\BE11\Access2000\2007r.mdb'); * Contains 
BS and IS data from BE-11 for 2007;
%import (dbo_be11_bal_inc,di06bsis,'S:\BE11\Access2000\2006r.mdb'); * Contains 
BS and IS data from BE-11 for 2006;
%import (dbo_be11_bal_inc,di05bsis,'S:\BE11\Access2000\2005r.mdb'); * Contains 
BS and IS data from BE-11 for 2005;
%import (dbo_be10_bal_sheet,di04bs,'S:\BE11\Access2000\2004r.mdb'); * Contains 
BS data from BE-10 for 2004;
%import (dbo_be10_inc_stmt,di04is,'S:\BE11\Access2000\2004r.mdb'); * Contains 
IS data from BE-10 for 2004;
%import (dbo_be11_bal_inc,di03bsis,'S:\BE11\Access2000\2003r.mdb'); * Contains 
BS and IS data from BE-11 for 2003;
%import (dbo_be11_bal_inc,di02bsis,'S:\BE11\Access2000\2002r.mdb'); * Contains 
BS and IS data from BE-11 for 2002;
%import (dbo_be11_bal_inc,di01bsis,'S:\BE11\Access2000\2001r.mdb'); * Contains 
BS and IS data from BE-11 for 2001;
%import (dbo_be11_bal_inc,di00bsis,'S:\BE11\Access2000\2000r.mdb'); * Contains 
BS and IS data from BE-11 for 2000;
%import (dbo_be10_bal_sheet,di99bs,'S:\BE11\Access2000\1999r.mdb'); * Contains 
BS data from BE-10 for 1999;
%import (dbo_be10_inc_stmt,di99is,'S:\BE11\Access2000\1999r.mdb'); * Contains 
IS data from BE-10 for 1999;
%import (dbo_be11_bal_inc,di98bsis,'S:\BE11\Access2000\1998r.mdb'); * Contains 
BS and IS data from BE-11 for 1998;
%import (dbo_be11_bal_inc,di97bsis,'S:\BE11\Access2000\1997r.mdb'); * Contains 
BS and IS data from BE-11 for 1997;
%import (dbo_be11_bal_inc,di96bsis,'S:\BE11\Access2000\1996r.mdb'); * Contains 
BS and IS data from BE-11 for 1996;
%import (dbo_be11_bal_inc,di95bsis,'S:\BE11\Access2000\1995r.mdb'); * Contains 
BS and IS data from BE-11 for 1995;
%import (dbo_be10_aff_data3,di94bs,'S:\BE11\Access2000\1994r.mdb'); * Contains 
BS data from BE-10 for 1994;
%import (dbo_be10_aff_data4,di94is,'S:\BE11\Access2000\1994r.mdb'); * Contains 
IS data from BE-10 for 1994;
%import (dbo_be11_bal_inc,di93bsis,'S:\BE11\Access2000\1993r.mdb'); * Contains 
BS and IS data from BE-11 for 1993;

/****************************************************************************************/
/****************************************************************************************/
/* Reformat affiliate balance sheet and income statement data from BE-10 or BE-11 for 
1993-2016 to be consistent across all years */
/****************************************************************************************/
/****************************************************************************************/
* Reformat affiliate balance sheet and income statement data to be consistent across all years;
%macro revbsis (x1,x2,x3,x4,x5,x6,x7);
	data &x1;
		set &x2;
		length BE11ID $12. ForeignID $12.;
		Year = &x3;
		BE11ID = &x4;
		ForeignID = &x5;
		GrPPE = &x6 * 1;
		AccDepr = &x7 * 1;
		keep year be11id foreignid grppe accdepr;
	run;
%mend revbsis;

%revbsis (di16bsisr,di16bsis,2016,us_id,foreign_id,gross_ppe,accum_depr);
%revbsis (di15bsisr,di15bsis,2015,us_id,foreign_id,gross_ppe,accum_depr);
%revbsis (di14bsisr,di14bs,2014,us_id,foreign_id,oth_ppe_cy,accum_depr_cy);
%revbsis (di13bsisr,di13bsis,2013,us_id,foreign_id,gross_ppe,accum_depr);
%revbsis (di12bsisr,di12bsis,2012,us_id,foreign_id,gross_ppe,accum_depr);
%revbsis (di11bsisr,di11bsis,2011,us_id,foreign_id,gross_ppe,accum_depr);
%revbsis (di10bsisr,di10bsis,2010,us_id,foreign_id,gross_ppe,accum_depr);
%revbsis (di09bsisr,di09bs,2009,us_id,foreign_id,oth_ppe_cy,accum_depr_cy);
%revbsis (di08bsisr,di08bsis,2008,us_id,foreign_id,gross_ppe,accum_depr);
%revbsis (di07bsisr,di07bsis,2007,us_id,foreign_id,gross_ppe,accum_depr);
%revbsis (di06bsisr,di06bsis,2006,us_id,foreign_id,gross_ppe,accum_depr);
%revbsis (di05bsisr,di05bsis,2005,us_id,foreign_id,gross_ppe,accum_depr);
%revbsis (di04bsisr,di04bs,2004,us_id,foreign_id,oth_ppe_cy,accum_depr_cy);
%revbsis (di03bsisr,di03bsis,2003,us_id,foreign_id,gross_ppe,accum_depr);
%revbsis (di02bsisr,di02bsis,2002,us_id,foreign_id,gross_ppe,accum_depr);
%revbsis (di01bsisr,di01bsis,2001,us_id,foreign_id,gross_ppe,accum_depr);
%revbsis (di00bsisr,di00bsis,2000,us_id,foreign_id,gross_ppe,accum_depr);
%revbsis (di99bsisr,di99bs,1999,us_id,foreign_id,oth_ppe_cy,accum_depr_cy);
%revbsis (di98bsisr,di98bsis,1998,us_id,foreign_id,gross_ppe,accum_depr);
%revbsis (di97bsisr,di97bsis,1997,us_id,foreign_id,gross_ppe,accum_depr);
%revbsis (di96bsisr,di96bsis,1996,us_id,foreign_id,gross_ppe,accum_depr);
%revbsis (di95bsisr,di95bsis,1995,us_id,foreign_id,gross_ppe,accum_depr);
%revbsis (di94bsisr,di94bs,1994,us_id,foreign_id,oth_ppe_94,accum_depr_94);
%revbsis (di93bsisr,di93bsis,1993,us_id,foreign_id,gross_ppe,accum_depr);

* Stack affiliate balance sheet and income statement data for 1993-2016;
data affbsisstack;
	set di16bsisr di15bsisr di14bsisr di13bsisr di12bsisr di11bsisr di10bsisr di09bsisr 
	di08bsisr di07bsisr di06bsisr di05bsisr di04bsisr di03bsisr di02bsisr di01bsisr 
	di00bsisr di99bsisr di98bsisr di97bsisr di96bsisr di95bsisr di94bsisr di93bsisr;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Import affiliate sales data from BE-10 or BE-11 for 1993-2016 */
/****************************************************************************************/
/****************************************************************************************/
%import (dbo_be11_sales,di16sales,'S:\BE11\Access2000\2016p.accdb'); * Contains 
sales data from BE-11 for 2016;
%import (dbo_be11_sales,di15sales,'S:\BE11\Access2000\2015r.accdb'); * Contains 
sales data from BE-11 for 2015;
%import (dbo_be10_sales,di14sales,'S:\BE11\Access2000\2014r.accdb'); * Contains 
sales data from BE-10 for 2014;
%import (dbo_be11_sales,di13sales,'S:\BE11\Access2000\2013r.accdb'); * Contains 
sales data from BE-11 for 2013;
%import (dbo_be11_sales,di12sales,'S:\BE11\Access2000\2012r.accdb'); * Contains 
sales data from BE-11 for 2012;
%import (dbo_be11_sales,di11sales,'S:\BE11\Access2000\2011r.accdb'); * Contains 
sales data from BE-11 for 2011;
%import (dbo_be11_sales,di10sales,'S:\BE11\Access2000\2010r.accdb'); * Contains 
sales data from BE-11 for 2010;
%import (dbo_be10_sales,di09sales,'S:\BE11\Access2000\2009r.accdb'); * Contains 
sales data from BE-10 for 2009;
%import (dbo_be11_sales,di08sales,'S:\BE11\Access2000\2008r.accdb'); * Contains 
sales data from BE-11 for 2008;
%import (dbo_be11_sales,di07sales,'S:\BE11\Access2000\2007r.mdb'); * Contains 
sales data from BE-11 for 2007;
%import (dbo_be11_sales,di06sales,'S:\BE11\Access2000\2006r.mdb'); * Contains 
sales data from BE-11 for 2006;
%import (dbo_be11_sales,di05sales,'S:\BE11\Access2000\2005r.mdb'); * Contains 
sales data from BE-11 for 2005;
%import (dbo_be10_sales,di04sales,'S:\BE11\Access2000\2004r.mdb'); * Contains 
sales data from BE-10 for 2004;
%import (dbo_be11_sales,di03sales,'S:\BE11\Access2000\2003r.mdb'); * Contains 
sales data from BE-11 for 2003;
%import (dbo_be11_sales,di02sales,'S:\BE11\Access2000\2002r.mdb'); * Contains 
sales data from BE-11 for 2002;
%import (dbo_be11_sales,di01sales,'S:\BE11\Access2000\2001r.mdb'); * Contains 
sales data from BE-11 for 2001;
%import (dbo_be11_sales,di00sales,'S:\BE11\Access2000\2000r.mdb'); * Contains 
sales data from BE-11 for 2000;
%import (dbo_be10_sales,di99sales,'S:\BE11\Access2000\1999r.mdb'); * Contains 
sales data from BE-10 for 1999;
%import (dbo_be11_sales,di98sales,'S:\BE11\Access2000\1998r.mdb'); * Contains 
sales data from BE-11 for 1998;
%import (dbo_be11_sales,di97sales,'S:\BE11\Access2000\1997r.mdb'); * Contains 
sales data from BE-11 for 1997;
%import (dbo_be11_sales,di96sales,'S:\BE11\Access2000\1996r.mdb'); * Contains 
sales data from BE-11 for 1996;
%import (dbo_be11_sales,di95sales,'S:\BE11\Access2000\1995r.mdb'); * Contains 
sales data from BE-11 for 1995;
%import (dbo_be10_aff_data9,di94sales,'S:\BE11\Access2000\1994r.mdb'); * Contains 
sales data from BE-10 for 1994;
%import (dbo_be11_sales,di93sales,'S:\BE11\Access2000\1993r.mdb'); * Contains 
sales data from BE-11 for 1993;

/****************************************************************************************/
/****************************************************************************************/
/* Reformat affiliate sales data from BE-10 or BE-11 for 1993-2016 to be consistent across all years */
/****************************************************************************************/
/****************************************************************************************/
* Reformat affiliate sales data to be consistent across all years;
%macro revsales (x1,x2,x3,x4,x5,x6,x7,x8,x9);
	data &x1;
		set &x2;
		length BE11ID $12. ForeignID $12.;
		Year = &x3;
		BE11ID = &x4;
		ForeignID = &x5;
		Sales1 = &x6 * 1;
		UnaffSales = sum(&x7,&x8,&x9);
		keep year be11id foreignid sales1 unaffsales;
	run;
%mend revsales;

%revsales (di16salesr,di16sales,2016,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);
%revsales (di15salesr,di15sales,2015,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);
%revsales (di14salesr,di14sales,2014,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);
%revsales (di13salesr,di13sales,2013,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);
%revsales (di12salesr,di12sales,2012,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);
%revsales (di11salesr,di11sales,2011,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);
%revsales (di10salesr,di10sales,2010,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);
%revsales (di09salesr,di09sales,2009,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);
%revsales (di08salesr,di08sales,2008,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);
%revsales (di07salesr,di07sales,2007,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);
%revsales (di06salesr,di06sales,2006,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);
%revsales (di05salesr,di05sales,2005,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);
%revsales (di04salesr,di04sales,2004,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);
%revsales (di03salesr,di03sales,2003,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);
%revsales (di02salesr,di02sales,2002,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);
%revsales (di01salesr,di01sales,2001,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);
%revsales (di00salesr,di00sales,2000,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);
%revsales (di99salesr,di99sales,1999,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);
%revsales (di98salesr,di98sales,1998,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);
%revsales (di97salesr,di97sales,1997,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);
%revsales (di96salesr,di96sales,1996,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);
%revsales (di95salesr,di95sales,1995,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);
%revsales (di94salesr,di94sales,1994,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff_ctry);
%revsales (di93salesr,di93sales,1993,us_id,foreign_id,sales,sales_local_unaff,sales_us_unaff,sales_oth_unaff);

* Stack affiliate sales data for 1993-2016;
data affsalestack;
	set di16salesr di15salesr di14salesr di13salesr di12salesr di11salesr di10salesr 
	di09salesr di08salesr di07salesr di06salesr di05salesr di04salesr di03salesr 
	di02salesr di01salesr di00salesr di99salesr di98salesr di97salesr di96salesr 
	di95salesr di94salesr di93salesr;
	rename sales1 = Sales;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Import affiliate miscellaneous data from BE-10 or BE-11 for 1993-2016 */
/****************************************************************************************/
/****************************************************************************************/
%import (dbo_be11_misc,di16misc,'S:\BE11\Access2000\2016p.accdb'); * Contains 
miscellaneous data from BE-11 for 2016;
%import (dbo_be11_misc,di15misc,'S:\BE11\Access2000\2015r.accdb'); * Contains 
miscellaneous data from BE-11 for 2015;
%import (dbo_be10_misc,di14misc,'S:\BE11\Access2000\2014r.accdb'); * Contains 
miscellaneous data from BE-10 for 2014;
%import (dbo_be11_misc,di13misc,'S:\BE11\Access2000\2013r.accdb'); * Contains 
miscellaneous data from BE-11 for 2013;
%import (dbo_be11_misc,di12misc,'S:\BE11\Access2000\2012r.accdb'); * Contains 
miscellaneous data from BE-11 for 2012;
%import (dbo_be11_misc,di11misc,'S:\BE11\Access2000\2011r.accdb'); * Contains 
miscellaneous data from BE-11 for 2011;
%import (dbo_be11_misc,di10misc,'S:\BE11\Access2000\2010r.accdb'); * Contains 
miscellaneous data from BE-11 for 2010;
%import (dbo_be10_misc,di09misc,'S:\BE11\Access2000\2009r.accdb'); * Contains 
miscellaneous data from BE-10 for 2009;
%import (dbo_be11_misc,di08misc,'S:\BE11\Access2000\2008r.accdb'); * Contains 
miscellaneous data from BE-11 for 2008;
%import (dbo_be11_misc,di07misc,'S:\BE11\Access2000\2007r.mdb'); * Contains 
miscellaneous data from BE-11 for 2007;
%import (dbo_be11_misc,di06misc,'S:\BE11\Access2000\2006r.mdb'); * Contains 
miscellaneous data from BE-11 for 2006;
%import (dbo_be11_misc,di05misc,'S:\BE11\Access2000\2005r.mdb'); * Contains 
miscellaneous data from BE-11 for 2005;
%import (dbo_be10_misc,di04misc,'S:\BE11\Access2000\2004r.mdb'); * Contains 
miscellaneous data from BE-10 for 2004;
%import (dbo_be11_misc,di03misc,'S:\BE11\Access2000\2003r.mdb'); * Contains 
miscellaneous data from BE-11 for 2003;
%import (dbo_be11_misc,di02misc,'S:\BE11\Access2000\2002r.mdb'); * Contains 
miscellaneous data from BE-11 for 2002;
%import (dbo_be11_misc,di01misc,'S:\BE11\Access2000\2001r.mdb'); * Contains 
miscellaneous data from BE-11 for 2001;
%import (dbo_be11_misc,di00misc,'S:\BE11\Access2000\2000r.mdb'); * Contains 
miscellaneous data from BE-11 for 2000;
%import (dbo_be10_misc,di99misc,'S:\BE11\Access2000\1999r.mdb'); * Contains 
miscellaneous data from BE-10 for 1999;
%import (dbo_be11_misc,di98misc,'S:\BE11\Access2000\1998r.mdb'); * Contains 
miscellaneous data from BE-11 for 1998;
%import (dbo_be11_misc,di97misc,'S:\BE11\Access2000\1997r.mdb'); * Contains 
miscellaneous data from BE-11 for 1997;
%import (dbo_be11_misc,di96misc,'S:\BE11\Access2000\1996r.mdb'); * Contains 
miscellaneous data from BE-11 for 1996;
%import (dbo_be11_misc,di95misc,'S:\BE11\Access2000\1995r.mdb'); * Contains 
miscellaneous data from BE-11 for 1995;
%import (dbo_be10_aff_data7,di94misc,'S:\BE11\Access2000\1994r.mdb'); * Contains 
miscellaneous data from BE-10 for 1994;
%import (dbo_be11_misc,di93misc,'S:\BE11\Access2000\1993r.mdb'); * Contains 
miscellaneous data from BE-11 for 1993;

/****************************************************************************************/
/****************************************************************************************/
/* Reformat affiliate miscellaneous data from BE-10 or BE-11 for 1993-2016 to be consistent across all years */
/****************************************************************************************/
/****************************************************************************************/
* Reformat affiliate miscellaneous data to be consistent across all years;
%macro revmisc (x1,x2,x3,x4,x5,x6,x7);
	data &x1;
		set &x2;
		length BE11ID $12. ForeignID $12.;
		Year = &x3;
		BE11ID = &x4;
		ForeignID = &x5;
		EmpComp = &x6 * 1;
		RDexp = &x7 * 1;
		keep year be11id foreignid empcomp rdexp;
	run;
%mend revmisc;

%revmisc (di16miscr,di16misc,2016,us_id,foreign_id,emp_compen,rd_exp);
%revmisc (di15miscr,di15misc,2015,us_id,foreign_id,emp_compen,rd_exp);
%revmisc (di14miscr,di14misc,2014,us_id,foreign_id,emp_compen,rd);
%revmisc (di13miscr,di13misc,2013,us_id,foreign_id,emp_compen,rd_exp);
%revmisc (di12miscr,di12misc,2012,us_id,foreign_id,emp_compen,rd_exp);
%revmisc (di11miscr,di11misc,2011,us_id,foreign_id,emp_compen,rd_exp);
%revmisc (di10miscr,di10misc,2010,us_id,foreign_id,emp_compen,rd_exp);
%revmisc (di09miscr,di09misc,2009,us_id,foreign_id,emp_compen,rd);
%revmisc (di08miscr,di08misc,2008,us_id,foreign_id,emp_compen,rd_exp);
%revmisc (di07miscr,di07misc,2007,us_id,foreign_id,emp_compen,rd_exp);
%revmisc (di06miscr,di06misc,2006,us_id,foreign_id,emp_compen,rd_exp);
%revmisc (di05miscr,di05misc,2005,us_id,foreign_id,emp_compen,rd_exp);
%revmisc (di04miscr,di04misc,2004,us_id,foreign_id,emp_compen,rd);
%revmisc (di03miscr,di03misc,2003,us_id,foreign_id,emp_compen,rd_exp);
%revmisc (di02miscr,di02misc,2002,us_id,foreign_id,emp_compen,rd_exp);
%revmisc (di01miscr,di01misc,2001,us_id,foreign_id,emp_compen,rd_exp);
%revmisc (di00miscr,di00misc,2000,us_id,foreign_id,emp_compen,rd_exp);
%revmisc (di99miscr,di99misc,1999,us_id,foreign_id,emp_compen,rd);
%revmisc (di98miscr,di98misc,1998,us_id,foreign_id,emp_compen,rd_exp);
%revmisc (di97miscr,di97misc,1997,us_id,foreign_id,emp_compen,rd_exp);
%revmisc (di96miscr,di96misc,1996,us_id,foreign_id,emp_compen,rd_exp);
%revmisc (di95miscr,di95misc,1995,us_id,foreign_id,emp_compen,rd_exp);
%revmisc (di94miscr,di94misc,1994,us_id,foreign_id,emp_compen,rd);
%revmisc (di93miscr,di93misc,1993,us_id,foreign_id,emp_compen,rd_exp);

* Stack affiliate miscellaneous data for 1993-2016;
data affmiscstack;
	set di16miscr di15miscr di14miscr di13miscr di12miscr di11miscr di10miscr di09miscr 
	di08miscr di07miscr di06miscr di05miscr di04miscr di03miscr di02miscr di01miscr 
	di00miscr di99miscr di98miscr di97miscr di96miscr di95miscr di94miscr di93miscr;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Import affiliate value-added data from BE-10 or BE-11 for 1993-2016 */
/****************************************************************************************/
/****************************************************************************************/
%import (dbo_be11_value_added,di16va,'S:\BE11\Access2000\2016p.accdb'); * Contains 
value-added data from BE-11 for 2016;
%import (dbo_be11_value_added,di15va,'S:\BE11\Access2000\2015r.accdb'); * Contains 
value-added data from BE-11 for 2015;
%import (dbo_be10_value_added,di14va,'S:\BE11\Access2000\2014r.accdb'); * Contains 
value-added data from BE-10 for 2014;
%import (dbo_be11_value_added,di13va,'S:\BE11\Access2000\2013r.accdb'); * Contains 
value-added data from BE-11 for 2013;
%import (dbo_be11_value_added,di12va,'S:\BE11\Access2000\2012r.accdb'); * Contains 
value-added data from BE-11 for 2012;
%import (dbo_be11_value_added,di11va,'S:\BE11\Access2000\2011r.accdb'); * Contains 
value-added data from BE-11 for 2011;
%import (dbo_be11_value_added,di10va,'S:\BE11\Access2000\2010r.accdb'); * Contains 
value-added data from BE-11 for 2010;
%import (dbo_be11_value_added,di09va,'S:\BE11\Access2000\2009r.accdb'); * Contains 
value-added data from BE-10 for 2009;
%import (dbo_be11_value_added,di08va,'S:\BE11\Access2000\2008r.accdb'); * Contains 
value-added data from BE-11 for 2008;
%import (dbo_be11_value_added,di07va,'S:\BE11\Access2000\2007r.mdb'); * Contains 
value-added data from BE-11 for 2007;
%import ('11b06rf5',di06va,'S:\BE11\Access2000\2006r.mdb'); * Contains 
value-added data from BE-11 for 2006;
%import ('11b05rf5',di05va,'S:\BE11\Access2000\2005r.mdb'); * Contains 
value-added data from BE-11 for 2005;
%import ('11b04rf5',di04va1,'S:\BE11\Access2000\2004r.mdb'); * Contains 
value-added data from BE-10 for 2004;
%import (dbo_be10_inc_stmt,di04va2,'S:\BE11\Access2000\2004r.mdb'); * Contains 
value-added data from BE-10 for 2004;
%import (dbo_be10_ppe_re,di04va3,'S:\BE11\Access2000\2004r.mdb'); * Contains 
value-added data from BE-10 for 2004;
%import ('11b03rf5',di03va,'S:\BE11\Access2000\2003r.mdb'); * Contains 
value-added data from BE-11 for 2003;
%import ('11b02rf5',di02va,'S:\BE11\Access2000\2002r.mdb'); * Contains 
value-added data from BE-11 for 2002;
%import ('11b01rf5',di01va,'S:\BE11\Access2000\2001r.mdb'); * Contains 
value-added data from BE-11 for 2001;
%import ('11b00rf5',di00va,'S:\BE11\Access2000\2000r.mdb'); * Contains 
value-added data from BE-11 for 2000;
%import ('11b99rf5',di99va,'S:\BE11\Access2000\1999r.mdb'); * Contains 
value-added data from BE-10 for 1999;
%import ('11b98rf5',di98va,'S:\BE11\Access2000\1998r.mdb'); * Contains 
value-added data from BE-11 for 1998;
%import ('11b97rf5',di97va,'S:\BE11\Access2000\1997r.mdb'); * Contains 
value-added data from BE-11 for 1997;
%import ('11b96rf5',di96va,'S:\BE11\Access2000\1996r.mdb'); * Contains 
value-added data from BE-11 for 1996;
%import ('11b95rf5',di95va,'S:\BE11\Access2000\1995r.mdb'); * Contains 
value-added data from BE-11 for 1995;
%import ('11b94rf5',di94va,'S:\BE11\Access2000\1994r.mdb'); * Contains 
value-added data from BE-10 for 1994;
%import ('11b93rf5',di93va,'S:\BE11\Access2000\1993r.mdb'); * Contains 
value-added data from BE-11 for 1993;

/****************************************************************************************/
/****************************************************************************************/
/* Combine value-added data sets for 2004 */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = di04va1;
by us_id foreign_id;
proc sort data = di04va2;
by us_id foreign_id;
proc sort data = di04va3;
by us_id foreign_id;
data di04va;
merge di04va1 di04va2 di04va3;
by us_id foreign_id;
keep us_id foreign_id va ptr net_income fgn_income_tax depl cap_gl income_eqty_invest_fa netip ibt depr;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Reformat affiliate value-added data from BE-10 or BE-11 for 1993-2016 to be consistent across all years */
/****************************************************************************************/
/****************************************************************************************/
* Reformat affiliate value-added data to be consistent across all years;
%macro revva (x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15);
	data &x1;
		set &x2;
		length BE11ID $12. ForeignID $12.;
		Year = &x3;
		BE11ID = &x4;
		if year in (2004,2005) then do;
			if substr(&x5,1,1) ne '5' then ForeignID = &x5;
			if substr(&x5,1,1) = '5' then ForeignID = &x5||'x';
		end;
		if year not in (2004,2005) then do;
			ForeignID = &x5;
		end;
		if &x5 = '0000' or &x5 = ' ' then delete;
		VA1 = &x6 * 1; * value-added;
		PTR1 = &x7 * 1; * profit type return;
		NI1 = &x8 * 1; * net income;
		Tax1 = &x9 * 1; * foreign income tax;
		Depl1 = &x10 * 1; * depletion;
		GL1 = &x11 * 1; * capital gain or loss;
		IQ1 = &x12 * 1; * income from equity;
		NIP1 = &x13 * 1; * net interest paid;
		IBT1 = &x14 * 1; * indirect business taxes;
		CCA1 = &x15 * 1; * capital consumption allowance;
		keep year be11id foreignid va1 ptr1 ni1 tax1 depl1 gl1 iq1 nip1 ibt1 cca1;
	run;
%mend revva;

%revva (di16var,di16va,2016,us_id,foreign_id,value_added,profit_type_return,net_income,income_taxes,depletion,cap_gl,income_eqty_invest,net_interest,indirect_business_taxes,cca);
%revva (di15var,di15va,2015,us_id,foreign_id,value_added,profit_type_return,net_income,income_taxes,depletion,cap_gl,income_eqty_invest,net_interest,indirect_business_taxes,cca);
%revva (di14var,di14va,2014,us_id,foreign_id,value_added,profit_type_return,net_income,income_taxes,depletion,cap_gl,income_eqty_invest,net_interest,indirect_business_taxes,cca);
%revva (di13var,di13va,2013,us_id,foreign_id,value_added,profit_type_return,net_income,income_taxes,depletion,cap_gl,income_eqty_invest,net_interest,indirect_business_taxes,cca);
%revva (di12var,di12va,2012,us_id,foreign_id,value_added,profit_type_return,net_income,income_taxes,depletion,cap_gl,income_eqty_invest,net_interest,indirect_business_taxes,cca);
%revva (di11var,di11va,2011,us_id,foreign_id,value_added,profit_type_return,net_income,income_taxes,depletion,cap_gl,income_eqty_invest,net_interest,indirect_business_taxes,cca);
%revva (di10var,di10va,2010,us_id,foreign_id,value_added,profit_type_return,net_income,income_taxes,depletion,cap_gl,income_eqty_invest,net_interest,indirect_business_taxes,cca);
%revva (di09var,di09va,2009,us_id,foreign_id,value_added,profit_type_return,net_income,income_taxes,depletion,cap_gl,income_eqty_invest,net_interest,indirect_business_taxes,cca);
%revva (di08var,di08va,2008,us_id,foreign_id,value_added,profit_type_return,net_income,income_taxes,depletion,cap_gl,income_eqty_invest,net_interest,indirect_business_taxes,cca);
%revva (di07var,di07va,2007,us_id,foreign_id,value_added,profit_type_return,net_income,income_taxes,depletion,cap_gl,income_eqty_invest,net_interest,indirect_business_taxes,cca);
%revva (di06var,di06va,2006,us_id,foreign_id,va,ptr,net_income,fgn_income_tax,depl,cap_gl,inc_eqty_invest,net_ip,ibt_etc,depr);
%revva (di05var,di05va,2005,us_id,foreign_id,va,ptr,net_income,fgn_income_tax,depl,cap_gl,inc_eqty_invest,net_ip,ibt_etc,depr);
%revva (di04var,di04va,2004,us_id,foreign_id,va,ptr,net_income,fgn_income_tax,depl,cap_gl,income_eqty_invest_fa,netip,ibt,depr);
%revva (di03var,di03va,2003,us_id,foreign_id,va03,ptr03,net_income03,fgn_income_tax03,depletion03,cap_gl03,inc_eqty_invest03,net_ip03,ibt_etc03,cca03);
%revva (di02var,di02va,2002,us_id,foreign_id,va02,ptr02,net_income02,fgn_income_tax02,depletion02,cap_gl02,inc_eqty_invest02,net_ip02,ibt_etc02,cca02);
%revva (di01var,di01va,2001,par_id_6,aff_id_4,gp,ptr,net_income,foreign_inc_tax,depletion,cap_g_l,income_from_eq,net_ip,ibt_etc,cca);
%revva (di00var,di00va,2000,us_id,aff_id_4,gp,ptr,net_income,foreign_inc_tax,depletion,cap_g_l,income_from_eq,net_ip,ibt_etc,cca);
%revva (di99var,di99va,1999,par_id_6,aff_id_5,gp,ptr,net_income,foreign_inc_tax,depletion,cap_g_l,income_from_eq,net_ip,ibt_etc,cca);
%revva (di98var,di98va,1998,par_id_6,aff_id_4,gp_98,ptr_98,net_income_98,foreign_inc_tax_98,depletion_98,cap_g_l_98,income_from_eq_98,net_ip_98,ibt_etc_98,cca_98);
%revva (di97var,di97va,1997,par_id_6,aff_id_4,gp_97,ptr_97,net_income_97,foreign_inc_tax_97,depletion_97,cap_g_l_97,income_from_eq_97,net_ip_97,ibt_etc_97,cca_97);
%revva (di96var,di96va,1996,par_id_6,aff_id_4,gp_96,ptr_96,net_income_96,foreign_inc_tax_96,depletion_96,cap_g_l_96,income_from_eq_96,net_ip_96,ibt_etc_96,cca_96);
%revva (di95var,di95va,1995,par_id_6,aff_id_4,gp_95,ptr_95,net_income_95,foreign_inc_tax_95,depletion_95,cap_g_l_95,income_from_eq_95,net_ip_95,ibt_etc_95,cca_95);
%revva (di94var,di94va,1994,us_id,foreign_id,gp_94,ptr_94,net_income_94,foreign_inc_tax_94,depletion_94,cap_g_l_94,income_from_eq_94,net_ip_94,ibt_etc_94,cca_94);
%revva (di93var,di93va,1993,par_id_6,aff_id_4,gp_93,ptr_93,net_income_93,foreign_inc_tax_93,depletion_93,cap_g_l_93,income_from_eq_93,net_ip_93,ibt_etc,cca_93);

* Stack affiliate miscellaneous data for 1993-2016;
data affvastack;
	set di16var di15var di14var di13var di12var di11var di10var di09var di08var di07var 
	di06var di05var di04var di03var di02var di01var di00var di99var di98var di97var 
	di96var di95var di94var di93var;
	rename va1 = VA ptr1 = PTR ni1 = NI tax1 = Tax depl1 = Depl gl1 = GL iq1 = IQ nip1 = NIP ibt1 = IBT cca1 = CCA;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Import reporter data from BE-10 or BE-11 for 1993-2016 */
/****************************************************************************************/
/****************************************************************************************/
%import (dbo_be11_reporter,di16rep,'S:\BE11\Access2000\2016p.accdb'); * Contains 
reporter data from BE-11 for 2016;
%import (dbo_be11_value_added,di16repva,'S:\BE11\Access2000\2016p.accdb'); * Contains 
reporter value-added data from BE-11 for 2016;
%import (dbo_be11_reporter,di15rep,'S:\BE11\Access2000\2015r.accdb'); * Contains 
reporter data from BE-11 for 2015;
%import (dbo_be11_value_added,di15repva,'S:\BE11\Access2000\2015r.accdb'); * Contains 
reporter value-added data from BE-11 for 2015;
%import (dbo_be10_rep_ident,di14repident,'S:\BE11\Access2000\2014r.accdb'); * Contains 
reporter identifying data from BE-10 for 2014;
%import (dbo_be10_rep_inc_bal,di14repbsis,'S:\BE11\Access2000\2014r.accdb'); * Contains 
reporter BS and IS data from BE-10 for 2014;
%import (dbo_be10_rep_sales,di14repsales,'S:\BE11\Access2000\2014r.accdb'); * Contains 
reporter sales data from BE-10 for 2014;
%import (dbo_be10_rep_misc,di14repmisc,'S:\BE11\Access2000\2014r.accdb'); * Contains 
reporter miscellaneous data from BE-10 for 2014;
%import (dbo_be10_value_added,di14repva,'S:\BE11\Access2000\2014r.accdb'); * Contains 
reporter value-added data from BE-10 for 2014;
%import (dbo_be11_reporter,di13rep,'S:\BE11\Access2000\2013r.accdb'); * Contains 
reporter data from BE-11 for 2013;
%import (dbo_be11_value_added,di13repva,'S:\BE11\Access2000\2013r.accdb'); * Contains 
reporter value-added data from BE-11 for 2013;
%import (dbo_be11_reporter,di12rep,'S:\BE11\Access2000\2012r.accdb'); * Contains 
reporter data from BE-11 for 2012;
%import (dbo_be11_value_added,di12repva,'S:\BE11\Access2000\2012r.accdb'); * Contains 
reporter value-added data from BE-11 for 2012;
%import (dbo_be11_reporter,di11rep,'S:\BE11\Access2000\2011r.accdb'); * Contains 
reporter data from BE-11 for 2011;
%import (dbo_be11_value_added,di11repva,'S:\BE11\Access2000\2011r.accdb'); * Contains 
reporter value-added data from BE-11 for 2011;
%import (dbo_be11_reporter,di10rep,'S:\BE11\Access2000\2010r.accdb'); * Contains 
reporter data from BE-11 for 2010;
%import (dbo_be11_value_added,di10repva,'S:\BE11\Access2000\2010r.accdb'); * Contains 
reporter value-added data from BE-11 for 2010;
%import (dbo_be10_rep_ident,di09repident,'S:\BE11\Access2000\2009r.accdb'); * Contains 
reporter identifying data from BE-10 for 2009;
%import (dbo_be10_rep_inc_bal,di09repbsis,'S:\BE11\Access2000\2009r.accdb'); * Contains 
reporter BS and IS data from BE-10 for 2009;
%import (dbo_be10_rep_sales,di09repsales,'S:\BE11\Access2000\2009r.accdb'); * Contains 
reporter sales data from BE-10 for 2009;
%import (dbo_be10_rep_misc,di09repmisc,'S:\BE11\Access2000\2009r.accdb'); * Contains 
reporter miscellaneous data from BE-10 for 2009;
%import (dbo_be11_value_added,di09repva,'S:\BE11\Access2000\2009r.accdb'); * Contains 
reporter value-added data from BE-10 for 2009;
%import (dbo_be11_reporter,di08rep,'S:\BE11\Access2000\2008r.accdb'); * Contains 
reporter data from BE-11 for 2008;
%import (dbo_be11_value_added,di08repva,'S:\BE11\Access2000\2008r.accdb'); * Contains 
reporter value-added data from BE-11 for 2008;
%import (dbo_be11_reporter,di07rep,'S:\BE11\Access2000\2007r.mdb'); * Contains 
reporter data from BE-11 for 2007;
%import (dbo_be11_value_added,di07repva,'S:\BE11\Access2000\2007r.mdb'); * Contains 
reporter value-added data from BE-11 for 2007;
%import (dbo_be11_reporter,di06rep,'S:\BE11\Access2000\2006r.mdb'); * Contains 
reporter data from BE-11 for 2006;
%import ('11a06rf5',di06repva,'S:\BE11\Access2000\2006r.mdb'); * Contains 
reporter value-added data from BE-11 for 2006;
%import (dbo_be11_reporter,di05rep,'S:\BE11\Access2000\2005r.mdb'); * Contains 
reporter data from BE-11 for 2005;
%import ('11a05rf5',di05repva,'S:\BE11\Access2000\2005r.mdb'); * Contains 
reporter value-added data from BE-11 for 2005;
%import (dbo_be10_rep_ident,di04repident,'S:\BE11\Access2000\2004r.mdb'); * Contains 
reporter identifying data from BE-10 for 2004;
%import (dbo_be10_rep_inc_bal,di04repbsis,'S:\BE11\Access2000\2004r.mdb'); * Contains 
reporter BS and IS data from BE-10 for 2004;
%import (dbo_be10_rep_sales,di04repsales,'S:\BE11\Access2000\2004r.mdb'); * Contains 
reporter sales data from BE-10 for 2004;
%import (dbo_be10_rep_misc,di04repmisc,'S:\BE11\Access2000\2004r.mdb'); * Contains 
reporter miscellaneous data from BE-10 for 2004;
%import ('11a04rf5',di04repva,'S:\BE11\Access2000\2004r.mdb'); * Contains 
reporter value-added data from BE-10 for 2004;
%import (dbo_be11_reporter,di03rep,'S:\BE11\Access2000\2003r.mdb'); * Contains 
reporter data from BE-11 for 2003;
%import ('11a03rf5',di03repva,'S:\BE11\Access2000\2003r.mdb'); * Contains 
reporter value-added data from BE-11 for 2003;
%import (dbo_be11_reporter,di02rep,'S:\BE11\Access2000\2002r.mdb'); * Contains 
reporter data from BE-11 for 2002;
%import ('11a02rf5',di02repva,'S:\BE11\Access2000\2002r.mdb'); * Contains 
reporter value-added data from BE-11 for 2002;
%import (dbo_be11_reporter,di01rep,'S:\BE11\Access2000\2001r.mdb'); * Contains 
reporter data from BE-11 for 2001;
%import ('11a01rf5',di01repva,'S:\BE11\Access2000\2001r.mdb'); * Contains 
reporter value-added data from BE-11 for 2001;
%import (dbo_be11_reporter,di00rep,'S:\BE11\Access2000\2000r.mdb'); * Contains 
reporter data from BE-11 for 2000;
%import ('11a00rf5',di00repva,'S:\BE11\Access2000\2000r.mdb'); * Contains 
reporter value-added data from BE-11 for 2000;
%import (dbo_be10_rep_ident,di99repident,'S:\BE11\Access2000\1999r.mdb'); * Contains 
reporter identifying data from BE-10 for 1999;
%import (dbo_be10_rep_inc_bal,di99repbsis,'S:\BE11\Access2000\1999r.mdb'); * Contains 
reporter BS and IS data from BE-10 for 1999;
%import (dbo_be10_rep_sales,di99repsales,'S:\BE11\Access2000\1999r.mdb'); * Contains 
reporter sales data from BE-10 for 1999;
%import (dbo_be10_rep_misc,di99repmisc,'S:\BE11\Access2000\1999r.mdb'); * Contains 
reporter miscellaneous data from BE-10 for 1999;
%import ('11A99RF5',di99repva,'S:\BE11\Access2000\1999r.mdb'); * Contains 
reporter value-added data from BE-10 for 1999;
%import (dbo_be11_reporter,di98rep,'S:\BE11\Access2000\1998r.mdb'); * Contains 
reporter data from BE-11 for 1998;
%import ('11A98RF5',di98repva,'S:\BE11\Access2000\1998r.mdb'); * Contains 
reporter value-added data from BE-11 for 1998;
%import (dbo_be11_reporter,di97rep,'S:\BE11\Access2000\1997r.mdb'); * Contains 
reporter data from BE-11 for 1997;
%import ('11A97RF5',di97repva,'S:\BE11\Access2000\1997r.mdb'); * Contains 
reporter value-added data from BE-11 for 1997;
%import (dbo_be11_reporter,di96rep,'S:\BE11\Access2000\1996r.mdb'); * Contains 
reporter data from BE-11 for 1996;
%import ('11A96RF5',di96repva,'S:\BE11\Access2000\1996r.mdb'); * Contains 
reporter value-added data from BE-11 for 1996;
%import (dbo_be11_reporter,di95rep,'S:\BE11\Access2000\1995r.mdb'); * Contains 
reporter data from BE-11 for 1995;
%import ('11A95RF5',di95repva,'S:\BE11\Access2000\1995r.mdb'); * Contains 
reporter value-added data from BE-11 for 1995;
%import (dbo_be10_rep_data1,di94repident,'S:\BE11\Access2000\1994r.mdb'); * Contains 
reporter identifying data from BE-10 for 1994;
%import (dbo_be10_rep_data2,di94repbsis,'S:\BE11\Access2000\1994r.mdb'); * Contains 
reporter BS and IS data from BE-10 for 1994;
%import (dbo_be10_rep_data4,di94repsales,'S:\BE11\Access2000\1994r.mdb'); * Contains 
reporter sales data from BE-10 for 1994;
%import (dbo_be10_rep_data4,di94repmisc,'S:\BE11\Access2000\1994r.mdb'); * Contains 
reporter miscellaneous data from BE-10 for 1994;
%import ('11A94RF5',di94repva,'S:\BE11\Access2000\1994r.mdb'); * Contains 
reporter value-added data from BE-10 for 1994;
%import (dbo_be11_reporter,di93rep,'S:\BE11\Access2000\1993r.mdb'); * Contains 
reporter data from BE-11 for 1993;

/****************************************************************************************/
/****************************************************************************************/
/* Reformat reporter identifying data from BE-10 or BE-11 for 1993-2016 to be consistent across all years */
/****************************************************************************************/
/****************************************************************************************/
%macro revrepi (x1,x2,x3,x4,x5,x6,x7);
	data &x1;
		set &x2;
		length BE11ID $12. ForeignID $12. BE15ID 8.;
		Year = &x3;
		BE11ID = &x4;
		ForeignID = '0000';
		Industry = &x5;
		Country = 999;
		DocType = &x6;
		BE15ID = &x7 * 1;
		USreporter = 1;
		keep year be11id foreignid industry country doctype be15id usreporter;
	run;
%mend revrepi;

%revrepi (di16repi,di16rep,2016,us_id,naics_id,doc_type,be15_id);
%revrepi (di15repi,di15rep,2015,us_id,naics_id,doc_type,be15_id);
%revrepi (di14repi,di14repident,2014,us_id,naics_id,doc_type,be15_id);
%revrepi (di13repi,di13rep,2013,us_id,naics_id,doc_type,be15_id);
%revrepi (di12repi,di12rep,2012,us_id,naics_id,doc_type,be15_id);
%revrepi (di11repi,di11rep,2011,us_id,naics_id,doc_type,be15_id);
%revrepi (di10repi,di10rep,2010,us_id,naics_id,doc_type,be15_id);
%revrepi (di09repi,di09repident,2009,us_id,naics_id,doc_type,be15_id);
%revrepi (di08repi,di08rep,2008,us_id,naics_id,doc_type,be15_id);
%revrepi (di07repi,di07rep,2007,us_id,naics_id,doc_type,be15_id);
%revrepi (di06repi,di06rep,2006,us_id,naics_id,doc_type,be15_id);
%revrepi (di05repi,di05rep,2005,us_id,naics_id,doc_type,be15_id);
%revrepi (di04repi,di04repident,2004,us_id,naics_id,doc_type,be15_id);
%revrepi (di03repi,di03rep,2003,us_id,naics_id,doc_type,be15_id);
%revrepi (di02repi,di02rep,2002,us_id,naics_id,doc_type,be15_id);
%revrepi (di01repi,di01rep,2001,us_id,naics_id,doc_type,be15_id);
%revrepi (di00repi,di00rep,2000,us_id,naics_id,doc_type,be15_id);
%revrepi (di99repi,di99repident,1999,us_id,naics_id,doc_type,be15_id);
%revrepi (di98repi,di98rep,1998,us_id,sic_ind,doc_type,be15_id);
%revrepi (di97repi,di97rep,1997,us_id,sic_ind,doc_type,be15_id);
%revrepi (di96repi,di96rep,1996,us_id,sic_ind,doc_type,be15_id);
%revrepi (di95repi,di95rep,1995,us_id,sic_ind,doc_type,be15_id);
%revrepi (di94repi,di94repident,1994,us_id,ind,doc_type,be15_id);
%revrepi (di93repi,di93rep,1993,us_id,sic_ind,doc_type,be15_id);

* Stack reporter identifying data for 1993-2016;
data repidentstack;
	set di16repi di15repi di14repi di13repi di12repi di11repi di10repi di09repi di08repi 
	di07repi di06repi di05repi di04repi di03repi di02repi di01repi di00repi di99repi 
	di98repi di97repi di96repi di95repi di94repi di93repi;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Reformat reporter balance sheet and income statement data from BE-10 or BE-11 for 
1993-2014 to be consistent across all years */
/****************************************************************************************/
/****************************************************************************************/
%macro revrepbsis (x1,x2,x3,x4,x5,x6);
	data &x1;
		set &x2;
		length BE11ID $12. ForeignID $12.;
		Year = &x3;
		BE11ID = &x4;
		ForeignID = '0000';
		GrPPE = &x5 * 1;
		AccDepr = abs(&x6) * 1;
		keep year be11id foreignid grppe accdepr;
	run;
%mend revrepbsis;

%revrepbsis (di14repbsisr,di14repbsis,2014,us_id,ppe_net,0);
%revrepbsis (di09repbsisr,di09repbsis,2009,us_id,ppe_net,0);
%revrepbsis (di04repbsisr,di04repbsis,2004,us_id,ppe_net,0);
%revrepbsis (di99repbsisr,di99repbsis,1999,us_id,ppe_net,0);
%revrepbsis (di94repbsisr,di94repbsis,1994,us_id,ppe_gross,accum_depr);

* Stack reporter balance sheet and income statement data for 1993-2014;
data repbsisstack;
	set di14repbsisr di09repbsisr di04repbsisr di99repbsisr di94repbsisr;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Reformat reporter sales data from BE-10 or BE-11 for 1993-2016 to be consistent across all years */
/****************************************************************************************/
/****************************************************************************************/
%macro revrepsales (x1,x2,x3,x4,x5,x6,x7);
	data &x1;
		set &x2;
		length BE11ID $12. ForeignID $12.;
		Year = &x3;
		if year = 1999 and period_year = 2004 then delete;
		BE11ID = &x4;
		ForeignID = '0000';
		Sales1 = &x5 * 1;
		UnaffSales = sum(&x6,&x7);
		keep year be11id foreignid sales1 unaffsales;
	run;
%mend revrepsales;

%revrepsales (di16repsalesr,di16rep,2016,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di15repsalesr,di15rep,2015,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di14repsalesr,di14repsales,2014,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di13repsalesr,di13rep,2013,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di12repsalesr,di12rep,2012,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di11repsalesr,di11rep,2011,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di10repsalesr,di10rep,2010,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di09repsalesr,di09repsales,2009,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di08repsalesr,di08rep,2008,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di07repsalesr,di07rep,2007,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di06repsalesr,di06rep,2006,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di05repsalesr,di05rep,2005,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di04repsalesr,di04repsales,2004,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di03repsalesr,di03rep,2003,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di02repsalesr,di02rep,2002,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di01repsalesr,di01rep,2001,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di00repsalesr,di00rep,2000,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di99repsalesr,di99repsales,1999,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di98repsalesr,di98rep,1998,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di97repsalesr,di97rep,1997,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di96repsalesr,di96rep,1996,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di95repsalesr,di95rep,1995,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di94repsalesr,di94repsales,1994,us_id,sales,sales_us,sales_oth_fgn);
%revrepsales (di93repsalesr,di93rep,1993,us_id,sales,sales_us,sales_oth_fgn);

* Stack reporter sales data for 1993-2016;
data repsalestack;
	set di16repsalesr di15repsalesr di14repsalesr di13repsalesr di12repsalesr 
	di11repsalesr di10repsalesr di09repsalesr di08repsalesr di07repsalesr di06repsalesr 
	di05repsalesr di04repsalesr di03repsalesr di02repsalesr di01repsalesr di00repsalesr 
	di99repsalesr di98repsalesr di97repsalesr di96repsalesr di95repsalesr di94repsalesr 
	di93repsalesr;
	rename sales1 = Sales;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Reformat reporter miscellaneous data from BE-10 or BE-11 for 1993-2016 to be consistent across all years */
/****************************************************************************************/
/****************************************************************************************/
%macro revrepmisc (x1,x2,x3,x4,x5,x6);
	data &x1;
		set &x2;
		length BE11ID $12. ForeignID $12.;
		Year = &x3;
		BE11ID = &x4;
		ForeignID = '0000';
		EmpComp = &x5 * 1;
		RDexp = &x6 * 1;
		keep year be11id foreignid empcomp rdexp;
	run;
%mend revrepmisc;

%revrepmisc (di16repmiscr,di16rep,2016,us_id,emp_compen,rd_exp);
%revrepmisc (di15repmiscr,di15rep,2015,us_id,emp_compen,rd_exp);
%revrepmisc (di14repmiscr,di14repmisc,2014,us_id,emp_compen,rd);
%revrepmisc (di13repmiscr,di13rep,2013,us_id,emp_compen,rd_exp);
%revrepmisc (di12repmiscr,di12rep,2012,us_id,emp_compen,rd_exp);
%revrepmisc (di11repmiscr,di11rep,2011,us_id,emp_compen,rd_exp);
%revrepmisc (di10repmiscr,di10rep,2010,us_id,emp_compen,rd_exp);
%revrepmisc (di09repmiscr,di09repmisc,2009,us_id,emp_compen,rd);
%revrepmisc (di08repmiscr,di08rep,2008,us_id,emp_compen,rd_exp);
%revrepmisc (di07repmiscr,di07rep,2007,us_id,emp_compen,rd_exp);
%revrepmisc (di06repmiscr,di06rep,2006,us_id,emp_compen,rd_exp);
%revrepmisc (di05repmiscr,di05rep,2005,us_id,emp_compen,rd_exp);
%revrepmisc (di04repmiscr,di04repmisc,2004,us_id,emp_compen,rd);
%revrepmisc (di03repmiscr,di03rep,2003,us_id,emp_compen,rd_exp);
%revrepmisc (di02repmiscr,di02rep,2002,us_id,emp_compen,rd_exp);
%revrepmisc (di01repmiscr,di01rep,2001,us_id,emp_compen,rd_exp);
%revrepmisc (di00repmiscr,di00rep,2000,us_id,emp_compen,rd_exp);
%revrepmisc (di99repmiscr,di99repmisc,1999,us_id,emp_compen,rd);
%revrepmisc (di98repmiscr,di98rep,1998,us_id,emp_compen,rd_exp);
%revrepmisc (di97repmiscr,di97rep,1997,us_id,emp_compen,rd_exp);
%revrepmisc (di96repmiscr,di96rep,1996,us_id,emp_compen,rd_exp);
%revrepmisc (di95repmiscr,di95rep,1995,us_id,emp_compen,rd_exp);
%revrepmisc (di94repmiscr,di94repmisc,1994,us_id,emp_compen,rd);
%revrepmisc (di93repmiscr,di93rep,1993,us_id,emp_compen,rd_exp);

* Stack reporter miscellaneous data for 1993-2016;
data repmiscstack;
	set di16repmiscr di15repmiscr di14repmiscr di13repmiscr di12repmiscr di11repmiscr 
	di10repmiscr di09repmiscr di08repmiscr di07repmiscr di06repmiscr di05repmiscr 
	di04repmiscr di03repmiscr di02repmiscr di01repmiscr di00repmiscr di99repmiscr 
	di98repmiscr di97repmiscr di96repmiscr di95repmiscr di94repmiscr di93repmiscr;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Reformat reporter value-added data from BE-10 or BE-11 for 1993-2016 to be consistent across all years */
/****************************************************************************************/
/****************************************************************************************/
%macro revrepva (x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15);
	data &x1;
		set &x2;
		length BE11ID $12. ForeignID $12.;
		Year = &x3;
		BE11ID = &x4;
		ForeignID = '0000';
		if &x5 ne '0000' then delete;
		VA1 = &x6 * 1; * value-added;
		PTR1 = &x7 * 1; * profit type return;
		NI1 = &x8 * 1; * net income;
		Tax1 = &x9 * 1; * foreign income tax;
		Depl1 = &x10 * 1; * depletion;
		GL1 = &x11 * 1; * capital gain or loss;
		IQ1 = &x12 * 1; * income from equity;
		NIP1 = &x13 * 1; * net interest paid;
		IBT1 = &x14 * 1; * indirect business taxes;
		CCA1 = &x15 * 1; * capital consumption allowance;
		keep year be11id foreignid va1 ptr1 ni1 tax1 depl1 gl1 iq1 nip1 ibt1 cca1;
	run;
%mend revrepva;

%revrepva (di16repvar,di16repva,2016,us_id,foreign_id,value_added,profit_type_return,net_income,income_taxes,depletion,cap_gl,income_eqty_invest,net_interest,other_taxes,cca);
%revrepva (di15repvar,di15repva,2015,us_id,foreign_id,value_added,profit_type_return,net_income,income_taxes,depletion,cap_gl,income_eqty_invest,net_interest,other_taxes,cca);
%revrepva (di14repvar,di14repva,2014,us_id,foreign_id,value_added,profit_type_return,net_income,income_taxes,depletion,cap_gl,income_eqty_invest,net_interest,other_taxes,cca);
%revrepva (di13repvar,di13repva,2013,us_id,foreign_id,value_added,profit_type_return,net_income,income_taxes,depletion,cap_gl,income_eqty_invest,net_interest,other_taxes,cca);
%revrepva (di12repvar,di12repva,2012,us_id,foreign_id,value_added,profit_type_return,net_income,income_taxes,depletion,cap_gl,income_eqty_invest,net_interest,other_taxes,cca);
%revrepva (di11repvar,di11repva,2011,us_id,foreign_id,value_added,profit_type_return,net_income,income_taxes,depletion,cap_gl,income_eqty_invest,net_interest,other_taxes,cca);
%revrepva (di10repvar,di10repva,2010,us_id,foreign_id,value_added,profit_type_return,net_income,income_taxes,depletion,cap_gl,income_eqty_invest,net_interest,other_taxes,cca);
%revrepva (di09repvar,di09repva,2009,us_id,foreign_id,value_added,profit_type_return,net_income,income_taxes,depletion,cap_gl,income_eqty_invest,net_interest,other_taxes,cca);
%revrepva (di08repvar,di08repva,2008,us_id,foreign_id,value_added,profit_type_return,net_income,income_taxes,depletion,cap_gl,income_eqty_invest,net_interest,other_taxes,cca);
%revrepva (di07repvar,di07repva,2007,us_id,foreign_id,value_added,profit_type_return,net_income,income_taxes,depletion,cap_gl,income_eqty_invest,net_interest,other_taxes,cca);
%revrepva (di06repvar,di06repva,2006,us_id,foreignid,va,ptr,net_income,us_income_tax,depl,cap_gl,income_from_eq,net_ip,int_paid,depr);
%revrepva (di05repvar,di05repva,2005,us_id,foreignid,va,ptr,net_income,us_income_tax,depl,cap_gl,income_from_eq,net_ip,int_paid,depr);
%revrepva (di04repvar,di04repva,2004,us_id,foreignid,va,ptr,net_income,us_income_tax,depl,cap_gl,income_from_eq,netip,int_paid,depr);
%revrepva (di03repvar,di03repva,2003,us_id,foreignid,va03,ptr03,net_income03,us_income_tax03,depletion03,cap_gl03,income_from_eq03,net_ip03,ibt_etc03,cca03);
%revrepva (di02repvar,di02repva,2002,us_id,foreignid,va02,ptr02,net_income02,us_income_tax02,depletion02,cap_gl02,income_from_eq02,net_ip02,ibt_etc02,cca02);
%revrepva (di01repvar,di01repva,2001,us_id,foreignid,gp,ptr,net_income,us_inc_tax,depletion,cap_g_l,income_from_eq,net_ip,ibt_etc,cca);
%revrepva (di00repvar,di00repva,2000,par_id_6,foreignid,gp,ptr,net_income,us_inc_tax,depletion,cap_gl,income_from_eq,net_ip,ibt_etc,cca);
%revrepva (di99repvar,di99repva,1999,us_id,foreignid,gp,ptr,net_income,us_inc_tax,depletion,cap_g_l,income_from_eq,net_ip,ibt_etc,cca);
%revrepva (di98repvar,di98repva,1998,par_id_6,foreignid,gp_98,ptr_98,net_income_98,us_inc_tax_98,depletion_98,cap_g_l_98,income_from_eq_98,net_ip_98,ibt_etc_98,cca_98);
%revrepva (di97repvar,di97repva,1997,par_id_6,foreignid,gp_97,ptr_97,net_income_97,us_inc_tax_97,depletion_97,cap_g_l_97,income_from_eq_97,net_ip_97,ibt_etc_97,cca_97);
%revrepva (di96repvar,di96repva,1996,par_id_6,foreignid,gp_96,ptr_96,net_income_96,us_inc_tax_96,depletion_96,cap_g_l_96,income_from_eq_96,net_ip_96,ibt_etc_96,cca_96);
%revrepva (di95repvar,di95repva,1995,par_id_6,foreignid,gp_95,ptr_95,net_income_95,us_inc_tax_95,depletion_95,cap_g_l_95,income_from_eq_95,net_ip_95,ibt_etc_95,cca_95);
%revrepva (di94repvar,di94repva,1994,us_id,foreignid,gp_94,ptr_94,net_income_94,us_inc_tax_94,depletion_94,cap_g_l_94,income_from_eq_94,net_ip_94,ibt_etc_94,cca_94);

* Stack reporter value-added data for 1993-2016;
data repvastack;
	set di16repvar di15repvar di14repvar di13repvar di12repvar di11repvar di10repvar 
	di09repvar di08repvar di07repvar di06repvar di05repvar di04repvar di03repvar 
	di02repvar di01repvar di00repvar di99repvar di98repvar di97repvar di96repvar 
	di95repvar di94repvar;
	rename va1 = VA ptr1 = PTR ni1 = NI tax1 = Tax depl1 = Depl gl1 = GL iq1 = IQ nip1 = NIP ibt1 = IBT cca1 = CCA;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Merge reporter data from BE-10 or BE-11 with U.S. affiliate data from BE-15 for 
1993-2016 to identify foreign-owned U.S. parents */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = repidentstack;
	by year be15id;
proc sort data = usaffstack;
	by year be15id;
data identifyforeign;
	merge repidentstack usaffstack;
	by year be15id;
	if usreporter ne 1 then delete;
* Set missing values to zero;
	array changemiss _numeric_;
	do over changemiss;
		if majforowned = . then majforowned = 0; 
	end;
	keep year be11id be15id majforowned;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Merge reporter data from BE-10 or BE-11 for 1993-2016 */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = identifyforeign;
	by year be11id;
proc sort data = repidentstack;
	by year be11id;
proc sort data = repbsisstack;
	by year be11id;
proc sort data = repsalestack;
	by year be11id;
proc sort data = repmiscstack;
	by year be11id;
proc sort data = repvastack;
	by year be11id;
data repmerge;
	merge identifyforeign repidentstack repbsisstack repsalestack repmiscstack repvastack;
	by year be11id;
	if year = 2000 and country = . and industry = . then delete; * Omits one null record;
	if be11id = '0' then delete; * Omits one null record;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Merge foreign affiliate data from BE-10 or BE-11 for 1993-2016 */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = affidentstack;
	by year be11id foreignid;
proc sort data = affbsisstack;
	by year be11id foreignid;
proc sort data = affsalestack;
	by year be11id foreignid;
proc sort data = affmiscstack;
	by year be11id foreignid;
proc sort data = affvastack;
	by year be11id foreignid;
data affmerge;
	merge affidentstack affbsisstack affsalestack affmiscstack affvastack;
	by year be11id foreignid;
	if be11id = '0' then delete; * Omits one null record;
	affmerge = 1;
	if industry = 0 then Industry = 999; * Industry code for individuals;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Merge foreign affiliate data from BE-10 or BE-11 with U.S. affiliate data from BE-15 
for 1993-2016 to identify affiliates with foreign-owned U.S. parents */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = affmerge;
	by year be11id;
proc sort data = identifyforeign;
	by year be11id;
data affmergeforeign;
	merge affmerge identifyforeign;
	by year be11id;
	if affmerge ne 1 then delete;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Stack affiliate and reporter data for 1993-2016 */
/****************************************************************************************/
/****************************************************************************************/
data aer.usdiafo93to16;
	set affmergeforeign repmerge;
	drop affmerge usreporter;
	* Set missing values to zero;
	array changemiss _numeric_;
	do over changemiss;
		if majforowned = . then majforowned = 0; 
	end;
run;
/****************************************************************************************/
/****************************************************************************************/
