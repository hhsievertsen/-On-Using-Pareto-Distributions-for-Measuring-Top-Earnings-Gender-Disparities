
/*
	Project: Pareto Gender
	File: 09_Figure5_educationshares_topinc
	Last edited: by Hans, Sep 12, 2020
*/

// Load settings
do "D:\Data\workdata\704784\xdrev\704784\pareto_gender\do\settings.do"
// Load panel
use "$tf\analysisdata.dta",clear

gen e_business	=v_educ_group=="Business"
gen e_law		=v_educ_group=="Law"
gen e_medicine	=v_educ_group=="Medicine"
gen e_stem		=v_educ_group=="STEM"
gen e_other		=v_educ_group=="-"

	  

// Collapse by income group
foreach v in  "1" "10"{
	preserve
	keep if top`v'_dummy==1
	collapse (mean) e*, by(v_female year) fast
		// Chart female
		tw  (connected e_stem year if v_female==1, msymbol(Sh) mcolor(gs10) lcolor(gs10)  ) ///
			(connected e_law year if v_female==1, msymbol(X) msize(large) mcolor(gs8) lcolor(gs8) ) ///
			(connected e_medicine year if v_female==1, msymbol(Th) mcolor(gs6) lcolor(gs6) ) ///
			(connected e_business year if v_female==1, msymbol(S) mcolor(gs4) lcolor(gs4) ) ///
			, graphregion(fcolor(white) lcolor(white)) ///
			  plotregion(fcolor(white) lcolor(black))  ///
			  xlab(1980(3)2013, noticks) xtitle(" ")  ///
			  ylab(, noticks format(%6.2f)  angle(horizontal)) ytitle("Share") ///
			  legend(region(lcolor(white)) row(1) pos(12) order(1 "STEM" 2 "Law" 3 "Medicine" 4 "Business")) ///
			  xscale(noline) yscale(noline)
			graph export "$of\fig_educationshare_overall_femaletop`v'.png", replace width(2000)
		// Chart male
		tw (connected e_stem year if v_female==0, msymbol(Sh) mcolor(gs10) lcolor(gs10)  ) ///
			(connected e_law year if v_female==0, msymbol(X) msize(large) mcolor(gs8) lcolor(gs8) ) ///
			(connected e_medicine year if v_female==0, msymbol(Th) mcolor(gs6) lcolor(gs6) ) ///
			(connected e_business year if v_female==0, msymbol(S) mcolor(gs4) lcolor(gs4) ) ///
			, graphregion(fcolor(white) lcolor(white)) ///
			  plotregion(fcolor(white) lcolor(black))  ///
			  xlab(1980(3)2013, noticks) xtitle(" ")  ///
			  ylab(, noticks format(%6.2f)  angle(horizontal)) ytitle("Share") ///
			  legend(region(lcolor(white)) row(1) pos(12) order(1 "STEM" 2 "Law" 3 "Medicine" 4 "Business")) ///
			  xscale(noline) yscale(noline)
			graph export "$of\fig_educationshare_overall_maletop`v'.png", replace width(2000)
	restore
}



