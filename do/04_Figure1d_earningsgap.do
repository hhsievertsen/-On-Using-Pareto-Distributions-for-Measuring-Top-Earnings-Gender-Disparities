
/*
	Project: Pareto Gender
	File: 04_Figure1d_earningsgap
	Last edited: by Hans, Sep 12, 2020
*/

// Load settings
do "D:\Data\workdata\704784\xdrev\704784\pareto_gender\do\settings.do"
// Load panel
use "$tf\analysisdata.dta",clear
gen female=v_income1 if v_female==1
gen male=v_income1 if v_female==0
// Collapse
collapse (mean) female male, by( year) fast
cap drop ratio
gen ratio=log(male)-log(female)
tw  (connected ratio year, msymbol(S) mcolor(black) lcolor(black) ) ///
			, graphregion(fcolor(white) lcolor(white)) ///
		  plotregion(fcolor(white) lcolor(black))  ///
		  xlab(1980(3)2013, noticks) xtitle(" ")  ///
		  ylab(0(0.1)0.6, noticks format(%6.2f)  angle(horizontal)) ytitle("Earnings gender gap (ln)") ///
		  legend(region(lcolor(white)) row(1) ring(0) pos(12) ///
		  order(2 "Women" 1 "Men" )) ///
		  xscale(noline) yscale(noline)
		graph export "$of\fig_gender_gap_flipped.png", width(2000) replace





