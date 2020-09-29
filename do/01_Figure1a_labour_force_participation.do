/*
	Project: Pareto Gender
	File: 01_Figure1a_labour_force_participation
	Last edited: by Hans, Sep 12, 2020
*/

// Load settings
do "D:\Data\workdata\704784\xdrev\704784\pareto_gender\do\settings.do"
// Load panel
use "$tf\analysisdata_raw.dta",clear
// Pos earnings
gen pos_earning=v_income1>0 & v_income1!=.
// Overall 

collapse (mean) pos_earning, by(v_female year) fast
// Chart female
tw  (connected pos_earning year if v_female==0, msymbol(Sh) mcolor(black) lcolor(black) ) ///
	(connected pos_earning year if v_female==1, msymbol(X) msize(large) mcolor(black) lcolor(black)) ///
	, graphregion(fcolor(white) lcolor(white)) ///
	  plotregion(fcolor(white) lcolor(black))  ///
	  xlab(1980(3)2013, noticks) xtitle(" ")  ///
	  ylab(0.6(0.05)0.9, noticks format(%6.2f)  angle(horizontal)) ytitle("Share") ///
	  legend(region(lcolor(white)) row(1) ring(0) pos(12) ///
	  order(2 "Women" 1 "Men" )) ///
	  xscale(noline) yscale(noline)
	graph export "$of\fig_pos_earnings_by_gender.png", replace width(2000)

