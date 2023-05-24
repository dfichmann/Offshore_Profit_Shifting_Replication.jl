/* Program date:  November 4, 2021 */
/* Program name:  '(9) Standard Errors AER Replication.sas' */
/* Program description:  This program calculates formulary adjustments and standard
errors for randomly generated panels with an equal number of observations to our
original panel. */
/* The CSV datasets used in this program are generated in STATA at
L:\Dylan\Paper - Productivity\AER Revision\AER Replication\'(8) Standard Errors Panels AER Replication.do' */

libname aer 'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\Data Sets';
run;

/****************************************************************************************/
/****************************************************************************************/
/* Import foreign affiliate panels that are randomly generated in STATA */
/****************************************************************************************/
/****************************************************************************************/
%macro import (out,file);
data &out;
	infile &file dlm = ',' dsd missover lrecl = 32767 firstobs = 2;
	input	BE11ID:$12. ForeignID:$12. Year:best12. MajForOwned:best12. Haven:best12. 
			Compensation:best12. NetPPE:best12. RDstock:best12. Profits:best12.;
run;
%mend import;

%import (panel_1,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_1.csv');
%import (panel_2,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_2.csv');
%import (panel_3,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_3.csv');
%import (panel_4,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_4.csv');
%import (panel_5,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_5.csv');
%import (panel_6,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_6.csv');
%import (panel_7,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_7.csv');
%import (panel_8,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_8.csv');
%import (panel_9,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_9.csv');
%import (panel_10,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_10.csv');
%import (panel_11,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_11.csv');
%import (panel_12,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_12.csv');
%import (panel_13,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_13.csv');
%import (panel_14,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_14.csv');
%import (panel_15,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_15.csv');
%import (panel_16,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_16.csv');
%import (panel_17,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_17.csv');
%import (panel_18,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_18.csv');
%import (panel_19,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_19.csv');
%import (panel_20,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_20.csv');
%import (panel_21,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_21.csv');
%import (panel_22,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_22.csv');
%import (panel_23,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_23.csv');
%import (panel_24,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_24.csv');
%import (panel_25,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_25.csv');
%import (panel_26,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_26.csv');
%import (panel_27,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_27.csv');
%import (panel_28,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_28.csv');
%import (panel_29,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_29.csv');
%import (panel_30,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_30.csv');
%import (panel_31,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_31.csv');
%import (panel_32,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_32.csv');
%import (panel_33,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_33.csv');
%import (panel_34,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_34.csv');
%import (panel_35,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_35.csv');
%import (panel_36,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_36.csv');
%import (panel_37,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_37.csv');
%import (panel_38,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_38.csv');
%import (panel_39,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_39.csv');
%import (panel_40,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_40.csv');
%import (panel_41,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_41.csv');
%import (panel_42,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_42.csv');
%import (panel_43,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_43.csv');
%import (panel_44,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_44.csv');
%import (panel_45,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_45.csv');
%import (panel_46,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_46.csv');
%import (panel_47,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_47.csv');
%import (panel_48,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_48.csv');
%import (panel_49,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_49.csv');
%import (panel_50,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_50.csv');
%import (panel_51,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_51.csv');
%import (panel_52,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_52.csv');
%import (panel_53,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_53.csv');
%import (panel_54,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_54.csv');
%import (panel_55,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_55.csv');
%import (panel_56,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_56.csv');
%import (panel_57,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_57.csv');
%import (panel_58,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_58.csv');
%import (panel_59,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_59.csv');
%import (panel_60,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_60.csv');
%import (panel_61,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_61.csv');
%import (panel_62,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_62.csv');
%import (panel_63,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_63.csv');
%import (panel_64,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_64.csv');
%import (panel_65,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_65.csv');
%import (panel_66,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_66.csv');
%import (panel_67,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_67.csv');
%import (panel_68,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_68.csv');
%import (panel_69,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_69.csv');
%import (panel_70,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_70.csv');
%import (panel_71,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_71.csv');
%import (panel_72,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_72.csv');
%import (panel_73,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_73.csv');
%import (panel_74,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_74.csv');
%import (panel_75,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_75.csv');
%import (panel_76,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_76.csv');
%import (panel_77,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_77.csv');
%import (panel_78,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_78.csv');
%import (panel_79,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_79.csv');
%import (panel_80,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_80.csv');
%import (panel_81,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_81.csv');
%import (panel_82,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_82.csv');
%import (panel_83,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_83.csv');
%import (panel_84,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_84.csv');
%import (panel_85,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_85.csv');
%import (panel_86,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_86.csv');
%import (panel_87,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_87.csv');
%import (panel_88,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_88.csv');
%import (panel_89,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_89.csv');
%import (panel_90,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_90.csv');
%import (panel_91,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_91.csv');
%import (panel_92,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_92.csv');
%import (panel_93,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_93.csv');
%import (panel_94,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_94.csv');
%import (panel_95,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_95.csv');
%import (panel_96,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_96.csv');
%import (panel_97,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_97.csv');
%import (panel_98,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_98.csv');
%import (panel_99,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_99.csv');
%import (panel_100,'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\CSV Panels\panel_100.csv');

/****************************************************************************************/
/****************************************************************************************/
/* Generate data set with only U.S. reporters for formulary apportionment */
/****************************************************************************************/
/****************************************************************************************/
data seOnlyPar;
	set aer.usdiafoir82to16;
	if foreignid ne '0000' then delete;
	keep be11id year majforowned foreignid haven compensation rdstock netppe profits;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Calculate formulary adjustments for randomly generated panels */
/****************************************************************************************/
/****************************************************************************************/
%macro adjustment (fullpanel,affpanel,sum,apportion,aggadjust,aggadjusthaven,panelnum);
* Add parents to each randomly generated affiliate panel;
data &fullpanel;
	set &affpanel seonlypar;
run;

* Aggregate financial and operating data for each firm;
proc sort data = &fullpanel;
	by be11id year;
proc means noprint data = &fullpanel;
	by be11id year;
	var compensation rdstock netppe profits;
	where year in (1982,1989,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,
	2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016);
	output	out = &sum (drop = _type_ _freq_) /* contains aggregate financial and 
			operating data for each firm */
			sum = compsum rdstksum ppesum profitssum;
run;

* Attach aggregate data to microdata and apply formulary apportionment;
proc sort data = &fullpanel;
	by be11id year;
proc sort data = &sum;
	by be11id year;
data &apportion;
	merge &fullpanel &sum;
	by be11id year;
	where year in (1982,1989,1994,1995,1996,1997,1998,1999,2000,2001,2002,2003,2004,2005,
	2006,2007,2008,2009,2010,2011,2012,2013,2014,2015,2016);
	Panel = &panelnum;
* Set missing values to zero;
	array changemiss _numeric_;
	do over changemiss;
		if compensation = . then compensation = 0;
		if rdstock = . then rdstock = 0;
		if netppe = . then netppe = 0;
		if profits = . then profits = 0;
	end;
* Generate apportionment factors;
	if compsum ne 0 then CompWt = (compensation / compsum); else CompWt = 0;
	if rdstksum ne 0 then RDstkWT = (rdstock / rdstksum); else RDstkWT = 0;
	if ppesum ne 0 then ppeWt = (netppe / ppesum); else ppeWt = 0;
* Reattribute the proxy for earnings based on a weighted average of compensation, R&D stock, and PPE;
	EarnFA3 = sum((profitssum * compwt * 0.333),(profitssum * rdstkwt * 0.333),(profitssum * ppewt * 0.334));
	if compsum gt 0 and rdstksum gt 0 and ppesum gt 0 then AdjWt3 = earnfa3 - profits;
	else if compsum le 0 and rdstksum gt 0 and ppesum gt 0 then AdjWt3 = sum((profitssum * rdstkwt * 0.5),(profitssum * ppewt * 0.5)) - profits;
	else if compsum gt 0 and rdstksum le 0 and ppesum gt 0 then AdjWt3 = sum((profitssum * compwt * 0.5),(profitssum * ppewt * 0.5)) - profits;
	else if compsum gt 0 and rdstksum gt 0 and ppesum le 0 then AdjWt3 = sum((profitssum * compwt * 0.5),(profitssum * rdstkwt * 0.5)) - profits;
	else AdjWt3 = 0;
	keep be11id foreignid year panel majforowned haven adjwt3;
run;

* Aggregate by year the formulary adjustments (net direct investment);
proc sort data = &apportion;
by year panel;
proc means noprint sum data = &apportion;
by year panel;
where majforowned = 0 and foreignid ne '0000';
var adjwt3;
output	out = &aggadjust (drop = _type_ _freq_)
		sum = adjwt3;
run;

* Aggregate by year and tax haven country the formulary adjustments (net direct investment);
proc sort data = &apportion;
by year haven panel;
proc means noprint sum data = &apportion;
by year haven panel;
where majforowned = 0 and foreignid ne '0000';
var adjwt3;
output	out = &aggadjusthaven (drop = _type_ _freq_)
		sum = adjwt3;
run;
%mend adjustment;

%adjustment (fullpanel_1,panel_1,sum_1,apportion_1,aggadjust_1,aggadjusthaven_1,1);
%adjustment (fullpanel_2,panel_2,sum_2,apportion_2,aggadjust_2,aggadjusthaven_2,2);
%adjustment (fullpanel_3,panel_3,sum_3,apportion_3,aggadjust_3,aggadjusthaven_3,3);
%adjustment (fullpanel_4,panel_4,sum_4,apportion_4,aggadjust_4,aggadjusthaven_4,4);
%adjustment (fullpanel_5,panel_5,sum_5,apportion_5,aggadjust_5,aggadjusthaven_5,5);
%adjustment (fullpanel_6,panel_6,sum_6,apportion_6,aggadjust_6,aggadjusthaven_6,6);
%adjustment (fullpanel_7,panel_7,sum_7,apportion_7,aggadjust_7,aggadjusthaven_7,7);
%adjustment (fullpanel_8,panel_8,sum_8,apportion_8,aggadjust_8,aggadjusthaven_8,8);
%adjustment (fullpanel_9,panel_9,sum_9,apportion_9,aggadjust_9,aggadjusthaven_9,9);
%adjustment (fullpanel_10,panel_10,sum_10,apportion_10,aggadjust_10,aggadjusthaven_10,10);
%adjustment (fullpanel_11,panel_11,sum_11,apportion_11,aggadjust_11,aggadjusthaven_11,11);
%adjustment (fullpanel_12,panel_12,sum_12,apportion_12,aggadjust_12,aggadjusthaven_12,12);
%adjustment (fullpanel_13,panel_13,sum_13,apportion_13,aggadjust_13,aggadjusthaven_13,13);
%adjustment (fullpanel_14,panel_14,sum_14,apportion_14,aggadjust_14,aggadjusthaven_14,14);
%adjustment (fullpanel_15,panel_15,sum_15,apportion_15,aggadjust_15,aggadjusthaven_15,15);
%adjustment (fullpanel_16,panel_16,sum_16,apportion_16,aggadjust_16,aggadjusthaven_16,16);
%adjustment (fullpanel_17,panel_17,sum_17,apportion_17,aggadjust_17,aggadjusthaven_17,17);
%adjustment (fullpanel_18,panel_18,sum_18,apportion_18,aggadjust_18,aggadjusthaven_18,18);
%adjustment (fullpanel_19,panel_19,sum_19,apportion_19,aggadjust_19,aggadjusthaven_19,19);
%adjustment (fullpanel_20,panel_20,sum_20,apportion_20,aggadjust_20,aggadjusthaven_20,20);
%adjustment (fullpanel_21,panel_21,sum_21,apportion_21,aggadjust_21,aggadjusthaven_21,21);
%adjustment (fullpanel_22,panel_22,sum_22,apportion_22,aggadjust_22,aggadjusthaven_22,22);
%adjustment (fullpanel_23,panel_23,sum_23,apportion_23,aggadjust_23,aggadjusthaven_23,23);
%adjustment (fullpanel_24,panel_24,sum_24,apportion_24,aggadjust_24,aggadjusthaven_24,24);
%adjustment (fullpanel_25,panel_25,sum_25,apportion_25,aggadjust_25,aggadjusthaven_25,25);
%adjustment (fullpanel_26,panel_26,sum_26,apportion_26,aggadjust_26,aggadjusthaven_26,26);
%adjustment (fullpanel_27,panel_27,sum_27,apportion_27,aggadjust_27,aggadjusthaven_27,27);
%adjustment (fullpanel_28,panel_28,sum_28,apportion_28,aggadjust_28,aggadjusthaven_28,28);
%adjustment (fullpanel_29,panel_29,sum_29,apportion_29,aggadjust_29,aggadjusthaven_29,29);
%adjustment (fullpanel_30,panel_30,sum_30,apportion_30,aggadjust_30,aggadjusthaven_30,30);
%adjustment (fullpanel_31,panel_31,sum_31,apportion_31,aggadjust_31,aggadjusthaven_31,31);
%adjustment (fullpanel_32,panel_32,sum_32,apportion_32,aggadjust_32,aggadjusthaven_32,32);
%adjustment (fullpanel_33,panel_33,sum_33,apportion_33,aggadjust_33,aggadjusthaven_33,33);
%adjustment (fullpanel_34,panel_34,sum_34,apportion_34,aggadjust_34,aggadjusthaven_34,34);
%adjustment (fullpanel_35,panel_35,sum_35,apportion_35,aggadjust_35,aggadjusthaven_35,35);
%adjustment (fullpanel_36,panel_36,sum_36,apportion_36,aggadjust_36,aggadjusthaven_36,36);
%adjustment (fullpanel_37,panel_37,sum_37,apportion_37,aggadjust_37,aggadjusthaven_37,37);
%adjustment (fullpanel_38,panel_38,sum_38,apportion_38,aggadjust_38,aggadjusthaven_38,38);
%adjustment (fullpanel_39,panel_39,sum_39,apportion_39,aggadjust_39,aggadjusthaven_39,39);
%adjustment (fullpanel_40,panel_40,sum_40,apportion_40,aggadjust_40,aggadjusthaven_40,40);
%adjustment (fullpanel_41,panel_41,sum_41,apportion_41,aggadjust_41,aggadjusthaven_41,41);
%adjustment (fullpanel_42,panel_42,sum_42,apportion_42,aggadjust_42,aggadjusthaven_42,42);
%adjustment (fullpanel_43,panel_43,sum_43,apportion_43,aggadjust_43,aggadjusthaven_43,43);
%adjustment (fullpanel_44,panel_44,sum_44,apportion_44,aggadjust_44,aggadjusthaven_44,44);
%adjustment (fullpanel_45,panel_45,sum_45,apportion_45,aggadjust_45,aggadjusthaven_45,45);
%adjustment (fullpanel_46,panel_46,sum_46,apportion_46,aggadjust_46,aggadjusthaven_46,46);
%adjustment (fullpanel_47,panel_47,sum_47,apportion_47,aggadjust_47,aggadjusthaven_47,47);
%adjustment (fullpanel_48,panel_48,sum_48,apportion_48,aggadjust_48,aggadjusthaven_48,48);
%adjustment (fullpanel_49,panel_49,sum_49,apportion_49,aggadjust_49,aggadjusthaven_49,49);
%adjustment (fullpanel_50,panel_50,sum_50,apportion_50,aggadjust_50,aggadjusthaven_50,50);
%adjustment (fullpanel_51,panel_51,sum_51,apportion_51,aggadjust_51,aggadjusthaven_51,51);
%adjustment (fullpanel_52,panel_52,sum_52,apportion_52,aggadjust_52,aggadjusthaven_52,52);
%adjustment (fullpanel_53,panel_53,sum_53,apportion_53,aggadjust_53,aggadjusthaven_53,53);
%adjustment (fullpanel_54,panel_54,sum_54,apportion_54,aggadjust_54,aggadjusthaven_54,54);
%adjustment (fullpanel_55,panel_55,sum_55,apportion_55,aggadjust_55,aggadjusthaven_55,55);
%adjustment (fullpanel_56,panel_56,sum_56,apportion_56,aggadjust_56,aggadjusthaven_56,56);
%adjustment (fullpanel_57,panel_57,sum_57,apportion_57,aggadjust_57,aggadjusthaven_57,57);
%adjustment (fullpanel_58,panel_58,sum_58,apportion_58,aggadjust_58,aggadjusthaven_58,58);
%adjustment (fullpanel_59,panel_59,sum_59,apportion_59,aggadjust_59,aggadjusthaven_59,59);
%adjustment (fullpanel_60,panel_60,sum_60,apportion_60,aggadjust_60,aggadjusthaven_60,60);
%adjustment (fullpanel_61,panel_61,sum_61,apportion_61,aggadjust_61,aggadjusthaven_61,61);
%adjustment (fullpanel_62,panel_62,sum_62,apportion_62,aggadjust_62,aggadjusthaven_62,62);
%adjustment (fullpanel_63,panel_63,sum_63,apportion_63,aggadjust_63,aggadjusthaven_63,63);
%adjustment (fullpanel_64,panel_64,sum_64,apportion_64,aggadjust_64,aggadjusthaven_64,64);
%adjustment (fullpanel_65,panel_65,sum_65,apportion_65,aggadjust_65,aggadjusthaven_65,65);
%adjustment (fullpanel_66,panel_66,sum_66,apportion_66,aggadjust_66,aggadjusthaven_66,66);
%adjustment (fullpanel_67,panel_67,sum_67,apportion_67,aggadjust_67,aggadjusthaven_67,67);
%adjustment (fullpanel_68,panel_68,sum_68,apportion_68,aggadjust_68,aggadjusthaven_68,68);
%adjustment (fullpanel_69,panel_69,sum_69,apportion_69,aggadjust_69,aggadjusthaven_69,69);
%adjustment (fullpanel_70,panel_70,sum_70,apportion_70,aggadjust_70,aggadjusthaven_70,70);
%adjustment (fullpanel_71,panel_71,sum_71,apportion_71,aggadjust_71,aggadjusthaven_71,71);
%adjustment (fullpanel_72,panel_72,sum_72,apportion_72,aggadjust_72,aggadjusthaven_72,72);
%adjustment (fullpanel_73,panel_73,sum_73,apportion_73,aggadjust_73,aggadjusthaven_73,73);
%adjustment (fullpanel_74,panel_74,sum_74,apportion_74,aggadjust_74,aggadjusthaven_74,74);
%adjustment (fullpanel_75,panel_75,sum_75,apportion_75,aggadjust_75,aggadjusthaven_75,75);
%adjustment (fullpanel_76,panel_76,sum_76,apportion_76,aggadjust_76,aggadjusthaven_76,76);
%adjustment (fullpanel_77,panel_77,sum_77,apportion_77,aggadjust_77,aggadjusthaven_77,77);
%adjustment (fullpanel_78,panel_78,sum_78,apportion_78,aggadjust_78,aggadjusthaven_78,78);
%adjustment (fullpanel_79,panel_79,sum_79,apportion_79,aggadjust_79,aggadjusthaven_79,79);
%adjustment (fullpanel_80,panel_80,sum_80,apportion_80,aggadjust_80,aggadjusthaven_80,80);
%adjustment (fullpanel_81,panel_81,sum_81,apportion_81,aggadjust_81,aggadjusthaven_81,81);
%adjustment (fullpanel_82,panel_82,sum_82,apportion_82,aggadjust_82,aggadjusthaven_82,82);
%adjustment (fullpanel_83,panel_83,sum_83,apportion_83,aggadjust_83,aggadjusthaven_83,83);
%adjustment (fullpanel_84,panel_84,sum_84,apportion_84,aggadjust_84,aggadjusthaven_84,84);
%adjustment (fullpanel_85,panel_85,sum_85,apportion_85,aggadjust_85,aggadjusthaven_85,85);
%adjustment (fullpanel_86,panel_86,sum_86,apportion_86,aggadjust_86,aggadjusthaven_86,86);
%adjustment (fullpanel_87,panel_87,sum_87,apportion_87,aggadjust_87,aggadjusthaven_87,87);
%adjustment (fullpanel_88,panel_88,sum_88,apportion_88,aggadjust_88,aggadjusthaven_88,88);
%adjustment (fullpanel_89,panel_89,sum_89,apportion_89,aggadjust_89,aggadjusthaven_89,89);
%adjustment (fullpanel_90,panel_90,sum_90,apportion_90,aggadjust_90,aggadjusthaven_90,90);
%adjustment (fullpanel_91,panel_91,sum_91,apportion_91,aggadjust_91,aggadjusthaven_91,91);
%adjustment (fullpanel_92,panel_92,sum_92,apportion_92,aggadjust_92,aggadjusthaven_92,92);
%adjustment (fullpanel_93,panel_93,sum_93,apportion_93,aggadjust_93,aggadjusthaven_93,93);
%adjustment (fullpanel_94,panel_94,sum_94,apportion_94,aggadjust_94,aggadjusthaven_94,94);
%adjustment (fullpanel_95,panel_95,sum_95,apportion_95,aggadjust_95,aggadjusthaven_95,95);
%adjustment (fullpanel_96,panel_96,sum_96,apportion_96,aggadjust_96,aggadjusthaven_96,96);
%adjustment (fullpanel_97,panel_97,sum_97,apportion_97,aggadjust_97,aggadjusthaven_97,97);
%adjustment (fullpanel_98,panel_98,sum_98,apportion_98,aggadjust_98,aggadjusthaven_98,98);
%adjustment (fullpanel_99,panel_99,sum_99,apportion_99,aggadjust_99,aggadjusthaven_99,99);
%adjustment (fullpanel_100,panel_100,sum_100,apportion_100,aggadjust_100,aggadjusthaven_100,100);

/****************************************************************************************/
/****************************************************************************************/
/* Stack affiliate-level formulary adjustments from the randomly generated panels */
/****************************************************************************************/
/****************************************************************************************/
data stackaffadj;
	set apportion_1 apportion_2 apportion_3 apportion_4 apportion_5 apportion_6
	apportion_7 apportion_8 apportion_9 apportion_10 apportion_11 apportion_12
	apportion_13 apportion_14 apportion_15 apportion_16 apportion_17 apportion_18
	apportion_19 apportion_20 apportion_21 apportion_22 apportion_23 apportion_24
	apportion_25 apportion_26 apportion_27 apportion_28 apportion_29 apportion_30
	apportion_31 apportion_32 apportion_33 apportion_34 apportion_35 apportion_36
	apportion_37 apportion_38 apportion_39 apportion_40 apportion_41 apportion_42
	apportion_43 apportion_44 apportion_45 apportion_46 apportion_47 apportion_48
	apportion_49 apportion_50 apportion_51 apportion_52 apportion_53 apportion_54
	apportion_55 apportion_56 apportion_57 apportion_58 apportion_59 apportion_60
	apportion_61 apportion_62 apportion_63 apportion_64 apportion_65 apportion_66
	apportion_67 apportion_68 apportion_69 apportion_70 apportion_71 apportion_72
	apportion_73 apportion_74 apportion_75 apportion_76 apportion_77 apportion_78
	apportion_79 apportion_80 apportion_81 apportion_82 apportion_83 apportion_84
	apportion_85 apportion_86 apportion_87 apportion_88 apportion_89 apportion_90
	apportion_91 apportion_92 apportion_93 apportion_94 apportion_95 apportion_96
	apportion_97 apportion_98 apportion_99 apportion_100;
run;

/****************************************************************************************/
/****************************************************************************************/
/* Stack aggregate formulary adjustments from the randomly generated panels */
/****************************************************************************************/
/****************************************************************************************/
data stackaggadj;
	set aggadjust_1 aggadjust_2 aggadjust_3 aggadjust_4 aggadjust_5 aggadjust_6
	aggadjust_7 aggadjust_8 aggadjust_9 aggadjust_10 aggadjust_11 aggadjust_12
	aggadjust_13 aggadjust_14 aggadjust_15 aggadjust_16 aggadjust_17 aggadjust_18
	aggadjust_19 aggadjust_20 aggadjust_21 aggadjust_22 aggadjust_23 aggadjust_24
	aggadjust_25 aggadjust_26 aggadjust_27 aggadjust_28 aggadjust_29 aggadjust_30
	aggadjust_31 aggadjust_32 aggadjust_33 aggadjust_34 aggadjust_35 aggadjust_36
	aggadjust_37 aggadjust_38 aggadjust_39 aggadjust_40 aggadjust_41 aggadjust_42
	aggadjust_43 aggadjust_44 aggadjust_45 aggadjust_46 aggadjust_47 aggadjust_48
	aggadjust_49 aggadjust_50 aggadjust_51 aggadjust_52 aggadjust_53 aggadjust_54
	aggadjust_55 aggadjust_56 aggadjust_57 aggadjust_58 aggadjust_59 aggadjust_60
	aggadjust_61 aggadjust_62 aggadjust_63 aggadjust_64 aggadjust_65 aggadjust_66
	aggadjust_67 aggadjust_68 aggadjust_69 aggadjust_70 aggadjust_71 aggadjust_72
	aggadjust_73 aggadjust_74 aggadjust_75 aggadjust_76 aggadjust_77 aggadjust_78
	aggadjust_79 aggadjust_80 aggadjust_81 aggadjust_82 aggadjust_83 aggadjust_84
	aggadjust_85 aggadjust_86 aggadjust_87 aggadjust_88 aggadjust_89 aggadjust_90
	aggadjust_91 aggadjust_92 aggadjust_93 aggadjust_94 aggadjust_95 aggadjust_96
	aggadjust_97 aggadjust_98 aggadjust_99 aggadjust_100;
* Scale the adjustment to billions USD;
	adjwt3scale = adjwt3 / 1000000;
* Apply the current cost adjustment;
	if year = 1982 then Adjustment = adjwt3scale * 1.125;
	if year = 1989 then Adjustment = adjwt3scale * 1.104;
	if year = 1994 then Adjustment = adjwt3scale * 1.102;
	if year = 1995 then Adjustment = adjwt3scale * 1.078;
	if year = 1996 then Adjustment = adjwt3scale * 1.080;
	if year = 1997 then Adjustment = adjwt3scale * 1.087;
	if year = 1998 then Adjustment = adjwt3scale * 1.130;
	if year = 1999 then Adjustment = adjwt3scale * 1.133;
	if year = 2000 then Adjustment = adjwt3scale * 1.115;
	if year = 2001 then Adjustment = adjwt3scale * 1.158;
	if year = 2002 then Adjustment = adjwt3scale * 1.157;
	if year = 2003 then Adjustment = adjwt3scale * 1.114;
	if year = 2004 then Adjustment = adjwt3scale * 1.077;
	if year = 2005 then Adjustment = adjwt3scale * 1.043;
	if year = 2006 then Adjustment = adjwt3scale * 1.028;
	if year = 2007 then Adjustment = adjwt3scale * 1.033;
	if year = 2008 then Adjustment = adjwt3scale * 1.033;
	if year = 2009 then Adjustment = adjwt3scale * 1.064;
	if year = 2010 then Adjustment = adjwt3scale * 1.045;
	if year = 2011 then Adjustment = adjwt3scale * 1.042;
	if year = 2012 then Adjustment = adjwt3scale * 1.047;
	if year = 2013 then Adjustment = adjwt3scale * 1.042;
	if year = 2014 then Adjustment = adjwt3scale * 1.033;
	if year = 2015 then Adjustment = adjwt3scale * 1.036;
	if year = 2016 then Adjustment = adjwt3scale * 1.050;
	drop adjwt3 adjwt3scale;
proc export data = stackaggadj
	replace
	outfile = 'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\Output\OutputAggStdError.xlsx';
run;

/****************************************************************************************/
/****************************************************************************************/
/* Stack aggregate formulary adjustments by haven from the randomly generated panels */
/****************************************************************************************/
/****************************************************************************************/
data stackaggadjhaven;
	set aggadjusthaven_1 aggadjusthaven_2 aggadjusthaven_3 aggadjusthaven_4 aggadjusthaven_5 aggadjusthaven_6
	aggadjusthaven_7 aggadjusthaven_8 aggadjusthaven_9 aggadjusthaven_10 aggadjusthaven_11 aggadjusthaven_12
	aggadjusthaven_13 aggadjusthaven_14 aggadjusthaven_15 aggadjusthaven_16 aggadjusthaven_17 aggadjusthaven_18
	aggadjusthaven_19 aggadjusthaven_20 aggadjusthaven_21 aggadjusthaven_22 aggadjusthaven_23 aggadjusthaven_24
	aggadjusthaven_25 aggadjusthaven_26 aggadjusthaven_27 aggadjusthaven_28 aggadjusthaven_29 aggadjusthaven_30
	aggadjusthaven_31 aggadjusthaven_32 aggadjusthaven_33 aggadjusthaven_34 aggadjusthaven_35 aggadjusthaven_36
	aggadjusthaven_37 aggadjusthaven_38 aggadjusthaven_39 aggadjusthaven_40 aggadjusthaven_41 aggadjusthaven_42
	aggadjusthaven_43 aggadjusthaven_44 aggadjusthaven_45 aggadjusthaven_46 aggadjusthaven_47 aggadjusthaven_48
	aggadjusthaven_49 aggadjusthaven_50 aggadjusthaven_51 aggadjusthaven_52 aggadjusthaven_53 aggadjusthaven_54
	aggadjusthaven_55 aggadjusthaven_56 aggadjusthaven_57 aggadjusthaven_58 aggadjusthaven_59 aggadjusthaven_60
	aggadjusthaven_61 aggadjusthaven_62 aggadjusthaven_63 aggadjusthaven_64 aggadjusthaven_65 aggadjusthaven_66
	aggadjusthaven_67 aggadjusthaven_68 aggadjusthaven_69 aggadjusthaven_70 aggadjusthaven_71 aggadjusthaven_72
	aggadjusthaven_73 aggadjusthaven_74 aggadjusthaven_75 aggadjusthaven_76 aggadjusthaven_77 aggadjusthaven_78
	aggadjusthaven_79 aggadjusthaven_80 aggadjusthaven_81 aggadjusthaven_82 aggadjusthaven_83 aggadjusthaven_84
	aggadjusthaven_85 aggadjusthaven_86 aggadjusthaven_87 aggadjusthaven_88 aggadjusthaven_89 aggadjusthaven_90
	aggadjusthaven_91 aggadjusthaven_92 aggadjusthaven_93 aggadjusthaven_94 aggadjusthaven_95 aggadjusthaven_96
	aggadjusthaven_97 aggadjusthaven_98 aggadjusthaven_99 aggadjusthaven_100;
* Scale the adjustment to billions USD;
	adjwt3scale = adjwt3 / 1000000;
* Apply the current cost adjustment;
	if year = 1982 then Adjustment = adjwt3scale * 1.125;
	if year = 1989 then Adjustment = adjwt3scale * 1.104;
	if year = 1994 then Adjustment = adjwt3scale * 1.102;
	if year = 1995 then Adjustment = adjwt3scale * 1.078;
	if year = 1996 then Adjustment = adjwt3scale * 1.080;
	if year = 1997 then Adjustment = adjwt3scale * 1.087;
	if year = 1998 then Adjustment = adjwt3scale * 1.130;
	if year = 1999 then Adjustment = adjwt3scale * 1.133;
	if year = 2000 then Adjustment = adjwt3scale * 1.115;
	if year = 2001 then Adjustment = adjwt3scale * 1.158;
	if year = 2002 then Adjustment = adjwt3scale * 1.157;
	if year = 2003 then Adjustment = adjwt3scale * 1.114;
	if year = 2004 then Adjustment = adjwt3scale * 1.077;
	if year = 2005 then Adjustment = adjwt3scale * 1.043;
	if year = 2006 then Adjustment = adjwt3scale * 1.028;
	if year = 2007 then Adjustment = adjwt3scale * 1.033;
	if year = 2008 then Adjustment = adjwt3scale * 1.033;
	if year = 2009 then Adjustment = adjwt3scale * 1.064;
	if year = 2010 then Adjustment = adjwt3scale * 1.045;
	if year = 2011 then Adjustment = adjwt3scale * 1.042;
	if year = 2012 then Adjustment = adjwt3scale * 1.047;
	if year = 2013 then Adjustment = adjwt3scale * 1.042;
	if year = 2014 then Adjustment = adjwt3scale * 1.033;
	if year = 2015 then Adjustment = adjwt3scale * 1.036;
	if year = 2016 then Adjustment = adjwt3scale * 1.050;
	drop adjwt3 adjwt3scale;
proc export data = stackaggadjhaven
	replace
	outfile = 'L:\Dylan\Paper - Productivity\AER Revision\AER Replication\Output\OutputHavenStdError.xlsx';
run;
/****************************************************************************************/
/****************************************************************************************/
