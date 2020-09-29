
/*
	Project: Pareto Gender
	File: 03_Figure1c_education_shares
	Last edited: by Hans, Sep 12, 2020
*/

// Load settings
do "D:\Data\workdata\704784\xdrev\704784\pareto_gender\do\settings.do"
// Load panel full sample
use "$tf\analysisdata_raw.dta",clear


collapse (mean) v_female, by(v_educ_group year) fast
// Chart
 tw  (connected v_female year if v_educ_group=="STEM", msymbol(Sh) mcolor(gs10) lcolor(gs10) ) ///
	(connected v_female year if v_educ_group=="Law", msymbol(X) msize(large) mcolor(gs8) lcolor(gs8) ) ///
	(connected v_female year if v_educ_group=="Medicine", msymbol(Th) mcolor(gs6) lcolor(gs6) ) ///
	(connected v_female year if v_educ_group=="Business", msymbol(S) mcolor(gs4) lcolor(gs4) ) ///
	, graphregion(fcolor(white) lcolor(white)) ///
	  plotregion(fcolor(white) lcolor(black))  ///
	  xlab(1980(3)2013, noticks) xtitle(" ")  ///
	  ylab(0(0.1)0.7, noticks format(%6.2f)  angle(horizontal)) ytitle("Share") ///
	  legend(region(lcolor(white)) row(1) ring(0) pos(12) order(1 "STEM" 2 "Law" 3 "Medicine" 4 "Business")) ///
	  xscale(noline) yscale(noline)
	  graph export "$of\fig_education_ratio_overall_fs.png", replace width(2000)
	  
 tw  (connected v_female year if v_educ_group=="STEM", msymbol(Sh) mcolor(gs10) lcolor(gs10) ) ///
	(connected v_female year if v_educ_group=="Law", msymbol(X) msize(large) mcolor(gs8) lcolor(gs8) ) ///
	(connected v_female year if v_educ_group=="Medicine", msymbol(Th) mcolor(gs6) lcolor(gs6) ) ///
	(connected v_female year if v_educ_group=="Business", msymbol(S) mcolor(gs4) lcolor(gs4) ) ///
	, graphregion(fcolor(white) lcolor(white)) ///
	  plotregion(fcolor(white) lcolor(black))  ///
	  xlab(1980(3)2013, noticks) xtitle(" ")  ///
	  ylab(0(0.1)0.7, noticks format(%6.2f)  angle(horizontal)) ytitle("Share") ///
	  legend(region(lcolor(white)) row(1) ring(1) pos(12) order(1 "STEM" 2 "Law" 3 "Medicine" 4 "Business")) ///
	  xscale(noline) yscale(noline)
	  graph export "$of\fig_education_ratio_overall_fsring1.png", replace width(2000)
