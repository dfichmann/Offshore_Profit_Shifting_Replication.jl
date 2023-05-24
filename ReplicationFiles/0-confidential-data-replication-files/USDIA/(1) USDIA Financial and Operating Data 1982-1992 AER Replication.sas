/* Program date:  November 4, 2021 */
/* Program name:  '(1) USDIA Financial and Operating Data 1982-1992 AER Replication.sas' */
/* Program description:  This program reformats BEA research data files for BE-10, BE-11, 
and BE-15 to generate consistent variable names and field characteristics.  The resulting 
dataset is a panel of financial and operating data on U.S. reporters and their foreign 
affiliates for 1982-1992:  aer.usdiafo82to92.
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
%import ('92RFKEY',di92own,'S:\BE15\Access2000\1992r.mdb'); * Contains 
U.S. affiliate data from BE-15 for 1992;
%import ('91RFKEY',di91own,'S:\BE15\Access2000\1991r.mdb'); * Contains 
U.S. affiliate data from BE-15 for 1991;
%import ('90RFKEY',di90own,'S:\BE15\Access2000\1990r.mdb'); * Contains 
U.S. affiliate data from BE-15 for 1990;

/****************************************************************************************/
/****************************************************************************************/
/* Reformat U.S. affiliate data from BE-15 for 1990-1992 to be consistent with other years */
/****************************************************************************************/
/****************************************************************************************/
%macro usaffrev (x1,x2,x3,x4,x5,x6);
	data &x1; 
		set &x2;
		length BE15ID 8.;
		Year = &x3; 
		BE15ID = &x4;
		if sum(&x5,&x6) gt 500 then MajForOwned = 1; else MajForOwned = 0;
		USaffiliate = 1;
		keep year be15id majforowned usaffiliate;
	run;
%mend usaffrev;

* Data for 1990-1992;
%usaffrev (di92usaff,di92own,1992,id_92,for_par___own_92,us_affil___owned_92);
%usaffrev (di91usaff,di91own,1991,id_91,for_par___own_91,us_affil___own_91);
%usaffrev (di90usaff,di90own,1990,id_90,for_par___own_90,us_affil___own_90);

* Use data from 1990 for 1982 and 1989;
%usaffrev (di89usaff,di90own,1989,id_90,for_par___own_90,us_affil___own_90);
%usaffrev (di82usaff,di90own,1982,id_90,for_par___own_90,us_affil___own_90);

* Stack U.S. affiliate data for 1982, 1989, and 1990-1992;
data usaffstack;
	set di92usaff di91usaff di90usaff di89usaff di82usaff;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Import affiliate data from BE-10 or BE-11 for 1982-1992 */
/****************************************************************************************/
/****************************************************************************************/
%import ('11B92RF',di92aff,'S:\BE11\Access2000\1992r.mdb'); * Contains 
affiliate financial and operating data from BE-11 for 1992;
%import ('11B92RF5',di92affva,'S:\BE11\Access2000\1992r.mdb'); * Contains 
affiliate value-added data from BE-11 for 1992;
%import ('11B91RF',di91aff,'S:\BE11\Access2000\1991r.mdb'); * Contains 
affiliate financial and operating data from BE-11 for 1991;
%import ('11B91RF5',di91affva,'S:\BE11\Access2000\1991r.mdb'); * Contains 
affiliate value-added data from BE-11 for 1991;
%import ('11B90RF',di90aff,'S:\BE11\Access2000\1990r.mdb'); * Contains 
affiliate financial and operating data from BE-11 for 1990;
%import ('11B90RF5',di90affva,'S:\BE11\Access2000\1990r.mdb'); * Contains 
affiliate value-added data from BE-11 for 1990;
%import ('11B89RF',di89aff1,'S:\BE11\Access2000\1989r.mdb'); * Contains 
affiliate financial and operating data from BE-10 for 1989;
%import ('Exv1',di89aff2,'S:\BE11\Access2000\1989r.mdb'); * Contains 
affiliate R&D data from BE-10 for 1989;
%import ('11B89RF5',di89affva,'S:\BE11\Access2000\1989r.mdb'); * Contains 
affiliate value-added data from BE-10 for 1989;
%import ('11B88RF',di88aff,'S:\BE11\Access2000\1988r.mdb'); * Contains 
affiliate financial and operating data from BE-11 for 1988;
%import ('11B88RF5',di88affva,'S:\BE11\Access2000\1988r.mdb'); * Contains 
affiliate value-added data from BE-11 for 1988;
%import ('11B87RF',di87aff,'S:\BE11\Access2000\1987r.mdb'); * Contains 
affiliate financial and operating data from BE-11 for 1987;
%import ('11B87RF5',di87affva,'S:\BE11\Access2000\1987r.mdb'); * Contains 
affiliate value-added data from BE-11 for 1987;
%import ('11B86RF',di86aff,'S:\BE11\Access2000\1986r.mdb'); * Contains 
affiliate financial and operating data from BE-11 for 1986;
%import ('11B86RF5',di86affva,'S:\BE11\Access2000\1986r.mdb'); * Contains 
affiliate value-added data from BE-11 for 1986;
%import ('11B85RF',di85aff,'S:\BE11\Access2000\1985r.mdb'); * Contains 
affiliate financial and operating data from BE-11 for 1985;
%import ('11B85RF5',di85affva,'S:\BE11\Access2000\1985r.mdb'); * Contains 
affiliate value-added data from BE-11 for 1985;
%import ('11B84RF',di84aff,'S:\BE11\Access2000\1984r.mdb'); * Contains 
affiliate financial and operating data from BE-11 for 1984;
%import ('11B84RF5',di84affva,'S:\BE11\Access2000\1984r.mdb'); * Contains 
affiliate value-added data from BE-11 for 1984;
%import ('11B83RF',di83aff,'S:\BE11\Access2000\1983r.mdb'); * Contains 
affiliate financial and operating data from BE-11 for 1983;
%import ('11B83RF5',di83affva,'S:\BE11\Access2000\1983r.mdb'); * Contains 
affiliate value-added data from BE-11 for 1983;
%import ('11B82RF1',di82aff1,'S:\BE11\Access2000\1982r.mdb'); * Contains 
affiliate financial and operating data from BE-10 for 1982;
%import ('11B82RF2',di82aff2,'S:\BE11\Access2000\1982r.mdb'); * Contains 
affiliate financial and operating data from BE-10 for 1982;
%import ('11B82RF5',di82affva,'S:\BE11\Access2000\1982r.mdb'); * Contains 
affiliate value-added data from BE-10 for 1982;

/****************************************************************************************/
/****************************************************************************************/
/* Reformat affiliate identifying data from BE-10 or BE-11 for 1982-1992 to be consistent 
across all years */
/****************************************************************************************/
/****************************************************************************************/
* Reformat affiliate identifying non-benchmark data to be consistent across all years;
%macro affrevi (x1,x2,x3,x4,x5,x6,x7,x8,x9);
	data &x1; 
		set &x2;
		length BE11ID $12. ForeignID $12.;
		Year = &x3; 
		BE11ID = par_id_6;	
		ForeignID = aff_id_4;
		Industry = &x4;
		Country = &x5;
		MOFA = &x6;
		DocType = &x7;
		USVoting = &x8;
		Indirect = &x9;
		keep year be11id foreignid industry country mofa doctype usvoting indirect;
	run;
%mend affrevi;

%affrevi (di92affi,di92aff,1992,industry_92,country_92,borc_92,doc_type_92,own__direct_92,own__indirect_92);
%affrevi (di91affi,di91aff,1991,industry_91,country_91,borc_91,doc_type_91,own__direct_91,own__indirect_91);
%affrevi (di90affi,di90aff,1990,industry_90,country_90,borc_90,doc_type_90,own__direct_90,own__indirect_90);
%affrevi (di88affi,di88aff,1988,industry_88,country_88,borc_88,doc_type_88,own__direct_88,own__indirect_88);
%affrevi (di87affi,di87aff,1987,industry_87,country_87,borc_87,doc_type_87,own__direct_87,own__indirect_87);
%affrevi (di86affi,di86aff,1986,industry_86,country_86,borc_86,doc_type_86,own__direct_86,own__indirect_86);
%affrevi (di85affi,di85aff,1985,industry_85,country_85,borc_85,doc_type_85,own__direct_85,own__indirect_85);
%affrevi (di84affi,di84aff,1984,industry_84,country_84,borc_84,doc_type_84,own__direct_84,own__indirect_84);
%affrevi (di83affi,di83aff,1983,industry_83,country_83,borc_83,doc_type_83,own__direct_83,own__indirect_83);

* Reformat affiliate identifying benchmark data to be consistent across all years;
%macro affrevib (x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11);
	data &x1; 
		set &x2;
		length BE11ID $12. ForeignID $12.;
		Year = &x3; 
		BE11ID = &x4;	
		ForeignID = &x5;
		Industry = &x6;
		Country = &x7;
		if &x8 = 1 then MOFA = 'B';
		if &x8 = 0 then MOFA = 'C';
		DocType = &x9;
		USVoting = &x10;
		Indirect = &x11;
		keep year be11id foreignid industry country mofa doctype usvoting indirect;
	run;
%mend affrevib;

%affrevib (di89affi,di89aff1,1989,us_id,foreign_id,industry_89,country_89,maj1_min0_89,doc_type_89,own_usp_dir_89,own_usp_indir_89);
%affrevib (di82affi,di82aff1,1982,par_id_6,aff_id_4,industry_82,country_82,maj_1__min_0__82,.,own__direct_usrep_82,own__indirect_82);

* Stack affiliate identifying data for 1982-1992;
data affidentstack;
	set di92affi di91affi di90affi di89affi di88affi di87affi di86affi di85affi di84affi di83affi di82affi;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Reformat affiliate financial and operating data from BE-10 or BE-11 for 1982-1992 to be 
consistent across all years */
/****************************************************************************************/
/****************************************************************************************/
* Reformat affiliate financial and operating non-benchmark data to be consistent across all years;
%macro affrevfo (x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13);
	data &x1; 
		set &x2;
		length BE11ID $12. ForeignID $12.;
		Year = &x3; 
		BE11ID = par_id_6;	
		ForeignID = aff_id_4;
		GrPPE = &x4 * 1;
		AccDepr = abs(&x5) * 1;
		Sales = &x6 * 1;
		UnaffSales = sum(&x7,&x8,&x9,&x10,&x11,&x12) * 1;
		EmpComp = &x13 * 1;
		keep year be11id foreignid grppe accdepr sales unaffsales empcomp;
	run;
%mend affrevfo;

%affrevfo (di92afffo,di92aff,1992,gross_pp_e_92,depreciation___depl_92,sales_92,sales_loc_unaff_92,sales_us_unaff_92,
           sales_oth_unaff_92,0,0,0,employee_comp_92);
%affrevfo (di91afffo,di91aff,1991,gross_pp_e_91,depreciation___depl_91,sales_91,sales_loc_unaff_91,sales_us_unaff_91,
           sales_oth_unaff_91,0,0,0,employee_comp_91);
%affrevfo (di90afffo,di90aff,1990,gross_pp_e_90,depreciation___depl_90,sales_90,sales_loc_unaff_90,sales_us_unaff_90,
           sales_oth_unaff_90,0,0,0,employee_comp_90);
%affrevfo (di88afffo,di88aff,1988,gross_pp_e_88,deprec____depl_88,sales_88,sales_cnty_g_unaff_88,sales_cnty_s_unaff_88,
           sales_us_g_unaff_88,sales_us_s_unaff_88,sales_oth_g_unaff_88,sales_oth_s_unaff_88,employee_comp_88);
%affrevfo (di87afffo,di87aff,1987,gross_pp_e_87,deprec____depl_87,sales_87,sales_cnty_g_unaff_87,sales_cnty_s_unaff_87,
           sales_us_g_unaff_87,sales_us_s_unaff_87,sales_oth_g_unaff_87,sales_oth_s_unaff_87,employee_comp_87);
%affrevfo (di86afffo,di86aff,1986,gross_pp_e_86,deprec____depl_86,sales_86,sales_cnty_g_unaff_86,sales_cnty_s_unaff_86,
           sales_us_g_unaff_86,sales_us_s_unaff_86,sales_oth_g_unaff_86,sales_oth_s_unaff_86,employee_comp_86);
%affrevfo (di85afffo,di85aff,1985,gross_pp_e_85,deprec____depl_85,sales_85,sales_cnty_g_unaff_85,sales_cnty_s_unaff_85,
           sales_us_g_unaff_85,sales_us_s_unaff_85,sales_oth_g_unaff_85,sales_oth_s_unaff_85,employee_comp_85);
%affrevfo (di84afffo,di84aff,1984,gross_pp_e_84,deprec____depl_84,sales_84,sales_cnty_g_unaff_84,sales_cnty_s_unaff_84,
           sales_us_g_unaff_84,sales_us_s_unaff_84,sales_oth_g_unaff_84,sales_oth_s_unaff_84,employee_comp_84);
%affrevfo (di83afffo,di83aff,1983,gross_pp_e_83,deprec____depl_83,sales_83,sales_cnty_g_unaff_83,sales_cnty_s_unaff_83,
           sales_us_g_unaff_83,sales_us_s_unaff_83,sales_oth_g_unaff_83,sales_oth_s_unaff_83,employee_comp_83);

* Reformat affiliate financial and operating benchmark data to be consistent across all years;
%macro affrevfob (x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15);
	data &x1; 
		set &x2;
		length BE11ID $12. ForeignID $12.;
		Year = &x3; 
		BE11ID = &x4;	
		ForeignID = &x5;
		GrPPE = &x6 * 1;
		AccDepr = abs(&x7) * 1;
		Sales = &x8 * 1;
		UnaffSales = sum(&x9,&x10,&x11,&x12,&x13,&x14) * 1;
		EmpComp = &x15 * 1;
		keep year be11id foreignid grppe accdepr sales unaffsales empcomp;
	run;
%mend affrevfob;

%affrevfob (di89afffo,di89aff1,1989,us_id,foreign_id,gross_ppe_89,accum_deprec_depl_89,sales_89,sales_local_unaff,sales_us_unaff,
		    sales_oth_for_unaff,0,0,0,employee_comp_89);
%affrevfob (di82afffo,di82aff2,1982,par_id_6,aff_id_4,gross_pp_e_82,acc_deprec__depl_82,sales_tot_82,sales_local_unaff_82,sales_us_unaff_82,
		    sales_o_for_unaff_82,0,0,0,emp_comp_82);

* Stack affiliate financial and operating data for 1982-1992;
data afffostack;
	set di92afffo di91afffo di90afffo di89afffo di88afffo di87afffo di86afffo di85afffo di84afffo di83afffo di82afffo;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Reformat affiliate R&D data from BE-10 or BE-11 for 1982 and 1989-1992 to be consistent 
across all years (no R&D data collected for 1983-1988) */
/****************************************************************************************/
/****************************************************************************************/
* Reformat affiliate R&D non-benchmark data to be consistent across all years;
%macro affrevrd (x1,x2,x3,x4);
	data &x1; 
		set &x2;
		length BE11ID $12. ForeignID $12.;
		Year = &x3; 
		BE11ID = par_id_6;	
		ForeignID = aff_id_4;
		RDexp = &x4 * 1;
		keep year be11id foreignid rdexp;
	run;
%mend affrevrd;

%affrevrd (di92affrd,di92aff,1992,r_d_expenditures_92);
%affrevrd (di91affrd,di91aff,1991,r_d_expenditures_91);
%affrevrd (di90affrd,di90aff,1990,r_d_expenditures_90);

* Reformat affiliate R&D benchmark data to be consistent across all years;
%macro affrevrdb (x1,x2,x3,x4,x5,x6);
	data &x1; 
		set &x2;
		length BE11ID $12. ForeignID $12.;
		Year = &x3; 
		BE11ID = &x4;	
		ForeignID = &x5;
		RDexp = &x6 * 1;
		keep year be11id foreignid rdexp;
	run;
%mend affrevrdb;

%affrevrdb (di89affrd,di89aff2,1989,us_id,foreign_id,rnd_by_aff_89);
%affrevrdb (di82affrd,di82aff2,1982,par_id_6,aff_id_4,r_d_performed_82);

* Stack affiliate R&D data for 1982 and 1989-1992;
data affrdstack;
	set di92affrd di91affrd di90affrd di89affrd di82affrd;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Reformat affiliate value-added data from BE-10 or BE-11 for 1982-1992 to be consistent
across all years */
/****************************************************************************************/
/****************************************************************************************/
* Reformat affiliate value-added non-benchmark data to be consistent across all years;
%macro affrevva (x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13);
	data &x1; 
		set &x2;
		length BE11ID $12. ForeignID $12.;
		Year = &x3; 
		BE11ID = par_id_6;	
		ForeignID = aff_id_4;
		VA1 = &x4 * 1;
		PTR1 = &x5 * 1;
		NI1 = &x6 * 1;
		Tax1 = &x7 * 1;
		Depl1 = &x8 * 1;
		GL1 = &x9 * 1;
		IQ1 = &x10 * 1;
		NIP1 = &x11 * 1;
		IBT1 = &x12 * 1;
		CCA1 = &x13 * 1;
		keep year be11id foreignid va1 ptr1 ni1 tax1 depl1 gl1 iq1 nip1 ibt1 cca1;
	run;
%mend affrevva;

%affrevva (di92affvar,di92affva,1992,gp_92,ptr_92,net_income_92,foreign_inc_tax_92,depletion_92,cap_g_l_92,income_from_eq_92,net_ip_92,ibt_etc_92,cca_92);
%affrevva (di91affvar,di91affva,1991,gp_91,ptr_91,net_income_91,foreign_inc_tax_91,depletion_91,cap_g_l_91,income_from_eq_91,net_ip_91,ibt_etc_91,cca_91);
%affrevva (di90affvar,di90affva,1990,gp_90,ptr_90,net_income_90,foreign_inc_tax_90,depletion_90,cap_g_l_90,income_from_eq_90,net_ip_90,ibt_etc_90,cca_90);
%affrevva (di88affvar,di88affva,1988,gp_88,ptr_88,net_income_88,foreign_inc_tax_88,depletion_88,cap_g_l_88,inc_from_eq_88,net_ip_88,ibt_etc_88,cca_88);
%affrevva (di87affvar,di87affva,1987,gp_87,ptr_87,net_income_87,foreign_inc_tax_87,depletion_87,cap_g_l_87,inc_from_eq_87,net_ip_87,ibt_etc_87,cca_87);
%affrevva (di86affvar,di86affva,1986,gp_86,ptr_86,net_income_86,foreign_inc_tax_86,depletion_86,cap_g_l_86,inc_from_eq_86,net_ip_86,ibt_etc_86,cca_86);
%affrevva (di85affvar,di85affva,1985,gp_85,ptr_85,net_income_85,foreign_inc_tax_85,depletion_85,cap_g_l_85,inc_from_eq_85,net_ip_85,ibt_etc_85,cca_85);
%affrevva (di84affvar,di84affva,1984,gp_84,ptr_84,net_income_84,foreign_inc_tax_84,depletion_84,cap_g_l_84,inc_from_eq_84,net_ip_84,ibt_etc_84,cca_84);
%affrevva (di83affvar,di83affva,1983,gp_83,ptr_83,net_income_83,foreign_inc_tax_83,depletion_83,cap_g_l_83,inc_from_eq_83,net_ip_83,ibt_etc_83,cca_83);

* Reformat affiliate value-added benchmark data to be consistent across all years;
%macro affrevvab (x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14,x15);
	data &x1; 
		set &x2;
		length BE11ID $12. ForeignID $12.;
		Year = &x3; 
		BE11ID = &x4;	
		ForeignID = &x5;
		VA1 = &x6 * 1;
		PTR1 = &x7 * 1;
		NI1 = &x8 * 1;
		Tax1 = &x9 * 1;
		Depl1 = &x10 * 1;
		GL1 = &x11 * 1;
		IQ1 = &x12 * 1;
		NIP1 = &x13 * 1;
		IBT1 = &x14 * 1;
		CCA1 = &x15 * 1;
		keep year be11id foreignid va1 ptr1 ni1 tax1 depl1 gl1 iq1 nip1 ibt1 cca1;
	run;
%mend affrevvab;

%affrevvab (di89affvar,di89affva,1989,us_id,foreign_id,gp,ptr,net_income,foreign_inc_tax,depletion,cap_g_l,income_from_eq,net_ip,ibt_etc,cca);
%affrevvab (di82affvar,di82affva,1982,par_id_6,aff_id_4,gp_82,ptr_82,net_income_82,foreign_inc_tax_82,depletion_82,cap_g_l_82,inc_from_eq_82,net_ip_82,ibt_etc_82,cca_82);

* Stack affiliate value-added data for 1982-1992;
data affvastack;
	set di92affvar di91affvar di90affvar di89affvar di88affvar di87affvar di86affvar di85affvar di84affvar di83affvar di82affvar;
	rename va1 = VA ptr1 = PTR ni1 = NI tax1 = Tax depl1 = Depl gl1 = GL iq1 = IQ nip1 = NIP ibt1 = IBT cca1 = CCA;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Import reporter data from BE-10 or BE-11 */
/****************************************************************************************/
/****************************************************************************************/
%import ('11A92RF',di92rep,'S:\BE11\Access2000\1992r.mdb'); * Contains 
reporter data from BE-11 for 1992;
%import ('11A91RF',di91rep,'S:\BE11\Access2000\1991r.mdb'); * Contains 
reporter data from BE-11 for 1991;
%import ('11A90RF',di90rep,'S:\BE11\Access2000\1990r.mdb'); * Contains 
reporter data from BE-11 for 1990;
%import ('11A89RF',di89rep,'S:\BE11\Access2000\1989r.mdb'); * Contains 
reporter data from BE-10 for 1989;
%import ('11A89RF5',di89repva,'S:\BE11\Access2000\1989r.mdb'); * Contains 
reporter value-added data from BE-10 for 1989;
%import ('11A88RF',di88rep,'S:\BE11\Access2000\1988r.mdb'); * Contains 
reporter data from BE-11 for 1988;
%import ('11A87RF',di87rep,'S:\BE11\Access2000\1987r.mdb'); * Contains 
reporter data from BE-11 for 1987;
%import ('11A86RF',di86rep,'S:\BE11\Access2000\1986r.mdb'); * Contains 
reporter data from BE-11 for 1986;
%import ('11A85RF',di85rep,'S:\BE11\Access2000\1985r.mdb'); * Contains 
reporter data from BE-11 for 1985;
%import ('11A84RF',di84rep,'S:\BE11\Access2000\1984r.mdb'); * Contains 
reporter data from BE-11 for 1984;
%import ('11A83RF',di83rep,'S:\BE11\Access2000\1983r.mdb'); * Contains 
reporter data from BE-11 for 1983;
%import (par82,di82rep,'S:\BE11\Access2000\1982r.mdb'); * Contains 
reporter data from BE-10 for 1982;
%import ('11A82RF5',di82repva,'S:\BE11\Access2000\1982r.mdb'); * Contains 
reporter value-added data from BE-10 for 1982;
%import ('Masterfile Data #1_of_2',di82ppe1,'S:\BE11\Access2000\1982r.mdb'); * Contains 
reporter net PPE data from line 2028 BE-10A for 1982;
%import ('Masterfile Data #2_of_2',di82ppe2,'S:\BE11\Access2000\1982r.mdb'); * Contains 
reporter net PPE data from line 2028 BE-10A for 1982;

/****************************************************************************************/
/****************************************************************************************/
/* Reformat reporter identifying data from BE-10 or BE-11 for 1982-1992 to be consistent 
across all years */
/****************************************************************************************/
/****************************************************************************************/
* Reformat reporter identifying data to be consistent across all years;
%macro reprevi (x1,x2,x3,x4,x5,x6,x7);
	data &x1; 
		set &x2;
		length BE11ID $12. ForeignID $12. BE15ID 8.;
		Year1 = &x3; 
		BE11ID = &x4;	
		ForeignID = '0000';
		Industry = &x5;
		Country = 999;
		DocType = &x6;
		BE15ID = &x7;
		USreporter = 1;
		keep year1 be11id foreignid industry country doctype be15id usreporter;
	run;
%mend reprevi;

%reprevi (di92repi,di92rep,1992,par_id_6,industry_92,doc_type_92,be15_id_92);
%reprevi (di91repi,di91rep,1991,par_id_6,industry_91,doc_type_91,be15_id_91);
%reprevi (di90repi,di90rep,1990,par_id_6,industry_90,doc_type_90,be15_id_90);
%reprevi (di89repi,di89rep,1989,us_id,ind_sic,doc_type,.);
%reprevi (di88repi,di88rep,1988,par_id_6,industry_88,doc_type_88,.);
%reprevi (di87repi,di87rep,1987,par_id_6,industry_87,doc_type_87,.);
%reprevi (di86repi,di86rep,1986,par_id_6,industry_86,doc_type_86,.);
%reprevi (di85repi,di85rep,1985,par_id_6,industry_85,doc_type_85,.);
%reprevi (di84repi,di84rep,1984,par_id_6,industry_84,doc_type_84,.);
%reprevi (di83repi,di83rep,1983,par_id_6,industry_83,doc_type_83,.);
%reprevi (di82repi,di82rep,1982,parids,ind_sic_par,.,.);

* Attach the 1990 BE-15 identifiers to 1982 and 1989 data;
data di90repibe15;
	set di90repi;
	yr90 = 1;
	keep be11id be15id yr90;
run;

proc sort data = di82repi;
	by be11id;
proc sort data = di90repibe15;
	by be11id;
data di82repibe15;
	merge di82repi di90repibe15;
	by be11id;
	if year1 = . and yr90 = 1 then delete;
	drop yr90;
run;

proc sort data = di89repi;
	by be11id;
proc sort data = di90repibe15;
	by be11id;
data di89repibe15;
	merge di89repi di90repibe15;
	by be11id;
	if year1 = . and yr90 = 1 then delete;
	drop yr90;
run;

* Stack reporter identifying data for 1982-1992;
data repidentstack;
	set di92repi di91repi di90repi di89repibe15 di88repi di87repi di86repi di85repi 
	di84repi di83repi di82repibe15;
	rename year1 = Year;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Reformat reporter net PPE from BE-10 masterfile (line 2028 on 1982 form BE-10A */
/****************************************************************************************/
/****************************************************************************************/
* Stack reporter master files and retain reporter net PPE;
data repppe82;
	set di82ppe1 di82ppe2;
	length usidchar $6 parids $6;
	usidchar = us_id;
	parids = cats('0',usidchar);
	if foreign_id ne '000' then delete;
	if line ne 2028 then delete;
	NetPPE = data1;
	keep parids netppe;
run;

* Merge reporter net PPE data with other reporter data;
proc sort data = di82rep;
	by parids;
proc sort data = repppe82;
	by parids;
data di82repr;
	merge di82rep repppe82;
	by parids;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Reformat reporter financial and operating data from BE-10 or BE-11 for 1982-1992 to be 
consistent across all years */
/****************************************************************************************/
/****************************************************************************************/
* Reformat reporter financial and operating data to be consistent across all years;
%macro reprevfo (x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11);
	data &x1; 
		set &x2;
		length BE11ID $12. ForeignID $12.;
		Year1 = &x3; 
		BE11ID = &x4;	
		ForeignID = '0000';
		GrPPE = &x5 * 1;
		AccDepr = abs(&x6) * 1;
		Sales1 = &x7 * 1;
		UnaffSales = sum(&x8,&x9,&x10) * 1;
		RDexp = &x11 * 1;
		keep year1 be11id foreignid grppe accdepr sales1 unaffsales rdexp;
	run;
%mend reprevfo;

%reprevfo (di92repfo,di92rep,1992,par_id_6,.,.,total_sales_92,sale_of_goods_92,sale_services__u_s__92,
           sale_services__o_for_92,r_d_expenditures_92);
%reprevfo (di91repfo,di91rep,1991,par_id_6,.,.,total_sales_91,sale_of_goods_91,sale_services__u_s__91,
           sale_services__o_for_91,r_d_expenditures_91);
%reprevfo (di90repfo,di90rep,1990,par_id_6,.,.,total_sales_90,sale_of_goods_90,sale_services__u_s__90,
           sale_services__o_for_90,r_d_expenditures_90);
%reprevfo (di89repfo,di89rep,1989,us_id,ppe_gross,accum_deprec_depl,total_sales,sales_us,sales_oth_fgn,
           0,rd);
%reprevfo (di88repfo,di88rep,1988,par_id_6,.,.,total_sales_88,sale_of_goods_88,sale_services__u_s__88,
           sale_services__o_for_88,.);
%reprevfo (di87repfo,di87rep,1987,par_id_6,.,.,total_sales_87,sale_of_goods_87,sale_services__u_s__87,
           sale_services__o_for_87,.);
%reprevfo (di86repfo,di86rep,1986,par_id_6,.,.,total_sales_86,sale_of_goods_86,sale_services__u_s__86,
           sale_services__o_for_86,.);
%reprevfo (di85repfo,di85rep,1985,par_id_6,.,.,total_sales_85,sale_of_goods_85,sale_services__u_s__85,
           sale_services__o_for_85,.);
%reprevfo (di84repfo,di84rep,1984,par_id_6,.,.,total_sales_84,sale_of_goods_84,sale_services__u_s__84,
           sale_services__o_for_84,.);
%reprevfo (di83repfo,di83rep,1983,par_id_6,.,.,total_sales_83,sale_of_goods_83,sale_services__u_s__83,
           sale_services__o_for_83,.);
%reprevfo (di82repfo,di82repr,1982,parids,netppe,0,sales_par,sales_par,0,0,rd_par);

* Stack reporter financial and operating data for 1982-1992;
data repfostack;
	set di92repfo di91repfo di90repfo di89repfo di88repfo di87repfo di86repfo di85repfo di84repfo di83repfo di82repfo;
	rename sales1 = Sales year1 = Year;
run;

* Reformat reporter compensation data to be consistent across all years;
%macro reprevcomp (x1,x2,x3,x4,x5);
	data &x1; 
		set &x2;
		length BE11ID $12. ForeignID $12.;
		Year1 = &x3; 
		BE11ID = &x4;	
		ForeignID = '0000';
		EmpComp = &x5;
		keep year1 be11id foreignid empcomp;
	run;
%mend reprevcomp;

%reprevcomp (di92repcomp,di92rep,1992,par_id_6,employee_compensation_92);
%reprevcomp (di91repcomp,di91rep,1991,par_id_6,employee_compensation_91);
%reprevcomp (di90repcomp,di90rep,1990,par_id_6,employee_compensation_90);
%reprevcomp (di89repcomp,di89rep,1989,us_id,emp_compen);
%reprevcomp (di88repcomp,di88rep,1988,par_id_6,employee_compensation_88);
%reprevcomp (di87repcomp,di87rep,1987,par_id_6,employee_compensation_87);
%reprevcomp (di86repcomp,di86rep,1986,par_id_6,employee_compensation_86);
%reprevcomp (di85repcomp,di85rep,1985,par_id_6,employee_compensation_85);
%reprevcomp (di84repcomp,di84rep,1984,par_id_6,employee_compensation_84);
%reprevcomp (di83repcomp,di83rep,1983,par_id_6,employee_compensation_83);
%reprevcomp (di82repcomp,di82repva,1982,par_id_6,employee_comp_82);

* Stack reporter compensation data for 1982-1992;
data repcompstack;
	set di92repcomp di91repcomp di90repcomp di89repcomp di88repcomp di87repcomp di86repcomp di85repcomp 
	di84repcomp di83repcomp di82repcomp;
	rename year1 = Year;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Reformat reporter value-added data from BE-10 or BE-11 for 1982-1992 to be consistent
across all years */
/****************************************************************************************/
/****************************************************************************************/
* Reformat reporter value-added benchmark data to be consistent across all years;
%macro reprevva (x1,x2,x3,x4,x5,x6,x7,x8,x9,x10,x11,x12,x13,x14);
	data &x1; 
		set &x2;
		length BE11ID $12. ForeignID $12.;
		Year = &x3; 
		BE11ID = &x4;	
		ForeignID = '0000';
		VA1 = &x5 * 1;
		PTR1 = &x6 * 1;
		NI1 = &x7 * 1;
		Tax1 = &x8 * 1;
		Depl1 = &x9 * 1;
		GL1 = &x10 * 1;
		IQ1 = &x11 * 1;
		NIP1 = &x12 * 1;
		IBT1 = &x13 * 1;
		CCA1 = &x14 * 1;
		keep year be11id foreignid va1 ptr1 ni1 tax1 depl1 gl1 iq1 nip1 ibt1 cca1;
	run;
%mend reprevva;

%reprevva (di89repvar,di89repva,1989,us_id,gp,ptr,net_income,us_inc_tax,depletion,cap_g_l,income_from_eq,net_ip,ibt_etc,cca);
%reprevva (di82repvar,di82repva,1982,par_id_6,gp_82,ptr_82,net_income_82,us_inc_tax_82,depletion_82,cap_g_l_82,income_from_eq_82,net_ip_82,ibt_etc_82,cca_82);

* Stack reporter value-added data for 1982 and 1989;
data repvastack;
	set di89repvar di82repvar;
	rename va1 = VA ptr1 = PTR ni1 = NI tax1 = Tax depl1 = Depl gl1 = GL iq1 = IQ nip1 = NIP ibt1 = IBT cca1 = CCA;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Merge reporter data from BE-10 or BE-11 with U.S. affiliate data from BE-15 for 
1990-1992 to identify foreign-owned U.S. parents */
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
	if year in (1982,1989,1990,1991,1992) then do;
		array changemiss _numeric_;
		do over changemiss;
			if majforowned = . then majforowned = 0; 
		end;
	end;
	keep year be11id be15id majforowned;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Merge reporter data from BE-10 or BE-11 for 1982-1992 */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = identifyforeign;
	by year be11id;
proc sort data = repidentstack;
	by year be11id;
proc sort data = repfostack;
	by year be11id;
proc sort data = repcompstack;
	by year be11id;
proc sort data = repvastack;
	by year be11id;
data repmerge;
	merge identifyforeign repidentstack repfostack repcompstack repvastack;
	by year be11id;
	if industry = 0 then Industry = 999; * Industry code for individuals;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Merge foreign affiliate data from BE-10 or BE-11 for 1982-1992 */
/****************************************************************************************/
/****************************************************************************************/
proc sort data = affidentstack;
	by year be11id foreignid;
proc sort data = afffostack;
	by year be11id foreignid;
proc sort data = affrdstack;
	by year be11id foreignid;
proc sort data = affvastack;
	by year be11id foreignid;
data affmerge;
	merge affidentstack afffostack affrdstack affvastack;
	by year be11id foreignid;
	affmerge = 1;
	if industry = 0 then Industry = 999; * Industry code for individuals;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Merge foreign affiliate data from BE-10 or BE-11 with U.S. affiliate data from BE-15 
for 1990-1992 to identify affiliates with foreign-owned U.S. parents */
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
	if _n_ = 8297 then majforowned = 1; * Create foreign ownership indicator;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Stack affiliate and reporter data for 1982-1992 */
/****************************************************************************************/
/****************************************************************************************/
data aer.usdiafo82to92;
	set affmergeforeign repmerge;
	drop affmerge usreporter;
	* Set missing values to zero;
	if year in (1982,1989,1990,1991,1992) then do;
		array changemiss _numeric_;
		do over changemiss;
			if majforowned = . then majforowned = 0; 
		end;
	end;
run;
/****************************************************************************************/
/****************************************************************************************/
